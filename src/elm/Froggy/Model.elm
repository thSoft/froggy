module Froggy.Model where

import Maybe (..)
import Froggy.Util (..)
import Froggy.TransitionUtil (..)
import Froggy.Grid as Grid
import Froggy.Levels (..)

type Game = {
  scene: Scene,
  instructions: Bool,
  lastSceneChange: Maybe (TransitionInfo (Maybe Scene))
}

type Scene = {
  frog: Frog,
  leaves: [Leaf],
  levelNumber: Int
}

type Frog = {
  leaf: Leaf,
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
reachableBy frog leaf = (frog.leaf `angleBetween` leaf) |> isJust

angleBetween : Leaf -> Leaf -> Maybe Float
angleBetween sourceLeaf targetLeaf =
  let sourceX = sourceLeaf.position.x
      sourceY = sourceLeaf.position.y
      targetX = targetLeaf.position.x
      targetY = targetLeaf.position.y
  in if | (sourceX == targetX) && (sourceY > targetY) && (sourceY `near` targetY) -> Just 0
        | (sourceY == targetY) && (sourceX < targetX) && (sourceX `near` targetX) -> Just 270
        | (sourceX == targetX) && (sourceY < targetY) && (sourceY `near` targetY) -> Just 180
        | (sourceY == targetY) && (sourceX > targetX) && (sourceX `near` targetX) -> Just 90
        | otherwise -> Nothing

near : Int -> Int -> Bool
near a b = (distance a b) <= maxDistance

maxDistance = 2

angleOf : Frog -> Float
angleOf frog =
  case frog.lastMove of
    Just { oldValue } -> oldValue `angleBetween` frog.leaf |> getOrElse 0
    Nothing -> 0

playing : Game -> Bool
playing game = not game.instructions