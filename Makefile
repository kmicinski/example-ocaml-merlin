default: main

main: main.native

test: test.native

%.native: 
	ocamlbuild -use-ocamlfind $@
	mv $@ $*

.PHONY: test default
