module Robot exposing (Direction, Model, Msg(..), initModel, rotateToLeft, rotateToRight, viewRobot)

import Html exposing (Html, text)


type alias Position =
    { x : Int
    , y : Int
    }


type Direction
    = North
    | East
    | South
    | West


type alias Model =
    { position : Position
    , direction : Direction
    }


type Msg
    = RotateLeft
    | RotateRight


initModel : Model
initModel =
    { position = { x = 0, y = 0 }
    , direction = East
    }


rotateToLeft : Direction -> Direction
rotateToLeft dir =
    case dir of
        North ->
            West

        East ->
            North

        South ->
            East

        West ->
            South


rotateToRight : Direction -> Direction
rotateToRight dir =
    case dir of
        North ->
            East

        East ->
            South

        South ->
            West

        West ->
            North


viewRobot : Direction -> Html msg
viewRobot dir =
    case dir of
        North ->
            text "⬆️"

        East ->
            text "➡️"

        South ->
            text "⬇️"

        West ->
            text "⬅️"
