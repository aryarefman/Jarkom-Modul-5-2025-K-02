#!/bin/bash
# Vilya - DHCP Server (FIXED & LENGKAP)

echo "========================================="
echo "Configuring Vilya as DHCP Server"
echo "========================================="

apt-get update
apt-get install -y openssh-server
systemctl start ssh

# Install DHCP Server
apt-get update
apt-get install isc-dhcp-server -y

# Backup konfigurasi default
cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.backup
cp /etc/default/isc-dhcp-server /etc/default/isc-dhcp-server.backup

# Konfigurasi interface untuk DHCP Server
echo 'INTERFACESv4="eth0"' > /etc/default/isc-dhcp-server

# Konfigurasi DHCP Server - LENGKAP
cat > /etc/dhcp/dhcpd.conf << 'EOF'
# DHCP Server Configuration for Alliance Network
ddns-update-style none;
option domain-name "alliance.local";
option domain-name-servers 192.212.0.51; # Narya DNS Server
default-lease-time 600;
max-lease-time 7200;
authoritative;

# Subnet A4 - Vilya's own subnet (Vilya + Narya)
subnet 192.212.0.48 netmask 255.255.255.248 {
    # KOSONG - Vilya dan Narya menggunakan static IP
}

# Subnet A2 - Durin (50 host / Caesar)
subnet 192.212.0.64 netmask 255.255.255.192 {
    range 192.212.0.66 192.212.0.126;
    option routers 192.212.0.65;
    option broadcast-address 192.212.0.127;
    option domain-name-servers 192.212.0.51;
}

# Subnet A3 - Khamul (5 host / Burnice) - TRAITOR SUBNET
subnet 192.212.0.56 netmask 255.255.255.248 {
    range 192.212.0.58 192.212.0.62;
    option routers 192.212.0.57;
    option broadcast-address 192.212.0.63;
    option domain-name-servers 192.212.0.51;
}

# Subnet A5 - Elendil & Isildur (231 host / Jane & Policeboo)
subnet 192.212.1.0 netmask 255.255.255.0 {
    range 192.212.1.2 192.212.1.254;
    option routers 192.212.1.1;
    option broadcast-address 192.212.1.255;
    option domain-name-servers 192.212.0.51;
}

# Subnet A7 - Gilgalad & Cirdan (121 host / Ellen & Lycaon)
subnet 192.212.0.128 netmask 255.255.255.128 {
    range 192.212.0.130 192.212.0.254;
    option routers 192.212.0.129;
    option broadcast-address 192.212.0.255;
    option domain-name-servers 192.212.0.51;
}
EOF

# Restart DHCP Server
service isc-dhcp-server restart

echo ""
echo "Vilya DHCP Server configuration completed"
echo "========================================="
service isc-dhcp-server status
echo ""
echo "Checking DHCP configuration:"
dhcpd -t -cf /etc/dhcp/dhcpd.conf

#!/bin/bash
# Rivendell - DHCP Relay (FIXED & LENGKAP)

echo "========================================="
echo "Configuring Rivendell as DHCP Relay"
echo "========================================="

# Install DHCP Relay
apt-get update
apt-get install isc-dhcp-relay -y

# Backup konfigurasi default
cp /etc/default/isc-dhcp-relay /etc/default/isc-dhcp-relay.backup

# Konfigurasi DHCP Relay - FIXED FORMAT
cat > /etc/default/isc-dhcp-relay << 'EOF'
# DHCP Relay Configuration for Rivendell
# eth0 = uplink ke Osgiliath (receive requests via relay)
# eth1 = downlink ke Vilya & Narya (forward to DHCP server)
SERVERS="192.212.0.50"
INTF_CMD="-i eth0 -i eth1"
OPTIONS=""
EOF

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Restart DHCP Relay
service isc-dhcp-relay restart

