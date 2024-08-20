module TestSpec exposing (suite)

import Main
import Robot exposing (Msg(..), initModel)
import Test exposing (Test, describe, test)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector as Html


suite : Test
suite =
    describe "Robot movement control"
        [ test "clicking on the Rotate ↻ button sends a RotateRight message" <|
            \_ ->
                Main.view initModel
                    |> Query.fromHtml
                    |> Query.find [ Html.tag "button", Html.containing [ Html.text "Rotate ↻" ] ]
                    |> Event.simulate Event.click
                    |> Event.expect RotateRight
        , test "clicking on the Rotate ↺ button sends a RotateLeft message" <|
            \_ ->
                Main.view initModel
                    |> Query.fromHtml
                    |> Query.find [ Html.tag "button", Html.containing [ Html.text "Rotate ↺" ] ]
                    |> Event.simulate Event.click
                    |> Event.expect RotateLeft
        ]
