#!/bin/bash
# Osgiliath - NAT without MASQUERADE

echo "========================================="
echo "Rule 1: NAT without MASQUERADE"
echo "========================================="

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Flush existing NAT rules
iptables -t nat -F
iptables -t nat -X

# Get external IP
ETH0_IP=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

echo "External Interface IP: $ETH0_IP"

# NAT using SNAT (NOT MASQUERADE)
iptables -t nat -A POSTROUTING -s 192.212.0.0/23 -o eth0 -j SNAT --to-source $ETH0_IP

# Allow forwarding
iptables -P FORWARD ACCEPT

echo "✓ NAT Configuration completed!"

iptables -t nat -L -n -v

ping -c 3 8.8.8.8
curl -I http://google.com