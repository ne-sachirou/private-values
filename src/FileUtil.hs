module FileUtil
  ( absolutize
  ) where

import Data.List ( isPrefixOf )
import Data.Maybe ( fromJust )
import System.Directory ( getHomeDirectory )
import System.FilePath ( addTrailingPathSeparator, normalise )
import System.Path.NameManip ( absolute_path, guess_dotdot )

absolutize :: String -> IO String
absolutize path
  | ("~" == path) || ("~/" `isPrefixOf` path) =
    do homePath <- getHomeDirectory
       return $ normalise $ addTrailingPathSeparator homePath ++ tail path
  | otherwise =
    do pathMaybeWithDots <- absolute_path path
       return $ fromJust $ guess_dotdot pathMaybeWithDots
