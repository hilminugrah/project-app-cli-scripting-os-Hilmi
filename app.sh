#!/bin/bash

# Warna untuk output
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Array untuk menyimpan daftar tugas
declare -a tugas_list
declare -a status_list

# Fungsi menampilkan menu
function show_menu() {
  echo -e "${CYAN}===== Aplikasi Pengelola Tugas Mahasiswa =====${NC}"
  echo "1. Tambah Tugas"
  echo "2. Lihat Daftar Tugas"
  echo "3. Hapus Tugas"
  echo "4. Statistik Tugas"
  echo "5. Keluar"
  echo -n "Pilih menu [1-5]: "
}

# Fungsi tambah tugas
function tambah_tugas() {
  read -p "Masukkan nama tugas: " nama
  if [[ -z "$nama" ]]; then
    echo -e "${RED}Nama tugas tidak boleh kosong.${NC}"
    return
  fi

  # Cek duplikat
  for tugas in "${tugas_list[@]}"; do
    if [[ "$tugas" == "$nama" ]]; then
      echo -e "${RED}Tugas dengan nama ini sudah ada.${NC}"
      return
    fi
  done

  read -p "Masukkan status tugas (selesai/belum): " status
  if [[ "$status" != "selesai" && "$status" != "belum" ]]; then
    echo -e "${RED}Status hanya boleh 'selesai' atau 'belum'.${NC}"
    return
  fi

  tugas_list+=("$nama")
  status_list+=("$status")
  echo -e "${GREEN}Tugas berhasil ditambahkan.${NC}"
}

