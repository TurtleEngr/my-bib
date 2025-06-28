my-bib Files
============

This file: <https://TurtleEngr.github.io/my-bib>

[![alt](https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png)](https://github.com/TurtleEngr/my-bib/blob/develop/LICENSE)
    [![GitHub Tag](https://img.shields.io/github/v/tag/TurtleEngr/my-bib)](https://github.com/TurtleEngr/my-bib/tags)
    [![GitHub issue custom search](https://img.shields.io/github/issues-search?query=repo%3ATurtleEngr%2Fmy-bib%20is%3Aopen&style=flat&label=issues)](https://github.com/TurtleEngr/my-bib/issues)

My personal bibliography
------------------------

-   \<a href=\"biblio.html\"\>docs/biblio.html\</a\> - references to:
    books, articles, websites, videos, DVDs, etc. (This is generated
    from: biblio.txt)

-   \<a href=\"biblio-raw.html\"\>docs/biblio-raw.html\</a\> - Formatted
    biblio.txt. This includes links to biblio-note.html, if an entry is
    in biblio-note.html.

-   \<a href=\"biblio-note.html\"\>docs/biblio-note.html\</a\> -
    Annotations related to Ids in biblio.txt (This is generated from
    biblio-note.org)

-   \<a href=\"aoc-biblio.html\"\>docs/aoc-biblio.html\</a\> -
    Bibliography for \<i\>Aliens of Our Creation\</i\> book. (This is
    generated from the citations in the book.)

How biblio is built and used
----------------------------

-   Source: <https://github.com/TurtleEngr/my-bib>
    -   biblio.txt - master file for biblio.html and for DB import.
    -   biblio-note.org - extra notes for biblio items.
    -   doc.odt - link to a LibreOffice document that will be updated
        from the DB.
    -   etc/ - config file for the \"bib\" command.
    -   status/ - datestamp of when bib commands are run.
    -   Makefile - build processes.
-   [libre-bib](https://github.com/TurtleEngr/libre-bib) - this tool
    imports the biblio.txt into a DB. The DB is then used by libre-bib
    and a Libreoffice document to generate the document\\\'s
    Bibliography.
