# pwsh-cron

A Docker container that runs PowerShell scripts on a cron schedule.

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `CRONJOB` | Yes | A cron expression followed by the command to run. |
| `SCRIPT` | No | PowerShell code to write to `/root/script.ps1` at startup. |

## Quick Start

```bash
docker compose up --build
```

## Examples

### Inline command every hour

```yaml
services:
  pwsh-cron:
    build: .
    environment:
      - CRONJOB=0 * * * * pwsh -Command "Get-Date | Out-File -Append /var/log/cron.log"
```

### Script from environment variable every minute

```yaml
services:
  pwsh-cron:
    build: .
    environment:
      - CRONJOB=* * * * * pwsh -File /root/script.ps1
      - SCRIPT=Get-Date | Out-File -Append /var/log/cron.log
```

### Multi-line script every day at midnight

```yaml
services:
  pwsh-cron:
    build: .
    environment:
      - CRONJOB=0 0 * * * pwsh -File /root/script.ps1
      - |
        SCRIPT=
        $$results = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
        $$results | Out-File -Append /var/log/cron.log
        Get-Date | Out-File -Append /var/log/cron.log
```

## Cron Schedule Reference

```
* * * * *
| | | | |
| | | | +-- Day of week (0-7, Sun=0 or 7)
| | | +---- Month (1-12)
| | +------ Day of month (1-31)
| +-------- Hour (0-23)
+---------- Minute (0-59)
```

| Expression | Schedule |
|------------|----------|
| `* * * * *` | Every minute |
| `0 * * * *` | Every hour |
| `0 0 * * *` | Every day at midnight |
| `0 0 * * 0` | Every Sunday at midnight |
| `*/5 * * * *` | Every 5 minutes |
