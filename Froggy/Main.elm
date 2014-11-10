module Froggy.Main where

import Window
import Froggy.View (..)
import Froggy.State (..)

main = lift2 view Window.dimensions game