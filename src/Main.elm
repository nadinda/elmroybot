module Main exposing (main, update, view)

import Browser
import Grid exposing (viewGrid)
import Html exposing (Html, button, div, h1, header, img, text)
import Html.Attributes exposing (alt, class, src)
import Html.Events exposing (onClick)
import Robot exposing (Model, Msg(..), initModel, moveTo, rotateToLeft, rotateToRight)
import VitePluginHelper exposing (asset)


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ header [ class "header" ]
            [ img [ src <| asset "/src/assets/logo.png", alt "Logo" ] []
            , h1 [ class "title" ] [ text "Elmroybot" ]
            ]
        , div [ class "grid" ] (viewGrid model)
        , div [ class "btn-group" ]
            [ button [ onClick RotateLeft ] [ text "Rotate ↺" ]
            , button [ onClick MoveForward ] [ text "Go Forward" ]
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

        MoveForward ->
            { model | position = moveTo model.position model.direction }


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initModel
        , update = update
        , view = view
        }
