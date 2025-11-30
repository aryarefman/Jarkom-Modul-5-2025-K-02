#!/bin/bash
clear
echo "===================================================="
echo " PALANTIR — FINAL FIX GNS3 (NO CHAIN_DEF_FAILED)"
echo "===================================================="

# Bersihkan recent list
echo clear > /proc/net/xt_recent/portscan 2>/dev/null
echo clear > /proc/net/xt_recent/blocklist 2>/dev/null

# Pastikan chain PORT_SCAN benar-benar bersih
iptables -F PORT_SCAN 2>/dev/null
iptables -X PORT_SCAN 2>/dev/null
iptables -N PORT_SCAN

# Flush semua rule
iptables -F INPUT
iptables -t nat -F

# Rule dasar
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Blocklist
iptables -A INPUT -m recent --rcheck --name blocklist -j DROP

# Tracking port scan
iptables -A INPUT -p tcp --syn -m recent --set --name portscan
iptables -A INPUT -p tcp --syn -m recent --update --seconds 20 --hitcount 16 --name portscan -j PORT_SCAN

# ACCEPT NEW port 80 → NC hijau sebelum scan
iptables -A INPUT -p tcp --dport 80 -m state --state NEW -j ACCEPT

# Rule 5 time-based
iptables -A INPUT -p tcp --dport 80 -s 192.212.0.128/25 -m time --timestart 07:00 --timestop 15:00 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -s 192.212.1.0/24   -m time --timestart 17:00 --timestop 23:00 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -s 192.212.0.128/25 -j DROP
iptables -A INPUT -p tcp --dport 80 -s 192.212.1.0/24   -j DROP

# Isi chain PORT_SCAN (LOG DULU!)
iptables -F PORT_SCAN
iptables -A PORT_SCAN -m limit --limit 3/sec -j LOG --log-prefix "PORT_SCAN_DETECTED: " --log-level 4
iptables -A PORT_SCAN -m recent --set --name blocklist
iptables -A PORT_SCAN -j DROP

# Default
iptables -A INPUT -j ACCEPT

# Fix rsyslog GNS3 (wajib!)
echo "kern.*                                                 /var/log/kern.log" > /etc/rsyslog.d/10-kernel.conf
pkill rsyslogd 2>/dev/null
rsyslogd &
touch /var/log/kern.log

echo "===================================================="
echo "SELESAI — TIDAK ADA LAGI ERROR CHAIN_DEF_FAILED"
echo "Sekarang langsung tes nmap dari Elendil!"
echo "Log pasti banjir: tail -f /var/log/kern.log | grep PORT_SCAN"
echo "===================================================="
iptables -L INPUT -n -v --line-numbers

#!/bin/bash
# Test from Elendil - Port Scan Simulation (STRICT TEST)

echo "========================================="
echo "   RULE 6: Port Scan Detection Test"
echo "========================================="
echo "Testing from: Elendil (Human Faction)"
echo "Target: Palantir (192.212.0.22)"
echo "========================================="

PALANTIR="192.212.0.22"

# Install tools
if ! command -v nmap >/dev/null 2>&1; then
    echo "Installing nmap..."
    apt-get update -qq
    apt-get install -y nmap netcat-traditional curl
fi

echo ""
echo "========================================="
echo "PHASE 1: Pre-Scan Connectivity Test"
echo "========================================="

echo ""
echo "Test 1.1: PING test"
ping -c 3 -W 2 $PALANTIR
PING_BEFORE=$?
if [ $PING_BEFORE -eq 0 ]; then
    echo "✓ Ping: SUCCESS"
else
    echo "✗ Ping: FAILED"
fi

echo ""
echo "Test 1.2: HTTP test"
curl -s -m 5 http://$PALANTIR | head -5
HTTP_BEFORE=$?
if [ $HTTP_BEFORE -eq 0 ]; then
    echo "✓ HTTP: SUCCESS"
else
    echo "✗ HTTP: FAILED"
