module ParseArgs where

import Options.Applicative
import Data.Monoid ((<>))

data Args = Args { kleeDir :: FilePath
                 , threads :: Word
                 , benchmark :: Benchmark
                 }
  deriving (Eq, Show)

data Benchmark = Montyhall
               | ReservoirSample Double Double
               | ExpectedValue
               | Monotone Double
               | Freivalds Int
               | BloomFilter Double
               | CountMinSketch Double
               | CalcProb
               | PrintProb
  deriving (Eq, Show)

reservoirBench :: Parser Benchmark
reservoirBench = ReservoirSample
  <$> option auto (  long "pop-size"
                  <> short 'n'
                  <> help "the number of elements in the population" )
  <*> option auto (  long "reservoir-size"
                  <> short 'k'
                  <> help "the number of elements in the reservoir" )

monotoneBench :: Parser Benchmark
monotoneBench = Monotone
  <$> option auto (  long "domain-size"
                  <> short 'n'
                  <> help "the cardinality of the domain for the function \'f\'")

freivaldsBench :: Parser Benchmark
freivaldsBench = Freivalds
  <$> option auto (  long "iterations"
                  <> short 'k'
                  <> value 1
                  <> help "the number of iterations Freivalds' algorithm is run")

bloomFilterBench :: Parser Benchmark
bloomFilterBench = BloomFilter
  <$> option auto (  long "epsilon"
                  <> short 'e'
                  <> help "the expected false-positive error rate, epsilon")

countMinSketchBench :: Parser Benchmark
countMinSketchBench = CountMinSketch
  <$> option auto (  long "gamma"
                  <> short 'g'
                  <> help "the expected probability of getting a miscount above epsilon rate, gamma")

parseArgs :: Parser Args
parseArgs = Args
  <$> strOption (  long "klee-output-dir"
                <> short 'd'
                <> metavar "DIR"
                <> help "path to the directory containing the \"_paths\", \"_winning\", and \"_dists\" files" )
  <*> option auto (  long "threads"
                  <> short 't'
                  <> metavar "NUM_THREADS"
                  <> value 1
                  <> help "number of threads to run Z3 with" )
  <*> subparser (  command "montyhall" (info (pure Montyhall) $ progDesc "run the Montyhall benchmark")
                <> command "reservoir-sample" (info reservoirBench $ progDesc "run the reservoir sample benchmark")
                <> command "expected-value" (info (pure ExpectedValue) $ progDesc "calculate the expected value")
                <> command "monotone-binary-search" (info monotoneBench $ progDesc "run the monotone binary serach benchmark")
                <> command "freivalds" (info freivaldsBench $ progDesc "run the Freivalds' benchmark")
                <> command "bloom-filter" (info bloomFilterBench $ progDesc "run the Bloom Filter benchmark")
                <> command "countminsketch" (info countMinSketchBench $ progDesc "run the CountMinSketch benchmark")
                <> command "calculate-prob" (info (pure CalcProb) $ progDesc "calculate the raw probability (not guaranteed to be maximal or minimal)")
                <> command "print-prob" (info (pure PrintProb) $ progDesc "print the SMTLIBv2 string representing the probability sum"))

runArgsParser :: IO Args
runArgsParser = execParser opts
  where opts = info (parseArgs <**> helper)
          (  fullDesc
          <> header "plinko - a formal verification tool for randomized programs using symbolic execution" )
