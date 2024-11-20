module HTTP where

import Text.XML.HXT.Core
import Text.HandsomeSoup

run :: IO ()
run = do
  let doc = fromUrl "https://en.wikipedia.org/wiki/Narwhal"
  links <- runX $ doc >>> css "#bodyContent a" ! "href"
  print links
