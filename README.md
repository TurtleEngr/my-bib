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

My personal bibliography
------------------------

-   &lt;a href="biblio.html"&gt;biblio.html&lt;/a&gt; - references to:
    books, articles, websites, videos, DVDs, etc. (This is generated
    from: biblio.txt)

-   &lt;a href="biblio-note.html"&gt;biblio-note.html&lt;/a&gt; -
    Annotations related to Ids in biblio.txt (This is generated from
    biblio-note.org)

-   &lt;a href="aoc-biblio.html"&gt;aoc-biblio.html&lt;/a&gt; -
    Bibliograph for &lt;i&gt;Aliens of Our Creation&lt;/i&gt; book.
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

