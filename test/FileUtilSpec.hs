module FileUtilSpec where

import Data.List ( isPrefixOf )
import FileUtil
import System.Directory ( getHomeDirectory )
import Test.Hspec
import Test.Hspec.QuickCheck ( prop )
import Test.QuickCheck

genStringStartWithTilde :: Gen String
genStringStartWithTilde = fmap ("~/" ++) arbitrary

spec :: Spec
spec =
  describe "absolutize" $ do
    it "Root path should be expanded to root" $ do
      actual <- absolutize "/"
      actual `shouldBe` "/"

    it "Home path should be expanded to home" $ do
      homePath <- getHomeDirectory
      actual <- absolutize "~"
      actual `shouldBe` (homePath ++ "/")
      
    prop "~/**/** should be expanded to home" $ forAll genStringStartWithTilde $ \path -> do
      homePath <- getHomeDirectory
      absolutizedPath <- absolutize path
      (homePath `isPrefixOf` absolutizedPath) `shouldBe` True
