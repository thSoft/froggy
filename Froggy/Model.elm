module Froggy.Model where

import Maybe (..)
import Froggy.Util (..)
import Froggy.TransitionUtil (..)
import Froggy.Grid as Grid
import Froggy.Levels (..)

type Game = {
  scene: Scene,
  instructions: Bool,
  lastSceneChange: TransitionInfo (Maybe Scene)
}

type Scene = {
  frog: Frog,
  leaves: [Leaf],
  levelNumber: Int
}

type Frog = {
  leaf: Leaf,
  angle: Float,
  lastMove: Maybe (TransitionInfo Leaf)
}

type Leaf = {
  position: Grid.Position
}

levelCompleted : Game -> Bool
levelCompleted game = (game.scene.leaves |> length) == 1

stuck : Game -> Bool
stuck game = not (game.scene.leaves |> any (reachableBy game.scene.frog))

reachableBy : Frog -> Leaf -> Bool
reachableBy frog leaf = (frog `angleTo` leaf) |> isJust

angleTo : Frog -> Leaf -> Maybe Float
angleTo frog leaf =
  let frogX = frog.leaf.position.x
      frogY = frog.leaf.position.y
      leafX = leaf.position.x
      leafY = leaf.position.y
  in if | (frogX == leafX) && (frogY > leafY) && (frogY `near` leafY) -> Just 0
        | (frogY == leafY) && (frogX < leafX) && (frogX `near` leafX) -> Just 270
        | (frogX == leafX) && (frogY < leafY) && (frogY `near` leafY) -> Just 180
        | (frogY == leafY) && (frogX > leafX) && (frogX `near` leafX) -> Just 90
        | otherwise -> Nothing

near : Int -> Int -> Bool
near a b = (distance a b) <= maxDistance

maxDistance = 2

playing : Game -> Bool
playing game = not game.instructions