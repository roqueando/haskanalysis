module ChapterTwo.Lexing where

import Data.Attoparsec.Text
import Data.Char (isAlphaNum)

data Email = Email
  { user :: String,
    host :: String
  } deriving Show

email :: Parser Email
email = do
  skipSpace
  usr <- many' $ satisfy isAlphaNum
  hostName <- many' $ satisfy isAlphaNum
  domain <- many' $ satisfy isAlphaNum
  return $ Email usr (hostName ++ "." ++ domain)

run :: IO ()
run = do
  print $ parseOnly email "nishant@shukle.io"
