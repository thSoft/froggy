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
  angle: Float
}

type Leaf = {
  position: Grid.Position
}

levelCompleted : Game -> Bool
levelCompleted game = (game.leaves |> length) == 1

stuck : Game -> Bool
stuck game =
  let canJumpThere leaf = (game.frog |> angleTo leaf) |> isJust
  in not (game.leaves |> any canJumpThere)

angleTo : Leaf -> Frog -> Maybe Float
angleTo leaf frog =
  let frogX = frog.leaf.position.x
      frogY = frog.leaf.position.y
      leafX = leaf.position.x
      leafY = leaf.position.y
  in if | (frogX == leafX) && (frogY > leafY) && (frogY `near` leafY) -> Just 0
        | (frogY == leafY) && (frogX < leafX) && (frogX `near` leafX) -> Just -90
        | (frogX == leafX) && (frogY < leafY) && (frogY `near` leafY) -> Just 180
        | (frogY == leafY) && (frogX > leafX) && (frogX `near` leafX) -> Just 90
        | otherwise -> Nothing

near : Int -> Int -> Bool
near a b = abs(a - b) <= maxDistance

maxDistance = 2

playing : Game -> Bool
playing game = not game.instructions