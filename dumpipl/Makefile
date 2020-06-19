NASM:=nasm
NASMFLAGS:=-f bin
PERL:=perl
PERLFLAGS:=-e

WWENCODE = \
	my ($$b, $$c) = (255, 0); \
	binmode STDIN; \
	$$/ = \1; \
	while (<STDIN>) { \
		print chr($$b ^= ord($$_)); \
		$$c++; \
		$$c &= 127; \
		if (!$$c) { \
			$$b=255; \
		} \
	}

.PHONY: all clean

all: wwsoft

dumpipl : dumpipl.asm
	$(NASM) $(NASMFLAGS) $<

wwsoft: dumpipl
	$(PERL) $(PERLFLAGS) '$(WWENCODE)' < $< > $@
	rm -rf $<

clean:
	rm -rf wwsoft
