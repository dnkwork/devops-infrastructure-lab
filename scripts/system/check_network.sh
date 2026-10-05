#!/bin/bash

check() {
local IP="$1"
local URL="$2"
if ping -c 4 -W 1 "$IP" > /dev/null 2>&1; then
	echo "[OK] Internet working!"
else
	echo "[FAIL] Internet is not working!"
fi
if [[ -n "$URL" ]]; then
        HTTP_STATUS=$(curl -sI "$URL" | head -n 1)
        echo "[HTTP] $URL -> $HTTP_STATUS"
        echo "$(date) | $URL | $HTTP_STATUS" >> network.log
    fi
}
if [[ "$#" -eq 0 ]]; then
    IP="8.8.8.8"
    URL="http://google.com"
    check "$IP" "$URL"
else
    IP="$1"
    URL="${2:-http://google.com}"
    check "$IP" "$URL"
fi
