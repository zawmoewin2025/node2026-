FROM alpine:latest
RUN apk add --no-cache ca-certificates curl unzip python3

# Xray download
RUN wget -O /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/bin/ && \
    chmod +x /usr/bin/xray && \
    rm /tmp/xray.zip

# Cloudflared download
RUN wget -O /usr/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/bin/cloudflared

RUN mkdir -p /etc/xray && chmod 777 /etc/xray

COPY index.html /etc/xray/index.html
COPY config.json /etc/xray/config.json
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3000
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]