import qualified Data.ByteString.Lazy.Char8 as NL
import Text.StringLike
import Text.HTML.TagSoup
import Network.HTTP.Conduit (simpleHttp)
import Data.Dequeue

-- AddRecord :: NL.ByteString -> NL.ByteString -> Int -> Bool
-- AddRecord word link priority = True

crawlOneLink :: String -> Bool
crawlOneLink link = True

leanpub :: String
leanpub = "http://leanpub.com/gameinhaskell"

visitedSites :: Data.Dequeue

type ParsedPageContent str = [Tag str]

contentWithinTags :: (TagRep t, StringLike str) => t -> t -> ParsedPageContent str -> ParsedPageContent str
contentWithinTags open close = takeWhile (~/= close) . dropWhile (~/= open)

textWithinTags :: (TagRep t, StringLike str) => t -> t -> ParsedPageContent str -> str
textWithinTags open close = innerText . contentWithinTags open close

getHref  :: ParsedPageContent String -> String
getHref = getHref . head . takeWhile (~/= "<a>")
    where getHref (TagOpen string xs) = snd $ hrefPair xs
          hrefPair xs = head $ filter (\x -> fst x == "href") xs

getTitle :: StringLike str => ParsedPageContent str -> str
getTitle = textWithinTags "<title>" "</title>"

getHeader :: StringLike str => Int -> ParsedPageContent str -> str
getHeader i = textWithinTags openHeader closeHeader
              where openHeader = "<h" ++ show i ++ ">"
                    closeHeader = "</h" ++ show i ++ ">"

getHeader1, getHeader2, getHeader3, getHeader4, getHeader5, getHeader6, getHeader7 :: StringLike str => ParsedPageContent str -> str
getHeader1 = getHeader 1
getHeader2 = getHeader 2
getHeader3 = getHeader 3
getHeader4 = getHeader 4
getHeader5 = getHeader 5
getHeader6 = getHeader 6
getHeader7 = getHeader 7

getParsedContent :: String -> IO (ParsedPageContent NL.ByteString)
getParsedContent = fmap parseTags . simpleHttp

-- Removing leading spaces and empty lines
trimWhiteSpaces :: NL.ByteString -> NL.ByteString
trimWhiteSpaces = NL.unlines . filter (/= NL.empty) . trimLeadingSpaces
  where trimLeadingSpaces = map (NL.pack . dropWhile (`elem` ['\n', '\t', ' ']). NL.unpack) . NL.lines

main :: IO ()
main = do
  content <- getParsedContent leanpub
  let title = trimWhiteSpaces $ getTitle content
  let header = trimWhiteSpaces $ getHeader1 content
  -- let contentString = NL.unpack content
  NL.putStrLn header