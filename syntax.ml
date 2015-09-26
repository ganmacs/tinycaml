type var = string

type primop = AddOp | FAddOp | SubOp | FSubOp | MulOp | FMulOp

type exp =
  | Int of int
  | Float of float
  | Bool of bool
  | Var of var
  | Prime of primop * exp * exp
  | If of exp * exp * exp
  | App of exp * exp list
  | Let of (var * Type.t) * exp * exp
  | LetRec of (var * Type.t) * (var * Type.t) list * exp * exp
  | Eq of exp * exp
  | Error                       (* for test *)
