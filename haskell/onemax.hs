import Data.Sequence hiding (take)
import Data.Time
import Data.Functor
import Data.Foldable hiding (concat)
import Control.Applicative
import Control.DeepSeq
import System.Random


iterations = 100000

onemax :: Seq Bool -> Int
onemax v = Data.Foldable.sum $ fmap fromEnum v

benchmark :: Int -> IO ()
benchmark n = do
  -- Random vector generation
  gen <- newStdGen
  let rbools = randoms gen :: [Bool]
  let vector = fromList $ take n rbools

  -- Timing
  start <- (vector `deepseq` getCurrentTime)

  -- Counting
  let count = Prelude.sum $ map (\x -> onemax vector) [1..iterations]

  stop <- (count `deepseq` getCurrentTime)
  let diffTime = diffUTCTime stop start

  -- Printing
  putStrLn $ concat ["Haskell-Sequence, ", show n, ", ", show diffTime]

main :: IO ()
main = do
  sequence $ Prelude.map benchmark ((2^) <$> [4..16])
  return ()

