# Jarkom-Modul-05-2025-K-02

| Nama | NRP |
| ---------------------- | ---------- |
| Nadia Kirana Afifah Prahandita | 5027241005 |
| Arya Bisma Putra Refman | 5027241036 |
----

# THE SHADOW OF THE EAST
Prolog: Pengkhianatan di Dagorlad
Perang Aliansi Terakhir (The Last Alliance) sedang berkecamuk. Sebuah jaringan komunikasi besar dibangun untuk menghubungkan pasukan Elf dan Manusia. Namun, intelijen mendeteksi bahwa Khamûl (Sang Easterling) telah berkhianat. Ia bersembunyi di pos terpencil, mencoba menyadap data strategi perang. <br>

Tugasmu adalah membangun infrastruktur jaringan Aliansi, amankan jalur komunikasi, dan isolasi sang pengkhianat sebelum ia membocorkan posisi kita ke Mordor.

## I. TOPOLOGI JARINGAN
<img width="1012" height="749" alt="image" src="https://github.com/user-attachments/assets/7043af22-e520-421b-ad7b-250168dff5b6" />

## II. MISI DAN SOAL
### Misi 1: Memetakan Medan Perang
1. Identifikasi Perangkat:
- Narya: Berfungsi sebagai DNS Server.
- Vilya: Berfungsi sebagai DHCP Server.
- Web Servers: Palantir  dan IronHills.
- Client (Pasukan):
  - Khamul: 5 host (Target/Burnice).
  - Cirdan: 20 host (Lycaon).
  - Isildur: 30 host (Policeboo).
  - Durin: 50 host (Caesar).
  - Gilgalad: 100 host (Ellen).
  - Elendil: 200 host (Jane).

