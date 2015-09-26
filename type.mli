type t =
  | Int
  | Float
  | Bool
  | Fun of t list * t
  | Var of varty
and varty = { id: int; mutable t: t option }

val gen_typ: unit -> t
