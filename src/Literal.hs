module Literal where

import Language.Haskell.TH
import Language.Haskell.TH.Quote

literally :: String -> Q Exp
literally = return . LitE . StringL

literal :: QuasiQuoter
literal = QuasiQuoter { quoteExp = literally }

literalFile :: QuasiQuoter
literalFile = quoteFile literal
