# syntax = docker/dockerfile:1.2
ARG LATEST_RELEASE
FROM docker.io/pandoc/extra:$LATEST_RELEASE

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8

# Install TexLive full
RUN tlmgr install scheme-full \
    && rm -rf /usr/share/doc/* \
    && rm -rf /usr/share/man/* \
    && rm -rf /usr/share/info/* \
    && rm -rf /usr/share/locale/*
