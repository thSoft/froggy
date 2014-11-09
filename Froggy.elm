module Froggy where

import Array
import Keyboard
import Window
import Maybe
import Text

-- Model

type Game = {
  frog: Frog,
  leaves: [Leaf],
  levelNumber: Int,
  level: Level
}

type Frog = {
  leaf: Leaf,
  direction: Direction
}

data Direction = Up | Right | Down | Left

type Leaf = {
  position: Position
}

type Position = {
  x: Int,
  y: Int
}

defaultGame = loadLevel 0

game : Signal Game
game = foldp update defaultGame commands

--- Levels

type Level = {
  frogPosition: Position,
  leafMatrix: LeafMatrix,
  levelPosition: Position
}

type LeafMatrix = [[Bool]]

levels =
  Array.fromList [
    -- 0
    {
      frogPosition = {
        x = 6,
        y = 1
      },
      leafMatrix = [
        [False, False, False, False, True , False, False, False], 
        [False, True , True , True , True , True , True , False], 
        [False, True , False, False, True , False, False, False], 
        [False, True , False, False, True , False, False, False], 
        [True , True , False, False, True , True , True , False], 
        [True , False, False, False, False, False, True , False], 
        [True , True , True , True , True , True , True , False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 6,
        y = 0
      }
    },
    -- 1
    {
      frogPosition = {
        x = 5,
        y = 2
      },
      leafMatrix = [
        [True , False, False, False, False, False, False, False], 
        [True , True , True , True , False, False, False, False], 
        [True , False, False, False, True , True , True , False], 
        [True , False, False, False, False, False, False, False], 
        [True , False, True , True , True , False, False, False], 
        [False, False, False, True , False, False, False, False], 
        [True , True , True , True , False, False, False, False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 5,
        y = 3
      }
    }, 
    -- 2
    {
      frogPosition = {
        x = 5,
        y = 3
      },
      leafMatrix = [
        [False, False, False, False, False, False, False, False], 
        [False, False, False, False, False, True , False, False], 
        [False, False, True , False, True , True , True , False], 
        [False, False, False, False, False, True , False, False], 
        [False, False, True , False, False, False, False, False], 
        [False, True , True , True , False, True , False, False], 
        [False, False, True , False, False, False, False, False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 0,
        y = 0
      }
    }, 
    -- 3
    {
      frogPosition = {
        x = 0,
        y = 2
      },
      leafMatrix = [
        [True , False, False, False, False, False, False, False], 
        [True , False, True , False, True , False, True , False], 
        [True , False, False, False, True , False, True , False], 
        [False, False, False, False, True , False, True , False], 
        [False, False, False, False, False, False, True , False], 
        [True , True , True , True , False, False, False, False], 
        [False, False, False, False, True , True , True , False], 
        [False, False, False, True , True , True , True , False]
      ],
      levelPosition = {
        x = 0,
        y = 3
      }
    }, 
    -- 4
    {
      frogPosition = {
        x = 4,
        y = 4
      },
      leafMatrix = [
        [False, False, True , False, False, False, False, False], 
        [False, False, True , False, False, False, False, False], 
        [False, True , True , True , False, False, False, False], 
        [False, False, True , False, True , False, False, False], 
        [False, True , False, False, True , False, True , False], 
        [True , True , False, True , True , True , True , False], 
        [False, True , False, False, False, False, True , False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 7,
        y = 0
      }
    }, 
    -- 5
    {
      frogPosition = {
        x = 5,
        y = 3
      },
      leafMatrix = [
        [False, False, False, True , False, True , False, False], 
        [False, False, False, True , False, False, False, False], 
        [False, False, False, False, False, True , True , False], 
        [False, False, True , True , True , True , False, False], 
        [False, False, False, False, False, False, True , False], 
        [False, True , False, True , False, False, False, False], 
        [False, False, False, True , False, True , True , False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 0,
        y = 3
      }
    }, 
    -- 6
    {
      frogPosition = {
        x = 1,
        y = 0
      },
      leafMatrix = [
        [False, True , False, False, False, False, False, False], 
        [True , True , True , False, True , False, True , False], 
        [False, False, False, True , False, True , True , False], 
        [False, False, False, True , False, False, True , False], 
        [False, True , True , True , True , True , False, False], 
        [False, True , False, True , False, True , True , False], 
        [False, False, False, False, False, True , False, False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 7,
        y = 7
      }
    }, 
    -- 7
    {
      frogPosition = {
        x = 3,
        y = 3
      },
      leafMatrix = [
        [False, False, False, False, False, False, False, False], 
        [False, False, False, False, True , True , True , False], 
        [False, True , False, True , False, False, True , False], 
        [False, True , True , True , True , False, False, False], 
        [False, False, False, False, False, False, True , False], 
        [False, False, True , True , True , True , False, False], 
        [False, False, False, False, False, False, True , False], 
        [False, False, False, False, False, True , True , False]
      ],
      levelPosition = {
        x = 0,
        y = 0
      }
    }, 
    -- 8
    {
      frogPosition = {
        x = 6,
        y = 0
      },
      leafMatrix = [
        [False, False, False, True , True , True , True , False], 
        [False, True , True , False, False, False, False, False], 
        [False, False, False, True , True , True , False, False], 
        [True , False, True , False, True , False, True , False], 
        [True , True , True , False, True , False, False, False], 
        [True , False, False, False, False, False, True , False], 
        [True , False, True , False, False, False, False, False], 
        [True , False, True , False, True , True , True , True ]
      ],
      levelPosition = {
        x = 7,
        y = 0
      }
    }, 
    -- 9
    {
      frogPosition = {
        x = 6,
        y = 2
      },
      leafMatrix = [
        [False, True , True , True , False, True , False, True ], 
        [False, False, False, False, True , True , False, False], 
        [False, True , False, False, True , False, True , True ], 
        [False, False, True , False, False, True , False, True ], 
        [True , True , True , False, True , False, True , False], 
        [True , False, True , False, False, True , False, False], 
        [True , True , True , True , True , False, True , False], 
        [False, False, False, True , False, True , False, False]
      ],
      levelPosition = {
        x = 0,
        y = 1
      }
    }, 
    -- 10
    {
      frogPosition = {
        x = 6,
        y = 1
      },
      leafMatrix = [
        [False, False, False, False, False, False, True , False], 
        [False, True , False, False, False, False, True , False], 
        [False, True , False, False, True , True , True , False], 
        [True , True , False, False, True , True , False, False], 
        [False, True , False, False, True , False, False, False], 
        [False, False, True , True , False, True , False, False], 
        [True , True , True , False, False, False, False, False], 
        [True , False, True , False, False, False, False, False]
      ],
      levelPosition = {
        x = 7,
        y = 7
      }
    }, 
    -- 11
    {
      frogPosition = {
        x = 5,
        y = 3
      },
      leafMatrix = [
        [False, False, False, True , False, True , False, False], 
        [False, True , False, True , True , True , True , True ], 
        [False, True , False, True , False, True , False, False], 
        [True , True , True , False, False, True , False, True ], 
        [False, True , False, False, True , True , True , True ], 
        [False, False, True , False, False, False, False, False], 
        [False, False, False, True , True , True , False, False], 
        [False, False, True , False, True , False, False, False]
      ],
      levelPosition = {
        x = 0,
        y = 0
      }
    }, 
    -- 12
    {
      frogPosition = {
        x = 6,
        y = 2
      },
      leafMatrix = [
        [False, False, True , False, True , True , False, True ], 
        [False, False, True , False, False, True , False, True ], 
        [False, False, True , True , True , False, True , False], 
        [False, False, True , False, False, False, False, False], 
        [False, False, False, True , False, True , True , True ], 
        [False, False, True , False, True , False, True , False], 
        [False, False, False, False, False, False, False, False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 0,
        y = 7
      }
    }, 
    -- 13
    {
      frogPosition = {
        x = 6,
        y = 2
      },
      leafMatrix = [
        [False, False, False, False, True , False, False, False], 
        [True , True , True , False, True , False, False, True ], 
        [False, False, True , True , True , True , True , True ], 
        [False, True , False, False, False, False, False, False], 
        [True , True , True , False, True , False, False, True ], 
        [False, True , False, True , True , False, True , True ], 
        [False, False, False, False, True , False, False, False], 
        [False, True , True , False, True , False, True , False]
      ],
      levelPosition = {
        x = 0,
        y = 0
      }
    }, 
    -- 14
    {
      frogPosition = {
        x = 1,
        y = 6
      },
      leafMatrix = [
        [True , False, True , False, True , False, False, True ], 
        [False, False, True , False, False, False, False, False], 
        [True , False, True , False, True , False, True , True ], 
        [False, True , True , True , False, True , True , False], 
        [False, False, False, False, False, False, True , False], 
        [True , False, False, True , True , False, False, False], 
        [True , True , False, False, True , False, True , False], 
        [True , False, True , True , True , False, False, False]
      ],
      levelPosition = {
        x = 7,
        y = 7
      }
    }, 
    -- 15
    {
      frogPosition = {
        x = 4,
        y = 6
      },
      leafMatrix = [
        [True , False, True , True , True , True , True , False], 
        [True , False, True , False, True , False, False, False], 
        [False, True , False, True , True , True , False, True ], 
        [True , False, True , False, True , False, True , False], 
        [False, True , False, False, True , False, False, True ], 
        [True , False, True , True , True , False, True , False], 
        [True , True , False, False, True , False, False, True ], 
        [True , False, False, True , False, True , False, True ]
      ],
      levelPosition = {
        x = 7,
        y = 0
      }
    }, 
    -- 16
    {
      frogPosition = {
        x = 4,
        y = 2
      },
      leafMatrix = [
        [True , True , True , False, True , False, False, False], 
        [False, False, False, True , True , True , False, False], 
        [False, True , False, False, True , False, False, False], 
        [False, True , False, True , True , True , False, False], 
        [True , True , False, False, True , False, False, False], 
        [False, True , False, False, True , False, False, False], 
        [False, True , False, False, False, False, False, False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 4,
        y = 7
      }
    }, 
    -- 17
    {
      frogPosition = {
        x = 4,
        y = 7
      },
      leafMatrix = [
        [True , True , True , True , True , True , True , True ], 
        [True , False, False, False, True , False, False, True ], 
        [True , False, True , False, True , False, False, True ], 
        [True , False, False, False, True , True , True , True ], 
        [True , False, False, False, False, False, False, True ], 
        [True , False, True , False, False, True , False, True ], 
        [True , False, False, False, False, False, False, True ], 
        [True , True , True , True , True , True , True , True ]
      ],
      levelPosition = {
        x = 3,
        y = 4
      }
    }, 
    -- 18
    {
      frogPosition = {
        x = 3,
        y = 5
      },
      leafMatrix = [
        [False, False, False, False, False, False, False, False], 
        [False, True , True , True , True , False, False, True ], 
        [True , False, True , False, False, False, False, True ], 
        [True , True , False, False, False, True , False, True ], 
        [True , False, True , False, False, True , False, False], 
        [False, True , True , True , False, True , False, True ], 
        [False, False, False, False, False, True , False, False], 
        [False, False, True , False, True , True , True , False]
      ],
      levelPosition = {
        x = 0,
        y = 0
      }
    }, 
    -- 19
    {
      frogPosition = {
        x = 4,
        y = 4
      },
      leafMatrix = [
        [False, False, True , False, True , False, False, False], 
        [False, False, True , False, False, True , True , False], 
        [False, False, False, False, True , False, False, False], 
        [True , True , True , True , False, False, True , False], 
        [False, False, False, False, True , False, False, False], 
        [False, False, False, True , False, False, True , False], 
        [False, False, False, True , True , True , True , False], 
        [False, False, False, False, True , False, True , False]
      ],
      levelPosition = {
        x = 7,
        y = 4
      }
    }, 
    -- 20
    {
      frogPosition = {
        x = 4,
        y = 3
      },
      leafMatrix = [
        [False, False, False, False, False, True , True , True ], 
        [False, False, False, True , False, True , True , False], 
        [True , True , True , True , True , False, False, False], 
        [False, True , False, True , True , False, True , False], 
        [False, False, False, False, False, True , True , False], 
        [False, False, False, False, False, False, True , False], 
        [False, True , False, True , True , True , True , False], 
        [True , True , True , False, True , False, False, False]
      ],
      levelPosition = {
        x = 0,
        y = 0
      }
    }, 
    -- 21
    {
      frogPosition = {
        x = 1,
        y = 6
      },
      leafMatrix = [
        [False, False, False, False, False, True , False, False], 
        [False, False, False, False, False, True , False, True ], 
        [False, False, False, False, False, True , True , True ], 
        [False, False, False, True , True , True , False, False], 
        [False, False, False, True , False, True , False, False], 
        [False, True , False, True , False, False, False, True ], 
        [True , True , True , False, True , False, False, False], 
        [False, True , False, False, True , True , False, True ]
      ],
      levelPosition = {
        x = 0,
        y = 7
      }
    }, 
    -- 22
    {
      frogPosition = {
        x = 0,
        y = 7
      },
      leafMatrix = [
        [True , True , True , True , False, True , False, True ], 
        [False, False, False, False, False, True , True , True ], 
        [False, False, True , True , False, False, True , False], 
        [False, False, False, False, True , True , True , False], 
        [True , True , False, True , False, True , False, False], 
        [False, False, True , False, True , True , False, False], 
        [True , False, False, False, False, False, False, False], 
        [True , True , True , True , True , False, False, False]
      ],
      levelPosition = {
        x = 7,
        y = 7
      }
    }, 
    -- 23
    {
      frogPosition = {
        x = 2,
        y = 6
      },
      leafMatrix = [
        [False, False, False, False, False, False, False, False], 
        [False, True , False, True , False, True , False, True ], 
        [True , False, True , True , True , False, True , True ], 
        [False, True , False, True , False, False, False, True ], 
        [True , False, True , False, False, False, True , False], 
        [False, False, False, False, True , False, True , False], 
        [False, True , True , True , True , False, True , False], 
        [False, True , False, False, False, False, True , False]
      ],
      levelPosition = {
        x = 4,
        y = 0
      }
    }, 
    -- 24
    {
      frogPosition = {
        x = 7,
        y = 0
      },
      leafMatrix = [
        [True , True , True , True , False, True , True , True ], 
        [False, False, False, True , False, True , False, False], 
        [False, False, False, True , False, True , False, False], 
        [True , True , True , True , False, True , True , True ], 
        [True , False, False, False, False, False, False, True ], 
        [True , False, False, False, False, False, False, True ], 
        [True , True , True , True , False, True , True , True ], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 4,
        y = 4
      }
    }, 
    -- 25
    {
      frogPosition = {
        x = 5,
        y = 3
      },
      leafMatrix = [
        [True , False, True , False, True , False, False, False], 
        [True , True , False, True , True , True , False, True ], 
        [False, False, False, False, True , False, False, True ], 
        [False, False, False, True , True , True , False, False], 
        [False, False, False, False, True , False, False, True ], 
        [False, False, False, True , False, False, False, True ], 
        [False, True , True , True , False, True , False, True ], 
        [False, False, True , True , True , False, False, True ]
      ],
      levelPosition = {
        x = 0,
        y = 3
      }
    }, 
    -- 26
    {
      frogPosition = {
        x = 4,
        y = 7
      },
      leafMatrix = [
        [False, False, False, False, False, True , True , True ], 
        [False, False, False, False, False, True , False, False], 
        [False, False, False, True , False, False, True , False], 
        [False, False, False, True , False, True , True , False], 
        [False, False, True , True , True , False, True , True ], 
        [False, True , False, False, False, False, True , False], 
        [True , True , True , False, False, False, True , True ], 
        [False, True , True , True , True , False, False, False]
      ],
      levelPosition = {
        x = 0,
        y = 0
      }
    }, 
    -- 27
    {
      frogPosition = {
        x = 3,
        y = 5
      },
      leafMatrix = [
        [True , False, True , False, True , False, True , True ], 
        [False, True , False, True , False, True , False, True ], 
        [True , False, True , False, True , False, False, False], 
        [False, True , False, True , False, True , True , True ], 
        [False, True , True , False, True , False, True , False], 
        [True , True , True , True , False, False, True , False], 
        [False, True , False, False, False, False, False, False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 6,
        y = 7
      }
    }, 
    -- 28
    {
      frogPosition = {
        x = 5,
        y = 5
      },
      leafMatrix = [
        [False, True , False, True , True , False, True , False], 
        [True , True , False, False, False, False, False, False], 
        [True , False, True , True , False, True , False, True ], 
        [False, False, True , False, True , False, True , False], 
        [True , False, False, True , False, True , False, True ], 
        [True , False, True , True , False, True , True , True ], 
        [True , False, False, True , False, True , False, False], 
        [False, False, True , False, True , True , False, False]
      ],
      levelPosition = {
        x = 7,
        y = 7
      }
    }, 
    -- 29
    {
      frogPosition = {
        x = 7,
        y = 0
      },
      leafMatrix = [
        [True , True , True , True , True , True , True , True ], 
        [True , True , True , True , True , True , True , True ], 
        [True , True , True , True , True , True , True , True ], 
        [True , True , True , True , True , True , True , True ], 
        [True , True , True , True , True , True , True , True ], 
        [True , True , True , True , True , True , True , True ], 
        [True , True , True , True , True , True , True , True ], 
        [False, True , True , True , True , True , True , True ]
      ],
      levelPosition = {
        x = 0,
        y = 7
      }
    }
  ]

numberOfLevels = levels |> Array.length

-- Commands

data Command =
  Nop |
  MoveBy Position |
  MoveTo Leaf |
  Continue

update : Command -> Game -> Game
update command game =
  case command of
    Nop -> game
    MoveBy positionDelta -> game |> moveBy positionDelta
    MoveTo leaf -> game |> moveTo leaf
    Continue -> game |> continue

moveBy : Position -> Game -> Game
moveBy positionDelta game =
  if (positionDelta.x == 0) && (positionDelta.y == 0)
  then
    game
  else
    let leafPosition = game.frog.leaf.position `translate` positionDelta
        maybeLeaf = game.leaves |> findLeaf leafPosition
    in case maybeLeaf of
      Nothing -> game
      Just leaf -> game |> moveTo leaf

translate : Position -> Position -> Position
translate a b =
  {
    x = a.x + b.x,
    y = a.y + b.y
  }

findLeaf : Position -> [Leaf] -> Maybe Leaf
findLeaf position leaves =
  let hasPosition leaf = leaf.position `equals` position
  in leaves |> filter hasPosition |> Array.fromList |> Array.get 0

equals : Position -> Position -> Bool
equals a b = (a.x == b.x) && (a.y == b.y)

remove : [a] -> a -> [a]
remove xs x = xs |> filter (\element -> not (element == x))

moveTo : Leaf -> Game -> Game
moveTo leaf game =
  let maybeDirection = game.frog |> directionTo leaf
  in case maybeDirection of
    Nothing -> game
    Just direction ->
      { game |
        frog <- {
          leaf = leaf,
          direction = direction
        },
        leaves <- remove game.leaves game.frog.leaf
      }

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

loadLevel : Int -> Game
loadLevel levelNumber =
  let actualLevelNumber = if (levelNumber >= numberOfLevels) || (levelNumber < 0) then 0 else levelNumber
      level = levels |> Array.getOrFail levelNumber
      leaves = loadLeafMatrix level.leafMatrix
      maybeLeaf = leaves |> findLeaf level.frogPosition
      leaf = maybeLeaf |> getOrElse (leaves |> head)
  in {
    frog = {
      leaf = leaf,
      direction = Right
    },
    levelNumber = actualLevelNumber,
    leaves = leaves,
    level = level
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

getOrElse : a -> Maybe a -> a
getOrElse defaultValue maybeValue = maybeValue |> Maybe.maybe defaultValue identity

continue : Game -> Game
continue game =
  if | game |> levelCompleted -> game |> nextLevel
     | game |> stuck -> game |> restartLevel
     | otherwise -> game

levelCompleted : Game -> Bool
levelCompleted game = (game.leaves |> length) == 1

nextLevel : Game -> Game
nextLevel game = loadLevel (game.levelNumber + 1)

stuck : Game -> Bool
stuck game =
  let canJumpThere leaf = (game.frog |> directionTo leaf) |> Maybe.isJust
  in not (game.leaves |> any canJumpThere)

restartLevel : Game -> Game
restartLevel game = loadLevel game.levelNumber

-- Input

commands : Signal Command
commands =
  let moveBy = lift2 makeMoveBy Keyboard.shift Keyboard.arrows
      continue = lift makeContinue Keyboard.enter
  in merges [moveBy, continue]

makeMoveBy : Bool -> Position -> Command
makeMoveBy shift arrows =
  let multiplier = if shift then 2 else 1
  in MoveBy {
    x = arrows.x * multiplier,
    y = -arrows.y * multiplier
  }

makeContinue : Bool -> Command
makeContinue pressed = if pressed then Continue else Nop

-- View

main = lift2 view Window.dimensions game

view : (Int, Int) -> Game -> Element
view (w, h) game =
  let background = fittedImage w h "http://lh5.ggpht.com/-pc0Bk49G7Cs/T5RYCdQjj1I/AAAAAAAAAmQ/e494iWINcrI/s9000/Texture%252Bacqua%252Bpiscina%252Bwater%252Bpool%252Bsimo-3d.jpg"
      viewSize = min w h
      foreground = game |> viewForeground viewSize |> collage viewSize viewSize |> container w h middle
      message = (game |> viewMessage viewSize) |> map (container w h middle)
  in layers ([background, foreground] ++ message)

viewForeground : Int -> Game -> [Form]
viewForeground viewSize game = 
  let tileSize = (viewSize |> toFloat) / mapSize
      frog = game.frog |> viewFrog tileSize
      leaves = game.leaves |> map (viewLeaf tileSize)
      level = game |> viewLevel tileSize
  in leaves ++ [frog] ++ level

mapSize = 8

viewFrog : Float -> Frog -> Form
viewFrog tileSize frog =
  let angle = case frog.direction of
        Up -> 0
        Right -> -90
        Down -> 180
        Left -> 90
  in sprite frog.leaf.position tileSize "https://az31353.vo.msecnd.net/pub/enuofhjd" |> rotate (angle |> degrees)

sprite : Position -> Float -> String -> Form
sprite position tileSize url =
  let element = image (floor tileSize) (floor tileSize) url
  in element |> makeForm position tileSize

makeForm : Position -> Float -> Element -> Form
makeForm position tileSize element =
  let worldPosition = position |> toWorld tileSize
  in element |> toForm |> move worldPosition

toWorld : Float -> Position -> (Float, Float)
toWorld tileSize position =
  let transform coordinate = ((coordinate |> toFloat) - mapSize / 2 + 0.5) * tileSize
  in (transform position.x, -(transform position.y))

viewLeaf : Float -> Leaf -> Form
viewLeaf tileSize leaf = sprite leaf.position tileSize "https://az31353.vo.msecnd.net/pub/ebfvplpg"

viewLevel : Float -> Game -> [Form]
viewLevel tileSize game =
  let background = sprite game.level.levelPosition tileSize "http://www.clker.com/cliparts/m/F/i/G/X/L/blank-wood-sign-th.png"
      levelNumber = textSprite game.level.levelPosition tileSize ("Level " ++ show game.levelNumber ++ " \n ") |> rotate (-1 |> degrees)
  in [background, levelNumber]

textSprite : Position -> Float -> String -> Form
textSprite position tileSize string =
  let textSize = (tileSize / 6)
  in gameText textSize string |> makeForm position tileSize

gameText : Float -> String -> Element
gameText height string = toText string |> Text.style {
    typeface = ["Comic Sans MS"],
    height = Just height,
    color = red,
    bold = True,
    italic = False,
    line = Nothing
  } |> centered

viewMessage : Int -> Game -> [Element]
viewMessage viewSize game =
  let backgroundSize = ((viewSize |> toFloat) / 2) |> round
      background = image backgroundSize backgroundSize "http://www.i2clipart.com/cliparts/9/2/6/b/clipart-bubble-256x256-926b.png"
      textSize = (viewSize |> toFloat) / 40
  in if | game |> levelCompleted -> [background, gameText textSize ("Level completed!\nPress " ++ continueKey ++ "\nto continue to the next level!")]
        | game |> stuck -> [background, gameText textSize ("Uh oh, you seem to be stuck!\nPress " ++ continueKey ++ "\nto restart this level!")]
        | otherwise -> []

continueKey = "Enter"