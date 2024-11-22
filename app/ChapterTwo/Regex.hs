module ChapterTwo.Regex where

import Text.Regex.Posix ((=~))
import ChapterTwo.Punctuation

createTuples :: [String] -> [String]
createTuples (x:y:xs) = (x ++ " " ++ y) : createTuples (y : xs)
createTuples _ = []

looksLikeName ::String -> Bool
looksLikeName str = str =~ ("^[A-Z][a-z]{1,30}$" :: String) :: Bool

run :: IO ()
run = do
  input <- readFile "data/chapter_two/corpus.txt"
  let cleanInput = (removePunctuation . replaceSpecialSymbols) input
  let wordPairs = createTuples $ words cleanInput
  let possibleNames = filter (all looksLikeName . words) wordPairs

  print possibleNames
