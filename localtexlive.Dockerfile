# syntax = docker/dockerfile:1.4

FROM docker.io/pandoc/extra:3.8.3-alpine
LABEL maintainer="informatica-global.com <support@informatica-global.com>" \
    org.opencontainers.image.title="Pandoc with Full Multilingual LaTeX Packages and Arabic Fonts" \
    org.opencontainers.image.description="Docker container for Pandoc with all LaTeX packages and fonts, tailored to create professional documents and presentations in multiple languages." \
    org.opencontainers.image.url="https://github.com/informatica-global/pandoc-texlive-full" \
    org.opencontainers.image.source="https://github.com/informatica-global/pandoc-texlive-full" \
    org.opencontainers.image.licenses="MIT"

# Set the local repository as the default repository for tlmgr
RUN --mount=type=bind,source=./texlive/tlnet,target=/texlive/tlnet \
    tlmgr option repository /texlive/tlnet \
    && tlmgr init-usertree /texlive \
    && tlmgr install scheme-full \
    && rm -rf /usr/share/doc/* \
    && rm -rf /usr/share/man/* \
    && rm -rf /usr/share/info/* \
    && rm -rf /usr/share/locale/*
