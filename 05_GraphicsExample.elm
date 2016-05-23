module Main exposing (..)

import Color
import Html
import Html.App
import Element
import Collage exposing (..)


main : Program Never
main =
    Html.App.beginnerProgram
        { model = model
        , update = update
        , view = view
        }


type alias Model =
    String


model : Model
model =
    "Hello"


type Msg
    = Nothing


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ collage 320
            200
            [ group
                [ circle 50 |> filled Color.charcoal
                , circle 40 |> filled Color.yellow
                ]
            ]
            |> Element.toHtml
        ]
