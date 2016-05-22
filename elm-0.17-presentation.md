theme: Fira

# Elm 0.17
## Introduction & What's New
### Michael Twomey @ Elm Dublin May 2016

---

# What is Elm?
## (Really Short Introduction)

^ Elm is a functional language that compiles to JavaScript.

---

```elm
import Html
import Html.App

main = Html.App.beginnerProgram
    { model = model
    , update = update
    , view = view }

type alias Model = { message : String}
model = { message = "Hello World!" }

type Msg = Nothing
update msg model = model

view model = Html.h1 [] [ Html.text model.message ]
```

^ A really small Elm app (which fully uses the elm pattern)
^ Also shows a hint about what's new
^ I'm omitting type signatures for brevity on slides

---

```elm
import Html
import Html.App

main : Program Never
main = Html.App.beginnerProgram
    { model = model
    , update = update
    , view = view }

type alias Model = { message : String}

model : Model
model = { message = "Hello World!" }

type Msg = Nothing

update : Msg -> Model -> Model
update msg model = model

view Model -> Html.Html Msg
view model = Html.h1 [] [ Html.text model.message ]
```

---

# What's New in 0.17?

---

## No More Signals :+1:
### foldp and mailboxes are gone too
### Subscriptions are the new hotness

---

# Subscription Example

---

```elm
import Html
import Html.App
import Time

main = Html.App.program
    { init = init, update = update , view = view
    , subscriptions = subscriptions
    }

type alias Model = { time : Time.Time}
init = ( { time = 0 }, Cmd.none)
update msg model =
    case msg of
        Tick newTime -> ( { model | time = newTime } , Cmd.none)

type Msg
    = Tick Time.Time

subscriptions : Model -> Sub Msg
subscriptions model = Time.every Time.second Tick

view model = Html.h1 [] [ Html.text ("The time is " ++ toString model.time) ]
```

---

```elm
main = Html.App.program
    { ...
    , subscriptions = subscriptions }

subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every Time.second Tick

update : Msg -> Model -> Model
update msg model =
    case msg of
        Tick newTime -> ...
```

---

## SVG Version
### (from Elm docs)

---

```elm
import Html
import Html.App
import Time
import Svg exposing (..)
import Svg.Attributes exposing (..)

main = Html.App.program
    { init = init, update = update , view = view
    , subscriptions = subscriptions
    }

type alias Model = Time.Time
init = ( 0 , Cmd.none)
update msg model =
    case msg of
        Tick newTime -> ( newTime , Cmd.none)

type Msg
    = Tick Time.Time

subscriptions : Model -> Sub Msg
subscriptions model = Time.every Time.second Tick

view model =
  let
    angle =
      turns (Time.inMinutes model)

    handX =
      toString (50 + 40 * cos angle)

    handY =
      toString (50 + 40 * sin angle)
  in
    svg [ viewBox "0 0 100 100", width "300px" ]
      [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
      , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963" ] []
      ]
```

---

### The only difference is the view

---

```elm
view model = Html.h1 [] [ Html.text ("The time is " ++ toString model.time) ]

view model =
  let
    angle =
      turns (Time.inMinutes model)

    handX =
      toString (50 + 40 * cos angle)

    handY =
      toString (50 + 40 * sin angle)
  in
    svg [ viewBox "0 0 100 100", width "300px" ]
      [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
      , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963" ] []
      ]
```

---

# 0.17 Changes in More Detail

---

No more Signal.Address

```elm
-- 0.16
view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ button [ onClick address Decrement ] [ text "-" ]
    , div [ countStyle ] [ text (toString model) ]
    , button [ onClick address Increment ] [ text "+" ]
    ]

-- 0.17
view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [ countStyle ] [ text (toString model) ]
    , button [ onClick Increment ] [ text "+" ]
    ]
```

---

- Effects are now Cmd
- Action is now Msg
- StartApp is now Html.App
- Many packages moved into core
- Graphics.* now lives in evancz/elm-graphics

---

# Effect Managers Added
### Moves the hard work to the library author

---

# Web Sockets

---

Simple API

```elm
WebSocket.send "ws://echo.websocket.org" input
WebSocket.listen "ws://echo.websocket.org" NewMessage
```

(Effect manager handles connection management, errors, re-connecting for you.)

---

```elm
import Html exposing (Html, div, text)
import Html.App as Html
import WebSocket

main = Html.program
    { init = init, view = view
    , update = update, subscriptions = subscriptions }

echoServer = "ws://echo.websocket.org"

type alias Model =
  { input : String , messages : List String }

init = ( Model "" [], WebSocket.send echoServer "Hello" )

type Msg = NewMessage String

update msg {input, messages} =
  case msg of
    NewMessage str -> (Model input (str :: messages), Cmd.none)

subscriptions model =
  WebSocket.listen echoServer NewMessage

view model =
  div [] (List.map viewMessage (List.reverse model.messages))

viewMessage msg = Html.p [] [ text msg ]
```

---
- http://elm-lang.org/
- http://elm-lang.org/blog/farewell-to-frp - Elm 0.17 Post
- http://guide.elm-lang.org
- http://www.lambdacat.com/migrating-from-elm-0-16-to-0-17-from-startapp/
- http://noredink.github.io/posts/signalsmigration.html
