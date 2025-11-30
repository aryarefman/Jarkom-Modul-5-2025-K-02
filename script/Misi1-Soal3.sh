#!/bin/bash
# Konfigurasi Osgiliath dengan NAT - Manual IP Setup

echo "========================================="
echo "Configuring Osgiliath Router with Internet (Manual)"
echo "========================================="

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Konfigurasi semua interface
ip link set eth0 up
ip link set eth1 up
ip link set eth2 up
ip link set eth3 up

ip addr flush dev eth0
ip addr flush dev eth1
ip addr flush dev eth2
ip addr flush dev eth3

# Konfigurasi eth0 untuk NAT
# Coba beberapa kemungkinan network NAT GNS3
echo "Trying to configure eth0 for NAT..."

# Coba network 192.168.122.0/24 (default virbr0)
ip addr add 192.168.122.100/24 dev eth0
ip route add default via 192.168.122.1 dev eth0

# Setup DNS
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

# Test koneksi
echo "Testing NAT gateway..."
ping -c 2 192.168.122.1

if [ $? -ne 0 ]; then
    echo "Network 192.168.122.0/24 failed, trying 10.0.2.0/24..."
    ip addr flush dev eth0
    ip route del default 2>/dev/null
    
    ip addr add 10.0.2.100/24 dev eth0
    ip route add default via 10.0.2.2 dev eth0
    
    ping -c 2 10.0.2.2
    
    if [ $? -ne 0 ]; then
        echo "Network 10.0.2.0/24 failed, trying 192.168.1.0/24..."
        ip addr flush dev eth0
        ip route del default 2>/dev/null
        
        ip addr add 192.168.1.100/24 dev eth0
        ip route add default via 192.168.1.1 dev eth0
        
        ping -c 2 192.168.1.1
    fi
fi

# Konfigurasi interface internal
ip addr add 192.212.0.29/30 dev eth2  # ke Moria (A9)
ip addr add 192.212.0.33/30 dev eth1  # ke Rivendell (A10)
ip addr add 192.212.0.37/30 dev eth3  # ke Minastir (A11)

# Setup NAT masquerading
echo "Setting up NAT masquerading..."
iptables -t nat -F  # Flush existing rules
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Allow forwarding
iptables -F FORWARD
iptables -P FORWARD ACCEPT
iptables -A FORWARD -i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth0 -o eth2 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth2 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth0 -o eth3 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth3 -o eth0 -j ACCEPT

# Routing ke subnet internal
echo "Setting up internal routes..."
ip route add 192.212.0.16/30 via 192.212.0.30 dev eth2  # A1
ip route add 192.212.0.24/30 via 192.212.0.30 dev eth2  # A8
ip route add 192.212.0.64/26 via 192.212.0.30 dev eth2  # A2
ip route add 192.212.0.56/29 via 192.212.0.30 dev eth2  # A3
ip route add 192.212.0.48/29 via 192.212.0.34 dev eth1  # A4
ip route add 192.212.1.0/24 via 192.212.0.38 dev eth3   # A5
ip route add 192.212.0.40/30 via 192.212.0.38 dev eth3  # A12
ip route add 192.212.0.20/30 via 192.212.0.38 dev eth3  # A6
ip route add 192.212.0.44/30 via 192.212.0.38 dev eth3  # A13
ip route add 192.212.0.128/25 via 192.212.0.38 dev eth3 # A7

echo ""
echo "========================================="
echo "Configuration completed!"
echo "========================================="
echo ""
echo "Interface Status:"
ip -br addr show
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "Testing Internet:"
ping -c 3 8.8.8.8
echo ""
echo "Testing DNS:"
ping -c 3 google.com

#!/bin/bash

# Konfigurasi Router Moria

echo "========================================="
echo "Configuring Moria Router"
echo "========================================="

# Enable IP forwarding
echo "Enabling IP forwarding..."
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Konfigurasi IP untuk setiap interface
echo "Configuring interfaces..."
ip link set eth0 up
ip link set eth1 up
ip link set eth2 up

ip addr flush dev eth0
ip addr flush dev eth1
ip addr flush dev eth2

ip addr add 192.212.0.30/30 dev eth0  # ke Osgiliath (A9)
ip addr add 192.212.0.17/30 dev eth1  # ke Switch2 -> IronHills (A1)
ip addr add 192.212.0.25/30 dev eth2  # ke Wilderland (A8)

# DNS Configuration
echo "Configuring DNS..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

# Routing
echo "Setting up routes..."

# Default route ke Osgiliath
ip route add default via 192.212.0.29 dev eth0

