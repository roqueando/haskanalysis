module ChapterTwo.MissingValues where

import Text.CSV
import Text.Parsec.Error

data Laptop = Laptop
  {
    brand :: Maybe String,
    model :: Maybe String,
    cost :: Maybe Float
  } deriving Show

getStringField :: String -> Maybe String
getStringField "" = Nothing 
getStringField str = Just str

getCost :: String -> Maybe Float
getCost "" = Nothing 
getCost str = case reads str::[(Float,String)] of
                [(c, "")] -> Just c
                _ -> Nothing

parseLaptops :: Either ParseError CSV -> [Laptop] 
parseLaptops (Left _) = []
parseLaptops (Right csvData) =
  foldl (\prev curr -> if length curr == 3
                          then (parseThis curr) : prev
                           else prev) [] csvData
  where
    parseThis :: Record -> Laptop
    parseThis record = Laptop
      { brand = getStringField $ record !! 0,
        model = getStringField $ record !! 1,
        cost = getCost $ record !! 2
      }

run :: IO ()
run = do
  let filename = "data/chapter_two/missing_values.csv"
  input <- readFile filename
  let csvData = parseCSV filename input
  let laptops = parseLaptops csvData

  print laptops
