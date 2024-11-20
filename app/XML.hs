module XML where

import Text.XML.HXT.Core

run :: IO ()
run = do
  input <- readFile "data/input.xml"
  dates <- runX $ readString [withValidate no] input
    //> hasName "date"
    //> getText

  print dates

  return ()
