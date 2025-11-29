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
        
        # Konfigurasi Router Osgiliath (Router Pusat)
        
        echo "========================================="
        echo "Configuring Osgiliath Router"
        echo "========================================="
        
        # Enable IP forwarding
        echo "Enabling IP forwarding..."
        echo 1 > /proc/sys/net/ipv4/ip_forward
        sysctl -w net.ipv4.ip_forward=1
        
        # Konfigurasi IP untuk setiap interface
        echo "Configuring interfaces..."
        ip link set eth1 up
        ip link set eth2 up
        ip link set eth3 up
        
        ip addr flush dev eth1
        ip addr flush dev eth2
        ip addr flush dev eth3
        
        ip addr add 192.212.0.29/30 dev eth2  # ke Moria (A9)
        ip addr add 192.212.0.33/30 dev eth1  # ke Rivendell (A10)
        ip addr add 192.212.0.37/30 dev eth3  # ke Minastir (A11)
        
        # Routing ke subnet lain
        echo "Setting up routes..."
        
        # Ke arah Moria
        ip route add 192.212.0.16/30 via 192.212.0.30 dev eth2  # A1 (IronHills)
        ip route add 192.212.0.24/30 via 192.212.0.30 dev eth2  # A8 (Moria-Wilderland)
        ip route add 192.212.0.64/26 via 192.212.0.30 dev eth2  # A2 (Durin)
        ip route add 192.212.0.56/29 via 192.212.0.30 dev eth2  # A3 (Khamul)
        
        # Ke arah Rivendell
        ip route add 192.212.0.48/29 via 192.212.0.34 dev eth1  # A4 (Vilya & Narya)
        
        # Ke arah Minastir
        ip route add 192.212.1.0/24 via 192.212.0.38 dev eth3   # A5 (Elendil & Isildur)
        ip route add 192.212.0.40/30 via 192.212.0.38 dev eth3  # A12 (Minastir-Pelargir)
        ip route add 192.212.0.20/30 via 192.212.0.38 dev eth3  # A6 (Palantir)
        ip route add 192.212.0.44/30 via 192.212.0.38 dev eth3  # A13 (Pelargir-AnduinBanks)
        ip route add 192.212.0.128/25 via 192.212.0.38 dev eth3 # A7 (Gilgalad & Cirdan)
        
        echo ""
        echo "Osgiliath configuration completed"
        echo ""
        echo "========================================="
        echo "Interface Status:"
        ip -br addr show
        echo ""
        echo "Routing Table:"
        ip route show
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
        echo "========================================="
        ```

     - IronHills
        ```
        #!/bin/bash

        # Konfigurasi Web Server IronHills
        
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
        
        echo ""
        echo "IronHills configuration completed"
        echo ""
        echo "========================================="
        echo "Interface Status:"
        ip -br addr show
        echo ""
        echo "Routing Table:"
        ip route show
        echo "========================================="#!/bin/bash
        
        # Konfigurasi Web Server IronHills
        
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
        
        echo ""
        echo "IronHills configuration completed"
        echo ""
        echo "========================================="
        echo "Interface Status:"
        ip -br addr show
        echo ""
        echo "Routing Table:"
        ip route show
        echo "========================================="
        ```

     - Palantir
        ```
        #!/bin/bash

        # Konfigurasi Web Server Palantir
        
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
        
        echo ""
        echo "Palantir configuration completed"
        echo ""
        echo "========================================="
        echo "Interface Status:"
        ip -br addr show
        echo ""
        echo "Routing Table:"
        ip route show
        echo "========================================="
        ```

     - Vilya
        ```
        #!/bin/bash

        # Konfigurasi DHCP Server Vilya
        
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
        
        echo ""
        echo "Vilya configuration completed"
        echo ""
        echo "========================================="
        echo "Interface Status:"
        ip -br addr show
        echo ""
        echo "Routing Table:"
        ip route show
        echo "========================================="
        ```

     - Narya
        ```
        #!/bin/bash

        # Konfigurasi DNS Server Narya
        
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
        
        echo ""
        echo "Narya configuration completed"
        echo ""
        echo "========================================="
        echo "Interface Status:"
        ip -br addr show
        echo ""
        echo "Routing Table:"
        ip route show
        echo "========================================="
        ```

     - Durin
        ```
        #!/bin/bash

        # Konfigurasi Client Durin (50 host / Caesar)
        
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
        echo "========================================="
        ```

     - Khamul
        ```
        #!/bin/bash

        # Konfigurasi Client Khamul (5 host / Burnice) - TARGET PENGKHIANAT
        
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
        echo "========================================="
        ```

     - Elendil
        ```
        #!/bin/bash

        # Konfigurasi Client Elendil (200 host / Jane)
        
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
        echo "========================================="
        ```

     - Isildur
        ```
        #!/bin/bash

        # Konfigurasi Client Isildur (30 host / Policeboo)
        
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
        echo "========================================="
        ```

     - Gilgalad
        ```
        #!/bin/bash

        # Konfigurasi Client Gilgalad (100 host / Ellen)
        
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
        echo "========================================="
        ```

     - Cirdan
        ```
        #!/bin/bash

        # Konfigurasi Client Cirdan (20 host / Lycaon)
        
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
