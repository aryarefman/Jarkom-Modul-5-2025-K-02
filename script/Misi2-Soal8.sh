#!/bin/bash
# Moria - Rule 8: Redirect Vilya → Khamul ke IronHills

echo "========================================="
echo "Rule 8: Traffic Redirection at Moria"
echo "========================================="

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# DNAT: Redirect traffic dari Vilya ke Khamul subnet → IronHills
iptables -t nat -A PREROUTING -s 192.212.0.50 -d 192.212.0.56/29 -j DNAT --to-destination 192.212.0.18

echo "✓ Redirection configured at Moria!"
echo "Vilya → Khamul (192.212.0.56/29) redirected to IronHills (192.212.0.18)"
echo ""
iptables -t nat -L PREROUTING -n -v

#!/bin/bash
# Test dari Vilya - Rule 8 (NC Simple)

echo "========================================="
echo "Rule 8: Traffic Redirection Test (NC)"
echo "========================================="

echo ""
echo "Test 1: NC ke IronHills langsung (192.212.0.18)"
echo "------------------------------------------------"
(echo -e "GET / HTTP/1.0\r\n\r"; sleep 1) | nc 192.212.0.18 80

echo ""
echo "========================================"
echo ""
echo "Test 2: NC ke Khamul IP (192.212.0.58)"
echo "---------------------------------------"
(echo -e "GET / HTTP/1.0\r\n\r"; sleep 1) | nc 192.212.0.58 80

echo ""
echo "========================================"
echo "✓ Compare both outputs"
echo "  If BOTH show IronHills HTML, redirect WORKS!"