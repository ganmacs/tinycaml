type t =
  | Int
  | Float
  | Bool
  | Var of varty
and varty = { id: int; mutable t: t option }

let current_id = ref 0

let gen_tyv () =
  let i = !current_id in
  current_id :=  i + 1;
  Var { id =  i; t = None }
