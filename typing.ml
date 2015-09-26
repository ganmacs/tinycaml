open Type

exception Unify_Error of Type.t * Type.t
exception Error of string * Type.t * Syntax.exp list

let rec unify t1 t2 =
  match t1, t2 with
  | Int, Int | Float, Float | Bool, Bool -> ()
  | Fun(ts1, t1'), Fun(ts2, t2') ->
    List.iter2 unify ts1 ts2;
    unify t1' t2'
  | Var(v1'), Var(v2') when v1'.t = v2'.t -> ()
  | Var({ id = _; t = Some(t1') }), _ -> unify t1' t2
  | _, Var({ id = _; t = Some(t2') }) -> unify t1 t2'
  | Var({ id = _; t = None } as v1), t -> v1.t <- Some(t2)
  | _, Var({ id = _; t = None } as v2) -> v2.t <- Some(t1)
  | _ -> raise (Unify_Error(t1, t2))

let rec infer env = function
  | Syntax.Int(_) -> Int
  | Syntax.Float(_) -> Float
  | Syntax.Bool(_) -> Bool
  | Syntax.Var(x) ->
    let t = List.assoc x env in (* TODO *)
    t
  | Syntax.If(e1, e2, e3) ->
    unify Bool (infer env e1);
    let e2' = infer env e2 in
    let e3' = infer env e3 in
    unify e2' e3';
    e2'
  | Syntax.Eq(e1, e2) ->
    let e1' = infer env e1 in
    let e2' = infer env e2 in
    unify e1' e2';
    Bool
  | Syntax.App(f, args1) -> begin
      let t = infer env f in
      match t with
      | Var({id = _; t = Some(Fun(args2, t')) }) ->
        List.iter2 unify args2 (List.map (infer env) args1);
        t'
      | Var({id = _; t = None }) ->
        let t' = gen_typ () in
        unify t (Fun(List.map (infer env) args1, t'));
        t'
      | _ -> raise (Error("in App", t, args1))
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
  | Syntax.Let((x, t), e1, e2) ->
    let e1' = infer env e1 in
    unify t e1';
    infer ((x, t) :: env) e2
  | Syntax.LetRec((x, t), args, e1, e2) ->
    let env' = (x, t) :: env in
    unify t (Fun(List.map snd args, infer (args @ env') e1));
    infer env' e2
  | _ -> failwith "unimplment"
