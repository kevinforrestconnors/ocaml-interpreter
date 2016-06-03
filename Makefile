CC=corebuild

all: clean io parser

clean: ; rm -rf _build

io: ; $(CC) io.native

parser: ; $(CC) parser.native

