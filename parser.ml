open Core.Std;;

type info =
  Position of int
  
type term =
  TmTrue of info
| TmFalse of info
| TmIf of info * term * term * term
| TmZero of info
| TmSucc of info * term
| TmPred of info * term
| TmIsZero of info * term;;

let dummyinfo = Position(-1)
  
let rec isNumericVal t =
  match t with
    TmZero(_) -> true
  | TmSucc(_,t1) -> isNumericVal t1
  | TmPred(_,t1) -> isNumericVal t1
  | _ -> false;;

let rec isVal t =
  match t with
    TmTrue(_) -> true
  | TmFalse(_) -> true
  | t when isNumericVal t -> true
  | _ -> false;;

exception NoRuleApplies;;

let rec evalstep t =
  match t with
    TmIf(_, TmTrue(_), t2, t3) -> t2
  | TmIf(_, TmFalse(_), t2, t3) -> t3
  | TmIf(fi, t1, t2, t3) -> TmIf(fi, evalstep t1, t2, t3)
  | TmSucc(fi, t1) -> TmSucc(fi, evalstep t1)
  | TmPred(_, TmZero(_)) -> TmZero(dummyinfo)
  | TmPred(_, TmSucc(_, nv1)) when isNumericVal nv1 -> nv1
  | TmPred(fi, t1) -> TmPred(fi, evalstep t1)
  | TmIsZero(_, TmZero(_)) -> TmTrue(dummyinfo)
  | TmIsZero(_, TmSucc(_, nv1)) when isNumericVal nv1 -> TmFalse(dummyinfo)
  | TmIsZero(fi, t1) -> TmIsZero(fi, evalstep t1)
  | _ -> raise NoRuleApplies;;

let rec eval t =
  try eval (evalstep t)
  with NoRuleApplies -> t;;


let rec string_of_term t =
  match t with
    TmTrue(_) -> "true"
  | TmFalse(_) -> "false"
  | TmIf(_, t1, t2, t3) -> "if " ^ string_of_term t1 ^ " then " ^ string_of_term t2 ^ " else " ^ string_of_term t3
  | TmZero(_) -> "0"
  | TmSucc(_, t1) -> "TmSucc(" ^ string_of_term t1 ^ ")" (* when isNumericVal nv1 -> String_of_int(1 + ) *)
  | TmPred(_, t1) -> "TmPred(" ^ string_of_term t1 ^ ")"
  | TmIsZero(_, t1) -> "TmIsZero(" ^ string_of_term t1 ^ ")";;
  
let main () =
  let output = string_of_term (TmTrue(Position(1)))
  in print_string "5"
