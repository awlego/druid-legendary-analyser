module Model exposing (Model, Druid, Message, Message(..))

import Dict exposing (Dict)
import Http
import Navigation

import Analyser
import Legendaries exposing (Legendary, Legendary(..))

import WarcraftLogs.Models as WCL

type alias Model =
  { reportCodes : List
  , activeReportCode : String
  , fights : List WCL.Fight
  , friendlies : List WCL.Friendly
  , legendaries : Analyser.Model
  -- todo , talents:
  , processed : Float
  , errorMessage : Maybe String
  , druids : Dict Int Druid
  , fightSelectionOpen : Bool
  , selectedFight : Maybe WCL.Fight
  }

type alias Druid =
  { id : Int
  , name : String
  , legendaries : List Legendary
  , healingDone : Int
  -- todo , port the mastery stuff to live here (probably)
  }

type Message
  = EnteringReportCode String
  | GetFights (Maybe Int) (Maybe Int)
  | FightsRetrieved (Maybe Int) (Result Http.Error (List WCL.Fight, List WCL.Friendly))
  | SelectFight WCL.Fight
  | Analyze WCL.Fight
  | EventsRetrieved WCL.Fight (Result Http.Error WCL.EventPage)
  | ClearErrorMessage
  | UrlChange Navigation.Location
  | OpenFightSelection
  