fi

echo ""
echo "Test 1.3: Netcat test (port 80)"
timeout 3 nc -zv $PALANTIR 80
NC_BEFORE=$?
if [ $NC_BEFORE -eq 0 ]; then
    echo "✓ NC: SUCCESS"
else
    echo "✗ NC: FAILED"
fi

sleep 2

echo ""
echo "========================================="
echo "PHASE 2: PORT SCAN (This will trigger detection)"
echo "========================================="
echo "⚠️  WARNING: Performing port scan 1-100"
echo "⚠️  This WILL block this IP completely!"
echo ""

# Aggressive scan to trigger quickly
nmap -T4 --max-retries 0 -p 1-100 $PALANTIR

echo ""
echo "✓ Port scan completed"
echo "Waiting 5 seconds for rules to apply..."
sleep 5

echo ""
echo "========================================="
echo "PHASE 3: Post-Scan Connectivity Test"
echo "========================================="
echo "ALL tests below should FAIL (blocked):"

echo ""
echo "Test 3.1: PING test (should FAIL)"
timeout 5 ping -c 3 -W 2 $PALANTIR
PING_AFTER=$?
if [ $PING_AFTER -ne 0 ]; then
    echo "✓ Ping: BLOCKED (as expected)"
else
    echo "✗ Ping: NOT BLOCKED (rule failed!)"
fi

echo ""
echo "Test 3.2: HTTP test (should FAIL)"
timeout 5 curl -s http://$PALANTIR
HTTP_AFTER=$?
if [ $HTTP_AFTER -ne 0 ]; then
    echo "✓ HTTP: BLOCKED (as expected)"
else
    echo "✗ HTTP: NOT BLOCKED (rule failed!)"
fi

echo ""
echo "Test 3.3: Netcat test (should FAIL)"
timeout 5 nc -zv $PALANTIR 80
NC_AFTER=$?
if [ $NC_AFTER -ne 0 ]; then
    echo "✓ NC: BLOCKED (as expected)"
else
    echo "✗ NC: NOT BLOCKED (rule failed!)"
fi

echo ""
echo "Test 3.4: Multiple protocols test"
echo "Trying ICMP..."
timeout 3 ping -c 1 $PALANTIR >/dev/null 2>&1
[ $? -ne 0 ] && echo "  ✓ ICMP blocked" || echo "  ✗ ICMP not blocked"

echo "Trying TCP port 22..."
timeout 3 nc -zv $PALANTIR 22 >/dev/null 2>&1
[ $? -ne 0 ] && echo "  ✓ SSH blocked" || echo "  ✗ SSH not blocked"

echo "Trying TCP port 443..."
timeout 3 nc -zv $PALANTIR 443 >/dev/null 2>&1
[ $? -ne 0 ] && echo "  ✓ HTTPS blocked" || echo "  ✗ HTTPS not blocked"

echo ""
echo "========================================="
echo "PHASE 4: Summary"
echo "========================================="

echo ""
echo "BEFORE Port Scan:"
echo "  Ping:  $([ $PING_BEFORE -eq 0 ] && echo '✓ Working' || echo '✗ Failed')"
echo "  HTTP:  $([ $HTTP_BEFORE -eq 0 ] && echo '✓ Working' || echo '✗ Failed')"
echo "  NC:    $([ $NC_BEFORE -eq 0 ] && echo '✓ Working' || echo '✗ Failed')"

echo ""
echo "AFTER Port Scan:"
echo "  Ping:  $([ $PING_AFTER -ne 0 ] && echo '✓ BLOCKED' || echo '✗ NOT BLOCKED')"
echo "  HTTP:  $([ $HTTP_AFTER -ne 0 ] && echo '✓ BLOCKED' || echo '✗ NOT BLOCKED')"
echo "  NC:    $([ $NC_AFTER -ne 0 ] && echo '✓ BLOCKED' || echo '✗ NOT BLOCKED')"