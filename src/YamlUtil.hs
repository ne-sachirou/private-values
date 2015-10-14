module YamlUtil
  ( toStringFromYL
  , toMapFromYL
  , getValueFromYL
  ) where

import Data.ByteString      ( ByteString )
import Data.Map.Lazy as Map ( Map, fromList, map, mapKeys )
import Data.Maybe           ( fromMaybe )
import Data.String          ( fromString )
import Data.Yaml.YamlLight  ( YamlLight ( YStr ), lookupYL, unMap, unStr )

toStringFromYL :: YamlLight -> String
toStringFromYL value = fromMaybe "" $ fmap toStrFromByteStr $ unStr value

toMapFromYL :: YamlLight -> Map String String
toMapFromYL yValues =
  case unMap yValues of
    Nothing     -> fromList []
    Just values -> mapKeys toStringFromYL $ Map.map toStringFromYL values

getValueFromYL :: String -> YamlLight -> String
getValueFromYL key values =
  case do
    yStr <- lookupYL (YStr $ fromString key) values
    unStr yStr
  of Nothing    -> ""
     Just value -> toStrFromByteStr value

toStrFromByteStr :: ByteString -> String
toStrFromByteStr byteStr = read $ show byteStr
