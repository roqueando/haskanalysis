module Main where

import Text.CSV
import Text.Parsec.Error

oldest :: Either ParseError CSV -> Either ParseError Record
oldest (Left e) = Left e
oldest (Right []) = Right []
oldest (Right (_:xs)) = Right (foldl1 checkAge xs)
  where
    checkAge a x
      | age x > age a = x
      | otherwise = a

    age [] = 0 :: Int
    age [_] = 0 :: Int
    age (_:_:_:_) = 0 :: Int
    age [_, a] = read a :: Int

ageAvg :: Either ParseError CSV -> Either ParseError Int
ageAvg (Left e) = Left e
ageAvg (Right []) = Right 0
ageAvg (Right (_:xs)) = Right (avg xs)
  where
    avg [] = 0
    avg xs' = (sumAges xs') `div` (length xs')


sumAges :: [[String]] -> Int
sumAges [] = 0
sumAges xs = (sum . map toInt) xs
  where
    toInt [] = 0
    toInt [_] = 0
    toInt (_:_:_:_) = 0
    toInt [_, x] = read x :: Int

main :: IO ()
main = do
  csvData <- parseCSVFromFile "data/input.csv"

  case ageAvg csvData of
    Left e -> print e
    Right c -> print c
  return ()
