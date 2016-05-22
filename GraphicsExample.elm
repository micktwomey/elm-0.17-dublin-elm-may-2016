import Color
import Html
import Html.App
import Element
import Collage exposing (..)


main =
    Html.App.beginnerProgram { model = model, update = update, view = view }

type alias Model = String
model = "Hello"

type Msg = Nothing
update msg model =
    model

view model =
    Html.div []
        [ collage 320 200
            [ group
                [ circle 50 |> filled Color.charcoal
                , circle 40 |> filled Color.yellow
                ]
            ] |> Element.toHtml
        ]
