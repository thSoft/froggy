module Froggy.View where

import Text
import Froggy.Grid as Grid
import Froggy.Levels (..)
import Froggy.Model (..)

view : (Int, Int) -> Game -> Element
view (windowWidth, windowHeight) game =
  let background = fittedImage windowWidth windowHeight "http://lh5.ggpht.com/-pc0Bk49G7Cs/T5RYCdQjj1I/AAAAAAAAAmQ/e494iWINcrI/s9000/Texture%252Bacqua%252Bpiscina%252Bwater%252Bpool%252Bsimo-3d.jpg"
      viewSize = min windowWidth windowHeight
      foreground = game |> viewForeground viewSize |> container windowWidth windowHeight middle
      message = game |> viewMessage viewSize |> map (container windowWidth windowHeight middle)
  in layers ([background, foreground] ++ message)

viewForeground : Int -> Game -> Element
viewForeground viewSize game = 
  let tileSize = (viewSize |> toFloat) / mapSize
      frog = game.frog |> viewFrog tileSize
      leaves = game.leaves |> map (viewLeaf tileSize)
      level = game |> viewLevel tileSize
  in (leaves ++ [frog] ++ level) |> collage viewSize viewSize

mapSize = 8

viewFrog : Float -> Frog -> Form
viewFrog tileSize frog =
  let angle = case frog.direction of
        Up -> 0
        Right -> -90
        Down -> 180
        Left -> 90
  in sprite frog.leaf.position tileSize "https://az31353.vo.msecnd.net/pub/enuofhjd" |> rotate (angle |> degrees)

sprite : Grid.Position -> Float -> String -> Form
sprite position tileSize url =
  let element = image (floor tileSize) (floor tileSize) url
  in element |> makeForm position tileSize

makeForm : Grid.Position -> Float -> Element -> Form
makeForm position tileSize element =
  let worldPosition = position |> toWorld tileSize
  in element |> toForm |> move worldPosition

toWorld : Float -> Grid.Position -> (Float, Float)
toWorld tileSize position =
  let transform coordinate = ((coordinate |> toFloat) - mapSize / 2 + 0.5) * tileSize
  in (transform position.x, -(transform position.y))

viewLeaf : Float -> Leaf -> Form
viewLeaf tileSize leaf = sprite leaf.position tileSize "https://az31353.vo.msecnd.net/pub/ebfvplpg"

viewLevel : Float -> Game -> [Form]
viewLevel tileSize game =
  let levelPosition = (getLevel game.levelNumber) |> .levelPosition
      background = sprite levelPosition tileSize "http://www.clker.com/cliparts/m/F/i/G/X/L/blank-wood-sign-th.png"
      levelNumber = textSprite levelPosition tileSize ("Level " ++ show game.levelNumber ++ " \n ") |> rotate (-1 |> degrees)
  in [background, levelNumber]

textSprite : Grid.Position -> Float -> String -> Form
textSprite position tileSize string =
  let textSize = tileSize / 6
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
  let backgroundSize = ((viewSize |> toFloat) / 1.7) |> round
      background = image backgroundSize backgroundSize "http://www.i2clipart.com/cliparts/9/2/6/b/clipart-bubble-256x256-926b.png"
      textSize = (viewSize |> toFloat) / 40
      lastLevel = game.levelNumber == numberOfLevels - 1
      completedMessage = if lastLevel then gameCompletedMessage else levelCompletedMessage
  in if | game |> levelCompleted -> [background, gameText textSize completedMessage]
        | game |> stuck -> [background, gameText textSize stuckMessage]
        | game.instructions -> [background, gameText textSize instructionsMessage]
        | otherwise -> []

gameCompletedMessage = """Congratulations!
You have completed the game!"""

levelCompletedMessage = """Level completed!
Press """ ++ continueKey ++ """ to continue to the next level!"""

stuckMessage = """Uh oh, you seem to be stuck!
Press """ ++ continueKey ++ """ to restart this level!"""

instructionsMessage = """Welcome to Froggy!

Your goal is to traverse all leaves.

Arrow key: jump to an adjacent leaf
Shift + arrow key: leap over an adjacent leaf

Press """ ++ continueKey ++ """ to start the game!"""

continueKey = "Enter"