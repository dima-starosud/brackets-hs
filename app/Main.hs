module Main where

import System.Environment
import qualified Brackets as B

data Kind = Round | Square | Curly | Angle
  deriving (Eq)

parse :: String -> [B.B Kind]
parse = map parse1

parse1 :: Char -> B.B Kind
parse1 '(' = B.opening Round
parse1 ')' = B.closing Round
parse1 '[' = B.opening Square
parse1 ']' = B.closing Square
parse1 '{' = B.opening Curly
parse1 '}' = B.closing Curly
parse1 '<' = B.opening Angle
parse1 '>' = B.closing Angle
parse1 _ = B.empty

isValid :: String -> Bool
isValid s = B.concat (parse s) == Just B.empty

main :: IO ()
main = do [string] <- getArgs
          print $ isValid string
