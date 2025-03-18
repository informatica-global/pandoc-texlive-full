# syntax = docker/dockerfile:1.4
FROM docker.io/pandoc/extra:3.6.4-alpine
LABEL maintainer="informatica-global.com <support@informatica-global.com>" \
    org.opencontainers.image.title="Pandoc with Full Multilingual LaTeX Packages and Arabic Fonts" \
    org.opencontainers.image.description="Docker container for Pandoc with all LaTeX packages and fonts, tailored to create professional documents and presentations in multiple languages." \
    org.opencontainers.image.url="https://github.com/informatica-global/pandoc-texlive-full" \
    org.opencontainers.image.source="https://github.com/informatica-global/pandoc-texlive-full" \
    org.opencontainers.image.licenses="MIT"

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8

# Install TexLive full
RUN tlmgr install scheme-full \
    && rm -rf /usr/share/doc/* \
    && rm -rf /usr/share/man/* \
    && rm -rf /usr/share/info/* \
    && rm -rf /usr/share/locale/*