module TestSpec exposing (suite)

import Expect
import Main
import Robot exposing (Direction(..), Msg(..), initModel)
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
        , test "clicking on the Go Forward button sends a MoveForward message" <|
            \_ ->
                Main.view initModel
                    |> Query.fromHtml
                    |> Query.find [ Html.tag "button", Html.containing [ Html.text "Go Forward" ] ]
                    |> Event.simulate Event.click
                    |> Event.expect MoveForward
        , test "pressing 'w' on keyboard puts the robot 1 step forward" <|
            \_ ->
                let
                    initialModel =
                        { initModel | position = { x = 2, y = 2 }, direction = East }

                    ( updatedModel, _ ) =
                        Main.update (KeyboardEvent "w") initialModel
                in
                Expect.equal updatedModel.position { x = 3, y = 2 }
        , test "pressing 'd' on keyboard changes the robot direction clockwise" <|
            \_ ->
                let
                    initialModel =
                        { initModel | direction = East }

                    ( updatedModel, _ ) =
                        Main.update (KeyboardEvent "d") initialModel
                in
                Expect.equal updatedModel.direction South
        , test "pressing 'a' on keyboard changes the robot direction counter-clockwise" <|
            \_ ->
                let
                    initialModel =
                        { initModel | direction = East }

                    ( updatedModel, _ ) =
                        Main.update (KeyboardEvent "a") initialModel
                in
                Expect.equal updatedModel.direction North
        , test "cannot move further north if reaching the top side of grid" <|
            \_ ->
                let
                    initialModel =
                        { initModel | position = { x = 0, y = 0 }, direction = North }

                    ( updatedModel, _ ) =
                        Main.update (KeyboardEvent "w") initialModel
                in
                Expect.equal updatedModel.position { x = 0, y = 0 }
        , test "cannot move further east if reaching the right-most side of grid" <|
            \_ ->
                let
                    initialModel =
                        { initModel | position = { x = 4, y = 0 }, direction = East }

                    ( updatedModel, _ ) =
                        Main.update (KeyboardEvent "w") initialModel
                in
                Expect.equal updatedModel.position { x = 4, y = 0 }
        , test "cannot move further south if exceeding the bottom of grid" <|
            \_ ->
                let
                    initialModel =
                        { initModel | position = { x = 0, y = 4 }, direction = South }

                    ( updatedModel, _ ) =
                        Main.update (KeyboardEvent "w") initialModel
                in
                Expect.equal updatedModel.position { x = 0, y = 4 }
        , test "cannot move further west if reaching the left-most side of grid" <|
            \_ ->
                let
                    initialModel =
                        { initModel | position = { x = 0, y = 0 }, direction = West }

                    ( updatedModel, _ ) =
                        Main.update (KeyboardEvent "w") initialModel
                in
                Expect.equal updatedModel.position { x = 0, y = 0 }
        ]
