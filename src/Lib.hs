{-# LANGUAGE QuasiQuotes, OverloadedStrings #-}
module Lib
  ( cmdProjects
  , cmdNew
  , cmdRm
  , cmdPath
  , cmdKeys
  , cmdSet
  , cmdGet
  , cmdHelp
  ) where

import Data.List ( intercalate )
import Data.List.Split ( splitOn )
import Literal ( literalFile )
import Project
import System.IO ( hPutStr, hSetEncoding, stdout, utf8 )

cmdProjects :: [String] -> IO ()
cmdProjects args =
  do projectNames <- listProjectNames
     putStrLn $ intercalate "\n" projectNames

cmdNew :: [String] -> IO ()
cmdNew args =
  let projectName:_ = args
  in do
    project <- initProject projectName
    create project

cmdRm :: [String] -> IO ()
cmdRm args =
  let projectName:_ = args
  in do
    project <- initProject projectName
    shouldExist project
    destroy project

cmdPath :: [String] -> IO ()
cmdPath args =
  let projectName:_ = args
  in do
    project <- initProject projectName
    shouldExist project
    putStr $ path project

cmdKeys :: [String] -> IO()
cmdKeys args =
  let projectName:_ = args
  in do
    project <- initProject projectName
    shouldExist project
    keys <- getKeys project
    putStrLn $ intercalate "\n" keys

cmdSet :: [String] -> IO ()
cmdSet args =
  let projectName:_keyLs = splitOn "." $ head args
      key                = intercalate "." _keyLs
      value              = head $ tail args
  in do
    project <- initProject projectName
    shouldExist project
    setValue project key value

cmdGet :: [String] -> IO ()
cmdGet args =
  let projectName:key:_ = splitOn "." $ head args
  in do
    project <- initProject projectName
    shouldExist project
    value <- getValue project key
    hSetEncoding stdout utf8
    putStr value

cmdHelp :: IO ()
cmdHelp = putStrLn [literalFile|src/Help.txt|]
