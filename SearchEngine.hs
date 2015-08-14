{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

module SearchEngine where

import qualified Data.ByteString.Char8 as BS

data SourceType = Title | Header1 | Header2 | Header3 | Header4 | Header5 | Header6 | Header7

addRecord :: BS.ByteString -> BS.ByteString -> SourceType
addRecord = undefined

searchWord :: BS.ByteString -> [BS.ByteString]
searchWord = undefined