#!/usr/bin/env bash

if [[ -t 0 ]]; then
    cat <<EOF
Usage:
    mk-biblio-txt2html.sh <biblio.txt >biblio.html

{ID-N} or Id: ID-N

Type: Book
    <p>id Author[, Authors]. <i>Title[: Subtitle]</i>[ Year.] Media.
    [ Publisher][, Address][.][ ISBN][ url: Link[ alt: AltLink]</p>

Type: article
Type: site
Type: media
    <p>id Author[, Authors]. "Title[: Subtitle]"[ Year.] Media.
    # [ Publisher.][ url: Link[ alt: AltLink]</p>
EOF
    exit 1
fi

# ----------------------------------------
cat <<\EOF >/tmp/mk-biblio-txt2html.awk
function fPrintRec() {
    print ""
    if (tPub != "") {
        tPub = tPub "."
    }
    if (tAuthor != "") {
        tAuthor = tAuthor ". "
    }
    if (tType == "book") {
        print "<p><b>" tId "</b> " tAuthor "<i>" tTitle ".</i>" tYear tMedia tPub tISBN tLink "</p>"
        return
    }
    print "<p><b>" tId "</b> " tAuthor "\"" tTitle ".\"" tYear tMedia tPub tLink "</p>"
}

/^#/ { next }
NF == 0 { next }

/^Id: .*-[0-9]*/ {
    if (tId != "") {
        fPrintRec()
    }
    tId = $2
    tType=""
    tAuthor=""
    tTitle=""
    tYear=""
    tMedia=""
    tPub=""
    tISBN=""
    tLink=""
    next
}

/^{.*-[0-9]*}/ {
    if (tId != "") {
        fPrintRec()
    }
  
    tId = $0
    tType=""
    tAuthor=""
    tTitle=""
    tYear=""
    tMedia=""
    tPub=""
    tISBN=""
    tLink=""
    next
}

/^Type: / {
    tType = $2
    next
}

/^Media: / {
    tMedia = " " $2 "."
    next
}

/^Title: / {
    $1 = ""
    sub(/^ /,"")
    tTitle = $0
  
    next
}
/^Subtitle: / {
    $1 = ""
    sub(/^ /,"")
    tTitle = tTitle ": " $0
    next
}

/^Author: / {
    $1 = ""
    sub(/^ /,"")
    tAuthor = $0
    next
}
/^Authors: / {
    $1 = ""
    sub(/^ /,"")
    tAuthor = tAuthor ", " $0
    next
}

/^Date: / {
    tYear = " " $2 "."
    next
}

/^Publisher: / {
    $1 = ""
    tPub = $0
    next
}
/^Address: / {
    $1 = ""
    sub(/^ /,"")
    tPub = tPub ", " $0
    next
}

/^ISBN: / {
    tISBN = " ISBN:" $2 "."
    next
}

/^Link: / {
    $1 = ""
    sub(/^ /,"")
    tLink = " url:<a href=\"" $0 "\">" $0 "</a>"
    next
}
/^AltLink: / {
    tLink = tLink " alt:<a href=\"" $2 "\">" $2 "</a>"
    next
}
EOF

# ----------------------------------------
# Main

cat <<\EOF
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<title>Bibliography</title>
<link rel="stylesheet"
      href="bib.css" />
</head>
<body>
<h1>Bibliography</h1>
<p>
EOF

'date' '+%F'
cat <<\EOF
</p>
EOF

awk -f /tmp/mk-biblio-txt2html.awk

cat <<\EOF
</body>
</html>
EOF

rm /tmp/mk-biblio-txt2html.awk
