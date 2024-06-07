# syntax = docker/dockerfile:1.2
ARG LATEST_RELEASE

FROM docker.io/pandoc/extra:$LATEST_RELEASE-ubuntu

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8

# Install TexLive full, fonts, and other necessary packages
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean \
    && tlmgr install scheme-full \
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
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/share/doc/* \
    && rm -rf /usr/share/man/* \
    && rm -rf /usr/share/info/* \
    && rm -rf /usr/share/locale/*

LABEL version="$LATEST_RELEASE"
