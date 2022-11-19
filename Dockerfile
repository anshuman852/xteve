FROM alpine:3.16
RUN apk --no-cache add ca-certificates tzdata ffmpeg wget unzip
WORKDIR /app
RUN export ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
        export ARCH="amd64"; \
    fi && \
    if [ "$ARCH" = "aarch64" ]; then \
        export ARCH="arm64"; \
    fi && \
    wget -O xteve.zip https://github.com/xteve-project/xTeVe-Downloads/blob/master/xteve_linux_$ARCH.zip?raw=true && \
    unzip xteve.zip && \
    rm xteve.zip
EXPOSE 34400

CMD [ "./xteve", "-config", "/app/config" ]
