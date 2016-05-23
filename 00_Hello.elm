module Main exposing (..)

import Html
import Html.App


main : Program Never
main =
    Html.App.beginnerProgram
        { model = model
        , update = update
        , view = view
        }


type alias Model =
    { message : String }


model : Model
model =
    { message = "Hello World!" }


type Msg
    = Nothing


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> Html.Html Msg
view model =
    Html.h1 [] [ Html.text model.message ]
