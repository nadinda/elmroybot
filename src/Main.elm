module Main exposing (main, update, view)

import Browser
import Browser.Events exposing (onKeyDown)
import Grid exposing (viewGrid)
import Html exposing (Html, button, div, h1, header, img, text)
import Html.Attributes exposing (alt, class, src)
import Html.Events exposing (onClick)
import Json.Decode as Decode
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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MoveForward ->
            ( { model | position = moveTo model.position model.direction }, Cmd.none )

        RotateLeft ->
            ( { model | direction = rotateToLeft model.direction }, Cmd.none )

        RotateRight ->
            ( { model | direction = rotateToRight model.direction }, Cmd.none )

        KeyboardEvent key ->
            case key of
                "w" ->
                    ( { model | position = moveTo model.position model.direction }, Cmd.none )

                "a" ->
                    ( { model | direction = rotateToLeft model.direction }, Cmd.none )

                "d" ->
                    ( { model | direction = rotateToRight model.direction }, Cmd.none )

                _ ->
                    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    onKeyDown (Decode.map KeyboardEvent (Decode.field "key" Decode.string))


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> ( initModel, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
