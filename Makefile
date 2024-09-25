
mVerPath = $(HOME)/ver/local/project/book-humane/draft
mPubPath = moria.whyayh.com:/rel/released/doc/own/bib
mClone = git clone git@github.com:TurtleEngr/my-bib.git
mTidy = tidy -m -config etc/tidyxhtml.conf

build : clean gen gen/README.html gen/README.md gen/biblio-note.html gen/todo.html

clean :
	find . -name '*~' -exec rm {} \;
	-bib clean

gen :
	mkdir $@

ci checkin commit : clean build
	git commit -am "Updated"

update pull : doc.odt
	git co develop
	git pull origin develop

save push : build
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
	rsync -a README.html biblio.txt biblio-note.org $(mPubPath)/

# -------------
# Add and maintain the bibliography in a Libreoffice document

gen/%.html : %.org
	org2html.sh $< $@

gen/%.md : %.org
	-pandoc -f org -t markdown < $< >$@

doc.odt : 
	-ln -s $(mVerPath)/alien.odt $@

bib-import : doc.odt
	echo "Run: bib import-lo"

bib-update-style : doc.odt etc/bib-style.xml
	echo "Run: bib style-update"

etc/bib-style.xml : doc.odt
	echo "Maybe run: bib style-save"

bib-ref :
	echo "Run: bib ref-new"

bib-update :
	echo "Run: bib ref-update"
