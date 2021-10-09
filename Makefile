PREFIX  := /usr/local
BINDIR  := $(PREFIX)/bin
DATADIR := $(PREFIX)/share

BINFILES   := $(foreach binfile,$(wildcard bin/*), $(BINDIR)/$(notdir $(binfile))) 
DATAFILES  := $(foreach datafile,$(wildcard lib/*), $(DATADIR)/yankee/$(notdir $(datafile)))
UNINSTALL_FILES := $(BINFILES) $(DATAFILES)
		   

.PHONY: install uninstall
install:
	install -D $(wildcard bin/*) $(BINDIR)/
	install -D -t $(DATADIR)/yankee/ $(wildcard lib/*) 

uninstall:
	rm -v $(UNINSTALL_FILES)
