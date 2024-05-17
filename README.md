# An Easy Docker Container to Run Pandoc With Full Multilingual LaTeX Packages and Arabic Fonts

This container installs the latest Pandoc release from its original GitHub repository, along with a full set of LaTeX packages and additional beautiful Arabic fonts to enhance Arabic support. Please note that because of the size of the `texlive-full` packages, the container is over 2Gb in terms of download size.

## Running the Container

### To Create an English Language PDF

The example below creates a PDF from this README file:

```sh
docker run --rm -v "$PWD:/data" --net=none -u $(id -u):$(id -g) \
ghcr.io/informatica-global/pandoc-texlive-full \
"README.md" -o "./README.pdf"
```

### To Create an Arabic (or Other Unicode Language) PDF

The example below creates a PDF from this README file. Notice the `--pdf-engine` option to select the `lualatex` engine, which supports Unicode and many languages, including Arabic and other RTL languages:

```sh
docker run --rm -v "$PWD:/data" --net=none -u $(id -u):$(id -g) \
ghcr.io/informatica-global/pandoc-texlive-full \
"README.md" -o "./README.pdf" --pdf-engine=lualatex 
```

## Building the Container

To build this container yourself, simply run:

```sh
make
```

To build and push the Docker image to a registry, run:

```sh
make push
```

### Notes

- You can add any extra tags or repositories in the makefile to tag and push automatically.
- The `LATEST_RELEASE` variable is automatically populated with the latest version number of Pandoc.
- The Docker image will be tagged with both the specific Pandoc version and `latest`.
- Ensure you have Docker and `make` installed on your system.
