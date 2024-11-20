module Main where

import qualified ChapterOne.CSV as CSV
import qualified ChapterOne.HTML as HTML
--import qualified ChapterOne.HTTP as HTTP
import qualified ChapterOne.JSON as JSON
import qualified ChapterOne.Mongo as Mongo
import qualified ChapterOne.SQLite as SQLite
import qualified ChapterOne.XML as XML

main :: IO ()
main = do
  CSV.run
  HTML.run
  --HTTP.run wikipedia is not working with https
  JSON.run
  Mongo.run
  SQLite.run
  XML.run
  return ()
