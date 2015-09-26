SRC= type.mli type.ml syntax.ml parser.mli parser.ml lexer.ml typing.ml main.ml test.ml
TARGET= tinycaml

all: $(TARGET)

$(TARGET): $(SRC)
	ocamlmktop $(SRC) -o $(TARGET)

parser.mli: parser.mly
	ocamlyacc parser.mly

parser.ml: parser.mly
	ocamlyacc parser.mly

lexer.ml: lexer.mll
	ocamllex lexer.mll
