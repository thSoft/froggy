module Froggy.View where

import Text
import Froggy.Grid as Grid
import Froggy.Levels (..)
import Froggy.Model (..)

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
  let background = sprite game.level.levelPosition tileSize "http://www.clker.com/cliparts/m/F/i/G/X/L/blank-wood-sign-th.png"
      levelNumber = textSprite game.level.levelPosition tileSize ("Level " ++ show game.levelNumber ++ " \n ") |> rotate (-1 |> degrees)
  in [background, levelNumber]

textSprite : Grid.Position -> Float -> String -> Form
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
      lastLevel = game.levelNumber == numberOfLevels - 1
      completedMessage = if lastLevel then "Congratulations!\nYou have completed the game!" else "Level completed!\nPress " ++ continueKey ++ "\nto continue to the next level!"
  in if | game |> levelCompleted -> [background, gameText textSize completedMessage]
        | game |> stuck -> [background, gameText textSize ("Uh oh, you seem to be stuck!\nPress " ++ continueKey ++ "\nto restart this level!")]
        | otherwise -> []

continueKey = "Enter"