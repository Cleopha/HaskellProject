module Main where

import System.Environment
import System.Exit
import System.IO
import DataTypes
import Parsing
import KMeansAlgorithm

help :: IO ()
help =  putStrLn "USAGE: ./imageCompressor -n N -l L -f F\n" >>
        putStrLn "\tN\tnumber of colors in the final image" >>
        putStrLn "\tL\tconvergence limit" >>
        putStrLn "\tF\tpath to the file containing the colors of the pixels"

main :: IO ()
main = do
    args <- getArgs
    case parseArgs args of
        Just conf -> do
            checkArgs conf
            content <- readFile (file conf)
            case parseFile (lines content) of
                Just pxArr -> kMeansAlgorithm conf pxArr >> exitWith ExitSuccess
                Nothing -> putStrLn "Invalid File" >> exitWith (ExitFailure 84)
        Nothing -> help >> exitWith (ExitFailure 84)
