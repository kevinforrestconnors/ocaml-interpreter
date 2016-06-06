CC=corebuild

all: clean io parser

clean: ; rm -rf _build

add: ; git add Makefile && git add io.ml && git add parser.ml

io: ; $(CC) io.native

parser: ; $(CC) parser.native

