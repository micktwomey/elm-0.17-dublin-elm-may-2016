module Main exposing (..)

import Html
import Html.App
import Html.Events


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
    { message = "" }


type Msg
    = SayHello
    | SayGoodbye


update : Msg -> Model -> Model
update msg model =
    case msg of
        SayHello ->
            { model | message = "Hello there!" }

        SayGoodbye ->
            { model | message = "Goodbye!" }


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.button [ Html.Events.onClick SayHello ] [ Html.text "Say Hello!" ]
        , Html.button [ Html.Events.onClick SayGoodbye ] [ Html.text "Say Goodbye!" ]
        , Html.h1 [] [ Html.text model.message ]
        ]
