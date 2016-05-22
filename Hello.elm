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
