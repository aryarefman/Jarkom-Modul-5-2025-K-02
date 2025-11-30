#!/bin/bash
# IronHills - Weekend only access for specific subnets

echo "========================================="
echo "Rule 4: Weekend Access Control"
echo "========================================="

# Flush existing rules
iptables -F INPUT

# Allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow loopback
iptables -A INPUT -i lo -j ACCEPT

# Define subnets
# Durin (A2): 192.212.0.64/26
# Khamul (A3): 192.212.0.56/29
# Elendil & Isildur (A5): 192.212.1.0/24

# Allow access on weekends (Saturday=6, Sunday=0) for specific subnets
iptables -A INPUT -p tcp --dport 80 -s 192.212.0.64/26 -m time --weekdays Sat,Sun -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -s 192.212.0.56/29 -m time --weekdays Sat,Sun -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -s 192.212.1.0/24 -m time --weekdays Sat,Sun -j ACCEPT

# Drop HTTP access from these subnets on weekdays
iptables -A INPUT -p tcp --dport 80 -s 192.212.0.64/26 -j DROP
iptables -A INPUT -p tcp --dport 80 -s 192.212.0.56/29 -j DROP
iptables -A INPUT -p tcp --dport 80 -s 192.212.1.0/24 -j DROP

# Allow other traffic
iptables -A INPUT -j ACCEPT

echo "✓ Weekend access control configured!"
iptables -L INPUT -n -v --line-numbers

#!/bin/bash

# =========================== #
#   Disable Time Sync First   #
# =========================== #
service ntp stop 2>/dev/null
service systemd-timesyncd stop 2>/dev/null

# Set manual time
date -s "2025-11-29 14:00:00"

# Show current date
date


#!/bin/bash
# =========================== #
#   IronHills Access Testing  #
# =========================== #

echo "========================================="
echo "        Testing IronHills Access"
echo "========================================="

# Method 1: wget request
echo "Method 1: Using wget"
wget --timeout=5 --tries=1 http://192.212.0.18 -O - 2>&1 | head -20

#!/bin/bash

# =========================== #
#   Disable Time Sync First   #
# =========================== #
service ntp stop 2>/dev/null
service systemd-timesyncd stop 2>/dev/null

# Set manual time
date -s "2025-01-29 14:00:00"

# Show current date
date


#!/bin/bash
# =========================== #
#   IronHills Access Testing  #
# =========================== #

echo "========================================="
echo "        Testing IronHills Access"
echo "========================================="

# Method 1: wget request
echo "Method 1: Using wget"
wget --timeout=5 --tries=1 http://192.212.0.18 -O - 2>&1 | head -20