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

**Verkilo** allows for some configuration using [YAML](https://yaml.org/). This is accomplished in one of two ways:

1. If you are writing multiple books (i.e., a series) that will share configurations, you put those into a `metadata.yml` file in the root directory.
2. For metadata related to a specific book in that series, you can put those as Frontmatter in any of the Markdown files, or as a dedicated Markdown file.

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
