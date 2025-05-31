# /home/bruce/ver/local/app/my-bib/Makefile
# docs/ files are published to: https://turtleengr.github.io/my-bib/

mBook = alien
mTitleDir = bib

mGen = ./gen
mServer = moria.whyayh.com
mRelDev = /rel/development/doc/own/$(mTitleDir)
mRelRel = /rel/released/doc/own/$(mTitleDir)
mBib = $(HOME)/ver/local/app/my-bib/biblio.txt
mDoc = $(HOME)/ver/local/project/book-humane/draft/$(mBook).odt
mAuthTools = ~/ver/github/app/author-tools

mClone = git clone git@github.com:TurtleEngr/my-bib.git
mTidy = tidy -config etc/tidyxhtml.conf

mPubList = \
	gen/README.html \
	gen/bib.css \
	gen/biblio.html \
	gen/biblio-raw.html \
	gen/biblio-note.html

# ======================================

build : clean gen $(mPubList) README.md gen/todo.html
	incver.sh -p VERSION

clean :
	-find . -name '*~' -exec rm {} \;
	-bib clean

dist-clean : clean
	-rm -rf gen

gen :
	-mkdir $@

ci checkin commit : clean build
	git commit -am "Updated"

update pull : doc.odt
	git co develop
	git pull origin develop

save push : ci build
	git co develop
	git pull origin develop
	incver.sh -m VERSION
	rsync -a $(mPubList) docs/
	mv docs/README.html docs/index.html
	-git ci -am Updated
	git push --tags origin develop

publish release : save
	incver.sh -M VERSION
	git commit -am "Inc Ver"
	git tag -f -F VERSION "v$$(cat VERSION)"
	git push --tags origin develop
	git co main
	git pull origin main
	git merge develop
	git push --tags origin main
	git co develop
	rsync -a $(mPubList) $(mServer):$(mRelRel)

view :
	-sensible-browser ./biblio.txt
	#-sensible-browser gen/biblio-note.html
	#-sensible-browser gen/README.html

# This will take a long time
status : biblio-status.txt

biblio-status.txt : biblio.txt
	time ./link-status <$?

setup : etc/mk-biblio-org etc/mk-biblio-txt2html.sh

etc/% : $(mAuthTools)/bin/%
	cp $< $@

# -------------

README.md : gen/README.md
	sed 's/^ *!\[GitHub /![GitHub /; s/^ *\[!\[alt]/[![alt]/' <$? >$@

gen/bib.css : etc/bib.css
	ln -f $? $@

gen/biblio-raw.html : biblio.txt
	etc/mk-biblio-org <$? > gen/biblio-raw.org
	org2html.sh gen/biblio-raw.org $@

gen/biblio.html : biblio.txt
	etc/mk-biblio-txt2html.sh  < $? >$@

# -------------
# Rules

gen/%.html : %.org
	-org2html.sh $< $@

gen/%.md : %.org
	-pandoc -f org -t markdown < $< >$@

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
