{-# LANGUAGE OverloadedStrings #-}

import qualified SearchEngine as E
import Persister as P

main = do
  state <- P.readFromFile
  let newState = E.addRecord "TestTitle" ("http://my.test", E.Title) state
  print newState
