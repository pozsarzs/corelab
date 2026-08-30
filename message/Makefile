# +----------------------------------------------------------------------------+
# | CoreLAB v0.1 - Modular Processor Simulation Framework                      |
# | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | Makefile                                                                   |
# | Makefile for message files                                                 |
# +----------------------------------------------------------------------------+

include ../Makefile.global

title="message files "
removetargetdir=0
sourcedir="."
targetdir=$(localedir)
filemode=$(txtmode)
languages=hu

# convert encoding and line-ending of the .po file for DOS
define conv_encode
  $(install) -d $(2)-$(4); \
  $(iconv) -f utf8 -t cp$(3) $(2)/$(1).po > $(2)-$(4)/out.po; \
  cat $(2)-$(4)/out.po | sed s/"charset=UTF-8"/"charset=cp$(3)"/ > $(2)-$(4)/$(1).po; \
  $(rm) $(2)-$(4)/out.po; \
  $(unix2dos) $(2)-$(4)/$(1).po; \
  $(msgfmt) $(2)-$(4)/$(1).po -o $(2)-$(4)/$(1).mo
endef

all:
	
clean:

install:
	@echo -n "- Installing "$(title)"["
	@for x in $(languages); do \
	  if [ -f $$x/$(name).mo ]; \
	  then \
	    $(install) -d $(targetdir)/$$x/LC_MESSAGES/; \
	    $(install) -m $(filemode) $(sourcedir)/$$x/$(name).mo $(targetdir)/$$x/LC_MESSAGES/; \
	    echo -n "#"; \
	  fi; \
	done
	@for x in $(languages); do \
	  if [ -f $$x/clprocessor.mo ]; \
	  then \
	    $(install) -d $(targetdir)/$$x/LC_MESSAGES/; \
	    $(install) -m $(filemode) $(sourcedir)/$$x/clprocessor.mo $(targetdir)/$$x/LC_MESSAGES/; \
	    echo -n "#"; \
	  fi; \
	done
	@for x in $(languages); do \
	  if [ -f $$x/clioport.mo ]; \
	  then \
	    $(install) -d $(targetdir)/$$x/LC_MESSAGES/; \
	    $(install) -m $(filemode) $(sourcedir)/$$x/clioport.mo $(targetdir)/$$x/LC_MESSAGES/; \
	    echo -n "#"; \
	  fi; \
	done
	@for x in $(languages); do \
	  if [ -f $$x/clmemory.mo ]; \
	  then \
	    $(install) -d $(targetdir)/$$x/LC_MESSAGES/; \
	    $(install) -m $(filemode) $(sourcedir)/$$x/clmemory.mo $(targetdir)/$$x/LC_MESSAGES/; \
	    echo -n "#"; \
	  fi; \
	done
	@if [ ! $(lhelp) = "no" ]; \
	then \
	  for x in $(languages); do \
	    if [ -f $$x/lhelp.mo ]; \
	    then \
	      $(install) -d $(targetdir)/$$x/LC_MESSAGES/; \
	      $(install) -m $(filemode) $(sourcedir)/$$x/lhelp.mo $(targetdir)/$$x/LC_MESSAGES/; \
	      echo -n "#"; \
	    fi; \
	  done; \
	fi
	@echo "]"

uninstall:
	@echo -n "- Removing "$(title)"["
	@for x in $(languages); do \
	  if [ -f $$x/$(name).mo ]; \
	  then \
	    $(rm) $(targetdir)/$$x/LC_MESSAGES/$(name).mo; \
	    echo -n "#"; \
	  fi; \
	done  
	@for x in $(languages); do \
	  if [ -f $$x/clprocessor.mo ]; \
	  then \
	    $(rm) $(targetdir)/$$x/LC_MESSAGES/clprocessor.mo; \
	    echo -n "#"; \
	  fi; \
	done
	@for x in $(languages); do \
	  if [ -f $$x/clioport.mo ]; \
	  then \
	    $(rm) $(targetdir)/$$x/LC_MESSAGES/clioport.mo; \
	    echo -n "#"; \
	  fi; \
	done
	@for x in $(languages); do \
	  if [ -f $$x/clmemory.mo ]; \
	  then \
	    $(rm) $(targetdir)/$$x/LC_MESSAGES/clmemory.mo; \
	    echo -n "#"; \
	  fi; \
	done
	@if [ ! $(lhelp) = "no" ]; \
	then \
	  for x in $(languages); do \
	    if [ -f $$x/lhelp.mo ]; \
	    then \
	      $(rm) $(targetdir)/$$x/LC_MESSAGES/lhelp.mo; \
	      echo -n "#"; \
	    fi; \
	  done; \
	fi
	@for x in $(languages); do \
	  if [ $(removetargetdir) -eq 1 ]; \
	  then \
	    if [ -d $(targetdir)/$$x/LC_MESSAGES ]; then $(rmdir) $(targetdir)/$$x/LC_MESSAGES; fi; \
	  fi; \
	done
	@echo "]"

convert:
	@if [ $(iconv) != "no" ] && [ $(msgfmt) != "no" ] && [ $(unix2dos) != "no" ]; \
	then \
	  $(call conv_encode,corelab,hu,1250,windows); \
	  $(call conv_encode,clprocessor,hu,1250,windows); \
	  $(call conv_encode,clioport,hu,1250,windows); \
	  $(call conv_encode,clmemory,hu,1250,windows); \
	else \
	  echo "To create message file for Windows, install the necessary tools."; \
	fi

createhelp:
