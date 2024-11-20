{-# LANGUAGE DeriveGeneric #-}
module Json where

import GHC.Generics
import Data.Aeson
import qualified Data.ByteString.Lazy as B

data Mathematician = Mathematician
  {
    name :: String,
    nationality :: String,
    born :: Int,
    died :: Maybe Int
  } deriving (Generic, Show)

instance FromJSON Mathematician

greet :: Mathematician -> String
greet m = (show . name) m ++ " was born at year " ++ (show . born) m ++ " as a " ++ (show . nationality) m

run :: IO ()
run = do
  input <- B.readFile "data/input.json"
  let mm = decode input :: Maybe Mathematician
  case mm of
    Nothing -> print "error parsing JSON"
    Just m -> (putStrLn . greet) m
  return ()