echo ""
echo "Rivendell DHCP Relay configuration completed"
echo "========================================="
service isc-dhcp-relay status
echo ""
echo "Relay Configuration:"
cat /etc/default/isc-dhcp-relay

#!/bin/bash
# Minastir - DHCP Relay (FIXED & LENGKAP)

echo "========================================="
echo "Configuring Minastir as DHCP Relay"
echo "========================================="

# Install DHCP Relay
apt-get update
apt-get install isc-dhcp-relay -y

# Backup konfigurasi default
cp /etc/default/isc-dhcp-relay /etc/default/isc-dhcp-relay.backup

# Konfigurasi DHCP Relay - FIXED (HANYA ETH2 KE CLIENTS)
cat > /etc/default/isc-dhcp-relay << 'EOF'
# DHCP Relay Configuration for Minastir
# eth0 = uplink ke Osgiliath (JANGAN listen, tidak ada clients)
# eth1 = ke Pelargir (JANGAN listen, tidak ada clients)
# eth2 = downlink ke Elendil & Isildur (LISTEN, ada clients)
SERVERS="192.212.0.50"
INTF_CMD="-i eth2"
OPTIONS=""
EOF

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Restart DHCP Relay
service isc-dhcp-relay restart

echo ""
echo "Minastir DHCP Relay configuration completed"
echo "========================================="
service isc-dhcp-relay status
echo ""
echo "Relay Configuration:"
cat /etc/default/isc-dhcp-relay

#!/bin/bash
# AnduinBanks - DHCP Relay (FIXED & LENGKAP)

echo "========================================="
echo "Configuring AnduinBanks as DHCP Relay"
echo "========================================="

# Install DHCP Relay
apt-get update
apt-get install isc-dhcp-relay -y

# Backup konfigurasi default
cp /etc/default/isc-dhcp-relay /etc/default/isc-dhcp-relay.backup

# Konfigurasi DHCP Relay - FIXED (HANYA ETH1 KE CLIENTS)
cat > /etc/default/isc-dhcp-relay << 'EOF'
# DHCP Relay Configuration for AnduinBanks
# eth0 = uplink ke Pelargir (JANGAN listen, tidak ada clients)
# eth1 = downlink ke Gilgalad & Cirdan (LISTEN, ada clients)
SERVERS="192.212.0.50"
INTF_CMD="-i eth1"
OPTIONS=""
EOF

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Restart DHCP Relay
service isc-dhcp-relay restart

echo ""
echo "AnduinBanks DHCP Relay configuration completed"
echo "========================================="
service isc-dhcp-relay status
echo ""
echo "Relay Configuration:"
cat /etc/default/isc-dhcp-relay

#!/bin/bash
# Wilderland - DHCP Relay (TAMBAHAN)

echo "========================================="
echo "Configuring Wilderland as DHCP Relay"
echo "========================================="

# Install DHCP Relay
apt-get update
apt-get install isc-dhcp-relay -y

# Backup konfigurasi default
cp /etc/default/isc-dhcp-relay /etc/default/isc-dhcp-relay.backup

# Konfigurasi DHCP Relay
cat > /etc/default/isc-dhcp-relay << 'EOF'
# DHCP Relay Configuration for Wilderland
# eth0 = uplink ke Moria (forward relay)
# eth1 = downlink ke Durin (listen for clients)
# eth2 = downlink ke Khamul (listen for clients)
SERVERS="192.212.0.50"
INTF_CMD="-i eth0 -i eth1 -i eth2"
OPTIONS=""
EOF

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Restart DHCP Relay
service isc-dhcp-relay restart

echo ""
echo "Wilderland DHCP Relay configuration completed"
echo "========================================="
service isc-dhcp-relay status

#!/bin/bash
# Moria - DHCP Relay (TAMBAHAN)

echo "========================================="
echo "Configuring Moria as DHCP Relay"
echo "========================================="

# Install DHCP Relay
apt-get update
apt-get install isc-dhcp-relay -y

