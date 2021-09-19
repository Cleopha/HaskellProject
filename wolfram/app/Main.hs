module Main where

import Lib
import System.IO
import System.Exit ( exitSuccess, exitWith, ExitCode(ExitFailure), exitFailure)
import System.Environment
import Text.Read
import Data.Bits
import Data.List


data Conf = Conf { rule :: Int
                ,  start :: Int
                ,  line :: Int
                ,  window :: Int
                ,  move :: Int

} deriving (Show)

defaultConf :: Conf
defaultConf = Conf {rule = -1, start = 0, line = -1, window = 80, move = 0}

checkRules :: Int -> Maybe Int
checkRules s = case s of
                s |  s >= 0  && s <= 255 -> Just s
                _ -> Nothing

positiveInt :: String -> Maybe Int
positiveInt s = case readMaybe s of
            Just s | s > 0 -> Just s
            _ -> Nothing

getOpts :: Conf -> [String] -> Either String Conf
getOpts c [] = Right c
getOpts c ("--rule":v:vs) = case positiveInt v >>= checkRules of
                            Just i -> getOpts c{rule = i} vs
                            Nothing  -> Left "on parse rule"
getOpts c ("--start":v:vs) = case positiveInt v of
                            Just i -> getOpts c{start = i} vs
                            Nothing  -> Left "on parse start"
getOpts c ("--lines":v:vs) = case positiveInt v of
                            Just i -> getOpts c{line = i} vs
                            Nothing  -> Left "on parse lines"
getOpts c ("--window":v:vs) = case positiveInt v of
                            Just i -> getOpts c{window = i} vs
                            Nothing  -> Left "on parse window"
getOpts c ("--move":v:vs) = case readMaybe v of
                            Just i -> getOpts c{move = i} vs
                            Nothing -> Left "on parse move"
getOpts c _ = Left "No good args"

exitError :: String -> IO()
exitError msg = hPutStrLn stderr ("Error: " ++ msg) >> exitStat
    where
        exitStat = exitWith (ExitFailure 84)

man :: IO()
man = mapM_  putStrLn
    ["USAGE:", "", "\t./wolfram [Options]", "", "Options:", "",
    "\t-h\t\tdisplay usage", "\t--help\t\tdisplay usage",
    "\t--rule\t\trule to generate [0:255] (Required)",
    "\t--start\t\tfirst generation to display [<0] (Default: 0)",
    "\t--lines\t\tnumber of lines to displau [<0] (Default: infinity)",
    "\t--window\tnumber of cells by line [<0] (Default: 80)",
    "\t--move\t\ttranslation to apply (Default: 0)"]

doSomething :: [String] -> IO()
doSomething ["-h"] = man
doSomething ["--help"] = man
doSomething s = case getOpts defaultConf s of
    Left msg -> exitError msg
    Right Conf {rule = -1} -> exitError "--rule not define"
    Right c@(Conf r _ l w m) -> main " * "
        where
            main = mL c{move = w `div` 2 + m, window = w}

makeX :: (Int, Int, Int) -> Int
makeX (l,m,r) = r + 2 * m + 4 * l

addCharStr :: String -> String
addCharStr s = "  " ++ s ++ "  "

convertChar :: Char -> Int
convertChar '*' = 1
convertChar ' ' = 0

checkBit :: Int -> Int -> Char
checkBit r n | testBit r n = '*' | otherwise = ' '

recreateStr :: String -> Int -> Char
recreateStr [s,sn,sa] r = checkBit r takeIndex
    where
        takeIndex = makeX (convertChar s, convertChar sn, convertChar sa)

doAlgo :: String -> Int -> String
doAlgo [s,sn,sa] r = [recreateStr ([s] ++ [sn] ++ [sa]) r]
doAlgo (s:sn:sa:sx) r = recreateStr cat r : doAlgo ([sn] ++ [sa] ++ sx) r
    where
        cat = [s] ++ [sn] ++ [sa]

addSpace :: Int -> Int -> String -> IO()
addSpace w b s = putStrLn (window_begin ++ s ++ window_after)
    where
        window_begin = concat (replicate (w - 1) " ")
        window_after = concat (replicate (w - (1 + b)) " ")

deleteSpace :: Int -> String -> String
deleteSpace _ [] = []
deleteSpace 0 s = s
deleteSpace n (_:xs) = deleteSpace (n - 1) xs

gP :: String -> Int -> IO()
gP s i = putStrLn (reverse $ deleteSpace (mid + mod) skirt)
    where
        mid = i `div` 2
        mod | even i = 0 | otherwise = 1
        skirt = reverse $ deleteSpace mid s

mL :: Conf -> String -> IO ()
mL c@(Conf _ _ 0 _ _) s = putStr ""
mL c@(Conf r st l w m) s = case c of
 c@(Conf _ 0 _ _ m)  | m <= 1 -> gP s (length s - w) >> mL c{line = l - 1} algo
 c@(Conf _ 0 _ _ _) -> addSpace m b s >> mL c{line = l - 1, move = m - 1} algo
 Conf{} -> putStr "" >> mL c{start = st - 1, move = m - 1} algo
 where
    b | even w = 1 | otherwise = 0 -- isPair
    algo = doAlgo (addCharStr s) r

main :: IO ()
main = getArgs >>= doSomething