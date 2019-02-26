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
import Data.Functor ((<&>))

-- | Data to represent text as a set of unmatched brackets.
--  Consists of list of closing brackets and reversed list of opening ones.
data B a = B [a] [a]
  deriving (Eq, Show)

empty :: B a
empty = B [] []

opening :: a -> B a
opening a = B [] [a]

closing :: a -> B a
closing a = B [a] []

-- | Appends two parts of the text canceling brackets,
--  if cancellation is impossible Nothing is returned.
append :: Eq a => B a -> B a -> Maybe (B a)
append (B a b) (B c d) = cancel b c <&> \(b, c) -> B (a ++ c) (d ++ b)
  where cancel (b:bs) (c:cs) | b == c = cancel bs cs
                             | otherwise = Nothing
        cancel bs cs = Just (bs, cs)

concat :: Eq a => [B a] -> Maybe (B a)
concat = foldl' (\acc b -> acc >>= (`append` b)) (Just empty)
