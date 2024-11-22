module ChapterTwo.Duplicate where

import Text.CSV (parseCSV, Record)

import Data.Map (fromListWith)
import Control.Applicative ((<|>))

data Item = Item
  { name :: String,
    color :: Maybe String,
    cost :: Maybe Float
  } deriving Show

combine :: Item -> Item -> Item
combine item1 item2 = Item 
  { name = name item1,
    color = color item1 <|> color item2,
    cost = cost item1 <|> cost item2
  }

parseItem :: Record -> Item
parseItem r = Item
  { name = r !! 0,
    color = parseColor (r !! 1),
    cost = parseCost (r !! 2)
  }
    where
      parseColor "" = Nothing
      parseColor str = Just str

      parseCost "" = Nothing
      parseCost str = case reads str :: [(Float, String)] of
                        [(c, "")] -> Just c
                        _ -> Nothing

parseToTuple :: [String] -> (String, Item)
parseToTuple record = if length record == 3
                         then (name item, item)
                         else ("", emptyItem)
  where
    item = parseItem record
    emptyItem = Item
      { name = "",
        color = Nothing,
        cost = Nothing
      }


handleCSVData :: [Record] -> IO ()
handleCSVData csv = print $ fromListWith combine (map parseToTuple csv)


run :: IO ()
run = do
  let filename = "data/chapter_two/duplicate.csv"
  input <- readFile filename
  let csvData = parseCSV filename input
  either (\e -> print e) handleCSVData csvData
