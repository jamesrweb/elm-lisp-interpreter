module CommonLispPeg exposing (grammar)

import Peg


grammar : Result Peg.Error Peg.Grammar
grammar =
    Peg.fromString """
    Entry <- Spacing Expression*
    Expression <- List / Atom / String / Number / Comment
    Comment <- <(';' (!'\\n' .)*)> '\\n' Spacing
    Spacing <- [ \\t\\n\\r]*
    List <- '(' Spacing Expression* ')'

    Atom <- Symbol / Keyword {atom}
    Symbol <- <([a-zA-Z_+*/<=>!?$%&~^:][a-zA-Z0-9_+*/<=>!?$%&~^:]*)> Spacing {symbol}
    Keyword <- ':' Symbol {keyword}
    Number <- <('-'? [0-9]+ ('.' [0-9]+)? / '.' [0-9]+)> Spacing {number}
    String <- <('"' (!'"' .)* '"')> Spacing {string}
    """
