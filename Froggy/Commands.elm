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

commands : Signal Command
commands =
  let moveBy = lift2 makeMoveBy Keyboard.shift Keyboard.arrows
      continueWithKeyboard = lift makeContinue Keyboard.enter
      continueWithMouse = lift makeContinue Mouse.isDown
  in merges [moveBy, continueWithKeyboard, continueWithMouse, moveTo.signal]

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