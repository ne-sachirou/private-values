{-# LANGUAGE QuasiQuotes #-}
module Lib
    ( cmdNew
    , cmdRm
    , cmdSet
    , cmdGet
    , cmdPath
    , cmdHelp
    ) where

import Literal ( literalFile )
import System.Directory
import System.Environment ( getEnv )
import System.IO
import Text.Regex.TDFA

cmdNew :: [String] -> IO ()
cmdNew args = let projectName:_ = args
  in do
    validateProjectName projectName
    homePath <- getEnv "HOME"
    createDirectoryIfMissing True $ homePath ++ "/.private-values"
    createDirectory $ homePath ++ "/.private-values/" ++ projectName
    valuesFile <- openFile (homePath ++ "/.private-values/" ++ projectName ++ "/values.yml") WriteMode
    hClose valuesFile

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

validateProjectName :: String -> IO ()
validateProjectName projectName
  | (projectName =~ "^[-A-Za-z0-9_]+$" :: Int) == 0 = fail "The project name shold only contain [-A-Za-z0-9_]"
  | otherwise                                       = return ()
