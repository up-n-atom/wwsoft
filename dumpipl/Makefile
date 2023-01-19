NASM:=nasm
NASMFLAGS:=-f bin
PERL:=perl
PERLFLAGS:=-e

# Based from http://daifukkat.su/blog/archives/2014/07/14/wonderhax_part_2/
WWENCODE = \
	binmode STDIN; \
	$$/ = \1; \
	while (<>) { \
		print chr($$b = ($$. - 1) & 127 ? ord($$_) ^ $$b : ord($$_) ^ 255); \
	}

.PHONY: all clean

all: wwsoft

dumpipl : dumpipl.asm
	$(NASM) $(NASMFLAGS) $<

wwsoft: dumpipl
	$(PERL) $(PERLFLAGS) '$(WWENCODE)' < $< > $@
	@rm -rf $< ||:

clean:
	rm -rf wwsoft
