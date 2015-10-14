{-# LANGUAGE QuasiQuotes #-}
module Lib
  ( cmdNew
  , cmdRm
  , cmdSet
  , cmdGet
  , cmdPath
  , cmdHelp
  ) where

import Data.List       ( intercalate )
import Data.List.Split ( splitOn )
import Literal         ( literalFile )
import Project

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
    putStr value

cmdPath :: [String] -> IO ()
cmdPath args =
  let projectName:_ = args
  in do
    project <- initProject projectName
    shouldExist project
    putStr $ path project

cmdHelp :: IO ()
cmdHelp = putStrLn [literalFile|src/Help.txt|]
