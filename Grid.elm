module Grid where

type Position = {
  x: Int,
  y: Int
}

equals : Position -> Position -> Bool
equals a b = (a.x == b.x) && (a.y == b.y)

translate : Position -> Position -> Position
translate a b =
  {
    x = a.x + b.x,
    y = a.y + b.y
  }