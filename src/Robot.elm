module Robot exposing (Direction(..), Model, Msg(..), initModel, moveTo, rotateToLeft, rotateToRight, viewRobot)

import Html exposing (Html, img)
import Html.Attributes exposing (alt, class, src, style)
import VitePluginHelper exposing (asset)


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
    | MoveForward
    | KeyboardEvent String


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


moveTo : Position -> Direction -> Position
moveTo pos dir =
    case dir of
        North ->
            { pos | y = max 0 (pos.y - 1) }

        East ->
            { pos | x = min 4 (pos.x + 1) }

        South ->
            { pos | y = min 4 (pos.y + 1) }

        West ->
            { pos | x = max 0 (pos.x - 1) }


viewRobot : Direction -> Html msg
viewRobot dir =
    let
        rotation =
            case dir of
                East ->
                    "rotate(0deg)"

                South ->
                    "rotate(90deg)"

                West ->
                    "rotate(180deg)"

                North ->
                    "rotate(270deg)"
    in
    img [ src <| asset "/src/assets/robot.png", style "transform" rotation, class "robot", alt "Robot" ] []
