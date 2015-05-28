OCaml with OCamlBuild and Merlin
================================

# Project structure

This is an example project that uses OCamlBuild and Merlin.

    - src/           <-- source code lives here
        awesome.ml   <-- An example module implementation
        awesome.mli  <-- An example module specification
        main.ml      <-- Main entry point
        test.ml      <-- Test harness (uses OCamlBuild)
      Makefile       <-- Driver for `make` (uses OCB)
      .merlin        <-- Merlin configuration
      _tags          <-- OCamlBuild configuration

Typing `make` will (hopefully!) generate a `main` binary, that you can
run:
    
    make
    ./main

# The source code

The `src/` directory defines three things:

- An example module `Awesome` (named `awesome.ml`) and its signature
  (`awesome.mli`).  Note the `.mli` file is using the `ocamldoc`
  format.

- A `main` program that uses the `Awesome` module.

- A `test` module that uses the `OUnit` for unit tests.

# The `Makefile`

Is just a wrapper around `ocamlbuild`, which is a standard use of
Makefiles with `ocamlbuild`.  OCamlBuild takes care of a lot of things
for us (dependency resolution, for example), but we still want to be
able to type `make` to build the project.

    default: main

    main: main.native

    test: test.native

    %.native: 
	ocamlbuild -use-ocamlfind $@
	mv $@ $*

    .PHONY: test default

The project defines two
[phony targets](http://stackoverflow.com/questions/2145590/what-is-the-purpose-of-phony-in-a-makefile)
so the developer can type `make main` or `make test` (and run `main`
by default if they only type `make`).  Then it shells out to
ocamlbuild.

## Running the test harness

    newvpn16:example-ocaml-merlin micinski$ make test
    ocamlbuild -use-ocamlfind test.native
    Finished, 8 targets (4 cached) in 00:00:00.
    mv test.native test
    newvpn16:example-ocaml-merlin micinski$ ./test
    .
    Ran: 1 tests in: 0.00 seconds.
    OK

Let's change something, change the definition of the `test` function
in `test.ml` to:

    let suite = "OUnit tests..." >:::  ["test_list_length" >::
        (fun () -> assert_equal "1" (str_of_t (succ one_t)))]

and now we get:

    ocamlbuild -use-ocamlfind test.native
    Finished, 8 targets (4 cached) in 00:00:00.
    mv test.native test
    newvpn16:example-ocaml-merlin micinski$ ./test
    F
    ==============================================================================
    Failure: OUnit tests...:0:test_list_length

    not equal
    ------------------------------------------------------------------------------
    Ran: 1 tests in: 0.00 seconds.
    FAILED: Cases: 1 Tried: 1 Errors: 0 Failures: 1 Skip:  0 Todo: 0 Timeouts: 0.

# Merlin `.merlin` file

The `.merlin` file in the main directory specifies project
dependencies for [Merlin](https://github.com/the-lambda-church/merlin):

    PRJ awesome
    S src

    PKG ounit

    B _build/src

- The first line names the project
- The second says that some source files live in the `src` directory
- The fourth says that we are using the `ounit` package (make sure you
  install it via OPAM!)
- The third says that built binaries live in `_build/src` (this is
  crucial, since Merlin seems to pick up signatures for it)

## Example merlin use

Rename `str_of_t` to `str_of_y` and save the buffer, it will be
highlighted with an error message:

    Error: Unbound value str_of_y

You can also partially complete `str_of_` and Merlin will auto fill a
completion for you.





