# bash-scripts

Linux CLI Bash scripts for technical SEO, cybersecurity, and web engineering.

This repository contains small Bash scripts I use to inspect websites directly from the command line.

The goal of these scripts is clarity, verification, and truth from the system itself.
I prefer observing real behavior at the infrastructure level instead of relying only on plugins or dashboards.

---

## Scripts

### seo-headers.sh

Checks:
- HTTP status chain
- Redirect count
- Final destination URL
- Server header

Usage:
./seo-headers.sh example.com

Why this exists:
SEO, security, and infrastructure overlap.
This script helps verify how a site actually responds on the network.

---

### site-check.sh

Checks:
- Site availability
- Final HTTP status
- Redirect behavior
- Total request time
- Time to First Byte (TTFB)
- Final canonical URL

Usage:
./site-check.sh example.com

Note:
Input domain only. Do not include protocol (https://).

---

### seo-health.sh

A combined infrastructure-level SEO health check.

This script brings multiple checks together in one run:
- HTTP status
- Redirect count
- Total request time
- Time to First Byte (TTFB)
- Final URL resolution

Usage:
./seo-health.sh example.com

Why this exists:
Before browser tools and performance scores, the server must be healthy.
This script provides a fast, repeatable way to validate that foundation.

---

## Philosophy

These scripts are intentionally simple.

They are read-only.
They do not modify systems.
They are designed for learning, auditing, and verification.

The CLI provides fewer assumptions and clearer answers.
