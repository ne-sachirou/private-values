module Project where

import Data.Map.Lazy       ( insert )
import Data.Yaml           ( encodeFile )
import Data.Yaml.YamlLight ( parseYamlFile )
import FileUtil
import System.Directory
import System.FilePath
import System.IO
import Text.Regex.TDFA
import YamlUtil

data ProjectConfig = ProjectConfig { valuesDir :: String }

data Project = Project { config :: ProjectConfig, name :: String }

getProjectConfig :: IO ProjectConfig
getProjectConfig =
  do homePath <- getHomeDirectory
     doesRcFileExist <- doesFileExist $ homePath ++ "/private-values.rc"
     if doesRcFileExist then do
       config <- parseYamlFile $ homePath ++ "/private-values.rc"
       valuesDir <- absolutize $ getValueFromYL "values-dir" config
       return $ ProjectConfig valuesDir
     else do
       return $ ProjectConfig (homePath ++ "/.private-values")

listProjectNames :: IO [String]
listProjectNames =
  do ProjectConfig valuesDir <- getProjectConfig
     paths <- getDirectoryContents valuesDir
     return [ path | path <- map takeBaseName paths, not $ path =~ "^[\\.]*$" ]

initProject :: String -> IO Project
initProject name =
  do validateName name
     config <- getProjectConfig
     return $ Project config name
  where
    validateName :: String -> IO ()
    validateName name
      | (name =~ "^[-A-Za-z0-9_]+$" :: Int) == 0 = fail "The project name shold only contain [-A-Za-z0-9_]"
      | otherwise                                = return ()

path :: Project -> String
path (Project (ProjectConfig valuesDir) name) = valuesDir ++ "/" ++ name

shouldExist :: Project -> IO ()
shouldExist project =
  let Project _ name = project
  in do
    isExist <- doesDirectoryExist $ path project
    case isExist of
      False -> fail $ "The project \"" ++ name ++ "\" isn't exist.\nRun `private-values new " ++ name ++ "`."
      True  -> return ()

create :: Project -> IO ()
create project =
  let Project (ProjectConfig valuesDir) name = project
  in do
    createDirectoryIfMissing True valuesDir
    createDirectory $ path project
    valuesFile <- openFile (path project ++ "/values.yml") WriteMode
    hClose valuesFile

destroy :: Project -> IO ()
destroy project = removeDirectoryRecursive $ path project

setValue :: Project -> String -> String -> IO ()
setValue project key value =
  let valuesPath = path project ++ "/values.yml"
  in do
    yValues <- parseYamlFile valuesPath
    encodeFile valuesPath $ insert key value $ toMapFromYL yValues

getValue :: Project -> String -> IO String
getValue project key =
  do values <- parseYamlFile $ path project ++ "/values.yml"
     return $ getValueFromYL key values
