# +----------------------------------------------------------------------------+
# | CoreLAB v0.1 - Modular Processor Simulation Framework                      |
# | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | Makefile                                                                   |
# | Make file for source code                                                  |
# +----------------------------------------------------------------------------+

include ../../Makefile.global

project=`ls | grep -v README.md | grep -v Makefile | grep -v Makefile.w32 | grep -v Makefile.w64`

all:
	@mkdir -p $(outdir)/
	@for x in $(project); do \
	  if [ -f $$x ]; then \
	    $(fpc) $(fpcargs) -Cg -Fu../corelab/core/ -FE$(outdir) $$x; \
	  echo ""; \
	  fi; \
	done

clean:
	@$(rm) $(outdir)/*

install:

uninstall:

convert:

createhelp:
