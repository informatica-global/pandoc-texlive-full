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

## Using VS Code Tasks for PDF Generation

The repository includes a `.vscode/tasks.json` file, which defines several tasks to streamline the process of generating PDFs using Docker and Pandoc. These tasks can be executed directly from Visual Studio Code (VS Code), simplifying the workflow for generating various types of PDFs, including multilingual and Beamer presentations.

### Tasks Overview

The tasks are designed to cover different use cases, including creating standard PDFs, Arabic PDFs, and Beamer presentation PDFs with incremental slides and handout formats. Here is a summary of the available tasks:

1. **MakePDF**: Generates a standard PDF from the current file.
2. **MakeArabicPDF**: Generates a PDF from the current file using the `lualatex` engine, which supports Arabic and other Unicode languages.
3. **MakeArabicBeamerHandoutPDF**: Creates a Beamer presentation handout PDF from the current file, formatted for Arabic with the `lualatex` engine.
4. **MakeArabicBeamerIncrementalPDF**: Creates an incremental Beamer presentation PDF from the current file, formatted for Arabic with the `lualatex` engine.
5. **MakeBeamerIncrementalPDF**: Creates an incremental Beamer presentation PDF from the current file.
6. **MakeBeamerHandoutPDF**: Creates a Beamer presentation handout PDF from the current file.

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

To add this `tasks.json` file to other workspaces, just copy the `tasks.json` file to the `.vscode` directory in your workspace. To add these tasks globally to all repos use the user scope in VS Code, follow these instructions based on your operating system.

#### Linux and macOS

Copy `tasks.json` to the global VS Code configuration directory typically at:

   ```sh
   ~/.config/Code/User/tasks.json
   ```

#### Windows

Copy the `tasks.json` file to the global VS Code configuration directory typically at:

   ```sh
   %APPDATA%\Code\User\tasks.json
   ```

These tasks leverage Docker to run Pandoc with the necessary LaTeX packages and fonts, ensuring a consistent and reproducible environment for PDF generation.
