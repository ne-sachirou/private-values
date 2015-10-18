module Project where

import Codec.Binary.UTF8.String ( encodeString )
import Control.Monad ( unless )
import Data.Map.Lazy ( insert, keys )
import qualified Data.Text.Encoding as Text
import qualified Data.Text.IO as Text
import Data.Yaml ( encode )
import Data.Yaml.YamlLight ( parseYaml, parseYamlFile )
import FileUtil
import System.Directory
import System.FilePath ( takeBaseName )
import System.IO
import Text.Regex.TDFA
import YamlUtil

listProjectNames :: IO [String]
listProjectNames =
  do ProjectConfig valuesDir <- getProjectConfig
     paths <- getDirectoryContents valuesDir
     return [ path | path <- map takeBaseName paths, not $ path =~ "^[\\.]*$" ]

data ProjectConfig = ProjectConfig { valuesDir :: String }

getProjectConfig :: IO ProjectConfig
getProjectConfig =
  do homePath <- getHomeDirectory
     doesRcFileExist <- doesFileExist $ homePath ++ "/private-values.rc"
     if doesRcFileExist then do
       config <- parseYamlFile $ homePath ++ "/private-values.rc"
       valuesDir <- absolutize $ getValueFromYL "values-dir" config
       return $ ProjectConfig valuesDir
     else
       return $ ProjectConfig (homePath ++ "/.private-values")

data Project = Project { config :: ProjectConfig, name :: String }

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
    unless isExist $ fail $ "The project \"" ++ name ++ "\" isn't exist.\nRun `private-values new " ++ name ++ "`."

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

getKeys :: Project -> IO [String]
getKeys project =
  let valuesPath = path project ++ "/values.yml"
  in do
    yValues <- parseYamlFile valuesPath
    return $ keys $ toMapFromYL yValues

setValue :: Project -> String -> String -> IO ()
setValue project key value =
  let valuesPath = path project ++ "/values.yml"
  in do
    yValues <- parseYamlFile valuesPath
    let yaml = Text.decodeUtf8 $ encode $ insert key value $ toMapFromYL yValues
    Text.writeFile valuesPath yaml

getValue :: Project -> String -> IO String
getValue project key =
  do values <- parseYamlFile $ path project ++ "/values.yml"
     return $ getValueFromYL (encodeString key) values
