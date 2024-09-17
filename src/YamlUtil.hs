module YamlUtil
  ( decodeYamlFile
  ) where

import Data.Yaml ( decodeFileThrow, Value )

decodeYamlFile :: String -> IO Value
decodeYamlFile path =
  do value <- decodeFileThrow path
     return value
