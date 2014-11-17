module Froggy.TransitionUtil where

import Time (..)

type TransitionInfo a = {
  oldValue: a,
  startTime: Time
}

time : Signal Time
time = fps 30 |> timestamp |> lift fst