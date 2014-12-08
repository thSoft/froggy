module Froggy.Model where

import Maybe (..)
import Froggy.Util (..)
import Froggy.TransitionUtil (..)
import Froggy.Grid as Grid
import Froggy.Levels (..)

type Game = {
  scene: Scene,
  usingKeyboard: Bool,
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

levelCompleted : Scene -> Bool
levelCompleted scene = (scene.leaves |> length) == 1

stuck : Scene -> Bool
stuck scene = not (scene.leaves |> any (reachableBy scene.frog))

reachableBy : Frog -> Leaf -> Bool
reachableBy frog leaf = (frog.leaf `angleBetween` leaf) |> isJust

angleBetween : Leaf -> Leaf -> Maybe Int
angleBetween sourceLeaf targetLeaf =
  let sourceX = sourceLeaf.position.x
      sourceY = sourceLeaf.position.y
      targetX = targetLeaf.position.x
      targetY = targetLeaf.position.y
  in if | (sourceX == targetX) && (sourceY > targetY) && (sourceY `near` targetY) -> Just 90
        | (sourceY == targetY) && (sourceX < targetX) && (sourceX `near` targetX) -> Just 0
        | (sourceX == targetX) && (sourceY < targetY) && (sourceY `near` targetY) -> Just 270
        | (sourceY == targetY) && (sourceX > targetX) && (sourceX `near` targetX) -> Just 180
        | otherwise -> Nothing

near : Int -> Int -> Bool
near a b = (distance a b) <= 2

onlyDoubleJump : Scene -> Bool
onlyDoubleJump scene =
  let distanceX leaf = distance scene.frog.leaf.position.x leaf.position.x
      distanceY leaf = distance scene.frog.leaf.position.y leaf.position.y
      leafOnlyDoubleJump leaf = ((distanceX leaf) == 2) || ((distanceY leaf) == 2)
  in scene.leaves |> filter (reachableBy scene.frog) |> all leafOnlyDoubleJump

angleOf : Frog -> Int
angleOf frog =
  case frog.lastMove of
    Just { oldValue } -> oldValue `angleBetween` frog.leaf |> getOrElse 0
    Nothing -> 90