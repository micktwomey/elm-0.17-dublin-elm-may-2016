import Html exposing (Html, div, text)
import Html.App as Html
import WebSocket

main = Html.program
    { init = init, view = view
    , update = update, subscriptions = subscriptions }

echoServer = "ws://echo.websocket.org"

type alias Model =
  { input : String
  , messages : List String
  }

init = ( Model "" [], WebSocket.send echoServer "Hello" )

type Msg = NewMessage String

update msg {input, messages} =
  case msg of
    NewMessage str ->
      (Model input (str :: messages), Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  WebSocket.listen echoServer NewMessage

view model =
  div [] (List.map viewMessage (List.reverse model.messages))

viewMessage msg = Html.p [] [ text msg ]
