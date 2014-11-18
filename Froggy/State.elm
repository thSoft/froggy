module Froggy.State where

import Array
import Froggy.Util (..)
import Froggy.Grid as Grid
import Froggy.Grid (..)
import Froggy.Levels (..)
import Froggy.Model (..)
import Froggy.Commands (..)

game : Maybe Game -> Signal Game
game loadedGame = foldp update (initialGame loadedGame) commands

update : (Time, Command) -> Game -> Game
update (time, command) game =
  case command of
    Nop -> game
    MoveBy positionDelta -> game |> moveBy positionDelta time
    MoveTo leaf -> game |> moveTo leaf time
    Continue -> game |> continue time

moveBy : Grid.Position -> Time -> Game -> Game
moveBy positionDelta time game =
  if (positionDelta.x == 0) && (positionDelta.y == 0) then game
  else
    let leafPosition = game.scene.frog.leaf.position `translate` positionDelta
        maybeLeaf = game.scene.leaves |> findLeaf leafPosition
    in case maybeLeaf of
      Nothing -> game
      Just leaf -> game |> moveTo leaf time

findLeaf : Grid.Position -> [Leaf] -> Maybe Leaf
findLeaf position leaves =
  let hasPosition leaf = leaf.position `equals` position
  in leaves |> filter hasPosition |> Array.fromList |> Array.get 0

moveTo : Leaf -> Time -> Game -> Game
moveTo leaf time game =
  if playing game then
    let reachable = leaf |> reachableBy game.scene.frog
        scene = game.scene
    in
      if reachable then
        { game |
          scene <- { scene |
            frog <- {
              leaf = leaf,
              lastMove = Just {
                oldValue = game.scene.frog.leaf,
                startTime = time
              }
            },
            leaves <- remove game.scene.leaves game.scene.frog.leaf
          }
        }
      else game
  else game

loadLevel : Time -> Int -> Game
loadLevel time levelNumber =
  let actualLevelNumber = if (levelNumber >= numberOfLevels) || (levelNumber < 0) then 0 else levelNumber
      level = getLevel actualLevelNumber
      leaves = loadLeafMatrix level.leafMatrix
      maybeLeaf = leaves |> findLeaf level.frogPosition
      leaf = maybeLeaf |> getOrElse (leaves |> head)
  in {
    scene = {
      frog = {
        leaf = leaf,
        lastMove = Nothing
      },
      leaves = leaves,
      levelNumber = actualLevelNumber
    },
    instructions = False,
    lastSceneChange = {
      oldValue = Nothing,
      startTime = time
    }
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

continue : Time -> Game -> Game
continue time game =
  if | game |> levelCompleted -> game |> nextLevel time
     | game |> stuck -> game |> restartLevel time
     | game.instructions -> { game | instructions <- False }
     | otherwise -> game

nextLevel : Time -> Game -> Game
nextLevel time game = loadLevel time (game.scene.levelNumber + 1)

restartLevel : Time -> Game -> Game
restartLevel time game = loadLevel time game.scene.levelNumber

initialGame : Maybe Game -> Game
initialGame loadedGame = loadedGame |> getOrElse (newGame 0)

newGame : Time -> Game
newGame time =
  let level0 = loadLevel time 0
  in { level0 | instructions <- True }