2. Setelah membagi alamat IP menggunakan VLSM (Prefix IP sesuai kelompok), gambarkan pohon subnet yang menunjukkan hierarki pembagian IP di jaringan Aliansi. Lingkari subnet yang akan dilewati.
    - Membagi Subnet
      ![WhatsApp Image 2025-11-28 at 20 31 30_1b239cc9](https://github.com/user-attachments/assets/99eb143d-09e8-4b6f-82d5-1a4ddf6420f4)
      | Nama Subnet | Rute                                              | Jumlah IP | Netmask |
      | ----------- | ------------------------------------------------- | --------- | ------- |
      | **A1**      | Moria > Switch > IronHills                        | 2         | /30     |
      | **A2**      | Wilderland > Durin                                | 51        | /26     |
      | **A3**      | Wilderland > Switch > Khamul                      | 6         | /29     |
      | **A4**      | Rivendell > Switch > Vilya > Switch > Narya       | 3         | /29     |
      | **A5**      | Minastir > Switch > Elendil > Switch > Isildur    | 231       | /24     |
      | **A6**      | Pelargir > Palantir                               | 2         | /30     |
      | **A7**      | AnduinBanks > Switch > Gilgalad > Switch > Cirdan | 121       | /25     |
      | **A8**      | Moria > Wilderland                                | 2         | /30     |
      | **A9**      | Osgiliath > Moria                                 | 2         | /30     |
      | **A10**     | Osgiliath > Rivendell                             | 2         | /30     |
      | **A11**     | Osgiliath > Minastir                              | 2         | /30     |
      | **A12**     | Minastir > Pelargir                               | 2         | /30     |
      | **A13**     | Pelargir > AnduinBanks                            | 2         | /30     |
      | **Total**   | —                                                 | **428**   | **/23** |
    - Membuat Tree
      <img width="2105" height="1504" alt="tree terbaru mdl 5 1" src="https://github.com/user-attachments/assets/0b1ddbb8-1f78-4147-b05d-fd97fa56f67b" />
    - Pembagian IP
      | Subnet  | Netmask         | Network ID    | Broadcast     | Range IP                      |
      | ------- | --------------- | ------------- | ------------- | ----------------------------- |
      | **A1**  | 255.255.255.252 | 192.212.0.16  | 192.212.0.19  | 192.212.0.17 – 192.212.0.18   |
      | **A2**  | 255.255.255.192 | 192.212.0.64  | 192.212.0.127 | 192.212.0.65 – 192.212.0.126  |
      | **A3**  | 255.255.255.248 | 192.212.0.56  | 192.212.0.63  | 192.212.0.57 – 192.212.0.62   |
      | **A4**  | 255.255.255.248 | 192.212.0.48  | 192.212.0.55  | 192.212.0.49 – 192.212.0.54   |
      | **A5**  | 255.255.255.0   | 192.212.1.0   | 192.212.1.255 | 192.212.1.1 – 192.212.1.254   |
      | **A6**  | 255.255.255.252 | 192.212.0.20  | 192.212.0.23  | 192.212.0.21 – 192.212.0.22   |
      | **A7**  | 255.255.255.128 | 192.212.0.128 | 192.212.0.255 | 192.212.0.129 – 192.212.0.254 |
      | **A8**  | 255.255.255.252 | 192.212.0.24  | 192.212.0.27  | 192.212.0.25 – 192.212.0.26   |
      | **A9**  | 255.255.255.252 | 192.212.0.28  | 192.212.0.31  | 192.212.0.29 – 192.212.0.30   |
      | **A10** | 255.255.255.252 | 192.212.0.32  | 192.212.0.35  | 192.212.0.33 – 192.212.0.34   |
      | **A11** | 255.255.255.252 | 192.212.0.36  | 192.212.0.39  | 192.212.0.37 – 192.212.0.38   |
      | **A12** | 255.255.255.252 | 192.212.0.40  | 192.212.0.43  | 192.212.0.41 – 192.212.0.42   |
      | **A13** | 255.255.255.252 | 192.212.0.44  | 192.212.0.47  | 192.212.0.45 – 192.212.0.46   |
      
  4. Buatlah konfigurasi rute untuk menghubungkan semua subnet dengan benar. Pastikan perangkat dapat saling terhubung.
     - Osgiliath
        ```
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
        ```
        
     - Moria
        ```
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
        ```
        
     - Rivendell
        ```
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
        ```

     - Minastir
        ```
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
        ```
        
     - Pelargir
        ```
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
        ```

     - AnduinBanks
        ```
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
        ```

     - Wilderland
        ```
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
        ```

     - IronHills
        ```
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
        ```

     - Palantir
        ```
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
        ```

     - Vilya
        ```
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
        ```

     - Narya
        ```
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
        ```

     - Durin
        ```
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
        ```

     - Khamul
        ```
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
        ```

     - Elendil
        ```
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
        ```

     - Isildur
        ```
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
        ```

     - Gilgalad
        ```
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
        ```

     - Cirdan
        ```
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
        ```

     - Test Semua Koneksi
        ```
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
        ```
        <img width="633" height="630" alt="image" src="https://github.com/user-attachments/assets/5538d4a8-5f08-46ee-95c8-7dc972a70ef0" />

4. Konfigurasi Service → Dikerjakan setelah Misi 2 No. 1:
    - Vilya sebagai DHCP Server agar perangkat dalam Khamul, Durin, Gilgalad, Elendil, Cirdan, dan Isildur menerima IP otomatis.
    - AnduinBanks, Rivendell, dan Minastir berfungsi sebagai DHCP Relay.
    - Narya sebagai DNS Server.
    - Palantir dan IronHills sebagai Web Server (Apache/Nginx).
    - Buat index.html berisikan : "Welcome to {hostname}".

    Penyelesaian: <br>
    - Vilya (DHCP Server)
        ```
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
        ```
        
    - Rivendell (DHCP Relay)
      ```
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
      ```
      
    - Minastir (DHCP Relay)
      ```
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
      ```

    - AnduinBanks (DHCP Relay)
      ```
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
      ```

    - Wilderland (DHCP Relay)
      ```
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
      ```

    - Moria (DHCP Relay)
      ```
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
      ```

    - Narya (DNS Server)
      ```
      #!/bin/bash
      # Narya - DNS Server (FIXED - Direct Named Daemon)
      
      echo "========================================="
      echo "Configuring Narya as DNS Server"
      echo "========================================="
      
      # Update package list
      apt-get update
      
      # Install BIND9 dan dependencies
      apt-get install -y bind9 bind9utils dnsutils
      
      # Backup konfigurasi default
      cp /etc/bind/named.conf.options /etc/bind/named.conf.options.backup
      
      # Konfigurasi BIND9
      cat > /etc/bind/named.conf.options << 'EOF'
      options {
          directory "/var/cache/bind";
      
          forwarders {
              8.8.8.8;
              8.8.4.4;
          };
      
          dnssec-validation auto;
          listen-on-v6 { any; };
          
          allow-query { any; };
          auth-nxdomain no;
          listen-on { any; };
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
      /usr/sbin/named -u bind -c /etc/bind/named.conf &
      
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
      
      echo "Test 1: narya.alliance.local"
      dig @127.0.0.1 narya.alliance.local +short
      
      echo ""
      echo "Test 2: ironhills.alliance.local"
      dig @127.0.0.1 ironhills.alliance.local +short
      
      echo ""
      echo "Test 3: vilya.alliance.local"
      dig @127.0.0.1 vilya.alliance.local +short
      
      echo ""
      echo "Test 4: durin.alliance.local"
      dig @127.0.0.1 durin.alliance.local +short
      
      echo ""
      echo "Test 5: Reverse lookup 192.212.0.51"
      dig @127.0.0.1 -x 192.212.0.51 +short
      
      echo ""
      echo "========================================="
      echo "DNS Configuration Complete!"
      echo "========================================="
      ```

    - IronHills (Web Server)
      ```
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
      ```

    - Palantir (Web Server)
      ```
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
      ```

    - Durin (Client - DHCP)
      ```
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
      ```

    - Khamul (Client - DHCP) - TRAITOR
      ```
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
      ```

    - Elendil (Client - DHCP)
      ```
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
      ```

    - Isildur (Client - DHCP)
      ```
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
      ```
      
    - Gilgalad (Client - DHCP)
      ```
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
      ```

    - Cirdan (Client - DHCP)
      ```
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
      ```

    - Test
      ```
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
      test_ping 192.212.0.66 "Durin (Caesar)"
      test_ping 192.212.0.58 "Khamul (Burnice) ⚠️ TRAITOR"
      test_ping 192.212.1.2 "Elendil (Jane)"
      test_ping 192.212.1.3 "Isildur (Policeboo)"
      test_ping 192.212.0.130 "Gilgalad (Ellen)"
      test_ping 192.212.0.131 "Cirdan (Lycaon)"
      echo ""
      
      echo "========================================"
      echo "TEST COMPLETED - ALL SYSTEMS OPERATIONAL"
      echo "========================================"
      ```
      <img width="814" height="990" alt="image" src="https://github.com/user-attachments/assets/c95266c4-0683-4ff2-a15f-1b103f97cbc9" />

### Misi 2: Menemukan Jejak Kegelapan (Security Rules)
Agar jaringan aman, terapkan aturan firewall berikut. 

1. Agar jaringan Aliansi bisa terhubung ke luar (Valinor/Internet), konfigurasi routing menggunakan iptables.
    - Syarat: Kalian TIDAK DIPERBOLEHKAN menggunakan target MASQUERADE.
    - Osgiliath
      ```
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
      ```
      
    - Uji
      - Di Osgiliath - Cek NAT rules
        ```
        iptables -t nat -L -n -v
        ```
        <img width="1086" height="277" alt="image" src="https://github.com/user-attachments/assets/a7bdc8ec-e82a-4032-bc32-f3608f3d87b9" />

      - Dari CLIENT (Durin, Elendil, dll)
        ```
        ping -c 3 8.8.8.8
        curl -I http://google.com
        ```
        <img width="1784" height="473" alt="image" src="https://github.com/user-attachments/assets/c2814b10-9b5b-467d-89b5-91858f051ab4" />


2. Karena Vilya (DHCP) menyimpan data vital, pastikan tidak ada perangkat lain yang bisa melakukan PING ke Vilya.
    - Namun, Vilya tetap leluasa dapat mengakses/ping ke seluruh perangkat lain.
    - Vilya
      ```
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
      ```

    - Uji
      - Dari CLIENT (Durin) - Should FAIL
        ```
        ping -c 3 192.212.0.50
        ```
        <img width="644" height="108" alt="image" src="https://github.com/user-attachments/assets/90c9d1de-6dbb-4f5d-8907-0a4bbe3d1266" />
        
      - Dari Vilya - Should SUCCESS
        ```
        ping -c 3 192.212.0.51  # ping Narya
        ping -c 3 8.8.8.8       # ping Internet
        ```
        <img width="643" height="398" alt="image" src="https://github.com/user-attachments/assets/8177b3b1-7199-4f02-bc55-fbd674ec7f48" />

3. Agar lokasi pasukan tidak bocor, hanya Vilya yang dapat mengakses Narya (DNS).
    - Gunakan nc (netcat) untuk memastikan akses port DNS (53) ini.
    - [Hapus aturan ini setelah pengujian agar internet lancar untuk install paket]
    - 

4. Aktivitas mencurigakan terdeteksi di IronHills. Berdasarkan dekrit Raja, IronHills hanya boleh diakses pada Akhir Pekan (Sabtu & Minggu).
    - Akses hanya diizinkan untuk Faksi Kurcaci & Pengkhianat (Durin & Khamul) serta Faksi Manusia (Elendil & Isildur).
    - Karena hari ini adalah Rabu (Simulasikan waktu server), mereka harusnya tertolak. Gunakan curl untuk membuktikan blokir waktu ini.

5. Sembari menunggu, pasukan berlatih di server Palantir. Akses dibatasi berdasarkan ras:
    - Faksi Elf (Gilgalad & Cirdan): Boleh akses jam 07.00 - 15.00.
    - Faksi Manusia (Elendil & Isildur): Boleh akses jam 17.00 - 23.00.
    - Gunakan curl untuk memastikan akses sesuai jam.

6. Pasukan Manusia (Elendil) diminta menguji keamanan Palantir. Lakukan simulasi port scan dengan nmap rentang port 1-100.
    - Web server harus memblokir scan port yang melebihi 15 port dalam waktu 20 detik.
    - Penyerang yang terblokir tidak dapat melakukan ping, nc, atau curl ke Palantir.
    - Catat log iptables dengan prefix "PORT_SCAN_DETECTED".

7. Hari Sabtu tiba. Akses ke IronHills dibatasi untuk mencegah overload.
    - Akses ke IronHills hanya boleh berasal dari 3 koneksi aktif per IP dalam waktu bersamaan.
    - Lakukan uji coba beban (stress test) menggunakan curl atau ab.

8. Selama uji coba, terdeteksi anomali. Setiap paket yang dikirim Vilya menuju Khamul, ternyata dibelokkan oleh sihir hitam menuju IronHills.
    - Gunakan nc untuk memastikan alur pengalihan ini (Redirect trafik dari Client ke Server).
