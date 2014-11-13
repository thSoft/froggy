module Froggy.Main where

import Window
import Froggy.Util (..)
import Froggy.Model (..)
import Froggy.Update (..)
import Froggy.Commands (..)
import Froggy.View (..)

main = lift2 (view fontName) Window.dimensions game

game : Signal Game
game = foldp update initialGame commands

initialGame : Game
initialGame = load |> getOrElse newGame

port load : Maybe Game

port save : Signal Game
port save = game

port fontName : String