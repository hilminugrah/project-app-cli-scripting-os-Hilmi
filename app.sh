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

# Fungsi melihat tugas
function lihat_tugas() {
  if [[ ${#tugas_list[@]} -eq 0 ]]; then
    echo -e "${YELLOW}Belum ada tugas yang ditambahkan.${NC}"
    return
  fi

  echo -e "${CYAN}Daftar Tugas:${NC}"
  for i in "${!tugas_list[@]}"; do
    echo "$((i+1)). ${tugas_list[$i]} - ${status_list[$i]}"
  done
}

# Fungsi hapus tugas
function hapus_tugas() {
  lihat_tugas
  if [[ ${#tugas_list[@]} -eq 0 ]]; then
    return
  fi
  read -p "Masukkan nomor tugas yang akan dihapus: " index
  ((index--)) # karena array mulai dari 0

  if [[ "$index" -lt 0 || "$index" -ge "${#tugas_list[@]}" ]]; then
    echo -e "${RED}Nomor tugas tidak valid.${NC}"
    return
  fi

  unset 'tugas_list[index]'
  unset 'status_list[index]'
  # Reindexing array
  tugas_list=("${tugas_list[@]}")
  status_list=("${status_list[@]}")
  echo -e "${GREEN}Tugas berhasil dihapus.${NC}"
}

# Fungsi menghitung statistik
function statistik_tugas() {
  total=${#tugas_list[@]}
  selesai=0
  belum=0

  for status in "${status_list[@]}"; do
    if [[ "$status" == "selesai" ]]; then
      ((selesai++))
    else
      ((belum++))
    fi
  done

  echo -e "${CYAN}Statistik Tugas:${NC}"
  echo "Total Tugas   : $total"
  echo "Tugas Selesai : $selesai"
  echo "Tugas Belum   : $belum"
}

# Main loop
while true; do
  show_menu
  read pilihan

  case $pilihan in
    1) tambah_tugas ;;
    2) lihat_tugas ;;
    3) hapus_tugas ;;
    4) statistik_tugas ;;
    5) echo -e "${YELLOW}Keluar dari program...${NC}"; exit 0 ;;
    *) echo -e "${RED}Pilihan tidak valid!${NC}" ;;
  esac

  echo "" # Spasi
done



