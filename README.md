# verkilo-script

This is a private script using Pandoc to use GitHub / Markdown to make books.

**Verkilo** is a brief Ruby script that wraps around Pandoc that converts Markdown files into books.

<!-- Stability -->
<a href="https://nodejs.org/api/documentation.html#documentation_stability_index">
  <img src="https://img.shields.io/badge/stability-stable-green.svg"
    alt="Code Stability" />
</a>

<!-- Platforms -->
<a href="#">
  <img src="https://img.shields.io/badge/platform-macOSx-orange.svg"
    alt="Works on" />
</a>

## Features

* Consolidates a (nested) Directory of Markdown files (*.md) into a single document in the following formats:
  - PDF - Creates a PDF leveraging LaTeX book format (not memoir).
  - ePUB - Creates an ePUB which can then be converted into MOBI for Kindle.
  - HTML - Creates a single-page HTML document for easy browser reading.
  - DOCX - Creates a Microsoft Word Document that most editors prefer.

## Installation

To install **Verkilo**:

1. Create directory `~/.verkilorc`
2. Move `templates` directory into `~/.verkilorc` (`~/.verkilorc/templates`)
3. Install Pandoc (see dependencies)
4. Copy verkilo to a bin directory of your choosing in your `$PATH`. (I use `~/bin`, but could be `/usr/local/bin`) and ensure it has execute permissions (`chmod +x verkilo`)

### Dependencies

* All code written in Ruby
* Requires [Pandoc](https://pandoc.org/).

## Example

To use Verkilo: `verkilo pdf great-national-novel`  creates a PDF.

## Philosophy

Novel writing should focus on the content, and let the formatting take care of itself. I believe in leveraging open-source to the extent practical. Since large-form fiction writing is straight text, Markdown is ideal. This may not be as well suited for non-fiction that relies heavily on tables. Provided the images are the right size (300 DPI), they should work fine.

## Configuration
