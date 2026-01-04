#!/bin/bash

# Website Availability & SEO Status Check
# Author: Christopher | Sunpath SEO
# Checks: final HTTP status, redirect count, latency, final URL

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================"
echo -e "      Website Availability Check"
echo -e "========================================${NC}"

SITE="$1"

if [[ -z "$SITE" ]]; then
  echo -e "${YELLOW}Usage:${NC} ./site-status.sh example.com"
  exit 1
fi

echo -e "[*] Checking: ${BLUE}$SITE${NC}"

URL="https://$SITE"

# 1) Final status + time + final URL (follows redirects)
RESULT=$(curl -s -L -o /dev/null \
  --connect-timeout 5 --max-time 15 \
  -w "%{http_code}|%{time_total}|%{url_effective}" \
  "$URL")

IFS="|" read -r CODE TIME FINAL_URL <<< "$RESULT"

# 2) Redirect count (count HTTP response lines in headers, then subtract 1)
HOPS=$(curl -s -I -L \
  --connect-timeout 5 --max-time 15 \
  "$URL" | grep -c '^HTTP/')
REDIRECTS=$((HOPS - 1))
if (( REDIRECTS < 0 )); then REDIRECTS=0; fi

# 3) Health label
LABEL="${YELLOW}UNKNOWN${NC}"
if [[ "$CODE" == "200" ]]; then
  LABEL="${GREEN}UP (OK)${NC}"
elif [[ "$CODE" == "000" ]]; then
  LABEL="${RED}NO RESPONSE${NC}"
elif [[ "$CODE" =~ ^4|^5 ]]; then
  LABEL="${RED}ERROR ($CODE)${NC}"
fi

echo -e "----------------------------------------"
echo -e "HTTP Status:  $CODE"
echo -e "Health:       $LABEL"
echo -e "Redirects:    $REDIRECTS"
echo -e "Latency:      $TIME seconds"
echo -e "Final URL:    $FINAL_URL"
echo -e "----------------------------------------"

# Simple SEO note
if [[ "$FINAL_URL" != "$URL"* ]]; then
  echo -e "${YELLOW}[!] SEO Note:${NC} Final URL differs from input (redirected)."
fi
