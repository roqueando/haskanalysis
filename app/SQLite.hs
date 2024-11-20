module SQLite where

import Database.SQLite.Simple

data TestField = TestField Int String deriving (Show)

instance FromRow TestField where
  fromRow = TestField
    <$> field
    <*> field

run :: IO ()
run = do
  conn <- open "data/test.db"
  result <- query_ conn "SELECT * FROM test" :: IO [TestField]
  mapM_ print result
