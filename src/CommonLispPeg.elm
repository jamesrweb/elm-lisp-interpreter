module CommonLispPeg exposing (grammar)

import Peg


grammar : Result Peg.Error Peg.Grammar
grammar =
    Peg.fromString """
    Entry <- Spacing Expression* {entry}
    Expression <- List / Atom / String / Number / Comment {expression}
    List <- '(' Spacing Expression* ')' {list}
    Atom <- Symbol / Keyword {atom}
    Symbol <- [a-zA-Z_+*/<=>!?$%&~^:][a-zA-Z0-9_+*/<=>!?$%&~^:]* Spacing {symbol}
    Keyword <- ':' [a-zA-Z_+*/<=>!?$%&~^:][a-zA-Z0-9_+*/<=>!?$%&~^:]* Spacing {keyword}
    Number <- ('-'? [0-9]+ ('.' [0-9]+)? / '.' [0-9]+) Spacing {number}
    String <- '"' (!'"' .)* '"' Spacing {string}
    Comment <- ';' (!'\\n' .)* '\\n' Spacing {comment}
    Spacing <- [ \\t\\n\\r]* {spacing}
    """
