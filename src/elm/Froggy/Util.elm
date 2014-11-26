module Froggy.Util where

import Maybe (..)

remove : [a] -> a -> [a]
remove xs x = xs |> filter (\element -> element /= x)

getOrElse : a -> Maybe a -> a
getOrElse defaultValue maybeValue = maybeValue |> maybe defaultValue identity

distance : Int -> Int -> Int
distance a b = abs(a - b)