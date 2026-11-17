import Data.Char (toUpper)
import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  let input = args !! 0
  let output = args !! 1
  txt <- readFile input
  let txtM = map toUpper txt
  writeFile output txtM