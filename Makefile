
mVerPath = $(HOME)/ver/local/project/book-humane/draft
mPubPath = moria:/rel/released/doc/own/bib
mTidy = tidy -m -config etc/tidyxhtml.conf

clean :
	find . -name '*~' -exec rm {} \;
	-bib clean

update : doc.odt

publish release : clean README.html
	git co develop
	git pull origin develop
	-git ci -am Updated
	git push origin develop
	git co main
	git pull origin main
	git merge develop
	git push origin main
	git co develop
	rsync -a README.html biblio.txt biblio-note.txt $(mPubPath)/

# -------------
# Add and maintain the bibliography in a Libreoffice document

README.html : README.md
	-pandoc -f markdown -t html <$? >$@
	-$(mTidy) $@

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
