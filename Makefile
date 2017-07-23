PREFIX ?= /usr
DESTDIR ?=
BINDIR ?= $(PREFIX)/bin
LIBDIR ?= $(PREFIX)/lib

install:
	install -D -m 0755 "tooru" "$(DESTDIR)$(BINDIR)/tooru"
	install -D "systemd/tooru@.service" "$(DESTDIR)$(LIBDIR)/systemd/system/tooru@.service"
	install -D "systemd/tooru@.timer" "$(DESTDIR)$(LIBDIR)/systemd/system/tooru@.timer"
test:
	shellcheck tooru
.PHONY: install test
