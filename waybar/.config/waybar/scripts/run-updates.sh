#!/bin/bash

# Erst Pacman mit sudo
echo "==> Pacman System Update..."
sudo pacman -Syu

# Dann yay ohne sudo
echo "==> Yay AUR Update..."
yay -Sua
