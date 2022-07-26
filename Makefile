# Copyright (C)  2013 Jana Traue (jana.traue[at]tu-cottbus.de)
#
# Permission is granted to copy, distribute and/or modify this document
# under the terms of the GNU Free Documentation License, Version 1.3
# or any later version published by the Free Software Foundation;
# with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
# A copy of the license is included in the file entitled "LICENSE".

#pdf:
# latexmk -pdf main.tex

# latexmk does a good job cleaning up, but some files still remain
# this is a list of all extensions of temporary files
EXTENSIONS:=aux bbl blg cut dvi log out pdfsync ps synctex.gz tdo toc tex~ backup

.PHONY: contents

default: pdf

pdf:
	latexmk -f -pdf main.tex

clean:
	@latexmk -silent -c main.tex 2> /dev/null
	@for i in $(EXTENSIONS); \
	do \
		for file in `find . -name "*.$$i"`; do rm $$file; done; \
	done

# pdf:
# 	@echo "pdflatex..."
# 	@pdflatex -halt-on-error main.tex > /dev/null || true
# 	@echo "makeglossaries..."
# 	@makeglossaries -q main
# 	@echo "bibtex..."
# 	@bibtex -terse main | grep "Warning--" || true
# 	@echo "pdflatex..."
# 	@pdflatex -halt-on-error main.tex > /dev/null || true
# 	@echo "pdflatex..."
# 	@pdflatex -halt-on-error main.tex | grep -a3 ^! || true
