# syntax = docker/dockerfile:1.2
FROM ubuntu:noble

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8

# Install TexLive, fonts, and other necessary packages
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean \
    && apt-get update -q \
    && apt-get --no-install-recommends install -qy \
    texlive-full \
    texlive-lang-arabic \
    texlive-lang-english \
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
    python3-pygments \
    gnuplot \
    wget \
    lmodern \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/share/doc/* \
    && rm -rf /usr/share/man/* \
    && rm -rf /usr/share/info/* \
    && rm -rf /usr/share/locale/*

# Install Pandoc
ARG LATEST_RELEASE
RUN curl -fsSL -o "/tmp/pandoc_$LATEST_RELEASE.deb" "https://github.com/jgm/pandoc/releases/download/$LATEST_RELEASE/pandoc-$LATEST_RELEASE-1-amd64.deb" \
    && dpkg -i "/tmp/pandoc_$LATEST_RELEASE.deb" \
    && rm -rf "/tmp/pandoc_$LATEST_RELEASE.deb" \
    && fc-cache \
    && luaotfload-tool -u -f

LABEL version="$LATEST_RELEASE"

VOLUME ["/data"]
WORKDIR /data
ENTRYPOINT ["pandoc"]
CMD ["-v"]
