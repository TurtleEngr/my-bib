<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<title>my-bib Files</title>
<link rel="stylesheet"
      href="bib.css" />
</head>
<body>

my-bib Files
============

This file: <https://TurtleEngr.github.io/my-bib>

[![alt](https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png)](https://github.com/santisoler/cc-licenses/blob/main/LICENSE-CC-BY-NC-SA)
![GitHub Tag](https://img.shields.io/github/v/tag/TurtleEngr/my-bib)
![GitHub issue custom search](https://img.shields.io/github/issues-search?query=repo%3ATurtleEngr%2Fmy-bib%20is%3Aopen&style=flat&label=issues)

My personal bibliography
------------------------

-   &lt;a href="biblio.html"&gt;docs/biblio.html&lt;/a&gt; - references
    to: books, articles, websites, videos, DVDs, etc. (This is generated
    from: biblio.txt)

-   &lt;a href="biblio-raw.html"&gt;docs/biblio-raw.html&lt;/a&gt; -
    Formatted biblio.txt. This includes links to biblio-note.html, if an
    entry is in biblio-note.html.

-   &lt;a href="biblio-note.html"&gt;docs/biblio-note.html&lt;/a&gt; -
    Annotations related to Ids in biblio.txt (This is generated from
    biblio-note.org)

-   &lt;a href="aoc-biblio.html"&gt;docs/aoc-biblio.html&lt;/a&gt; -
    Bibliography for &lt;i&gt;Aliens of Our Creation&lt;/i&gt; book.
    (This is generated from the citations in the book.)

How biblio is built and used
----------------------------

-   Source: <https://github.com/TurtleEngr/my-bib>
    -   biblio.txt - master file for biblio.html and for DB import.
    -   biblio-note.org - extra notes for biblio items.
    -   doc.odt - link to a LibreOffice document that will be updated
        from the DB.
    -   etc/ - config file for the "bib" command.
    -   status/ - datestamp of when bib commands are run.
    -   Makefile - build processes.
-   [libre-bib](https://github.com/TurtleEngr/libre-bib) - this tool
    imports the biblio.txt into a DB. The DB is then used by libre-bib
    and a Libreoffice document to generate the documentś Bibliography.