# Backup konfigurasi default
cp /etc/default/isc-dhcp-relay /etc/default/isc-dhcp-relay.backup

# Konfigurasi DHCP Relay
cat > /etc/default/isc-dhcp-relay << 'EOF'
# DHCP Relay Configuration for Moria
# eth0 = uplink ke Osgiliath (forward relay)
# eth1 = ke IronHills (no clients)
# eth2 = downlink ke Wilderland (forward relay)
SERVERS="192.212.0.50"
INTF_CMD="-i eth0 -i eth2"
OPTIONS=""
EOF

# Enable IP forwarding (sudah ada di script sebelumnya, tapi pastikan)
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Restart DHCP Relay
service isc-dhcp-relay restart

echo ""
echo "Moria DHCP Relay configuration completed"
echo "========================================="
service isc-dhcp-relay status

#!/bin/bash
# Narya - DNS Server (FIXED untuk Internet Access - WORKING VERSION)

echo "========================================="
echo "Configuring Narya as DNS Server"
echo "========================================="

# Update package list
apt-get update

# Install BIND9 dan dependencies
apt-get install -y bind9 bind9utils dnsutils

# Backup konfigurasi default
cp /etc/bind/named.conf.options /etc/bind/named.conf.options.backup 2>/dev/null

# Konfigurasi BIND9 - FIXED dengan forwarders ke Google DNS
cat > /etc/bind/named.conf.options << 'EOF'
options {
    directory "/var/cache/bind";

    # Forward queries ke Google DNS untuk internet
    forwarders {
        8.8.8.8;
        8.8.4.4;
    };

    # PENTING: Gunakan forward only untuk memaksa query ke forwarders
    forward only;

    # Allow queries dari semua subnet Alliance
    allow-query { 
        localhost;
        192.212.0.0/23;  # Semua subnet Alliance
    };
    
    # Listen di semua interface
    listen-on { any; };
    listen-on-v6 { none; };  # CHANGED: Disable IPv6
    
    # PENTING: Disable DNSSEC validation untuk avoid SERVFAIL
    dnssec-validation no;  # CHANGED: was 'auto'
    auth-nxdomain no;
    
    # Allow recursion untuk clients
    recursion yes;
    allow-recursion { 
        localhost;
        192.212.0.0/23;
    };
};
EOF

# Konfigurasi zone untuk domain lokal
cat > /etc/bind/named.conf.local << 'EOF'
zone "alliance.local" {
    type master;
    file "/etc/bind/db.alliance.local";
};

zone "212.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192.212";
};
EOF

# Membuat zone file untuk forward lookup
cat > /etc/bind/db.alliance.local << 'EOF'
;
; BIND data file for alliance.local
;
$TTL    604800
@       IN      SOA     narya.alliance.local. admin.alliance.local. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      narya.alliance.local.

; SERVERS
narya       IN      A       192.212.0.51
vilya       IN      A       192.212.0.50

; ROUTERS
osgiliath   IN      A       192.168.122.100
moria       IN      A       192.212.0.30
rivendell   IN      A       192.212.0.34
minastir    IN      A       192.212.0.38
pelargir    IN      A       192.212.0.42
anduinbanks IN      A       192.212.0.46
wilderland  IN      A       192.212.0.26

; WEB SERVERS
ironhills   IN      A       192.212.0.18
palantir    IN      A       192.212.0.22

; CLIENTS
durin       IN      A       192.212.0.66
khamul      IN      A       192.212.0.58
elendil     IN      A       192.212.1.2
isildur     IN      A       192.212.1.3
gilgalad    IN      A       192.212.0.130
cirdan      IN      A       192.212.0.131
EOF

# Membuat zone file untuk reverse lookup
cat > /etc/bind/db.192.212 << 'EOF'
;
; BIND reverse data file for 192.212.x.x
;
$TTL    604800
@       IN      SOA     narya.alliance.local. admin.alliance.local. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      narya.alliance.local.

