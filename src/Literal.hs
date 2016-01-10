module Literal
  ( literalFile
  ) where

import Language.Haskell.TH
import Language.Haskell.TH.Quote

literal :: QuasiQuoter
literal = QuasiQuoter { quoteExp = return . LitE . StringL }

literalFile :: QuasiQuoter
literalFile = quoteFile literal
