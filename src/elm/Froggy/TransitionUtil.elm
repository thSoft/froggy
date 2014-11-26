module Froggy.TransitionUtil where

type TransitionInfo a = {
  oldValue: a,
  startTime: Time
}

time : Signal Time
time = fps 30 |> timestamp |> lift fst