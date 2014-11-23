module Froggy.Main where

import Window
import Froggy.Model (..)
import Froggy.State (..)
import Froggy.View (..)
import Froggy.TransitionUtil (..)

main = lift3 (view fontName) Window.dimensions time mainState

mainState = game loadedGame

port loadedGame : Signal (Maybe Game)

port savedGame : Signal Game
port savedGame = mainState

port fontName : String