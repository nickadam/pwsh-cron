#!/bin/bash
set -e

# Write the SCRIPT env var to a ps1 file if provided
if [ -n "$SCRIPT" ]; then
  echo "$SCRIPT" > /root/script.ps1
fi

# Write the CRONJOB env var into the crontab
echo "$CRONJOB" | crontab -

# Start cron in the foreground
cron -f
