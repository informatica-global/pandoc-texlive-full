# syntax = docker/dockerfile:1.4
FROM ghcr.io/pandoc/extra:3.10.0-ubuntu
LABEL maintainer="informatica-global.com <support@informatica-global.com>" \
    org.opencontainers.image.title="Pandoc with Full Multilingual LaTeX Packages and Arabic Fonts" \
    org.opencontainers.image.description="Docker container for Pandoc with all LaTeX packages and fonts, tailored to create professional documents and presentations in multiple languages." \
    org.opencontainers.image.url="https://github.com/informatica-global/pandoc-texlive-full" \
    org.opencontainers.image.source="https://github.com/informatica-global/pandoc-texlive-full" \
    org.opencontainers.image.licenses="MIT"

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8

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
    && rm -rf /var/lib/apt/lists/*

# Install TexLive full
RUN tlmgr install scheme-full \
    && rm -rf /usr/share/doc/* \
    && rm -rf /usr/share/man/* \
    && rm -rf /usr/share/info/* \
    && rm -rf /usr/share/locale/*