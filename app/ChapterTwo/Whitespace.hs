module ChapterTwo.Whitespace where

import Data.Char (isSpace)

trim :: String -> String
trim = f . f
  where
    f = reverse . dropWhile isSpace

run :: IO ()
run = do
  print $ trim " whooaaa!    "
