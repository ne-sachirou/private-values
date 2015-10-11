{-# LANGUAGE QuasiQuotes #-}
module Lib
    ( cmdNew,
      cmdRm,
      cmdSet,
      cmdGet,
      cmdPath,
      cmdHelp
    ) where

import Literal ( literalFile )

cmdNew :: [String] -> IO ()
cmdNew args =
  putStrLn "NEW"

cmdRm :: [String] -> IO ()
cmdRm args =
  putStrLn "RM"

cmdSet :: [String] -> IO ()
cmdSet args =
  putStrLn "SET"

cmdGet :: [String] -> IO ()
cmdGet args =
  putStrLn "GET"

cmdPath :: [String] -> IO ()
cmdPath args =
  putStrLn "PATH"

cmdHelp :: IO ()
cmdHelp =
  putStrLn [literalFile|src/Help.txt|]
