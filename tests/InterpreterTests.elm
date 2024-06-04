module InterpreterTests exposing (..)

import Expect
import Interpreter exposing (parse)
import Test


suite : Test.Test
suite =
    Test.describe "The Interpreter Module"
        [ Test.describe "The tokenise function"
            [ Test.test "An integer atom" <|
                \_ ->
                    Expect.equal (parse "( 1 )") (Ok "1")

            -- , Test.test "A string atom" <|
            --     \_ ->
            --         Expect.equal (parse "a") [ "a" ]
            -- , Test.test "An empty list" <|
            --     \_ ->
            --         Expect.equal (parse "()") [ "(", ")" ]
            -- , Test.test "A list containing an atom" <|
            --     \_ ->
            --         Expect.equal (parse "(1)") [ "(", "1", ")" ]
            -- , Test.test "A list containing a list containing an atom" <|
            --     \_ ->
            --         Expect.equal (parse "((1))") [ "(", "(", "1", ")", ")" ]
            -- , Test.test "A list containing two atoms" <|
            --     \_ ->
            --         Expect.equal (parse "(1 2)") [ "(", "1", "2", ")" ]
            -- , Test.test "A list containing an atom and another list" <|
            --     \_ ->
            --         Expect.equal (parse "(1 (2))") [ "(", "1", "(", "2", ")", ")" ]
            -- , Test.test "A function invokation" <|
            --     \_ ->
            --         Expect.equal (parse "((lambda (x) x) \"Lisp\")") [ "(", "(", "lambda", "(", "x", ")", "x", ")", "\"Lisp\"", ")" ]
            ]
        ]
