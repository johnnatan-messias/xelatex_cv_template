MAIN=main
SRCS=sections/*.tex

LMK=latexmk
OTYPE=-pdf
TEX=-xelatex
TEX_OPTS="xelatex -interaction=nonstopmode -shell-escape"
BIB=-bibtex

ERROR_MSG=Error: cannot find '$(LMK)' in path; try 'xelatex $(MAIN).tex'

lmk_check =								\
	@which $(LMK) > /dev/null ||		\
		(echo "$(ERROR_MSG)" >& 2 &&	\
			exit 1)

default: $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex $(SRCS)
	$(call lmk_check)
	@$(LMK) $(OTYPE) $(TEX) $<

.PHONY: watch clean

# Automatically rebuild latex files whenever changes are made.
watch: $(MAIN).tex
	$(call lmk_check)
	@$(LMK) -pvc $(OTYPE) $(TEX) $<

clean:
	@rm -f *.dvi *.aux *.blg *.log *.ps *~ *.bbl *.fdb_latexmk *.fls $(MAIN).pdf *.out *.xdv
