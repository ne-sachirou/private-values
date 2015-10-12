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
import Text.Regex.TDFA

cmdNew :: [String] -> IO ()
cmdNew args = let projectName:_ = args
  in do
    case validateProjectName projectName of
      Right projectName -> putStrLn projectName
      Left error        -> fail error

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
cmdHelp = putStrLn [literalFile|src/Help.txt|]

validateProjectName :: String -> Either String String
validateProjectName projectName
  | (projectName =~ "^[-A-Za-z0-9_]+$" :: Int) == 0 = Left "The project name shold only contain [-A-Za-z0-9_]"
  | otherwise                                       = Right projectName
