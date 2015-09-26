let fopen filename =
  let inchan = open_in filename in (Lexing.from_channel inchan)

let parse filename =
  Parser.main
    Lexer.token (fopen filename)

let infer filename =
  Typing.infer [] (parse filename)
