# +----------------------------------------------------------------------------+
# | CoreLAB v0.1 - Modular Processor Simulation Framework                      |
# | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | Makefile                                                                   |
# | Make file for source code                                                  |
# +----------------------------------------------------------------------------+

include ../../Makefile.global

outdir=../_lib/$(architecture)-$(os)
project=`ls | grep -v Makefile | grep -v Makefile.w64`

all:
	
	@mkdir -p $(outdir)/
	@for x in $(project); do \
	  if [ -f $$x/$$x.pas ]; then \
	    $(fpc) $(fpcargs) -Fu../corelab/core/ -FE$(outdir) $$x/$$x.pas; \
	  echo ""; \
	  fi; \
	done

clean:

install:

uninstall:

convert:

createhelp:
