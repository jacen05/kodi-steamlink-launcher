#!/bin/bash

SLL_LOG_FILE=/home/kodi/.kodi/temp/steamlink_launcher_debug.log

if [[ ! -f "$SLL_LOG_FILE" ]]; then
        touch "$SLL_LOG_FILE"
        chown kodi:kodi "$SLL_LOG_FILE"
fi

echo "[+] Stopping Kodi" &>> "$SLL_LOG_FILE"
/bin/systemctl stop kodi &>> "$SLL_LOG_FILE"

echo "[+] Starting Steam Link" &> "$SLL_LOG_FILE"
su kodi -c "steamlink &>> $SLL_LOG_FILE"

echo "[+] Restarting Kodi" &>> "$SLL_LOG_FILE"
/bin/systemctl start kodi &>> "$SLL_LOG_FILE"