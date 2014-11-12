module Froggy.Update where

import Array
import Maybe
import Froggy.Util (..)
import Froggy.Grid as Grid
import Froggy.Grid (..)
import Froggy.Levels (..)
import Froggy.Model (..)
import Froggy.Commands (..)

update : Command -> Game -> Game
update command game =
  case command of
    Nop -> game
    MoveBy positionDelta -> game |> moveBy positionDelta
    MoveTo leaf -> game |> moveTo leaf
    Continue -> game |> continue

moveBy : Grid.Position -> Game -> Game
moveBy positionDelta game =
  if (positionDelta.x == 0) && (positionDelta.y == 0) then game
  else
    let leafPosition = game.frog.leaf.position `translate` positionDelta
        maybeLeaf = game.leaves |> findLeaf leafPosition
    in case maybeLeaf of
      Nothing -> game
      Just leaf -> game |> moveTo leaf

findLeaf : Grid.Position -> [Leaf] -> Maybe Leaf
findLeaf position leaves =
  let hasPosition leaf = leaf.position `equals` position
  in leaves |> filter hasPosition |> Array.fromList |> Array.get 0

moveTo : Leaf -> Game -> Game
moveTo leaf game =
  if playing game then
    let maybeDirection = game.frog `angleTo` leaf
    in case maybeDirection of
      Nothing -> game
      Just angle ->
        { game |
          frog <- {
            leaf = leaf,
            angle = angle
          },
          leaves <- remove game.leaves game.frog.leaf
        }
  else game

loadLevel : Int -> Game
loadLevel levelNumber =
  let actualLevelNumber = if (levelNumber >= numberOfLevels) || (levelNumber < 0) then 0 else levelNumber
      level = getLevel actualLevelNumber
      leaves = loadLeafMatrix level.leafMatrix
      maybeLeaf = leaves |> findLeaf level.frogPosition
      leaf = maybeLeaf |> getOrElse (leaves |> head)
  in {
    frog = {
      leaf = leaf,
      angle = 0
    },
    levelNumber = actualLevelNumber,
    leaves = leaves,
    instructions = False
  }

loadLeafMatrix : LeafMatrix -> [Leaf]
loadLeafMatrix leafMatrix = leafMatrix |> indexedMap loadLeafRow |> concat

loadLeafRow : Int -> [Bool] -> [Leaf]
loadLeafRow y row =
  let make x value = {
        position = {
          x = x,
          y = y
        },
        value = value
      }
      isThere { value } = value
      removeValue leaf = { leaf - value }
  in row |> indexedMap make |> filter isThere |> map removeValue

continue : Game -> Game
continue game =
  if | game |> levelCompleted -> game |> nextLevel
     | game |> stuck -> game |> restartLevel
     | game.instructions -> { game | instructions <- False }
     | otherwise -> game

nextLevel : Game -> Game
nextLevel game = loadLevel (game.levelNumber + 1)

restartLevel : Game -> Game
restartLevel game = loadLevel game.levelNumber

newGame : Game
newGame =
  let level0 = loadLevel 0
  in { level0 | instructions <- True }