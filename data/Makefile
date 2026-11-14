# +----------------------------------------------------------------------------+
# | CoreLAB v0.1 - Modular Processor Simulation Framework                      |
# | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | Makefile                                                                   |
# | Makefile for Unix-like systems                                             |
# +----------------------------------------------------------------------------+

include ../Makefile.global

title="data files   \t"
removetargetdir=1
sourcedir="."
targetdir=$(datarootdir)/$(name)
filemode=$(txtmode)
files=`ls $(sourcedir) | grep -v Makefile`

all:

clean:

install:
	@echo -n "- Installing "$(title)"["
	@$(install) --directory $(targetdir)
	@for x in $(files); do \
	  if [ -f $(sourcedir)/$$x ]; \
	  then \
	    $(install) --mode $(filemode) $(sourcedir)/$$x $(targetdir); \
	    echo -n "#"; \
	  fi \
	done
	@echo "]"

uninstall:
	@echo -n "- Removing "$(title)"["
	@for x in $(files); do \
	  $(rm) $(targetdir)/$$x; \
	  echo -n "#"; \
	done
	@if [ $(removetargetdir) -eq 1 ]; \
	then \
	  if [ -d $(targetdir) ]; then $(rmdir) $(targetdir); fi; \
	fi
	@echo "]"

convert:

createhelp:
