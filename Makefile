# /home/bruce/ver/local/app/my-bib/Makefile

mBook = alien
mTitleDir = bib

mGen = ./gen
mServer = moria.whyayh.com
mRelDev = /rel/development/doc/own/$(mTitleDir)
mRelRel = /rel/released/doc/own/$(mTitleDir)
mBib = $(HOME)/ver/local/app/my-bib/biblio.txt
mDoc = $(HOME)/ver/local/project/book-humane/draft/$(mBook).odt

mClone = git clone git@github.com:TurtleEngr/my-bib.git
mTidy = tidy -config etc/tidyxhtml.conf

mPubList = \
	$(mGen)/README.html \
	$(mGen)/biblio-note.html \
	biblio.txt

# ======================================

build : clean $(mGen) $(mPubList) README.md $(mGen)/todo.html

clean :
	-find . -name '*~' -exec rm {} \;
	-bib clean

dist-clean : clean
	-rm -rf $(mGen)

$(mGen) :
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
	rsync -a $(mPubList) $(mServer):$(mRelRel)

# -------------
# Rules

$(mGen)/%.html : %.org
	org2html.sh $< $@

$(mGen)/%.md : %.org
	-pandoc -f org -t markdown < $< >$@

README.md : $(mGen)/README.md
	cp $? $@

# -------------
# Add and maintain the bibliography in a Libreoffice document

doc.odt : 
	-ln -s $(mDoc) $@

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
