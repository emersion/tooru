PREFIX ?= /usr
DESTDIR ?=
BINDIR ?= $(PREFIX)/bin

install:
	install -D -m 0755 tooru.sh "$(DESTDIR)$(BINDIR)/tooru"
test:
	shellcheck tooru.sh
.PHONY: install test
