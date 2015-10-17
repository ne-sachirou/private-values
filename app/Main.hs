module Main where

import Lib
import System.Environment ( getArgs )

main :: IO ()
main = do
  args <- getArgs
  case args of
    "projects":rest -> cmdProjects rest
    "new":rest      -> cmdNew rest
    "rm":rest       -> cmdRm rest
    "path":rest     -> cmdPath rest
    "keys":rest     -> cmdKeys rest
    "set":rest      -> cmdSet rest
    "get":rest      -> cmdGet rest
    _               -> cmdHelp
