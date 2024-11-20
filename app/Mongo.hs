module Mongo where

import Database.MongoDB

run :: IO ()
run = do
  conn <- connect (host "127.0.0.1") -- connect into mongodb server

  result <- access conn master "test" getData
  close conn
  print result

  where
    --getData = rest =<< find (select [] "people") {sort=[]}
    getData = find (select [] "people") {options=[]} >>= rest
