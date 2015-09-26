open Type

exception Unify_Error of Type.t * Type.t

let rec unify t1 t2 =
  match t1, t2 with
  | Int, Int | Float, Float | Bool, Bool -> ()
  | Var(r1), Var(r2) when r1.t = r2.t -> ()
  | Var { id = _; t = Some(t1') }, _ -> unify t1' t2
  | _, Var { id = _; t = Some(t2') } -> unify t1 t2'
  | (Var ({ id = _; t = None } as ty), t') -> ty.t <- Some(t')
  | (t', Var ({ id = _; t = None } as ty)) -> ty.t <- Some(t')
  | _, _ -> raise (Unify_Error (t1, t2))

let rec infer env = function
  | Syntax.Int(_) -> Int
  | Syntax.Float(_) -> Float
  | Syntax.Bool(_) -> Bool
  | Syntax.Var(x) ->
    let t = List.assoc x env in (* TODO *)
    t
  (* 型環境からxに対応する型をとる *)
  | Syntax.If(e1, e2, e3) -> begin
      unify Bool (infer env e1);
      let e2' = infer env e2 in
      let e3' = infer env e3 in
      unify e2' e3';
      e2'
    end
  | Syntax.Eq(e1, e2) -> begin
      let e1' = infer env e1 in
      let e2' = infer env e2 in
      unify e1' e2';
      Bool
    end
  | Syntax.Prime(op, e1, e2) -> begin
      let e1' = infer env e1 in
      let e2' = infer env e2 in
      match op with
      | Syntax.AddOp | Syntax.SubOp | Syntax.MulOp ->
        unify Int e1';
        unify Int e2';
        Int
      | Syntax.FAddOp | Syntax.FSubOp | Syntax.FMulOp ->
        unify Float e1';
        unify Float e2';
        Float
    end
  | Syntax.Let(x, e1, e2) -> begin
      let e1' = infer env e1 in
      let t = gen_tyv () in
      unify t e1';
      infer ((x, t) :: env) e2
    end
  | _ -> failwith "unimplment"

(* let x = 1 in x + 1 *)
(* Syntax.Let ("x", Syntax.Int 1, Syntax.Prime (Syntax.AddOp, Syntax.Var "x", Syntax.Int 1)) *)
