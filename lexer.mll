{
open Parser
}

let space = [' ' '\t' '\n' '\r']
let digit = ['0'-'9']
let lalpha = ['a'-'z']
let ualpha = ['A'-'Z']

rule token = parse
           | digit+ '.' digit* as lxm { FLOAT (float_of_string lxm) }
           | digit+ as lxm { INT (int_of_string lxm) }
           | '+'    { PLUS }
           | "+."   { PLUS_DOT }
           | '-'    { MINUS }
           | "-."   { MINUS_DOT }
           | '*'    { TIME }
           | "*."   { TIME_DOT }
           | '='    { EQ }
           | '('    { LPAREN }
           | ')'    { RPAREN }
           | "if"   { IF }
           | "else" { ELSE }
           | "then" { THEN }
           | "let"  { LET }
           | "rec"  { REC }
           | "true" { TRUE }
           | "false" { FALSE }
           | lalpha (ualpha|lalpha|digit)* { ID (Lexing.lexeme lexbuf) }
           | eof    { EOF }
           | space+ { token lexbuf }
