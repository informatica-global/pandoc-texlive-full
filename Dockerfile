FROM docker.io/pandoc/extra:3.3.0-alpine

# Install TexLive full from the local repository
RUN --mount=type=bind,source=./texlive/tlnet,target=/texlive/tlnet \
    tlmgr init-usertree /texlive \
    && tlmgr option repository /texlive/tlnet \
    && ls -lah /texlive/tlnet \
    && tlmgr install -repository file:/texlive/tlnet scheme-full \
    && rm -rf /usr/share/doc/* \
    && rm -rf /usr/share/man/* \
    && rm -rf /usr/share/info/* \
    && rm -rf /usr/share/locale/*