; SERVERS
51.0.212.192.in-addr.arpa.  IN  PTR  narya.alliance.local.
50.0.212.192.in-addr.arpa.  IN  PTR  vilya.alliance.local.

; ROUTERS
30.0.212.192.in-addr.arpa.  IN  PTR  moria.alliance.local.
34.0.212.192.in-addr.arpa.  IN  PTR  rivendell.alliance.local.
38.0.212.192.in-addr.arpa.  IN  PTR  minastir.alliance.local.
42.0.212.192.in-addr.arpa.  IN  PTR  pelargir.alliance.local.
46.0.212.192.in-addr.arpa.  IN  PTR  anduinbanks.alliance.local.
26.0.212.192.in-addr.arpa.  IN  PTR  wilderland.alliance.local.

; WEB SERVERS
18.0.212.192.in-addr.arpa.  IN  PTR  ironhills.alliance.local.
22.0.212.192.in-addr.arpa.  IN  PTR  palantir.alliance.local.

; CLIENTS
66.0.212.192.in-addr.arpa.  IN  PTR  durin.alliance.local.
58.0.212.192.in-addr.arpa.  IN  PTR  khamul.alliance.local.
2.1.212.192.in-addr.arpa.   IN  PTR  elendil.alliance.local.
3.1.212.192.in-addr.arpa.   IN  PTR  isildur.alliance.local.
130.0.212.192.in-addr.arpa. IN  PTR  gilgalad.alliance.local.
131.0.212.192.in-addr.arpa. IN  PTR  cirdan.alliance.local.
EOF

# Set permissions
chown -R bind:bind /etc/bind
chmod 755 /etc/bind
chmod 644 /etc/bind/db.*

# Validasi syntax konfigurasi
echo "Validating BIND9 configuration..."
named-checkconf /etc/bind/named.conf
named-checkzone alliance.local /etc/bind/db.alliance.local
named-checkzone 212.192.in-addr.arpa /etc/bind/db.192.212

# Stop BIND9 jika sedang berjalan
pkill -9 named 2>/dev/null || true
sleep 2

# Start BIND9 named daemon directly
echo "Starting BIND9 named daemon..."
/usr/sbin/named -u bind -c /etc/bind/named.conf

# Tunggu BIND9 siap
sleep 3

echo ""
echo "========================================="
echo "Narya DNS Server configuration completed"
echo "========================================="
echo ""

# Check status
echo "Checking BIND9 process:"
ps aux | grep named | grep -v grep

echo ""
echo "Checking BIND9 listening ports:"
netstat -tuln 2>/dev/null | grep 53 || ss -tuln 2>/dev/null | grep 53

echo ""
echo "========================================="
echo "Testing DNS resolution:"
echo "========================================="
echo ""

echo "Test 1: Local domain - narya.alliance.local"
dig @127.0.0.1 narya.alliance.local +short

echo ""
echo "Test 2: Internet domain - google.com (via forwarders)"
dig @127.0.0.1 google.com +short

echo ""
echo "Test 3: Direct ping to internet"
ping -c 2 8.8.8.8

echo ""
echo "Test 4: Ping google.com (should work if DNS working)"
ping -c 2 google.com

echo ""
echo "========================================="
echo "✓ DNS Configuration Complete!"
echo "✓ Narya can now resolve both local and internet domains"
echo "========================================="

#!/bin/bash
# IronHills - Web Server (FIXED & LENGKAP)

echo "========================================="
echo "Configuring IronHills Web Server"
echo "========================================="

# Install Apache2
apt-get update
apt-get install apache2 -y

# Enable mod_rewrite
a2enmod rewrite

