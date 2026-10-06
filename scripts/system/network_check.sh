#!/bin/bash

echo "=== Перевірка системних служб ==="
if systemctl is-active --quiet nginx; then
    echo "[OK] Веб-сервер Nginx працює."
else
    echo "[WARNING] Nginx зупинено!"
fi

echo "=== Перевірка мережі ==="
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" https://github.com)

if [ "$HTTP_CODE" -eq 200 ]; then
    echo "[OK] Інтернет-з'єднання є (GitHub відповідає 200 OK)."
else
    echo "[WARNING] Проблема з мережею! Код відповіді: $HTTP_CODE"
fi
