import Html
import Html.App
import Time

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

view model = Html.h1 [] [ Html.text ("The time is " ++ toString model) ]
