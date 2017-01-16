FROM gliderlabs/alpine:3.4

RUN echo "Creating herokuish user" && \
    adduser -u 32767 -h /app -D herokuish && \
    echo "Installing curl" && \
    apk add --quiet --no-cache curl && \
    echo "Creating storage directories" && \
    mkdir -p /app/storage && \
    echo "Downloading minio" && \
    curl -so /app/minio "https://dl.minio.io/server/minio/release/linux-386/minio" && \
    apk del --quiet curl && \
    echo "Ensuring correct permissions" && \
    chown -R herokuish:herokuish /app && \
    chmod +x /app/minio

EXPOSE 80

WORKDIR /app

CMD ["/app/minio", "server", "--address", "0.0.0.0:80", "/app/storage"]
