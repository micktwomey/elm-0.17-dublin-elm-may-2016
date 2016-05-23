module Main exposing (..)

import Html
import Html.App
import Time
import Color
import Collage exposing (..)
import Element exposing (..)
import Date
import Date.Format


main : Program Never
main =
    Html.App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    Time.Time


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( newTime, Cmd.none )


type Msg
    = Tick Time.Time


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every Time.second Tick


view : Model -> Html.Html Msg
view model =
    let
        angle =
            turns (Time.inMinutes model)

        handX =
            150 * cos (-angle)

        handY =
            150 * sin (-angle)

        time =
            Date.fromTime model
                |> Date.Format.format "%H:%M:%S"
    in
        Html.div []
            [ collage 640
                480
                [ group
                    [ circle 150 |> filled Color.darkBlue
                    , path
                        [ ( 0, 0 )
                        , ( handX, handY )
                        ]
                        |> traced
                            { defaultLine
                                | width = 5
                                , color = Color.darkCharcoal
                            }
                    ]
                ]
                |> toHtml
            , Html.h1 [] [ Html.text ("The time is " ++ time) ]
            ]
