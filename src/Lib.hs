module Lib
    ( cmdNew,
      cmdRm,
      cmdSet,
      cmdGet,
      cmdPath,
      cmdHelp
    ) where

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
  putStrLn "\
            \ private-values [COMMAND]\n\
            \ \n\
            \ COMMAND\n\
            \ --\n\
            \ new PROJECT          \tCreate new private values.\n\
            \ rm PROJECT           \tRemove private values.\n\
            \ set PROJECT.KEY VALUE\tSet a private value.\n\
            \ get PROJECT.KEY      \tGet the private value.\n\
            \ path PROJECT         \tPath to the private files.\n\
            \ \n\
            \ ~/private-values.rc\n\
            \ --\n\
            \ values-dir: ~/.private-values\n\
            \ password: PASSWORD\n\
            \ "
