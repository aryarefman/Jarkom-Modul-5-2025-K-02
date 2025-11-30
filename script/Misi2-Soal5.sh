#!/bin/bash
# Palantir - Time-based access control for different factions

echo "========================================="
echo "Rule 5: Time-Based Access Control"
echo "========================================="

# Flush existing rules
iptables -F INPUT

# Allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow loopback
iptables -A INPUT -i lo -j ACCEPT

# Define subnets
# Gilgalad & Cirdan (A7 - Elf): 192.212.0.128/25
# Elendil & Isildur (A5 - Human): 192.212.1.0/24

# ELF FACTION: 07:00 - 15:00
iptables -A INPUT -p tcp --dport 80 -s 192.212.0.128/25 -m time --timestart 07:00 --timestop 15:00 -j ACCEPT

# HUMAN FACTION: 17:00 - 23:00
iptables -A INPUT -p tcp --dport 80 -s 192.212.1.0/24 -m time --timestart 17:00 --timestop 23:00 -j ACCEPT

# Drop HTTP access from these subnets outside allowed hours
iptables -A INPUT -p tcp --dport 80 -s 192.212.0.128/25 -j DROP
iptables -A INPUT -p tcp --dport 80 -s 192.212.1.0/24 -j DROP

# Allow other traffic
iptables -A INPUT -j ACCEPT

echo "✓ Time-based access control configured!"
echo ""
echo "Rules configured:"
echo "- Elf Faction (Gilgalad & Cirdan): 07:00-15:00"
echo "- Human Faction (Elendil & Isildur): 17:00-23:00"
echo ""
iptables -L INPUT -n -v --line-numbers

#!/bin/bash
# Test from Gilgalad (Elf Faction)

echo "========================================="
echo "   Testing Palantir Access - Elf Faction"
echo "========================================="

# Stop time sync
service ntp stop 2>/dev/null
service systemd-timesyncd stop 2>/dev/null

# Test 1: During allowed hours (10:00 - should SUCCESS)
echo ""
echo "Test 1: During Elf hours (10:00)"
date -s "2025-01-29 10:00:00"
date
echo "Attempting to access Palantir..."
wget --timeout=5 --tries=1 http://192.212.0.22 -O - 2>&1 | head -20

echo ""
echo "========================================="

# Test 2: Outside allowed hours (18:00 - should FAIL)
echo ""
echo "Test 2: Outside Elf hours (18:00)"
date -s "2025-01-29 18:00:00"
date
echo "Attempting to access Palantir..."
wget --timeout=5 --tries=1 http://192.212.0.22 -O - 2>&1 | head -20

echo ""
echo "========================================="
echo "Testing completed!"

#!/bin/bash
# Test from Elendil (Human Faction)

echo "========================================="
echo " Testing Palantir Access - Human Faction"
echo "========================================="

# Stop time sync
service ntp stop 2>/dev/null
service systemd-timesyncd stop 2>/dev/null

# Test 1: During allowed hours (20:00 - should SUCCESS)
echo ""
echo "Test 1: During Human hours (20:00)"
date -s "2025-01-29 20:00:00"
date
echo "Attempting to access Palantir..."
wget --timeout=5 --tries=1 http://192.212.0.22 -O - 2>&1 | head -20

echo ""
echo "========================================="

# Test 2: Outside allowed hours (12:00 - should FAIL)
echo ""
echo "Test 2: Outside Human hours (12:00)"
date -s "2025-01-29 12:00:00"
date
echo "Attempting to access Palantir..."
wget --timeout=5 --tries=1 http://192.212.0.22 -O - 2>&1 | head -20

echo ""
echo "========================================="
echo "Testing completed!"