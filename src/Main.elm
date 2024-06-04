module Main exposing (..)

import Browser
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Interpreter exposing (parse)
import Peg


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { input : String
    , result : Result Peg.Error Interpreter.State
    }


init : Model
init =
    { input = "(+ 1 2)"
    , result = Ok []
    }


type Msg
    = HandleInput String
    | ParseInput


update : Msg -> Model -> Model
update msg model =
    case msg of
        HandleInput input ->
            { model | input = input }

        ParseInput ->
            { model | result = String.trim model.input |> Interpreter.parse }


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.div []
            [ Html.textarea
                [ Html.Events.onInput HandleInput
                , Html.Attributes.value model.input
                , Html.Attributes.rows 10
                , Html.Attributes.cols 50
                ]
                []
            ]
        , Html.button [ Html.Events.onClick ParseInput ] [ Html.text "Parse" ]
        , Html.hr [] []
        , case model.result of
            Ok result ->
                Html.text ("Parsed: " ++ Debug.toString result)

            Err err ->
                Html.text ("Error: " ++ Debug.toString err)
        ]
