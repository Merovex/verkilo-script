# Verkilo (CLI)

![Markdown Here logo](markdown-here-logo.png)

**Verkilo** is a Ruby command line script wrapped around Pandoc that compiles [Markdown](https://www.markdownguide.org/) files in a nested directory into a finished product.

**Verkilo** is a brief Ruby script that wraps around Pandoc that converts Markdown files into books. Use with **[Verkilo-Master](https://github.com/Merovex/verkilo-master)** as a template to create your own book.

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

## Usage

To use Verkilo:
* `verkilo pdf great-national-novel`  creates a PDF against the great-national-novel directory.
* `verkilo epub great-national-novel`  creates an ePUB against the great-national-novel directory.
* `verkilo html great-national-novel`  creates an HTML page against the great-national-novel directory.
* `verkilo docx great-national-novel`  creates a Word doc against the great-national-novel directory.

The formatted documents will be dropped into the `build/` directory.

### Fancy Page Breaks

One feature of the LaTeX Memoir package is Fancy Page Break. In print, the fancy page break appears as vertical white space (three blank lines typically) between two sections, or a symbol denoting the break when it appears at the bottom of a page. While Verkilo does not use Memoir class, we did borrow the Fancy Page Break. This means your PDF will benefit from these expected behaviors.

To create a fancy page break, use the [Horizontal Rule](https://www.markdownguide.org/basic-syntax/#horizontal-rules) markup.

## Configuration

**Verkilo** allows for some configuration using [YAML](https://yaml.org/). This is accomplished in one of two ways:

1. If you are writing multiple books (i.e., a series) that will share configurations, you put those into a `metadata.yml` file in the root directory.
2. For metadata related to a specific book in that series, you can put those as Frontmatter in any of the Markdown files, or as a dedicated Markdown file.

Pandoc uses the `metadata.yml` as a default configuration that Frontmatter yaml in the `*.md` files overrides. So, if there are broad configurations that should apply everywhere with a few exceptions, then a mix of the `metadata.yml` and Frontmatter should suffice.

**Warning:** the last Frontmatter metadata setting wins, so if you are using them in multiple files, you will experience odd side effects.

### Trimsize

The PDF option includes multiple trim sizes, depending on your target form factor. The Word document has a fixed trim size (Letter). The ePUB and HTML lack trim sizes. Metric measures rounded to 2 digits.

|   Trimsize       |  Paper Size    |  I/O Margins  | T/B Margins |
|        ---       |      ---       |      ---      |     ---     |
| **AFourSize**    |   21cm x 30cm  |          2cm  |        2cm  |
| **Letter**       | 8-1/2" x 11"   |          1.0" |       1.0"  |
| **USTrade**      |     6" x 9"    |   7/8" x 5/8" | 5/8" x 5/8" |
| **Digest**       | 5-1/2" x 8.5"  |   7/8" x 5/8" | 7/8" x 7/8" |
| **USSmallTrade** | 5-1/4" x 8"    |   7/8" x 5/8" | 7/8" x 7/8" |
| **Novella**      |     5" x 8"    |   3/4" x 5/8" | 7/8" x 6/8" |
| **MassMarket**   | 4-1/4" x 7"    |   3/4" x 5/8" | 7/8" x 7/8" |
| **UKAFormat**    |   11cm x 18cm  |   20mm x 16mm | 22mm x 22mm |
| **UKBFormat**    |   13cm x 20cm  |   20mm x 16mm | 22mm x 22mm |

* I/O Margins - This is the inner & outer margin. The inner margin adds the gutter necessary for the binding.
* T/B Margins - This is the top & bottom margin. The top margin includes the header.

**Warning:** Failure to use one of the listed trimsizes will cause the compilation to fail.

### Example - Frontmatter in Markdown

```
---
title: "Stranded Series Bible"
# subtitle: "The worldbuilding for the Stranded Series"
author: "Ben Wilson"
website: "https://merovex.com"
imprint: "images/logo.png"
toc: true
toc-depth: 2
# Other titles
other-titles:
  - Bellicose
  - Scintilla

# Copyright Information
publisher: Merovex Press
rights: Copyright © 2019 Ben Wilson
disclaimer: >
  This is a work of fiction. Names, characters, places and incidents are either
  the product of the author's imagination or are used fictitiously, and any resemblance to
  actual persons, living or dead, business establishments, events or locales is entirely
  coincidental.

reservation: >
  No part of this publication may be reproduced, stored in a retrieval system, posted on the
  Internet, or transmitted, in any form or by any means, electronic, mechanical, photocopying,
  recording, or otherwise, without prior written permission from the author. The only exception is
  by a reviewer, who may quote short excerpts in a review.

# lccn:  # http://www.loc.gov/publish/pcn/

isbn: # Paperback
  - "9-78098-3952-107 paperback"
  - "9-78098-3952-107 ebook"

identifier: # Ebook
  -scheme: ISBN-13
  -text:   isbn13:9-78098-3952-107

# Production Recognition
credits:
  - "Cover Design: Donna Murillo"
  - "Developmental Editor: Cara Lockwood"
  - "Copy Editor: Cynthia Shepp"

country: Printed in the United States of America
---
```

### FAQ

#### Q: What does "fatal: No names found, cannot describe anything" mean?

Verkilo attempts to use the repository's git tag in the output filename. When that tag is missing, the git command throws the "fatal: No names found, cannot describe anything" error. This does not affect the final output.

## License

This script is licensed under an [MIT license](LICENSE).
