%{
open Syntax
%}

%token <int> INT
%token <float> FLOAT
%token <string> ID
%token <bool> Bool

%token PLUS
%token PLUS_DOT
%token MINUS
%token MINUS_DOT
%token TIME
%token TIME_DOT
%token EQ
%token LPAREN
%token RPAREN
%token COMMA
%token TRUE
%token FALSE

// keyword
%token IF
%token THEN
%token ELSE
%token IN
%token LET
%token REC

%token EOF

%right prec_let
%left PLUS PLUS_DOT MINUS MINUS_DOT
%left TIME TIME_DOT

%start main
%type <Syntax.exp> main

%%

main:
  exp EOF { $1 }
;

exp:
  | simple_exp { $1 }
  | ID LPAREN args RPAREN { App($1, $3) }
  | IF simple_exp THEN exp ELSE exp { If($2, $4, $6) }
  | exp EQ exp       { Eq($1, $3) }
  | exp PLUS exp     { Prime (AddOp, $1 ,$3)  }
  | exp PLUS_DOT exp { Prime (FAddOp, $1 ,$3) }
  | exp MINUS exp      { Prime (SubOp, $1 ,$3)  }
  | exp MINUS_DOT exp  { Prime (FSubOp, $1 ,$3) }
  | exp TIME exp      { Prime (MulOp, $1 ,$3)  }
  | exp TIME_DOT exp  { Prime (FMulOp, $1 ,$3) }
  | LET ID EQ exp IN exp
     %prec prec_let
     { Let($2, $4, $6) }
  | LET REC ID LPAREN formal_args RPAREN EQ exp IN exp
    %prec prec_let
    { LetRec($3, $5, $8, $10) }

formal_args:
  | ID { [$1] }
  | ID COMMA formal_args { $1 :: $3 }

simple_exp:
  | LPAREN exp RPAREN { $2 }
  | ID    { Var($1) }
  | INT   { Int($1) }
  | FLOAT { Float($1) }
  | TRUE  { Bool(true) }
  | FALSE { Bool(false) }

args:
  | simple_exp { [$1] }
  | simple_exp COMMA args { $1 :: $3 }
