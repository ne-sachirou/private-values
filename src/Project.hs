module Project where

import System.Directory
import System.Environment ( getEnv )
import System.IO
import Text.Regex.TDFA

data Project = Project { valuesDir :: String, name :: String }

initProject :: String -> IO Project
initProject name = do
  validateName name
  homePath <- getEnv "HOME"
  return $ Project (homePath ++ "/.private-values") name
  where
    validateName :: String -> IO ()
    validateName name
      | (name =~ "^[-A-Za-z0-9_]+$" :: Int) == 0 = fail "The project name shold only contain [-A-Za-z0-9_]"
      | otherwise                                = return ()

path :: Project -> String
path (Project valuesDir name) = valuesDir ++ "/" ++ name

shouldExist :: Project -> IO ()
shouldExist project = let Project _ name = project
  in do
    isExist <- doesDirectoryExist $ path project
    case isExist of
      False -> fail $ "The project \"" ++ name ++ "\" isn't exist.\nRun `private-values new " ++ name ++ "`."
      True  -> return ()

create :: Project -> IO ()
create project = let Project valuesDir name = project
  in do
    createDirectoryIfMissing True valuesDir
    createDirectory $ path project
    valuesFile <- openFile (path project ++ "/values.yml") WriteMode
    hClose valuesFile

destroy :: Project -> IO ()
destroy project = do
  removeDirectoryRecursive $ path project
