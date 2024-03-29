let target_file = [
  "int.ml"; "float.ml"; "if.ml"; "app.ml";
  "add.ml"; "assoc.ml"; "bool.ml"; "let.ml";
  "letrec.ml"; "letlet.ml"; "fact.ml"
]

let infer_run () = List.map
    (fun x ->
       Typing.infer [] (Main.parse ("test/" ^ x))
    )
    target_file


let run () = List.map
    (fun x ->
       try
         Main.parse ("test/" ^ x)
       with
         Parsing.Parse_error -> Syntax.Error
    )
    target_file
