module Main exposing (..)

import Html exposing (Html, div, text)
import Html.App as Html
import WebSocket


main : Program Never
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


echoServer : String
echoServer =
    "ws://echo.websocket.org"


type alias Model =
    { input : String
    , messages : List String
    }


init : ( Model, Cmd Msg )
init =
    -- Model "" [] is equivalent to { input = "", messages = [] } (Model acts as a constructor function too)
    ( { input = "", messages = [] }, WebSocket.send echoServer "Hello" )


type Msg
    = NewMessage String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewMessage str ->
            let
                -- :: is the List "cons" function, puts an item on the head of a list
                newMessages = str :: model.messages
            in
                ( { model | messages = newMessages }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen echoServer NewMessage


view : Model -> Html Msg
view model =
    div [] (List.map viewMessage (List.reverse model.messages))


viewMessage : String -> Html Msg
viewMessage msg =
    Html.p [] [ text msg ]
