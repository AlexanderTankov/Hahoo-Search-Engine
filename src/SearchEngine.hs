{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

module SearchEngine where

import qualified Data.ByteString.Char8 as BS
import qualified Data.Map.Strict as DMS

data SourceType = Title | Header1 | Header2 | Header3 | Header4 | Header5 | Header6 | Header7
  deriving (Read, Show, Ord, Eq)
type Record = (BS.ByteString, SourceType)
type MapType = DMS.Map BS.ByteString [Record]

addRecord :: BS.ByteString -> Record -> MapType -> MapType
addRecord word record currState = DMS.insertWith (++) word [record] currState

searchWord :: BS.ByteString -> MapType -> [Record]
searchWord word state = DMS.findWithDefault [] word state