# Route spesifik ke subnet di bawah Wilderland
ip route add 192.212.0.64/26 via 192.212.0.26 dev eth2  # A2 (Durin)
ip route add 192.212.0.56/29 via 192.212.0.26 dev eth2  # A3 (Khamul)

echo ""
echo "Moria configuration completed"
echo ""
echo "========================================="
echo "Interface Status:"
ip -br addr show
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf
echo ""
echo "Testing internet:"
ping -c 3 8.8.8.8
echo ""
echo "Testing DNS:"
ping -c 3 google.com
echo "========================================="

#!/bin/bash

# Konfigurasi Router Rivendell

echo "========================================="
echo "Configuring Rivendell Router"
echo "========================================="

# Enable IP forwarding
echo "Enabling IP forwarding..."
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Konfigurasi IP untuk setiap interface
echo "Configuring interfaces..."
ip link set eth0 up
ip link set eth1 up

ip addr flush dev eth0
ip addr flush dev eth1

ip addr add 192.212.0.34/30 dev eth0  # ke Osgiliath (A10)
ip addr add 192.212.0.49/29 dev eth1  # ke Switch1 (A4) -> Vilya & Narya

# DNS Configuration
echo "Configuring DNS..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

# Routing
echo "Setting up routes..."

# Default route ke Osgiliath
ip route add default via 192.212.0.33 dev eth0

echo ""
echo "Rivendell configuration completed"
echo ""
echo "========================================="
echo "Interface Status:"
ip -br addr show
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf
echo ""
echo "Testing connectivity to Osgiliath:"
ping -c 3 192.212.0.33
echo ""
echo "Testing internet:"
ping -c 3 8.8.8.8
echo ""
echo "Testing DNS resolution:"
ping -c 3 google.com
echo "========================================="

#!/bin/bash

# Konfigurasi Router Minastir

echo "========================================="
echo "Configuring Minastir Router"
echo "========================================="

# Enable IP forwarding
echo "Enabling IP forwarding..."
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Konfigurasi IP untuk setiap interface
echo "Configuring interfaces..."
ip link set eth0 up
ip link set eth1 up
ip link set eth2 up

ip addr flush dev eth0
ip addr flush dev eth1
ip addr flush dev eth2

ip addr add 192.212.0.38/30 dev eth0  # ke Osgiliath (A11)
ip addr add 192.212.0.41/30 dev eth1  # ke Pelargir (A12)
ip addr add 192.212.1.1/24 dev eth2   # ke Switch4 (A5) -> Elendil & Isildur

# DNS Configuration
echo "Configuring DNS..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

# Routing
echo "Setting up routes..."

# Default route ke Osgiliath
ip route add default via 192.212.0.37 dev eth0

# Route ke subnet di bawah Pelargir
ip route add 192.212.0.20/30 via 192.212.0.42 dev eth1  # A6 (Palantir)
ip route add 192.212.0.44/30 via 192.212.0.42 dev eth1  # A13 (Pelargir-AnduinBanks)
ip route add 192.212.0.128/25 via 192.212.0.42 dev eth1 # A7 (Gilgalad & Cirdan)

echo ""
echo "Minastir configuration completed"
echo ""
echo "========================================="
echo "Interface Status:"
ip -br addr show
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf
echo ""
echo "Testing internet:"
ping -c 3 8.8.8.8
echo ""
echo "Testing DNS:"
ping -c 3 google.com
echo "========================================="

#!/bin/bash

# Konfigurasi Router Pelargir

echo "========================================="
echo "Configuring Pelargir Router"
echo "========================================="

# Enable IP forwarding
echo "Enabling IP forwarding..."
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Konfigurasi IP untuk setiap interface
echo "Configuring interfaces..."
ip link set eth0 up
ip link set eth1 up
ip link set eth2 up

ip addr flush dev eth0
ip addr flush dev eth1
ip addr flush dev eth2

ip addr add 192.212.0.42/30 dev eth0  # ke Minastir (A12)
ip addr add 192.212.0.45/30 dev eth1  # ke AnduinBanks (A13)
ip addr add 192.212.0.21/30 dev eth2  # ke Palantir (A6)

# DNS Configuration
echo "Configuring DNS..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

# Routing
echo "Setting up routes..."

# Default route ke Minastir
ip route add default via 192.212.0.41 dev eth0

# Route ke subnet di bawah AnduinBanks
ip route add 192.212.0.128/25 via 192.212.0.46 dev eth1 # A7 (Gilgalad & Cirdan)

