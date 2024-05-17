# Docker Container for Pandoc with Full Multilingual LaTeX Packages and Arabic Fonts

This Docker container provides the latest Pandoc release from its official GitHub repository, bundled with a comprehensive set of LaTeX packages and additional Arabic fonts to enhance Arabic language support. Please note that due to the inclusion of the `texlive-full` packages, the container download size exceeds 2GB.

## Running the Container

Ensure Docker is installed on your system. Then, use one of the following commands:

### Creating an English Language PDF

The following example demonstrates how to create a PDF from this README file:

```sh
docker run --rm -v "$PWD:/data" --net=none -u $(id -u):$(id -g) \
ghcr.io/informatica-global/pandoc-texlive-full \
"README.md" -o "./README.pdf"
```

### Creating an Arabic (or Other Unicode Language) PDF

To create a PDF from this README file in Arabic or any other Unicode language, use the `--pdf-engine` option to select `lualatex`. This engine supports Unicode and many languages, including Arabic and other right-to-left (RTL) languages:

```sh
docker run --rm -v "$PWD:/data" --net=none -u $(id -u):$(id -g) \
ghcr.io/informatica-global/pandoc-texlive-full \
"README.md" -o "./README.pdf" --pdf-engine=lualatex 
```

## Building the Container

To build the container yourself, execute the following command:

```sh
make
```

To build and push the Docker image to a registry, execute:

```sh
make push
```

### Notes

- You can add extra tags or repositories in the Makefile to automate tagging and pushing.
- The `LATEST_RELEASE` variable is automatically updated with the latest Pandoc version number.
- The Docker image will be tagged with both the specific Pandoc version and `latest`.
- To build, ensure Docker and `make` are installed on your system.
