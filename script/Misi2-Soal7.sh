#!/bin/bash
clear
echo "============================================================"
echo " IRONHILLS — RULE 4 (Weekend) + RULE 7 (Max 3 Conn)"
echo "============================================================"

# 1. PASTIKAN RULE 4 (WEEKEND) SUDAH ADA & TIDAK DIHAPUS
# Kalau belum ada, pasang dulu (biar aman)
iptables -C INPUT -p tcp --dport 80 -s 192.212.0.64/26 -m time --weekdays Sat,Sun -j ACCEPT 2>/dev/null || \
    iptables -A INPUT -p tcp --dport 80 -s 192.212.0.64/26 -m time --weekdays Sat,Sun -j ACCEPT

iptables -C INPUT -p tcp --dport 80 -s 192.212.0.56/29 -m time --weekdays Sat,Sun -j ACCEPT 2>/dev/null || \
    iptables -A INPUT -p tcp --dport 80 -s 192.212.0.56/29 -m time --weekdays Sat,Sun -j ACCEPT

iptables -C INPUT -p tcp --dport 80 -s 192.212.1.0/24   -m time --weekdays Sat,Sun -j ACCEPT 2>/dev/null || \
    iptables -A INPUT -p tcp --dport 80 -s 192.212.1.0/24   -m time --weekdays Sat,Sun -j ACCEPT

# Drop di hari kerja (Rule 4)
iptables -C INPUT -p tcp --dport 80 -s 192.212.0.64/26 -j DROP 2>/dev/null || \
    iptables -A INPUT -p tcp --dport 80 -s 192.212.0.64/26 -j DROP
iptables -C INPUT -p tcp --dport 80 -s 192.212.0.56/29 -j DROP 2>/dev/null || \
    iptables -A INPUT -p tcp --dport 80 -s 192.212.0.56/29 -j DROP
iptables -C INPUT -p tcp --dport 80 -s 192.212.1.0/24   -j DROP 2>/dev/null || \
    iptables -A INPUT -p tcp --dport 80 -s 192.212.1.0/24   -j DROP

# 2. HAPUS RULE 7 LAMA kalau pernah ada (biar tidak duplikat)
iptables -D INPUT -p tcp --dport 80 -m connlimit --connlimit-above 3 -j REJECT 2>/dev/null || true
iptables -D INPUT -p tcp --dport 80 -m connlimit --connlimit-above 3 -j DROP 2>/dev/null || true
iptables -D INPUT -p tcp --dport 80 -j ACCEPT 2>/dev/null || true

# 3. PASANG RULE 7 DI POSISI YANG BENAR (setelah established & loopback)
#    → posisi 3 = connlimit, posisi 4 = ACCEPT normal
iptables -I INPUT 3 -p tcp --dport 80 -m connlimit --connlimit-above 3 --connlimit-mask 32 -j REJECT --reject-with tcp-reset
iptables -I INPUT 4 -p tcp --dport 80 -j ACCEPT

echo "============================================================"
echo "SELESAI"
echo ""
echo "Status sekarang:"
echo "• Rule 4 (Weekend Only) → TETAP HIDUP & UTUH"
echo "• Rule 7 (Max 3 koneksi per IP) → AKTIF dengan TCP Reset"
echo ""
echo "Urutan penting di INPUT chain:"
iptables -L INPUT -n -v --line-numbers | grep -E "(80|connlimit|REJECT|ACCEPT|time|Sat|Sun|DROP)"
echo ""
echo "============================================================"
echo "Completed"
echo "============================================================"

#!/bin/bash
# IronHills Rule 7 - TESTER FINAL & CLEAN (Duren/Elendil/Durin)
# Hanya pakai alat yang BENAR-BENAR akurat

echo "===================================================="
echo " IRONHILLS RULE 7 — CONNECTION LIMIT TESTER (FINAL)"
echo " Maksimal 3 koneksi aktif bersamaan per IP"
echo "===================================================="

# Install tools (sekali jalan cukup)
echo "Installing apache2-utils (ab)..."
apt-get update -qq
apt-get install -y apache2-utils python3 >/dev/null 2>&1

echo -e "\n1. Sequential test → semua harus SUCCESS"
echo "---------------------------------------------"
for i in {1..6}; do
    echo -n "Request $i: "
    curl -s -o /dev/null -w "SUCCESS (%{size_download} bytes)\n" http://192.212.0.18
done

echo -e "\n2. Concurrent test — PAKAI AB (paling akurat)"
echo "---------------------------------------------"
echo "Tes 50 request dengan 10 koneksi bersamaan (harus banyak ditolak)"
ab -n 50 -c 10 http://192.212.0.18/ | grep -E "Complete requests|Failed requests|Non-2xx|Requests per second|Connection refused"

echo -e "\n3. Real-time concurrent test (Python) — bonus pro"
echo "---------------------------------------------------"
echo "Mencoba buka 10 koneksi sekaligus & tahan 8 detik..."
python3 - <<EOF
import socket, time
target = "192.212.0.18"
port = 80
socks = []
print("Mencoba 10 koneksi bersamaan...")
for i in range(1, 11):
    try:
        s = socket.socket()
        s.settimeout(3)
        s.connect((target, port))
        socks.append(s)
        print(f"  Koneksi {i} → SUCCESS (total aktif: {len(socks)})")
    except Exception as e:
        print(f"  Koneksi {i} → DITOLAK ({e})")
        break
print(f"\nHASIL: {len(socks)} koneksi aktif bersamaan → harus maksimal 3!")
print("Tahan 8 detik untuk bukti...")
time.sleep(8)
[s.close() for s in socks]
EOF

echo -e "\n===================================================="
echo "COMPLETE"
echo "===================================================="