echo ""
echo "Pelargir configuration completed"
echo ""
echo "========================================="
echo "Interface Status:"
ip -br addr show
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf
echo ""
echo "Testing internet:"
ping -c 3 8.8.8.8
echo ""
echo "Testing DNS:"
ping -c 3 google.com
echo "========================================="

#!/bin/bash

# Konfigurasi Router AnduinBanks

echo "========================================="
echo "Configuring AnduinBanks Router"
echo "========================================="

# Enable IP forwarding
echo "Enabling IP forwarding..."
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Konfigurasi IP untuk setiap interface
echo "Configuring interfaces..."
ip link set eth0 up
ip link set eth1 up

ip addr flush dev eth0
ip addr flush dev eth1

ip addr add 192.212.0.46/30 dev eth0  # ke Pelargir (A13)
ip addr add 192.212.0.129/25 dev eth1 # ke Switch5 (A7) -> Gilgalad & Cirdan

# DNS Configuration
echo "Configuring DNS..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

# Routing
echo "Setting up routes..."

# Default route ke Pelargir
ip route add default via 192.212.0.45 dev eth0

echo ""
echo "AnduinBanks configuration completed"
echo ""
echo "========================================="
echo "Interface Status:"
ip -br addr show
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf
echo ""
echo "Testing internet:"
ping -c 3 8.8.8.8
echo ""
echo "Testing DNS:"
ping -c 3 google.com
echo "========================================="

#!/bin/bash

# Konfigurasi Router Wilderland

echo "========================================="
echo "Configuring Wilderland Router"
echo "========================================="

# Enable IP forwarding
echo "Enabling IP forwarding..."
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Konfigurasi IP untuk setiap interface
echo "Configuring interfaces..."
ip link set eth0 up
ip link set eth1 up
ip link set eth2 up

ip addr flush dev eth0
ip addr flush dev eth1
ip addr flush dev eth2

ip addr add 192.212.0.26/30 dev eth0  # ke Moria (A8)
ip addr add 192.212.0.65/26 dev eth1  # ke Durin (A2)
ip addr add 192.212.0.57/29 dev eth2  # ke Switch3 (A3) -> Khamul

# DNS Configuration
echo "Configuring DNS..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

# Routing
echo "Setting up routes..."

# Default route ke Moria
ip route add default via 192.212.0.25 dev eth0

echo ""
echo "Wilderland configuration completed"
echo ""
echo "========================================="
echo "Interface Status:"
ip -br addr show
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf
echo ""
echo "Testing internet:"
ping -c 3 8.8.8.8
echo ""
echo "Testing DNS:"
ping -c 3 google.com
echo "========================================="

#!/bin/bash
# Konfigurasi Web Server IronHills dengan DNS Configuration

echo "========================================="
echo "Configuring IronHills Web Server"
echo "========================================="

# Konfigurasi IP
echo "Configuring interface..."
ip link set eth0 up
ip addr flush dev eth0

ip addr add 192.212.0.18/30 dev eth0  # ke Moria via Switch2 (A1)

# Default gateway ke Moria
ip route add default via 192.212.0.17

# DNS Configuration
echo "Configuring DNS..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

echo ""
echo "IronHills configuration completed"
echo ""
echo "========================================="
echo "Interface Status:"
ip -br addr show
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf
echo ""
echo "Testing internet:"
ping -c 3 8.8.8.8
echo ""
echo "Testing DNS:"
ping -c 3 google.com
echo "========================================="

#!/bin/bash
# Konfigurasi Web Server Palantir dengan DNS Configuration

echo "========================================="
echo "Configuring Palantir Web Server"
echo "========================================="

# Konfigurasi IP
echo "Configuring interface..."
ip link set eth0 up
ip addr flush dev eth0

ip addr add 192.212.0.22/30 dev eth0  # ke Pelargir (A6)

# Default gateway ke Pelargir
ip route add default via 192.212.0.21

# DNS Configuration
echo "Configuring DNS..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

echo ""
echo "Palantir configuration completed"
echo ""
echo "========================================="
echo "Interface Status:"
ip -br addr show
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf
echo ""
echo "Testing internet:"
ping -c 3 8.8.8.8
echo ""
echo "Testing DNS:"
ping -c 3 google.com
echo "========================================="

#!/bin/bash
# Konfigurasi Vilya dengan DNS Configuration

echo "========================================="
echo "Configuring Vilya DHCP Server"
echo "========================================="

# Konfigurasi IP
echo "Configuring interface..."
ip link set eth0 up
ip addr flush dev eth0

ip addr add 192.212.0.50/29 dev eth0  # ke Rivendell via Switch1 (A4)

