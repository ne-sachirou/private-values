module Main where

import Lib
import System.Environment ( getArgs )

main :: IO ()
main = do
  args <- getArgs
  case args of
    "new":rest  -> cmdNew rest
    "rm":rest   -> cmdRm rest
    "set":rest  -> cmdSet rest
    "get":rest  -> cmdGet rest
    "path":rest -> cmdPath rest
    _           -> cmdHelp
