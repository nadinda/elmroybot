module TestSpec exposing (suite)

import Main
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text)


suite : Test
suite =
    describe "Tests"
        [ test "renders model content correctly" <|
            \() ->
                Main.view { count = 1 }
                    |> Query.fromHtml
                    |> Query.has [ text "1" ]
        ]
