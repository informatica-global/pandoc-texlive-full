# Docker Container for Pandoc with Full Multilingual LaTeX Packages and Arabic Fonts

Easily use Docker to run [Pandoc](https://pandoc.org/) with all LaTeX packages and fonts, ensuring a consistent and reproducible environment for PDF generation. Supports all other source and destination file formats handled by Pandoc and is tailored to facilitate a streamlined workflow for creating professional documents and presentations with Markdown and LaTeX typesetting.

This Docker container is based on the original [Pandoc's official GitHub repository](https://github.com/jgm/pandoc) and its [official docker container](https://github.com/pandoc/dockerfiles) `latex/extra`, bundled with the full set of LaTeX packages. Additional Arabic fonts were added to enhance Arabic and similar language support. Due to the inclusion of the `texlive full`, the container download size exceeds 2GB but has all LaTeX packages and fonts already preinstalled and ready to use.

## Running the Container (Linux, Mac, BSD)

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

### Creating an English Language PDF with Eisvogel Template

The following example demonstrates how to create a PDF from this README file:

```sh
docker run --rm -v "$PWD:/data" --net=none -u $(id -u):$(id -g) \
ghcr.io/informatica-global/pandoc-texlive-full \
"README.md" -o "./README.pdf" --template eisvogel --listings
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
- Ensure Docker and `make` are installed on your system.

## Using VS Code Tasks for PDF Generation

The repository includes a `.vscode/tasks.json` file, which defines several tasks to streamline the process of generating PDFs using Docker and Pandoc. These tasks can be executed directly from Visual Studio Code (VS Code), simplifying the workflow for generating various types of PDFs, including multilingual and Beamer presentations.

### Tasks Overview

The tasks are designed to cover different use cases, including creating standard PDFs, Arabic PDFs, and Beamer presentation PDFs with incremental slides and handout formats. Here is a summary of the available tasks:

1. **Make PDF**: Generates a standard PDF document from the current file.
2. **Make Arabic PDF**: Generates a PDF document from the current file using the `lualatex` engine, which supports Arabic and other Unicode languages.
3. **Make Beamer Handout PDF**: Creates a Beamer presentation handout PDF from the current file.
4. **Make Beamer Incremental PDF**: Creates an incremental Beamer presentation PDF from the current file.
5. **Make Arabic Beamer Handout PDF**: Creates a Beamer presentation handout PDF from the current file, formatted for Arabic with the `lualatex` engine.
6. **Make Arabic Beamer Incremental PDF**: Creates an incremental Beamer presentation PDF from the current file, formatted for Arabic with the `lualatex` engine.

### Running Tasks

To run a task, you can use the Command Palette or access the tasks through the menu.

#### Using the Command Palette

1. Open the Command Palette (Ctrl+Shift+P or Cmd+Shift+P on macOS).
2. Type `Tasks: Run Task` and select it.
3. Choose the desired task from the list.

#### Using the Menu

1. Navigate to `Terminal` in the top menu.
2. Select `Run Task...`.
3. Choose the desired task from the list.

### Adding the Tasks to Other Workspaces

To add this `tasks.json` file to other workspaces, copy the `tasks.json` file to the `.vscode` directory in your workspace. To add these tasks globally to all your VS Code workspaces, use the user scope in VS Code. Follow these instructions based on your operating system:

#### Linux and macOS

Copy `tasks.json` to the global VS Code configuration directory:

   ```sh
   cp path/to/repo/.vscode/tasks.json ~/.config/Code/User/tasks.json
   ```

#### Windows

Copy the `tasks.json` file to the global VS Code configuration directory:

   ```sh
   copy path\to\repo\.vscode\tasks.json %APPDATA%\Code\User\tasks.json
   ```
