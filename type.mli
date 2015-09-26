type t =
  | Int
  | Float
  | Bool
  | Var of varty
and varty = { id: int; mutable t: t option }

val gen_tyv: unit -> t
