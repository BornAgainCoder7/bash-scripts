#!/bin/bash

echo "SEO Header Check"
echo "----------------"
echo

SITE="$1"

if [ -z "$SITE" ]; then
  echo "Usage: ./seo-headers.sh example.com"
  exit 1
fi

curl -s -I -L "https://$SITE" | grep -E 'HTTP/|server:'
FINAL_STATUS=$(curl -s -I -L "https://$SITE" | grep HTTP | tail -n 1 | awk '{print $2}')

echo
echo "Final status: $FINAL_STATUS"

REDIRECTS=$(curl -s -I -L "https://$SITE" | grep -c '^HTTP/')
REDIRECTS=$((REDIRECTS - 1))
FINAL_URL=$(curl -s -o /dev/null -w "%{url_effective}" -L "https://$SITE")

echo "Redirects: $REDIRECTS"
echo "Final URL: $FINAL_URL"
