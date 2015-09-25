SRC= syntax.ml parser.mli parser.ml lexer.ml
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
