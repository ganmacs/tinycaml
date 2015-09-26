tiny caml implementation

### Token

```
Digit = [0-9]
Int   = Digit+
Float = Digit+ "." Digit*

Laplha = [a-z]
Aplha = [a-zA-Z]
Id = str(str|digit)*
```

### Syntax

```
exp:
  | simple_exp
  | ID LPAREN args RPAREN
  | exp PLUS exp
  | exp PLUS_DOT exp
  | exp SUB exp
  | exp SUB_DOT exp
  | exp MUL exp
  | exp MUL_DOT exp
  | IF simple_exp THEN exp ELSE exp
  | LET ID EQ exp IN exp
  | LET REC ID LPAREN formal_args RPAREN EQ exp IN exp

formal_args:
  | ID
  | ID COMMA foraml_args

simple_exp:
  | LPAREN exp RPAREN
  | ID
  | INT
  | FLOAT

args:
  | simple_exp
  | simple_exp COMMA args
```


