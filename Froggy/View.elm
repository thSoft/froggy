module Froggy.View where

import Text
import Graphics.Input (..)
import Easing (..)
import Froggy.Util (..)
import Froggy.Grid as Grid
import Froggy.Levels (..)
import Froggy.Model (..)
import Froggy.Commands (..)

view : String -> (Int, Int) -> Time -> Game -> Element
view fontName (windowWidth, windowHeight) time game =
  let background = fittedImage windowWidth windowHeight "http://lh5.ggpht.com/-pc0Bk49G7Cs/T5RYCdQjj1I/AAAAAAAAAmQ/e494iWINcrI/s9000/Texture%252Bacqua%252Bpiscina%252Bwater%252Bpool%252Bsimo-3d.jpg"
      viewSize = min windowWidth windowHeight
      foreground = game |> viewForeground fontName viewSize time |> container windowWidth windowHeight middle
      message = game |> viewMessage fontName viewSize |> map (container windowWidth windowHeight middle)
  in layers ([background, foreground] ++ message)

viewForeground : String -> Int -> Time -> Game -> Element
viewForeground fontName viewSize time game = 
  let tileSize = (viewSize |> toFloat) / mapSize
      frog = game.frog |> viewFrog tileSize time
      leaves = game.leaves |> map (viewLeaf tileSize)
      targets = game.leaves |> viewTargets game.frog tileSize
      level = game |> viewLevel fontName tileSize
  in (leaves ++ targets ++ frog ++ level) |> collage viewSize viewSize

mapSize = 8

viewFrog : Float -> Time -> Frog -> [Form]
viewFrog tileSize time frog =
  let newWorldPosition = frog.leaf.position |> toWorld tileSize
      worldPosition = case frog.lastMove of
        Just { oldValue, startTime } ->
          let oldWorldPosition = oldValue.position |> toWorld tileSize
          in ease easeInOutQuint (pair float) oldWorldPosition newWorldPosition movingFromDuration (time - startTime)
        Nothing -> newWorldPosition
      lastLeaf = case frog.lastMove of
        Nothing -> []
        Just { oldValue, startTime } ->
          let alphaValue = ease easeInCubic float 1 0 movingFromDuration (time - startTime)
          in [viewLeaf tileSize oldValue |> alpha alphaValue]
      size = case frog.lastMove of
        Nothing -> 1
        Just { startTime } -> ease (easeInQuad |> retour) float 1 1.2 movingFromDuration (time - startTime)
      frogSprite = sprite worldPosition tileSize "https://az31353.vo.msecnd.net/pub/enuofhjd" |> rotate (frog.angle |> degrees) |> scale size
  in lastLeaf ++ [frogSprite]

movingFromDuration : Time
movingFromDuration = (250 * millisecond)

sprite : (Float, Float) -> Float -> String -> Form
sprite = customSprite identity

customSprite : (Element -> Element) -> (Float, Float) -> Float -> String -> Form
customSprite transform worldPosition tileSize url =
  let element = image (round tileSize) (round tileSize) url
  in element |> transform |> makeForm worldPosition

makeForm : (Float, Float) -> Element -> Form
makeForm worldPosition element = element |> toForm |> move worldPosition

toWorld : Float -> Grid.Position -> (Float, Float)
toWorld tileSize position =
  let transform coordinate = ((coordinate |> toFloat) - mapSize / 2 + 0.5) * tileSize
  in (transform position.x, -(transform position.y))

viewLeaf : Float -> Leaf -> Form
viewLeaf tileSize leaf =
  let worldPosition = leaf.position |> toWorld tileSize
  in sprite worldPosition tileSize "https://az31353.vo.msecnd.net/pub/ebfvplpg"

viewTargets : Frog -> Float -> [Leaf] -> [Form]
viewTargets frog tileSize leaves =
  let targets = leaves |> filter (reachableBy frog)
      toClickable target = clickable moveTo.handle (MoveTo target)
      distanceOf target = (distance target.position.x frog.leaf.position.x) + (distance target.position.y frog.leaf.position.y)
      angleOf target = frog `angleTo` target |> getOrElse 0
      filename target = "arrows/" ++ (distanceOf target |> show) ++ "/" ++ (angleOf target |> show) ++ ".png"
      worldPosition target = target.position |> toWorld tileSize
      viewTarget target = customSprite (toClickable target) (worldPosition target) tileSize (filename target)
  in targets |> map viewTarget

viewLevel : String -> Float -> Game -> [Form]
viewLevel fontName tileSize game =
  let levelPosition = (getLevel game.levelNumber) |> .levelPosition
      worldPosition = levelPosition |> toWorld tileSize
      background = sprite worldPosition tileSize "http://www.clker.com/cliparts/m/F/i/G/X/L/blank-wood-sign-md.png"
      levelNumber = textSprite fontName levelPosition tileSize ("Level\n" ++ show game.levelNumber ++ "/" ++ show numberOfLevels ++ "\n\n") |> rotate (-1 |> degrees)
  in [background, levelNumber]

textSprite : String -> Grid.Position -> Float -> String -> Form
textSprite fontName position tileSize string =
  let textSize = tileSize / 6
      worldPosition = position |> toWorld tileSize
  in gameText fontName textSize string |> makeForm worldPosition

gameText : String -> Float -> String -> Element
gameText fontName height string = toText string |> Text.style {
    typeface = [fontName],
    height = Just height,
    color = red,
    bold = True,
    italic = False,
    line = Nothing
  } |> centered

viewMessage : String -> Int -> Game -> [Element]
viewMessage fontName viewSize game =
  let backgroundSize = ((viewSize |> toFloat) / 1.7) |> round
      background = image backgroundSize backgroundSize "http://www.i2clipart.com/cliparts/9/2/6/b/clipart-bubble-256x256-926b.png"
      textSize = (viewSize |> toFloat) / 40
      lastLevel = game.levelNumber == numberOfLevels - 1
      completedMessage = if lastLevel then gameCompletedMessage else levelCompletedMessage
  in if | game |> levelCompleted -> [background, gameText fontName textSize completedMessage]
        | game |> stuck -> [background, gameText fontName textSize stuckMessage]
        | game.instructions -> [background, gameText fontName textSize instructionsMessage]
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