let target_file = [
  "int.ml"; "float.ml"; "if.ml"; "app.ml";
  "add.ml"; "assoc.ml";
]

let run () = List.map
    (fun x ->
       try
         Main.parse ("test/" ^ x)
       with
         Parsing.Parse_error -> Syntax.Error
    )
    target_file