# Default gateway ke Rivendell
ip route add default via 192.212.0.49

# DNS Configuration
echo "Configuring DNS..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

echo ""
echo "Vilya configuration completed"
echo ""
echo "========================================="
echo "Interface Status:"
ip -br addr show
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf
echo ""
echo "Testing internet:"
ping -c 3 8.8.8.8
echo ""
echo "Testing DNS:"
ping -c 3 google.com
echo "========================================="

#!/bin/bash
# Konfigurasi Narya dengan DNS Configuration

echo "========================================="
echo "Configuring Narya DNS Server"
echo "========================================="

# Konfigurasi IP
echo "Configuring interface..."
ip link set eth0 up
ip addr flush dev eth0

ip addr add 192.212.0.51/29 dev eth0  # ke Rivendell via Switch1 (A4)

# Default gateway ke Rivendell
ip route add default via 192.212.0.49

# DNS Configuration
echo "Configuring DNS..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

echo ""
echo "Narya configuration completed"
echo ""
echo "========================================="
echo "Interface Status:"
ip -br addr show
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf
echo ""
echo "Testing internet:"
ping -c 3 8.8.8.8
echo ""
echo "Testing DNS:"
ping -c 3 google.com
echo "========================================="

#!/bin/bash
# Konfigurasi Client Durin dengan DNS Configuration (50 host / Caesar)

echo "========================================="
echo "Configuring Durin Client"
echo "========================================="

# Konfigurasi IP (contoh untuk host pertama)
echo "Configuring interface..."
ip link set eth0 up
ip addr flush dev eth0

ip addr add 192.212.0.66/26 dev eth0  # A2

# Default gateway ke Wilderland
ip route add default via 192.212.0.65

# DNS Configuration
echo "Configuring DNS..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

echo ""
echo "Durin configuration completed"
echo "IP Range Available: 192.212.0.65 - 192.212.0.126"
echo ""
echo "========================================="
echo "Interface Status:"
ip -br addr show
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf
echo ""
echo "Testing internet:"
ping -c 3 8.8.8.8
echo ""
echo "Testing DNS:"
ping -c 3 google.com
echo "========================================="

#!/bin/bash
# Konfigurasi Client Khamul dengan DNS Configuration (5 host / Burnice) - TARGET PENGKHIANAT

echo "========================================="
echo "Configuring Khamul Client"
echo "========================================="
echo "⚠️  WARNING: This is the TRAITOR's subnet!"
echo "========================================="

# Konfigurasi IP (contoh untuk host pertama)
echo "Configuring interface..."
ip link set eth0 up
ip addr flush dev eth0

ip addr add 192.212.0.58/29 dev eth0  # A3

# Default gateway ke Wilderland
ip route add default via 192.212.0.57

# DNS Configuration
echo "Configuring DNS..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

echo ""
echo "Khamul configuration completed"
echo "IP Range Available: 192.212.0.57 - 192.212.0.62"
echo "⚠️  ISOLATE THIS SUBNET TO PREVENT DATA LEAK!"
echo ""
echo "========================================="
echo "Interface Status:"
ip -br addr show
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf
echo ""
echo "Testing internet:"
ping -c 3 8.8.8.8
echo ""
echo "Testing DNS:"
ping -c 3 google.com
echo "========================================="

#!/bin/bash
# Konfigurasi Client Elendil dengan DNS Configuration (200 host / Jane)

echo "========================================="
echo "Configuring Elendil Client"
echo "========================================="

# Konfigurasi IP (contoh untuk host pertama)
echo "Configuring interface..."
ip link set eth0 up
ip addr flush dev eth0

ip addr add 192.212.1.2/24 dev eth0  # A5

# Default gateway ke Minastir
ip route add default via 192.212.1.1

# DNS Configuration
echo "Configuring DNS..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

echo ""
echo "Elendil configuration completed"
echo "IP Range Available: 192.212.1.1 - 192.212.1.254"
echo "(Shared subnet with Isildur)"
echo ""
echo "========================================="
echo "Interface Status:"
ip -br addr show
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf
echo ""
echo "Testing internet:"
ping -c 3 8.8.8.8
echo ""
echo "Testing DNS:"
ping -c 3 google.com
echo "========================================="

#!/bin/bash
# Konfigurasi Client Isildur dengan DNS Configuration (30 host / Policeboo)

echo "========================================="
echo "Configuring Isildur Client"
echo "========================================="

# Konfigurasi IP (contoh untuk host pertama)
echo "Configuring interface..."
ip link set eth0 up
ip addr flush dev eth0

