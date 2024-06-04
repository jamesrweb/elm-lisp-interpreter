module Interpreter exposing (State, decimal, entryPoint, integer, list, parse, symbol, whitespace)

import CommonLispPeg exposing (grammar)
import Peg


type Token
    = Integer Int
    | Decimal Float
    | WhiteSpace String
    | Symbol String
    | List State
    | EntryPoint String


integer : Int -> Token
integer =
    Integer


decimal : Float -> Token
decimal =
    Decimal


whitespace : String -> Token
whitespace =
    WhiteSpace


symbol : String -> Token
symbol =
    Symbol


list : List Token -> Token
list =
    List


entryPoint : String -> Token
entryPoint =
    EntryPoint


type alias State =
    List Token


parse : String -> Result Peg.Error State
parse input =
    let
        actions : String -> String -> State -> Result String State
        actions name found state =
            if String.isEmpty found then
                Ok state

            else if name == "number" then
                case ( String.toInt found, String.toFloat found ) of
                    ( Just x, _ ) ->
                        Ok <| state ++ [ Integer x ]

                    ( _, Just y ) ->
                        Ok <| state ++ [ Decimal y ]

                    _ ->
                        Err "The number provided was not an integer or a float."

            else if name == "symbol" then
                Ok <| state ++ [ Symbol found ]

            else if name == "list" then
                case parse found of
                    Ok items ->
                        Ok <| state ++ [ List items ]

                    Err error ->
                        Err error.message

            else if name == "entry" then
                Ok <| state ++ [ EntryPoint found ]

            else
                Ok state

        predicate : String -> String -> State -> ( Bool, State )
        predicate name match state =
            let
                _ =
                    Debug.log "name, match, state" [ name, match, Debug.toString state ]
            in
            ( True, state )

        go : Peg.Grammar -> Result Peg.Error State
        go grammar =
            Peg.parse grammar [] actions predicate input
    in
    CommonLispPeg.grammar |> Result.andThen go
