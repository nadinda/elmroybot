module Grid exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Robot exposing (Model, viewRobot)


viewGrid : Model -> List (Html msg)
viewGrid model =
    List.concatMap (\y -> viewRow model y) (List.range 0 4)


viewRow : Model -> Int -> List (Html msg)
viewRow model y =
    List.map (\x -> viewTile model x y) (List.range 0 4)


viewTile : Model -> Int -> Int -> Html msg
viewTile model x y =
    div [ class "tile" ]
        [ if x == model.position.x && y == model.position.y then
            viewRobot model.direction

          else
            text ""
        ]
