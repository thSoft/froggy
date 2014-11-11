module Froggy.Model where

import Maybe (..)
import Froggy.Grid as Grid
import Froggy.Levels (..)

type Game = {
  frog: Frog,
  leaves: [Leaf],
  levelNumber: Int,
  instructions: Bool
}

type Frog = {
  leaf: Leaf,
  direction: Direction
}

type Leaf = {
  position: Grid.Position
}

data Direction = Up | Right | Down | Left

levelCompleted : Game -> Bool
levelCompleted game = (game.leaves |> length) == 1

stuck : Game -> Bool
stuck game =
  let canJumpThere leaf = (game.frog |> directionTo leaf) |> isJust
  in not (game.leaves |> any canJumpThere)

directionTo : Leaf -> Frog -> Maybe Direction
directionTo leaf frog =
  let frogX = frog.leaf.position.x
      frogY = frog.leaf.position.y
      leafX = leaf.position.x
      leafY = leaf.position.y
  in if | (frogX == leafX) && (frogY > leafY) && (frogY `near` leafY) -> Just Up
        | (frogY == leafY) && (frogX < leafX) && (frogX `near` leafX) -> Just Right
        | (frogX == leafX) && (frogY < leafY) && (frogY `near` leafY) -> Just Down
        | (frogY == leafY) && (frogX > leafX) && (frogX `near` leafX) -> Just Left
        | otherwise -> Nothing

near : Int -> Int -> Bool
near a b = abs(a - b) <= maxDistance

maxDistance = 2

playing : Game -> Bool
playing game = not game.instructions