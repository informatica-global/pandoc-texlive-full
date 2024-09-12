# syntax = docker/dockerfile:1.2

FROM docker.io/pandoc/extra:3.4.0-alpine

# Set the local repository as the default repository for tlmgr
RUN --mount=type=bind,source=./texlive/tlnet,target=/texlive/tlnet \
    tlmgr option repository /texlive/tlnet \
    && tlmgr init-usertree /texlive \
    && tlmgr install scheme-full \
    && rm -rf /usr/share/doc/* \
    && rm -rf /usr/share/man/* \
    && rm -rf /usr/share/info/* \
    && rm -rf /usr/share/locale/*
