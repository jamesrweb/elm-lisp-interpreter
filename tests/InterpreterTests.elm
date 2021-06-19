module InterpreterTests exposing (..)

import Expect
import Interpreter exposing (Token(..), TokenIdentity, TokenType(..), TokenValue(..), categoriseTokens, tokenise)
import Test


suite : Test.Test
suite =
    Test.describe "The Interpreter Module"
        [ Test.describe "The tokenise function"
            [ Test.test "An integer atom" <|
                \_ ->
                    Expect.equal (tokenise "1") [ Token "1" ]
            , Test.test "A string atom" <|
                \_ ->
                    Expect.equal (tokenise "a") [ Token "a" ]
            , Test.test "An empty list" <|
                \_ ->
                    Expect.equal (tokenise "()") [ Token "(", Token ")" ]
            , Test.test "A list containing an atom" <|
                \_ ->
                    Expect.equal (tokenise "(1)") [ Token "(", Token "1", Token ")" ]
            , Test.test "A list containing a list containing an atom" <|
                \_ ->
                    Expect.equal (tokenise "((1))") [ Token "(", Token "(", Token "1", Token ")", Token ")" ]
            , Test.test "A list containing two atoms" <|
                \_ ->
                    Expect.equal (tokenise "(1 2)") [ Token "(", Token "1", Token "2", Token ")" ]
            , Test.test "A list containing an atom and another list" <|
                \_ ->
                    Expect.equal (tokenise "(1 (2))") [ Token "(", Token "1", Token "(", Token "2", Token ")", Token ")" ]
            , Test.test "A function invokation" <|
                \_ ->
                    Expect.equal (tokenise "((lambda (x) x) \"Lisp\")") [ Token "(", Token "(", Token "lambda", Token "(", Token "x", Token ")", Token "x", Token ")", Token "\"Lisp\"", Token ")" ]
            ]
        , Test.describe "The categoriseTokens function"
            [ Test.test "An integer atom" <|
                \_ ->
                    let
                        actual =
                            categoriseTokens (tokenise "1")

                        expected =
                            [ TokenIdentity Literal (Value "1") ]
                    in
                    Expect.equal expected actual
            , Test.test "A lambda definition" <|
                \_ ->
                    -- let
                    --     actual = categoriseTokens (tokenise "lambda (x) x")
                    --     expected = [[{ type_ = Identifier, value = Keyword "lambda" }, [{ type_ = Identifier, value = Value "x" }], { type_ = Identifier, value = Value "x" }]]
                    -- in
                    -- Expect.equal expected actual
                    Debug.todo "Handle nested tokens"
            ]
        ]
