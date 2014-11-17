module Froggy.Commands where

import Keyboard
import Mouse
import Graphics.Input (..)
import Froggy.Grid as Grid
import Froggy.Model (..)

data Command =
  Nop |
  MoveBy Grid.Position |
  MoveTo Leaf |
  Continue

commandsWithTime : Signal (Time, Command)
commandsWithTime = commands |> timestamp

commands : Signal Command
commands =
  let moveBy = lift2 makeMoveBy Keyboard.shift Keyboard.arrows
      continue = lift makeContinue (merge Keyboard.enter Mouse.isDown)
  in merges [moveBy, moveTo.signal, continue]

makeMoveBy : Bool -> Grid.Position -> Command
makeMoveBy shift arrows =
  let multiplier = if shift then 2 else 1
  in MoveBy {
    x = arrows.x * multiplier,
    y = -arrows.y * multiplier
  }

makeContinue : Bool -> Command
makeContinue pressed = if pressed then Continue else Nop

moveTo : Input Command
moveTo = input Nop