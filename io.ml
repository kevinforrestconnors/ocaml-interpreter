open Core.Std;;
open Parser;;

let _ =
  let t = TmIf(Position(0), TmTrue(Position(1)), TmZero(Position(2)), TmZero(Position(3))) in
  eval t
  |> string_of_term
  |> print_endline
