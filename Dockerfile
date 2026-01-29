FROM mcr.microsoft.com/powershell:latest

RUN apt-get update && apt-get install -y cron && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]