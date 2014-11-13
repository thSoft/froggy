module Froggy.View where

import Text
import Graphics.Input (..)
import Froggy.Util (..)
import Froggy.Grid as Grid
import Froggy.Levels (..)
import Froggy.Model (..)
import Froggy.Commands (..)

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
      targets = game.leaves |> viewTargets game.frog tileSize
      level = game |> viewLevel tileSize
  in (leaves ++ targets ++ [frog] ++ level) |> collage viewSize viewSize

mapSize = 8

viewFrog : Float -> Frog -> Form
viewFrog tileSize frog = sprite frog.leaf.position tileSize "https://az31353.vo.msecnd.net/pub/enuofhjd" |> rotate (frog.angle |> degrees)

sprite : Grid.Position -> Float -> String -> Form
sprite = customSprite identity

customSprite : (Element -> Element) -> Grid.Position -> Float -> String -> Form
customSprite transform position tileSize url =
  let element = image (round tileSize) (round tileSize) url
  in element |> transform |> makeForm position tileSize

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

viewTargets : Frog -> Float -> [Leaf] -> [Form]
viewTargets frog tileSize leaves =
  let targets = leaves |> filter (reachableBy frog)
      toClickable target = clickable moveTo.handle (MoveTo target)
      distanceOf target = (distance target.position.x frog.leaf.position.x) + (distance target.position.y frog.leaf.position.y)
      angle target =
        case frog `angleTo` target of
          Just angle -> angle
          Nothing -> 0
      filename target = "arrows/" ++ (distanceOf target |> show) ++ "/" ++ (angle target |> show) ++ ".png"
      viewTarget target = customSprite (toClickable target) target.position tileSize (filename target)
  in targets |> map viewTarget

viewLevel : Float -> Game -> [Form]
viewLevel tileSize game =
  let levelPosition = (getLevel game.levelNumber) |> .levelPosition
      background = sprite levelPosition tileSize "http://www.clker.com/cliparts/m/F/i/G/X/L/blank-wood-sign-md.png"
      levelNumber = textSprite levelPosition tileSize ("Level " ++ show game.levelNumber ++ " \n ") |> rotate (-1 |> degrees)
  in [background, levelNumber]

textSprite : Grid.Position -> Float -> String -> Form
textSprite position tileSize string =
  let textSize = tileSize / 6
  in gameText textSize string |> makeForm position tileSize

gameText : Float -> String -> Element
gameText height string = toText string |> Text.style {
    typeface = ["Bubblegum Sans", "cursive"],
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
""" ++ continueInstruction ++ """ to continue to the next level!"""

stuckMessage = """Uh oh, you seem to be stuck!
""" ++ continueInstruction ++ """ to restart this level!"""

instructionsMessage = """Welcome to Froggy!

Your goal is to traverse all leaves.

Arrow key: jump to an adjacent leaf
Shift + arrow key: leap over an adjacent leaf

""" ++ continueInstruction ++ """ to start the game!"""

continueInstruction = "Press Enter or tap"