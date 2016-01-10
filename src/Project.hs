{-# LANGUAGE OverloadedStrings #-}

module Project where

import Control.Lens ( (^.), (^?), (&), (?~), at )
import Control.Monad ( unless )
import Data.Aeson.Lens ( key, _Object, _String )
import Data.HashMap.Strict ( keys )
import Data.Maybe ( fromMaybe )
import qualified Data.Text as Text ( pack, unpack )
import qualified Data.Text.Encoding as Text ( decodeUtf8 )
import qualified Data.Text.IO as Text ( writeFile )
import Data.Yaml ( encode, object, Value ( String ) )
import FileUtil ( absolutize )
import System.Directory ( createDirectory, createDirectoryIfMissing, doesFileExist, doesDirectoryExist, getDirectoryContents, getHomeDirectory, removeDirectoryRecursive )
import System.FilePath ( takeBaseName )
import System.IO ( hClose, IOMode ( WriteMode ), openFile )
import Text.Regex.TDFA ( (=~) )
import YamlUtil ( decodeYamlFile )

listProjectNames :: IO [String]
listProjectNames =
  do ProjectConfig valuesDir <- getProjectConfig
     paths <- getDirectoryContents valuesDir
     return [ path | path <- map takeBaseName paths, not $ path =~ ("^[\\.]*$" :: String) ]

data ProjectConfig = ProjectConfig { valuesDir :: String }

getProjectConfig :: IO ProjectConfig
getProjectConfig =
  do homePath <- getHomeDirectory
     doesRcFileExist <- doesFileExist $ homePath ++ "/private-values.rc"
     if doesRcFileExist then
       do config <- decodeYamlFile $ homePath ++ "/private-values.rc"
          valuesDir <- absolutize $ Text.unpack $ config ^. key "values-dir" . _String
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
      | (name =~ ("^[-A-Za-z0-9_]+$" :: String) :: Int) == 0 = fail "The project name shold only contain [-A-Za-z0-9_]"
      | otherwise                                = return ()

path :: Project -> String
path (Project (ProjectConfig valuesDir) name) = valuesDir ++ "/" ++ name

shouldExist :: Project -> IO ()
shouldExist project =
  let Project _ name = project
  in do isExist <- doesDirectoryExist $ path project
        unless isExist $ fail $ "The project \"" ++ name ++ "\" isn't exist.\nRun `private-values new " ++ name ++ "`."

create :: Project -> IO ()
create project =
  let Project (ProjectConfig valuesDir) name = project
  in do createDirectoryIfMissing True valuesDir
        createDirectory $ path project
        valuesFile <- openFile (path project ++ "/values.yml") WriteMode
        hClose valuesFile

destroy :: Project -> IO ()
destroy project = removeDirectoryRecursive $ path project

getKeys :: Project -> IO [String]
getKeys project =
  let valuesPath = path project ++ "/values.yml"
  in do values <- decodeYamlFile valuesPath
        return $ fmap Text.unpack $ keys (values ^. _Object)

setValue :: Project -> String -> String -> IO ()
setValue project k v =
  let valuesPath = path project ++ "/values.yml"
  in do values <- decodeYamlFile valuesPath
        let yaml = encode $ values & _Object . at (Text.pack k) ?~ String (Text.pack v)
        Text.writeFile valuesPath $ Text.decodeUtf8 yaml

getValue :: Project -> String -> IO String
getValue project k =
  do values <- decodeYamlFile $ path project ++ "/values.yml"
     return $ Text.unpack (values ^. key (Text.pack k) . _String)
