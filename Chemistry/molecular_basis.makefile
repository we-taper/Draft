PANDOC = /home/hx/.cabal/bin/pandoc
P_CROSSREF = /home/hx/.cabal/bin/pandoc-crossref
P_CITEPROC = /home/hx/.cabal/bin/pandoc-citeproc
FILTERS = --filter ${P_CROSSREF} --filter ${P_CITEPROC}
COMMON_OPTS = -f markdown ${FILTERS} --number-sections
SOURCE = molecular_basis
HTML_CSS = --css syntax-highlighting.css --css docs.css

html : ${SOURCE}.md
	${PANDOC} ${COMMON_OPTS}  ${HTML_CSS} \
	--mathjax -t html --standalone -o ${SOURCE}.html  \
	${SOURCE}.md
pdf : ${SOURCE}.md
	${PANDOC} ${COMMON_OPTS} --template pandoc.tex \
	-t latex -o ${SOURCE}.pdf  \
	${SOURCE}.md
latex : ${SOURCE}.md
	${PANDOC} ${COMMON_OPTS} --template pandoc.tex \
	-t latex -o ${SOURCE}.tex  \
	${SOURCE}.md

clean :
	rm -f *.aux
	rm -f *.fdb_latexmk
	rm -f *.fls
	rm -f *.log
	rm -f *.synctex.gz