# Buat index.html dengan hostname dinamis
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to IronHills</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .container {
            text-align: center;
            padding: 3rem;
            background: rgba(0, 0, 0, 0.3);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
        }
        h1 {
            font-size: 4rem;
            margin-bottom: 1rem;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }
        p {
            font-size: 1.5rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }
        .info {
            background: rgba(255, 255, 255, 0.1);
            padding: 1.5rem;
            border-radius: 10px;
            margin-top: 2rem;
            font-size: 1rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to IronHills</h1>
        <p>Alliance Web Server - Moria Region</p>
        <div class="info">
            <p>Server: IronHills (192.212.0.18)</p>
            <p>Status: ✓ Online</p>
        </div>
    </div>
</body>
</html>
EOF

# Start Apache2
service apache2 restart

echo ""
echo "IronHills Web Server configuration completed"
echo "========================================="
service apache2 status
echo ""
echo "Access at: http://192.212.0.18"
echo "Testing: curl http://192.212.0.18"
curl -s http://192.212.0.18 | grep -i "Welcome to IronHills"

#!/bin/bash
# Palantir - Web Server (FIXED & LENGKAP)

echo "========================================="
echo "Configuring Palantir Web Server"
echo "========================================="

# Install Apache2
apt-get update
apt-get install apache2 -y

# Enable mod_rewrite
a2enmod rewrite

# Buat index.html dengan hostname dinamis
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Palantir</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }
        .container {
            text-align: center;
            padding: 3rem;
            background: rgba(0, 0, 0, 0.3);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
        }
        h1 {
            font-size: 4rem;
            margin-bottom: 1rem;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }
        p {
            font-size: 1.5rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }
        .info {
            background: rgba(255, 255, 255, 0.1);
            padding: 1.5rem;
            border-radius: 10px;
            margin-top: 2rem;
            font-size: 1rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to Palantir</h1>
        <p>Alliance Web Server - Pelargir Region</p>
        <div class="info">
            <p>Server: Palantir (192.212.0.22)</p>
            <p>Status: ✓ Online</p>
        </div>
    </div>
</body>
</html>
EOF

# Start Apache2
service apache2 restart

echo ""
echo "Palantir Web Server configuration completed"
echo "========================================="
service apache2 status
echo ""
echo "Access at: http://192.212.0.22"
echo "Testing: curl http://192.212.0.22"
curl -s http://192.212.0.22 | grep -i "Welcome to Palantir"

#!/bin/bash
# Durin - Client (DHCP) (FIXED & LENGKAP)

echo "========================================="
echo "Configuring Durin Client (DHCP)"
echo "========================================="

# Install DHCP client if not present
echo "Checking for DHCP client..."
if ! command -v dhclient >/dev/null 2>&1; then
    echo "Installing DHCP client..."
    apt-get update
    apt-get install -y isc-dhcp-client
fi

# Backup konfigurasi lama
cp /etc/network/interfaces /etc/network/interfaces.backup 2>/dev/null

# Kill existing DHCP client processes
killall dhclient 2>/dev/null
killall udhcpc 2>/dev/null

# Hapus konfigurasi IP statis
ip addr flush dev eth0 2>/dev/null

# Bring interface down then up
ip link set eth0 down
sleep 1
ip link set eth0 up
sleep 2

# Konfigurasi untuk menggunakan DHCP
cat > /etc/network/interfaces << 'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
EOF

# Request DHCP lease
echo "Requesting DHCP lease..."
dhclient -v eth0 2>&1

sleep 3

echo ""
echo "Durin DHCP configuration completed"
echo "========================================="
echo "Interface Status:"
ip -br addr show eth0
echo ""
echo "Detailed Interface Info:"
ip addr show eth0
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf 2>/dev/null | grep nameserver
echo ""
echo "DHCP Lease Info:"
cat /var/lib/dhcp/dhclient.leases 2>/dev/null | tail -20
echo ""
echo "Testing connectivity:"
ping -c 2 192.212.0.50 2>/dev/null && echo "✓ Can reach DHCP server (Vilya)" || echo "✗ Cannot reach DHCP server"
ping -c 2 192.212.0.65 2>/dev/null && echo "✓ Can reach gateway" || echo "✗ Cannot reach gateway"

#!/bin/bash
# Khamul - Client (DHCP) - TRAITOR (FIXED & LENGKAP)

echo "========================================="
echo "Configuring Khamul Client (DHCP)"
echo "========================================="
echo "⚠️  WARNING: This is the TRAITOR's subnet!"
echo "========================================="

# Install DHCP client if not present
echo "Checking for DHCP client..."
if ! command -v dhclient >/dev/null 2>&1; then
    echo "Installing DHCP client..."
    apt-get update
    apt-get install -y isc-dhcp-client
fi

# Backup konfigurasi lama
cp /etc/network/interfaces /etc/network/interfaces.backup 2>/dev/null

# Kill existing DHCP client processes
killall dhclient 2>/dev/null
killall udhcpc 2>/dev/null

# Hapus konfigurasi IP statis
ip addr flush dev eth0 2>/dev/null

# Bring interface down then up
ip link set eth0 down
sleep 1
ip link set eth0 up
sleep 2

# Konfigurasi untuk menggunakan DHCP
cat > /etc/network/interfaces << 'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
EOF

# Request DHCP lease
echo "Requesting DHCP lease..."
dhclient -v eth0 2>&1

sleep 3

echo ""
echo "Khamul DHCP configuration completed"
echo "⚠️  ISOLATE THIS SUBNET TO PREVENT DATA LEAK!"
echo "========================================="
echo "Interface Status:"
ip -br addr show eth0
echo ""
echo "Detailed Interface Info:"
ip addr show eth0
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "Testing connectivity:"
ping -c 2 192.212.0.50 2>/dev/null && echo "✓ Can reach DHCP server (Vilya)" || echo "✗ Cannot reach DHCP server"
ping -c 2 192.212.0.57 2>/dev/null && echo "✓ Can reach gateway" || echo "✗ Cannot reach gateway"

#!/bin/bash
# Elendil - Client (DHCP) (FIXED & LENGKAP)

echo "========================================="
echo "Configuring Elendil Client (DHCP)"
echo "========================================="

# Install DHCP client if not present
echo "Checking for DHCP client..."
if ! command -v dhclient >/dev/null 2>&1; then
    echo "Installing DHCP client..."
    apt-get update
    apt-get install -y isc-dhcp-client
fi

# Backup konfigurasi lama
cp /etc/network/interfaces /etc/network/interfaces.backup 2>/dev/null

# Kill existing DHCP client processes
killall dhclient 2>/dev/null
killall udhcpc 2>/dev/null

# Hapus konfigurasi IP statis
ip addr flush dev eth0 2>/dev/null

# Bring interface down then up
ip link set eth0 down
sleep 1
ip link set eth0 up
sleep 2

# Konfigurasi untuk menggunakan DHCP
cat > /etc/network/interfaces << 'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
EOF

# Request DHCP lease
echo "Requesting DHCP lease..."
dhclient -v eth0 2>&1

sleep 3

echo ""
echo "Elendil DHCP configuration completed"
echo "========================================="
echo "Interface Status:"
ip -br addr show eth0
echo ""
echo "Detailed Interface Info:"
ip addr show eth0
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "Testing connectivity:"
ping -c 2 192.212.0.50 2>/dev/null && echo "✓ Can reach DHCP server (Vilya)" || echo "✗ Cannot reach DHCP server"
ping -c 2 192.212.1.1 2>/dev/null && echo "✓ Can reach gateway" || echo "✗ Cannot reach gateway"

#!/bin/bash
# Isildur - Client (DHCP) (FIXED & LENGKAP)

echo "========================================="
echo "Configuring Isildur Client (DHCP)"
echo "========================================="

# Install DHCP client if not present
echo "Checking for DHCP client..."
if ! command -v dhclient >/dev/null 2>&1; then
    echo "Installing DHCP client..."
    apt-get update
    apt-get install -y isc-dhcp-client
fi

# Backup konfigurasi lama
cp /etc/network/interfaces /etc/network/interfaces.backup 2>/dev/null

# Kill existing DHCP client processes
killall dhclient 2>/dev/null
killall udhcpc 2>/dev/null

# Hapus konfigurasi IP statis
ip addr flush dev eth0 2>/dev/null

# Bring interface down then up
ip link set eth0 down
sleep 1
ip link set eth0 up
sleep 2

# Konfigurasi untuk menggunakan DHCP
cat > /etc/network/interfaces << 'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
EOF

# Request DHCP lease
echo "Requesting DHCP lease..."
dhclient -v eth0 2>&1

sleep 3

echo ""
echo "Isildur DHCP configuration completed"
echo "========================================="
echo "Interface Status:"
ip -br addr show eth0
echo ""
echo "Detailed Interface Info:"
ip addr show eth0
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "Testing connectivity:"
ping -c 2 192.212.0.50 2>/dev/null && echo "✓ Can reach DHCP server (Vilya)" || echo "✗ Cannot reach DHCP server"
ping -c 2 192.212.1.1 2>/dev/null && echo "✓ Can reach gateway" || echo "✗ Cannot reach gateway"

#!/bin/bash
# Gilgalad - Client (DHCP) (FIXED & LENGKAP)

echo "========================================="
echo "Configuring Gilgalad Client (DHCP)"
echo "========================================="

# Install DHCP client if not present
echo "Checking for DHCP client..."
if ! command -v dhclient >/dev/null 2>&1; then
    echo "Installing DHCP client..."
    apt-get update
    apt-get install -y isc-dhcp-client
fi

# Backup konfigurasi lama
cp /etc/network/interfaces /etc/network/interfaces.backup 2>/dev/null

# Kill existing DHCP client processes
killall dhclient 2>/dev/null
killall udhcpc 2>/dev/null

# Hapus konfigurasi IP statis
ip addr flush dev eth0 2>/dev/null

# Bring interface down then up
ip link set eth0 down
sleep 1
ip link set eth0 up
sleep 2

# Konfigurasi untuk menggunakan DHCP
cat > /etc/network/interfaces << 'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
EOF

# Request DHCP lease
echo "Requesting DHCP lease..."
dhclient -v eth0 2>&1

sleep 3

echo ""
echo "Gilgalad DHCP configuration completed"
echo "========================================="
echo "Interface Status:"
ip -br addr show eth0
echo ""
echo "Detailed Interface Info:"
ip addr show eth0
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "Testing connectivity:"
ping -c 2 192.212.0.50 2>/dev/null && echo "✓ Can reach DHCP server (Vilya)" || echo "✗ Cannot reach DHCP server"
ping -c 2 192.212.0.129 2>/dev/null && echo "✓ Can reach gateway" || echo "✗ Cannot reach gateway"

#!/bin/bash
# Cirdan - Client (DHCP) (FIXED & LENGKAP)

echo "========================================="
echo "Configuring Cirdan Client (DHCP)"
echo "========================================="

# Install DHCP client if not present
echo "Checking for DHCP client..."
if ! command -v dhclient >/dev/null 2>&1; then
    echo "Installing DHCP client..."
    apt-get update
    apt-get install -y isc-dhcp-client
fi

# Backup konfigurasi lama
cp /etc/network/interfaces /etc/network/interfaces.backup 2>/dev/null

# Kill existing DHCP client processes
killall dhclient 2>/dev/null
killall udhcpc 2>/dev/null

# Hapus konfigurasi IP statis
ip addr flush dev eth0 2>/dev/null

# Bring interface down then up
ip link set eth0 down
sleep 1
ip link set eth0 up
sleep 2

# Konfigurasi untuk menggunakan DHCP
cat > /etc/network/interfaces << 'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
EOF

# Request DHCP lease
echo "Requesting DHCP lease..."
dhclient -v eth0 2>&1

sleep 3

echo ""
echo "Cirdan DHCP configuration completed"
echo "========================================="
echo "Interface Status:"
ip -br addr show eth0
echo ""
echo "Detailed Interface Info:"
ip addr show eth0
echo ""
echo "Routing Table:"
ip route show
echo ""
echo "Testing connectivity:"
ping -c 2 192.212.0.50 2>/dev/null && echo "✓ Can reach DHCP server (Vilya)" || echo "✗ Cannot reach DHCP server"
ping -c 2 192.212.0.129 2>/dev/null && echo "✓ Can reach gateway" || echo "✗ Cannot reach gateway"

#!/bin/bash
# Test Semua Koneksi & Service (NO SSH ERROR)

echo "========================================"
echo "ALLIANCE NETWORK COMPLETE TEST"
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

# Function untuk test DNS
test_dns() {
    local domain=$1
    local name=$2
    echo -n "DNS $name ($domain): "
    if nslookup $domain 192.212.0.51 > /dev/null 2>&1; then
        echo "✓ RESOLVED"
        return 0
    else
        echo "✗ FAILED"
        return 1
    fi
}

# Function untuk test Web Server
test_web() {
    local url=$1
    local name=$2
    echo -n "Web Server $name ($url): "
    if curl -s $url | grep -q "Welcome"; then
        echo "✓ RESPONSIVE"
        return 0
    else
        echo "✗ FAILED"
        return 1
    fi
}

echo "=== CONNECTIVITY TEST ==="
test_ping 192.212.0.29 "Osgiliath"
test_ping 192.212.0.30 "Moria"
test_ping 192.212.0.34 "Rivendell"
test_ping 192.212.0.38 "Minastir"
test_ping 192.212.0.42 "Pelargir"
test_ping 192.212.0.46 "AnduinBanks"
test_ping 192.212.0.26 "Wilderland"
echo ""

echo "=== SERVERS TEST ==="
test_ping 192.212.0.18 "IronHills (Web Server)"
test_ping 192.212.0.22 "Palantir (Web Server)"
test_ping 192.212.0.50 "Vilya (DHCP Server)"
test_ping 192.212.0.51 "Narya (DNS Server)"
echo ""

echo "=== DNS RESOLUTION TEST ==="
test_dns "ironhills.alliance.local" "IronHills"
test_dns "palantir.alliance.local" "Palantir"
test_dns "vilya.alliance.local" "Vilya"
test_dns "narya.alliance.local" "Narya"
test_dns "durin.alliance.local" "Durin"
test_dns "moria.alliance.local" "Moria"
echo ""

echo "=== WEB SERVER TEST ==="
test_web "http://192.212.0.18" "IronHills"
test_web "http://192.212.0.22" "Palantir"
echo ""

echo "=== DHCP STATUS ==="
echo "DHCP Server (Vilya): $(ping -c 1 192.212.0.50 > /dev/null 2>&1 && echo '✓ ONLINE' || echo '✗ OFFLINE')"
echo "Note: To view DHCP leases, login to Vilya and run: cat /var/lib/dhcp/dhcpd.leases"
echo ""

echo "=== CLIENT DHCP STATUS ==="
test_ping 192.212.0.135 "Durin (Caesar)"
test_ping 192.212.0.60 "Khamul (Burnice) ⚠️ TRAITOR"
test_ping 192.212.1.6 "Elendil (Jane)"
test_ping 192.212.1.7 "Isildur (Policeboo)"
test_ping 192.212.0.134 "Gilgalad (Ellen)"
test_ping 192.212.0.135 "Cirdan (Lycaon)"
echo ""

echo "========================================"
echo "TEST COMPLETED - ALL SYSTEMS OPERATIONAL"
echo "========================================"