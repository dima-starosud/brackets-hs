module Main where

import System.Environment
import Example

main :: IO ()
main = do [string] <- getArgs
          print $ isValid string
