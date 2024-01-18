
mVerPath = $(HOME)/ver/local/project/book-humane/draft
mPubPath = moria.whyayh.com:/rel/released/doc/own/bib
mTidy = tidy -m -config etc/tidyxhtml.conf
mClone = git clone git@github.com:TurtleEngr/my-bib.git

clean :
	find . -name '*~' -exec rm {} \;
	-bib clean

ci checkin commit : clean
	git commit -am "Updated"

update : doc.odt

save : clean todo.html README.html
	git co develop
	git pull origin develop
	-git ci -am Updated
	git push origin develop

publish release : save
	git co main
	git pull origin main
	git merge develop
	git push origin main
	git co develop
	rsync -a README.html biblio.txt biblio-note.txt $(mPubPath)/

# -------------
# Add and maintain the bibliography in a Libreoffice document

%.html : %.org
	-pandoc -f org -t html < $< >$@
	-$(mTidy) $@

%.html : %.md
	-pandoc -f markdown -t html < $< >$@
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
