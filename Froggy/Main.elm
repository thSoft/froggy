module Froggy.Main where

import Window
import Froggy.Util (..)
import Froggy.Model (..)
import Froggy.Update (..)
import Froggy.Commands (..)
import Froggy.View (..)

main = lift2 (view fontName) Window.dimensions game

game : Signal Game
game = foldp update (initialGame loadedGame) commands

port loadedGame : Maybe Game

port savedGame : Signal Game
port savedGame = game

port fontName : String