import Test.DocTest
import System.FilePath.Glob (glob)

main = glob "src/**/*.hs" >>= doctest