ip addr add 192.212.1.3/24 dev eth0  # A5

# Default gateway ke Minastir
ip route add default via 192.212.1.1

# DNS Configuration
echo "Configuring DNS..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

echo ""
echo "Isildur configuration completed"
echo "IP Range Available: 192.212.1.1 - 192.212.1.254"
echo "(Shared subnet with Elendil)"
echo ""
echo "========================================="
echo "Interface Status:"
ip -br addr show
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf
echo ""
echo "Testing internet:"
ping -c 3 8.8.8.8
echo ""
echo "Testing DNS:"
ping -c 3 google.com
echo "========================================="

#!/bin/bash
# Konfigurasi Client Gilgalad dengan DNS Configuration (100 host / Ellen)

echo "========================================="
echo "Configuring Gilgalad Client"
echo "========================================="

# Konfigurasi IP (contoh untuk host pertama)
echo "Configuring interface..."
ip link set eth0 up
ip addr flush dev eth0

ip addr add 192.212.0.130/25 dev eth0  # A7

# Default gateway ke AnduinBanks
ip route add default via 192.212.0.129

# DNS Configuration
echo "Configuring DNS..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

echo ""
echo "Gilgalad configuration completed"
echo "IP Range Available: 192.212.0.129 - 192.212.0.254"
echo "(Shared subnet with Cirdan)"
echo ""
echo "========================================="
echo "Interface Status:"
ip -br addr show
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf
echo ""
echo "Testing internet:"
ping -c 3 8.8.8.8
echo ""
echo "Testing DNS:"
ping -c 3 google.com
echo "========================================="

#!/bin/bash
# Konfigurasi Client Cirdan dengan DNS Configuration (20 host / Lycaon)

echo "========================================="
echo "Configuring Cirdan Client"
echo "========================================="

# Konfigurasi IP (contoh untuk host pertama)
echo "Configuring interface..."
ip link set eth0 up
ip addr flush dev eth0

ip addr add 192.212.0.131/25 dev eth0  # A7

# Default gateway ke AnduinBanks
ip route add default via 192.212.0.129

# DNS Configuration
echo "Configuring DNS..."
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

echo ""
echo "Cirdan configuration completed"
echo "IP Range Available: 192.212.0.129 - 192.212.0.254"
echo "(Shared subnet with Gilgalad)"
echo ""
echo "========================================="
echo "Interface Status:"
ip -br addr show
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf
echo ""
echo "Testing internet:"
ping -c 3 8.8.8.8
echo ""
echo "Testing DNS:"
ping -c 3 google.com
echo "========================================="

#!/bin/bash

# Script untuk test konektivitas seluruh jaringan

echo "========================================"
echo "ALLIANCE NETWORK CONNECTIVITY TEST"
echo "========================================"
echo ""

# Function untuk test ping
test_ping() {
    local target=$1
    local name=$2
    echo -n "Testing $name ($target): "
    if ping -c 2 -W 2 $target > /dev/null 2>&1; then
        echo "✓ REACHABLE"
        return 0
    else
        echo "✗ UNREACHABLE"
        return 1
    fi
}

echo "=== ROUTER TO ROUTER ==="
test_ping 192.212.0.29 "Osgiliath"
test_ping 192.212.0.30 "Moria"
test_ping 192.212.0.34 "Rivendell"
test_ping 192.212.0.38 "Minastir"
test_ping 192.212.0.42 "Pelargir"
test_ping 192.212.0.46 "AnduinBanks"
test_ping 192.212.0.26 "Wilderland"
echo ""

echo "=== SERVERS ==="
test_ping 192.212.0.18 "IronHills (Web Server)"
test_ping 192.212.0.22 "Palantir (Web Server)"
test_ping 192.212.0.50 "Vilya (DHCP Server)"
test_ping 192.212.0.51 "Narya (DNS Server)"
echo ""

echo "=== CLIENTS ==="
test_ping 192.212.0.66 "Durin (Caesar)"
test_ping 192.212.0.58 "Khamul (Burnice) ⚠️ TRAITOR"
test_ping 192.212.1.2 "Elendil (Jane)"
test_ping 192.212.1.3 "Isildur (Policeboo)"
test_ping 192.212.0.130 "Gilgalad (Ellen)"
test_ping 192.212.0.131 "Cirdan (Lycaon)"
echo ""

echo "========================================"
echo "TEST COMPLETED"
echo "========================================"
echo ""
echo "Current device routing table:"
ip route show
echo ""
echo "Current device interfaces:"
ip -br addr show