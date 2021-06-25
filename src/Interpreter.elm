module Interpreter exposing (Token(..), TokenIdentity, TokenType(..), TokenValue(..), categoriseTokens, tokenise)


type Token
    = Token String


type alias Tokens =
    List Token


tokenise : String -> Tokens
tokenise input =
    input
        |> String.replace "(" " ( "
        |> String.replace ")" " ) "
        |> String.trim
        |> String.words
        |> List.map (\v -> Token v)


type TokenType
    = Identifier
    | Literal


type TokenValue
    = Keyword String
    | Value String


type alias TokenIdentity =
    { type_ : TokenType, value : TokenValue }


type alias TokenIdentities =
    List TokenIdentity


categoriseTokens : Tokens -> TokenIdentities
categoriseTokens tokens =
    Maybe.withDefault [] (categoriseTokensHelper tokens [])


categoriseTokensHelper : Tokens -> TokenIdentities -> Maybe TokenIdentities
categoriseTokensHelper tokens identities =
    case tokens of
        [] ->
            List.reverse identities
                |> List.head
                |> Maybe.map List.singleton

        token :: rest ->
            let
                (Token value) =
                    token
            in
            if value == "(" then
                Maybe.andThen
                    (\ids -> categoriseTokensHelper rest (List.append identities ids))
                    (categoriseTokensHelper rest [])

            else if value == ")" then
                Just identities

            else
                categoriseTokensHelper rest (List.append identities [ categoriseToken token ])


categoriseToken : Token -> TokenIdentity
categoriseToken (Token value) =
    case String.toInt value of
        Nothing ->
            case String.toFloat value of
                Nothing ->
                    if String.startsWith "\"" value && String.endsWith "\"" value then
                        TokenIdentity Literal (Value (String.slice 1 -1 value))

                    else
                        TokenIdentity Identifier (Keyword value)

                Just _ ->
                    TokenIdentity Literal (Value value)

        Just _ ->
            TokenIdentity Literal (Value value)


parse : String -> TokenIdentities
parse input =
    categoriseTokens (tokenise input)
