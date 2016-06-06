open Core.Std;;
open Parser;;

let _ =
  eval Tests.term1
  |> string_of_term
  |> print_endline
