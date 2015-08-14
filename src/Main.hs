{-# LANGUAGE OverloadedStrings #-}

import qualified SearchEngine as E
import Persist as P

main = do
  state <- P.readFromFile
  newState <- E.addRecord "TestTitle" ("http://my.test", E.Title) state
  show newState
