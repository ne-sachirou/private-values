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
import Project

cmdNew :: [String] -> IO ()
cmdNew args = let projectName:_ = args
  in do
    project <- initProject projectName
    create project

cmdRm :: [String] -> IO ()
cmdRm args = let projectName:_ = args
  in do
    project <- initProject projectName
    shouldExist project
    destroy project

cmdSet :: [String] -> IO ()
cmdSet args =
  putStrLn "SET"

cmdGet :: [String] -> IO ()
cmdGet args =
  putStrLn "GET"

cmdPath :: [String] -> IO ()
cmdPath args = let projectName:_ = args
  in do
    project <- initProject projectName
    shouldExist project
    putStrLn $ path project

cmdHelp :: IO ()
cmdHelp = putStrLn [literalFile|src/Help.txt|]
