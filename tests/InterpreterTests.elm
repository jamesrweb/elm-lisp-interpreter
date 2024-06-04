module InterpreterTests exposing (..)

import Expect
import Interpreter exposing (integer, parse, symbol)
import Test


suite : Test.Test
suite =
    Test.describe "The Interpreter Module"
        [ Test.describe "The parse function"
            [ Test.test "A sum of two numbers" <|
                \_ ->
                    Expect.equal (parse "(+ 1 2)")
                        (Ok
                            [ symbol "+"
                            , integer 1
                            , integer 2
                            ]
                        )

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
