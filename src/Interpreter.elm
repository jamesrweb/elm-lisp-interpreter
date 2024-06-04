module Interpreter exposing (parse)

import CommonLispPeg exposing (grammar)
import Peg


type alias State =
    String


parse : String -> Result Peg.Error String
parse input =
    let
        actions : String -> String -> State -> Result String State
        actions name found state =
            let
                _ =
                    Debug.log "name, found, state" [ name, found, state ]
            in
            Ok found

        predicate : String -> String -> State -> ( Bool, State )
        predicate name match state =
            let
                _ =
                    Debug.log "name, match, state" [ name, match, state ]
            in
            ( True, state )

        go : Peg.Grammar -> Result Peg.Error String
        go grammar =
            Peg.parse grammar "" actions predicate input
    in
    CommonLispPeg.grammar |> Result.andThen go
