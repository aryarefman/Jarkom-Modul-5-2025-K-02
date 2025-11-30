apt-get update && apt-get install -y netcat-traditional

#!/bin/bash
# Narya - DNS access only from Vilya

echo "========================================="
echo "Rule 3: DNS access only from Vilya"
echo "========================================="

# Flush existing rules
iptables -F INPUT

# Allow DNS (port 53) ONLY from Vilya
iptables -A INPUT -p tcp --dport 53 -s 192.212.0.50 -j ACCEPT
iptables -A INPUT -p udp --dport 53 -s 192.212.0.50 -j ACCEPT

# Drop DNS from others
iptables -A INPUT -p tcp --dport 53 -j DROP
iptables -A INPUT -p udp --dport 53 -j DROP

# Allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow other traffic
iptables -A INPUT -j ACCEPT

echo "✓ Configuration completed!"
iptables -L INPUT -n -v

apt-get update && apt-get install -y netcat-traditional

echo "Testing TCP port 53:"
nc -zv -n 192.212.0.51 53

echo "Testing TCP port 53:"
timeout 5 nc -zv -n 192.212.0.51 53

iptables -F INPUT
iptables -P INPUT ACCEPT
iptables -L INPUT -n -v