#!/bin/bash

echo "Infrastructure SEO Health Check"
echo "--------------------------------"
echo

SITE="$1"

if [[ -z "$SITE" ]]; then
  echo "Usage: ./infra-check.sh example.com"
  exit 1
fi

URL="https://$SITE"

echo "Target: $URL"
echo

# 1. Final HTTP status, total time, final URL
RESULT=$(curl -s -L -o /dev/null \
  --connect-timeout 5 --max-time 15 \
  -w "%{http_code}|%{time_total}|%{time_starttransfer}|%{url_effective}" \
  "$URL")

IFS="|" read -r CODE TOTAL_TIME TTFB FINAL_URL <<< "$RESULT"

# 2. Redirect count
HOPS=$(curl -s -I -L "$URL" | grep -c '^HTTP/')
REDIRECTS=$((HOPS - 1))
if (( REDIRECTS < 0 )); then REDIRECTS=0; fi

# 3. Output
echo "HTTP Status:   $CODE"
echo "Redirects:     $REDIRECTS"
echo "Total Time:    ${TOTAL_TIME}s"
echo "TTFB:          ${TTFB}s"
echo "Final URL:     $FINAL_URL"

# 4. Simple interpretation
echo
if [[ "$CODE" == "200" ]]; then
  echo "Health:        OK"
else
  echo "Health:        Needs review"
fi

if (( REDIRECTS > 1 )); then
  echo "SEO Note:      Multiple redirects detected"
fi
