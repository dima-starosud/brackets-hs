module Brackets
    ( B()
    , empty
    , opening
    , closing
    , append
    , concat
    ) where

import Prelude hiding (concat)
import Data.List (foldl')

data B a = B [a] [a]
  deriving (Eq)

empty :: B a
empty = B [] []

opening a = B [] [a]
closing a = B [a] []

append :: Eq a => B a -> B a -> Maybe (B a)
append (B a b) (B c d) = cancel b c `ff` \(b, c) -> B (a ++ c) (d ++ b)
  where cancel (b:bs) (c:cs) | b == c = cancel bs cs
                             | otherwise = Nothing
        cancel bs cs = Just (bs, cs)

ff = flip fmap

concat :: Eq a => [B a] -> Maybe (B a)
concat = foldl' (\acc b -> acc >>= (`append` b)) (Just empty)
