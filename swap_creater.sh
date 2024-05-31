#!/bin/bash

# Solicităm utilizatorului să introducă dimensiunea dorită pentru fișierul de swap
read -p "Introdu dimensiunea dorită pentru fișierul de swap (în GB): " size

# Cream fișierul de swap cu dimensiunea specificată
sudo fallocate -l ${size}G /swapfile

# Setăm permisiunile pentru fișierul de swap
sudo chmod 600 /swapfile

# Cream swap pe fișierul respectiv
sudo mkswap /swapfile

# Activăm swap pe fișierul respectiv
sudo swapon /swapfile

# Adăugăm linia corespunzătoare în fișierul /etc/fstab la sfârșit
echo "/swapfile swap swap defaults 0 0" | sudo tee -a /etc/fstab > /dev/null

# Afisăm informații despre swap
sudo swapon --show

# Afisăm un mesaj de felicitare
echo "Bravo ba ai facut Swap in sfarsit =))"
