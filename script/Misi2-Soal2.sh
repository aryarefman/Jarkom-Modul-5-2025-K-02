#!/bin/bash
# Vilya - Block incoming PING

echo "========================================="
echo "Rule 2: Block PING to Vilya"
echo "========================================="

# Flush existing rules
iptables -F INPUT

# Allow ICMP from loopback
iptables -A INPUT -i lo -p icmp -j ACCEPT

# Block ICMP Echo Request from others
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# Allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow other traffic
iptables -A INPUT -j ACCEPT

# Allow Vilya to ping others (OUTPUT not blocked)
iptables -P OUTPUT ACCEPT

echo "✓ Configuration completed!"
iptables -L INPUT -n -v

ping -c 3 192.212.0.50

ping -c 3 192.212.0.51  # ping Narya
ping -c 3 8.8.8.8       # ping Internet