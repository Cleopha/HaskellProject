module Parsing
    ( parseArgs
    , checkArgs
    , parseFile
    ) where

import Text.Read
import System.Exit
import GHC.Float
import StringOperations
import ReadOperations
import DataTypes

defaultInput :: Config
defaultInput = Config {colorsNumber = -1, convergenceLimit = -1, file = ""}

parseArgs :: [String] -> Maybe Config
parseArgs [] = Just defaultInput
parseArgs ("-n":x:xs) = case readColor x of
    Just nb -> fmap (\config -> config {colorsNumber = nb}) (parseArgs xs)
    Nothing -> Nothing
parseArgs ("-l":x:xs) = case readPositiveFloat x of
    Just nb -> fmap (\config -> config {convergenceLimit = nb}) (parseArgs xs)
    Nothing -> Nothing
parseArgs ("-f":x:xs) = fmap (\config -> config {file = x}) (parseArgs xs)
parseArgs (x:xs) = Nothing

checkArgs :: Config -> IO ()
checkArgs conf@(Config cNb convLimit f) =
    if cNb == -1 || convLimit == -1 || f == ""
    then putStrLn "Invalid argument" >> exitWith (ExitFailure 84)
    else return ()


retrieveColors :: Int -> Int -> [String] -> Maybe Pixel
retrieveColors x y (rs:gs:bs:s) =
    case readColor rs of
        Just r -> case readColor gs of
            Just g -> case readColor bs of
                Just b -> Just Pixel {point = Point {x = x, y = y},
                    color = Color {r = int2Float r, g = int2Float g,
                        b = int2Float b}}
                Nothing -> Nothing
            Nothing -> Nothing
        Nothing -> Nothing

retrieveStringContent :: String -> Maybe Pixel
retrieveStringContent str =
    case readPositiveInt xs of
        Just x -> case readPositiveInt ys of
            Just y -> retrieveColors x y (rs:gs:bs:s)
            Nothing -> Nothing
        Nothing -> Nothing
    where (xs:ys:rs:gs:bs:s) = stringToArray str "(), \n"

parseFile :: [String] -> Maybe [Pixel]
parseFile (line:lines) = case retrieveStringContent line of
        Just pixel -> case parseFile lines of
            Just pixelArray -> Just (pixel : pixelArray)
            Nothing -> Nothing
        Nothing -> Nothing
parseFile [] = Just []
