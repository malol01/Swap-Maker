#!/bin/bash

# Solicită utilizatorului să introducă cantitatea dorită de swap
read -p "Câți GB de swap dorești să aloci? " swap_size_gb

# Verificăm dacă inputul este un număr
if ! [[ "$swap_size_gb" =~ ^[0-9]+$ ]]; then
    echo "Te rog introdu un număr valid."
    exit 1
fi

# Definim numele fișierului de swap
swap_file="/swapfile"

# Calculăm dimensiunea în MB
swap_size_mb=$((swap_size_gb * 1024))

# Cream fișierul de swap
sudo fallocate -l "${swap_size_mb}M" "$swap_file"

# Verificăm dacă s-a creat fișierul cu succes
if [ $? -ne 0 ]; then
    echo "A fost o eroare în crearea fișierului de swap."
    exit 1
fi

# Setăm permisiunile corecte
sudo chmod 600 "$swap_file"

# Setăm swap-ul
sudo mkswap "$swap_file"
sudo swapon "$swap_file"

# Adăugăm intrarea în /etc/fstab pentru a face swap-ul permanent
echo "$swap_file none swap sw 0 0" | sudo tee -a /etc/fstab > /dev/null

echo "Swap de $swap_size_gb GB a fost creat cu succes."
