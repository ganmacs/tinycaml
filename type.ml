type t =
  | Int
  | Float
  | Bool
  | Fun of t list * t
  | Var of varty
and varty = { id: int; mutable t: t option }

let current_id = ref 0

let gen_typ () =
  let i = !current_id in
  current_id :=  i + 1;
  Var { id =  i; t = None }
