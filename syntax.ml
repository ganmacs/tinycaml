type var = string

type primop = AddOp | FAddOp | SubOp | FSubOp | MulOp | FMulOp

type exp =
  | Int of int
  | Float of float
  | Var of var
  | Prime of primop * exp * exp
  | If of exp * exp * exp
  | App of var * exp list
  | Let of var * exp * exp
  | LetRec of var * var list * exp * exp
  | Eq of exp * exp
