module YamlUtil
  ( decodeYamlFile
  ) where

import Data.ByteString as ByteString ( readFile )
import Data.Maybe ( fromMaybe )
import Data.Yaml ( decode, object, Value )

decodeYamlFile :: String -> IO Value
decodeYamlFile path =
  do yaml <- ByteString.readFile path
     return $ fromMaybe (object []) (decode yaml :: Maybe Value)
