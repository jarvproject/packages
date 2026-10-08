#!/usr/bin/env bash

# Ограничиваем выполнение, если скрипт запущен не от root (sudo требуется для установки)
if [ "$EUID" -ne 0 ]; then
  echo "[ОШИБКА] Пожалуйста, запустите main.py через sudo: sudo ./main.py -i go"
  exit 1
fi

# Проверяем, какой пакетный менеджер доступен в системе
if command -v pacman &> /dev/null; then
    echo "[ОС: Arch Linux] Устанавливаю Go через pacman..."
    pacman -S --noconfirm go

elif command -v dnf &> /dev/null; then
    echo "[ОС: Fedora] Устанавливаю Go через dnf..."
    dnf install -y go

elif command -v apt-get &> /dev/null; then
    echo "[ОС: Ubuntu/Debian/Mint] Устанавливаю Go через apt..."
    apt-get update && apt-get install -y golang-go

# Дополнительно проверяем paru (AUR для Arch), если запуск идет не из-под рута
elif command -v paru &> /dev/null; then
    echo "[ОС: Arch Linux] Устанавливаю Go через paru..."
    paru -S --noconfirm go

else
    echo "[ОШИБКА] Не удалось определить пакетный менеджер для вашей системы!"
    exit 1
fi
