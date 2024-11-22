module ChapterTwo.Punctuation where

punctuations :: [Char]
punctuations = ['!', '"', '#', '$', '%', '(', ')', '.', ',', '?']

specialSymbols :: [Char]
specialSymbols = ['/', '-']

removePunctuation :: [Char] -> [Char]
removePunctuation = filter (`notElem` punctuations)

replaceSpecialSymbols :: [Char] -> [Char]
replaceSpecialSymbols = map $ (\c -> if c `elem` specialSymbols then ' ' else c)

run :: IO ()
run = do
  let quote = "Deep Blue plays very good chess-so what?\
    \Des that tell you something about how we play chess?\
    \No. Does it tell you about how Kasparov envisions,\
    \understands a chessboard? (Douglas Hofstadter)"
  putStrLn $ (removePunctuation . replaceSpecialSymbols) quote
