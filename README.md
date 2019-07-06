# ![Markdown Here logo...borrowed for the time being](images/markdown-here-logo.png) Verkilo (CLI)

**Verkilo** is a Ruby command line script wrapped around Pandoc that compiles [Markdown](https://www.markdownguide.org/) files in a nested directory into a finished product. Use with the **[Verkilo template repository](https://github.com/Merovex/verkilo-master)** to create your own book.

**Note:** Verkilo has not been tested on Windows or Linux, though it is more likely to work on Linux since Mac OSX and Linux are both BSD derivatives. (If you find success or problems using other formats, please create an issue.)

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

## Philosophy

Novel writing should focus on the content, and let the formatting take care of itself. I believe in leveraging open-source to the extent practical. Since large-form fiction writing is straight text, Markdown is ideal. This may not be as well suited for non-fiction that relies heavily on tables or code examples. Provided the images are the right size (300 DPI), they should work fine.

## Features

* **Compilation.** Consolidates a (nested) Directory of Markdown files (`*.md`) into a single document in the following formats:
  - PDF - Creates a PDF leveraging LaTeX book format (not memoir).
  - ePUB - Creates an ePUB which can then be converted into MOBI for Kindle.
  - HTML - Creates a single-page HTML document for easy browser reading.
  - DOCX - Creates a Microsoft Word Document that most editors prefer.
* **Word count.** Provides a word count of the complete document. This should be helpful when putting together price estimates for editors, determining book length, or tracking writing progress.

## Installation

To install **Verkilo**:

1. Create directory `~/.verkilorc`
2. Move `templates` directory into `~/.verkilorc` (`~/.verkilorc/templates`)
3. Install Pandoc (see dependencies)
4. Copy verkilo to a bin directory of your choosing in your `$PATH`. (I use `~/bin`, but could be `/usr/local/bin`) and ensure it has execute permissions (`chmod +x verkilo`)

### Dependencies

* All code written in Ruby
* Requires [Pandoc](https://pandoc.org/).

## Usage

To use Verkilo:
* `verkilo pdf great-national-novel`  creates a PDF against the great-national-novel directory.
* `verkilo epub great-national-novel`  creates an ePUB against the great-national-novel directory.
* `verkilo html great-national-novel`  creates an HTML page against the great-national-novel directory.
* `verkilo docx great-national-novel`  creates a Word doc against the great-national-novel directory.

The formatted documents will be dropped into the `build/` directory.

### Fancy Page Breaks

One feature of the LaTeX Memoir package is Fancy Page Break. In print, the fancy page break appears as vertical white space (three blank lines typically) between two sections, or a symbol denoting the break when it appears at the bottom of a page. While Verkilo does not use Memoir class, we did borrow the Fancy Page Break. Your PDF will benefit from these expected behaviors. Other formats will show a horizontal rule.

To create a fancy page break, use the [Horizontal Rule](https://www.markdownguide.org/basic-syntax/#horizontal-rules) markup.

## Configuration

**Verkilo** uses Pandoc allows for some configuration using [YAML](https://yaml.org/). This is accomplished in one of two ways:

1. If you are writing multiple books (i.e., a series) that will share configurations, you put those into a `metadata.yml` file in the root directory.
2. For metadata related to a specific book in that series, you can put those as YAML Front Matter in any of the Markdown files, or as a dedicated Markdown file.

Pandoc uses the `metadata.yml` as a default configuration that YAML Front Matter in the `*.md` files overrides. So, if there are broad configurations that should apply everywhere with a few exceptions, then a mix of the `metadata.yml` and YAML Front Matter should suffice. See [Pandoc's Documentation on LaTeX variables for more information](https://pandoc.org/MANUAL.html#variables-for-latex).

**Warning:** the last YAML Front Matter metadata setting wins, so if you are using them in multiple files, you will experience odd side effects.

**Note.** Settings relating to Geometry, margins, and linestretch are governed by trim size in Verkilo.

### Configuration Examples

Examples of both the metadata.yml and front matter metadata are available in the [Verkilo template repository](https://github.com/Merovex/verkilo-master). YAML Front Matter in this context is a block of YAML code at the top of the document. [Jekyll's documentation on YAML Front Matter](https://jekyllrb.com/docs/front-matter/) describes it better than I could.

### Fonts

Verkilo configures three default fonts, but you may reconfigure them provided they are available when using the LaTeX font packages listed here. See [Pandoc fonts for LaTeX](https://pandoc.org/MANUAL.html#fonts) for more information.

```
\usepackage{fontspec}
\usepackage{xunicode}
\usepackage{xltxtra}
```

| Family | Default | Configuration |
| :-: |  :-: | :-: |
| Serif   | Libre Baskerville   | seriffont |
| Sans-Serif   | Libre Franklin  |  sansfont |
| Monospace   | Inconsolata | monofont  |

**Why default Baskerville, Franklin & Inconsolata?** Both Libre Baskerville and Libre Franklin have been optimized for use on screen. Baskerville is nice and readable, so ideal for use as body text, while Franklin is better suited to headlines. Inconsolata pairs with Baskerville & Franklin as they all share similar traits (double-story g & a, etc.). See the [Libre Baskerville / Franklin / Inconsolata pairing image](./images/libre-franklin-baskerville-inconsolata.png).

### Trimsize

The PDF option includes multiple trim sizes, depending on your target form factor. The Word document has a fixed trim size (Letter). The ePUB and HTML lack trim sizes. Metric measures rounded to 2 digits in the table. All measures are in metric in the LaTeX macros. When calculating trim size, we compared [commonly used sizes](./trim-sizes.md) and those offered by [KDP](https://kdp.amazon.com/en_US/help/topic/G201834180#trim).

|   Trimsize       |   Paper Size    |
|        ---       |       :---:     |
| **Letter**       | 8-1/2" x 11"    |
| **LargeTrade**   |     8" x 10"    |
| **Textbook**     |     7" x 10"    |
| **Trade**        |     6" x 9"     |
| **Digest**       | 5-1/2" x 8-1/2" |
| **SmallTrade**   | 5-1/4" x 8"     |
| **Novella**      |     5" x 8"     |
| **AFourSize**    |   21cm x 30cm   |
| **UKAFormat**    |   11cm x 18cm   |
| **UKBFormat**    |   13cm x 20cm   |

* Top and Inner margins are 2cm.
* Outer and bottom margins are 17mm.
* When configuration `bleed` is `true`, then the paper size and margins are increased by 3mm wide and 6mm high.

**Warning:** Failure to use one of the listed trim sizes will cause the compilation to fail. Defaults to `Trade`.

### Line Height

Line hight is determined by trim size so that a 10pt font size will yield 35-40 lines per page when compiling to PDF. The odd result is the page count for various sizes should be within ten percent of one another.

## FAQ

#### Q: What does "fatal: No names found, cannot describe anything" mean?

Verkilo attempts to use the repository's git tag in the output filename. When that tag is missing, the git command throws the "fatal: No names found, cannot describe anything" error. This does not affect the final output.

#### Q: What does 'fontspec error: "font-not-found"' mean?

This error means you do not have the font listed installed. If you are using the out-of-the-box fonts, you can install them from Google:

* [Libre Baskerville](https://fonts.google.com/specimen/Libre+Baskerville)
* [Libre Franklin](https://fonts.google.com/specimen/Libre+Franklin)
* [Inconsolata](https://fonts.google.com/specimen/Inconsolata)

## License

This script is licensed under an [MIT license](LICENSE).
