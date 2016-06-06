open Core.Std;;
open Parser;;

let term1 = TmIf(Position(0), TmTrue(Position(1)), TmZero(Position(2)), TmZero(Position(3)))
