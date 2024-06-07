# syntax = docker/dockerfile:1.2
FROM docker.io/pandoc/extra:3.2-ubuntu

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8

# Install TexLive full
RUN tlmgr install scheme-full

# Install extra fonts, and other necessary packages
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean \
    && apt-get update -q \
    && apt-get --no-install-recommends install -qy \
    fonts-sil-scheherazade \
    fonts-sil-awami-nastaliq \
    fonts-sil-lateef \
    fonts-hosny-amiri \
    fonts-kacst \
    fonts-kacst-one \
    fonts-arabeyes \
    fonts-noto-core \
    fonts-noto \
    fonts-noto-extra \
    fonts-hosny-thabit \
    fonts-lemonada \
    lmodern \
    && fc-cache \
    && luaotfload-tool -u -f \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/share/doc/* \
    && rm -rf /usr/share/man/* \
    && rm -rf /usr/share/info/* \
    && rm -rf /usr/share/locale/*
