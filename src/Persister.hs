module Persister where

import qualified Data.Map.Strict as M
import qualified Data.ByteString.Lazy as BL
import System.IO.Error(tryIOError)

-- Path to file
getFilePath :: String
getFilePath = "./persisted"

fromMapToByteString :: Ord k => M.Map k a -> [(k, a)]
fromMapToByteString m = M.toList m

fromByteStringToMap :: Ord k => [(k, a)] -> M.Map k a
fromByteStringToMap l = M.fromList l

writeInFile :: (Ord k, Show a, Show k) => M.Map k a -> IO()
writeInFile m = writeFile getFilePath $ show $ fromMapToByteString m

readFromFile :: (Ord k, Read a, Read k) => IO(M.Map k a)
readFromFile = do
    m <- (tryIOError $ readFile getFilePath) >>= (\eitherMap -> case eitherMap
                                                      of Right val -> return val
                                                         _ -> return "[]")

    return $ fromByteStringToMap $ read m