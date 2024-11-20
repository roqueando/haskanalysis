module ChapterOne.HTML where

import Text.XML.HXT.Core
import Data.List.Split (chunksOf)

biggest :: [[String]] -> [String]
biggest [] = []
biggest items = foldl1 (\a x -> if capacity x > capacity a then x else a) items
  where
    capacity [_,_,c] = read c :: Int
    capacity _ = -1

run :: IO ()
run = do
  input <- readFile "data/input.html"
  texts <- runX $ readString [withParseHTML yes, withWarnings no] input
    //> hasName "td"
    //> getText

  print $ texts
  let rows = chunksOf 3 texts
  print $ biggest rows
  return ()

