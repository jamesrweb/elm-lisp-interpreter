module ReviewConfig exposing (config)

{-| Do not rename the ReviewConfig module or the config function, because
`elm-review` will look for these.
-}

import NoDebug.Log
import NoDebug.TodoOrToString
import NoUnused.Variables
import Review.Rule exposing (Rule)


config : List Rule
config =
    [ NoDebug.Log.rule
    , NoDebug.TodoOrToString.rule
    , NoUnused.Variables.rule
    ]
