module Main exposing (main, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Robot exposing (Model, Msg(..), initModel, rotateToLeft, rotateToRight, viewRobot)


view : Model -> Html Msg
view model =
    div []
        [ viewRobot model.direction
        , div []
            [ button [ onClick RotateLeft ] [ text "Rotate ↺" ]
            , button [ onClick RotateRight ] [ text "Rotate ↻" ]
            ]
        ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        RotateLeft ->
            { model | direction = rotateToLeft model.direction }

        RotateRight ->
            { model | direction = rotateToRight model.direction }


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initModel
        , update = update
        , view = view
        }
