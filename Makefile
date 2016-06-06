CC=corebuild

all: clean io parser tests

clean: ; rm -rf _build

gitadd: ; git add Makefile && git add io.ml && git add parser.ml && git add tests.ml

io: ; $(CC) io.native
parser: ; $(CC) parser.native
tests: ; $(CC) tests.native
