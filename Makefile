
mVerPath = $(HOME)/ver/local/project/book-humane/draft
mPubPath = moria:/rel/released/doc/own/bib

clean :
	find . -name '*~' -exec rm {} \;
	-bib clean

publish release :
	rsync -a README.html biblio.txt biblio-note.txt $(mPubPath)/

update : doc.odt

# -------------
# Add and maintain the bibliography in a Libreoffice document

doc.odt : 
	ln -s $(mVerPath)/alien.odt $@

bib-import : doc.odt
	echo "Run: bib import-lo"

bib-update-style : doc.odt etc/bib-style.xml
	echo "Run: bib style-update"

etc/bib-style.xml : doc.odt
	echo "Maybe run: bib style-save"

bib-ref :
	echo "Run: bib ref-new"

bib- update :
	echo "Run: bib ref-update"
