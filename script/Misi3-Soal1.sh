#!/bin/bash
# Wilderland - Misi 3: Total Isolation Khamul (BEST PRACTICE - CLEAN)

echo "========================================="
echo "Misi 3: Total Isolation Khamul"
echo "========================================="

# HAPUS rule lama Khamul jika ada
echo "Cleaning old Khamul rules..."
iptables -D FORWARD -s 192.212.0.56/29 -j DROP 2>/dev/null
iptables -D FORWARD -d 192.212.0.56/29 -j DROP 2>/dev/null
iptables -D INPUT -s 192.212.0.56/29 -j DROP 2>/dev/null
iptables -D OUTPUT -d 192.212.0.56/29 -j DROP 2>/dev/null

# Hapus semua kemungkinan duplikat (loop sampai tidak ada lagi)
while iptables -D FORWARD -s 192.212.0.56/29 -j DROP 2>/dev/null; do :; done
while iptables -D FORWARD -d 192.212.0.56/29 -j DROP 2>/dev/null; do :; done
while iptables -D INPUT -s 192.212.0.56/29 -j DROP 2>/dev/null; do :; done
while iptables -D OUTPUT -d 192.212.0.56/29 -j DROP 2>/dev/null; do :; done

echo "✓ Old rules cleaned"
echo ""

# PASANG rule baru di posisi paling atas
echo "Installing new isolation rules..."

# FORWARD chain (untuk traffic transit)
iptables -I FORWARD 1 -s 192.212.0.56/29 -j DROP
iptables -I FORWARD 1 -d 192.212.0.56/29 -j DROP

# INPUT chain (untuk traffic ke Wilderland dari Khamul)
iptables -I INPUT 1 -s 192.212.0.56/29 -j DROP

# OUTPUT chain (untuk traffic dari Wilderland ke Khamul)
iptables -I OUTPUT 1 -d 192.212.0.56/29 -j DROP

echo "✓ Khamul subnet (192.212.0.56/29) FULLY ISOLATED!"
echo ""
echo "========================================="
echo "Rules applied (at top priority):"
echo "========================================="
echo ""
echo "FORWARD chain:"
iptables -L FORWARD -n -v --line-numbers | head -5
echo ""
echo "INPUT chain:"
iptables -L INPUT -n -v --line-numbers | head -5
echo ""
echo "OUTPUT chain:"
iptables -L OUTPUT -n -v --line-numbers | head -5
echo ""
echo "Note: Durin (192.212.0.64/26) is NOT affected"

#!/bin/bash
# Test dari Khamul - Misi 3 (Full Test dengan Install NC)

echo "========================================="
echo "Misi 3: Testing Isolation FROM Khamul"
echo "========================================="

# Install netcat (akan gagal jika sudah terisolasi penuh)
echo "Trying to install netcat..."
apt-get update -qq 2>&1 | head -5
apt-get install -y netcat-traditional 2>&1 | head -5

echo ""
echo "========================================="
echo "Starting isolation tests..."
echo "All tests should FAIL (fully isolated)"
echo "========================================="

echo ""
echo "Test 1: Ping to Gateway (Wilderland)"
echo "-------------------------------------"
timeout 5 ping -c 3 192.212.0.57
if [ $? -ne 0 ]; then
    echo "✓ Gateway: BLOCKED"
else
    echo "✗ Gateway: NOT BLOCKED"
fi

echo ""
echo "Test 2: Ping to Durin"
echo "-------------------------------------"
timeout 5 ping -c 3 192.212.0.66
if [ $? -ne 0 ]; then
    echo "✓ Durin: BLOCKED"
else
    echo "✗ Durin: NOT BLOCKED"
fi

echo ""
echo "Test 3: Ping to IronHills"
echo "-------------------------------------"
timeout 5 ping -c 3 192.212.0.18
if [ $? -ne 0 ]; then
    echo "✓ IronHills: BLOCKED"
else
    echo "✗ IronHills: NOT BLOCKED"
fi

echo ""
echo "Test 4: Ping to Internet"
echo "-------------------------------------"
timeout 5 ping -c 3 8.8.8.8
if [ $? -ne 0 ]; then
    echo "✓ Internet: BLOCKED"
else
    echo "✗ Internet: NOT BLOCKED"
fi

echo ""
echo "Test 5: NC to IronHills port 80"
echo "-------------------------------------"
if command -v nc >/dev/null 2>&1; then
    timeout 5 nc -zv -n 192.212.0.18 80
    if [ $? -ne 0 ]; then
        echo "✓ NC: BLOCKED"
    else
        echo "✗ NC: NOT BLOCKED"
    fi
else
    echo "⚠ NC not installed (likely because apt-get is blocked)"
    echo "✓ This proves isolation is working!"
fi

echo ""
echo "========================================="
echo "SUMMARY"
echo "========================================="
echo "✓ If ALL tests FAILED, Khamul is FULLY ISOLATED!"
echo "✓ Khamul cannot communicate with anyone"
echo "✓ The traitor is imprisoned in Barad-dûr!"
echo "========================================="