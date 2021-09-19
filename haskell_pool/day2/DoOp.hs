--
-- EPITECH PROJECT, 2021
-- day2
-- File description:
-- DoOp
--

import System.Environment
import System.Exit

main :: IO ()
main = getArgs >>= out . fct
        where
                fct [x, "+", y] = maybeDo (+) (readInt x) (readInt y)
                fct [x, "-", y] = maybeDo (-) (readInt x) (readInt y)
                fct [x, "*", y] = maybeDo (*) (readInt x) (readInt y)
                fct [x, "/", "0"] = Nothing
                fct [x, "/", y] = maybeDo div (readInt x) (readInt y)
                fct [x, "%", "0"] = Nothing
                fct [x, "%", y] = maybeDo mod (readInt x) (readInt y)
                fct _ = Nothing

out :: Maybe Int -> IO ()
out (Just a) = print a
out Nothing = exitWith $ ExitFailure 84

myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem nb (x:xs)
        | x == nb = True
        | otherwise = myElem nb xs

safeDiv :: Int -> Int -> Maybe Int
safeDiv _  0 = Nothing
safeDiv a b = Just (a `div` b)

safeNth :: [a] -> Int -> Maybe a
safeNth [] _ = Nothing
safeNth [a] b | b < 0 = Nothing
safeNth (x:xs) 0 = Just x
safeNth (x:xs) b = safeNth xs (b -1)

safeSucc :: Maybe Int -> Maybe Int
safeSucc Nothing = Nothing
safeSucc (Just a) = Just (a + 1)

myLookup :: Eq a => a -> [(a, b)] -> Maybe b
myLookup _ [] = Nothing
myLookup nb ((key, val):xs)
    | nb == key = Just val
    | otherwise = myLookup nb xs

maybeDo :: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
maybeDo _ Nothing _ = Nothing
maybeDo  _ _ Nothing  = Nothing
maybeDo f (Just a) (Just b) = Just $ f a b

readInt :: [Char] -> Maybe Int
readInt [] = Nothing
readInt s = case reads s :: [(Int, [Char])] of
        [(val, "")] -> Just val
        _ -> Nothing

getLineLength :: IO Int
getLineLength = length <$> getLine

printAndGetLength :: String -> IO Int
printAndGetLength s = putStrLn s >> return (length s)

printBox :: Int -> IO ()
printBox nb | nb <= 0 = return ()
printBox 1 = putStrLn "++"
printBox nb =  putStrLn top_bot >> putStr (unlines body) >> putStrLn top_bot
    where   len = (nb - 1) * 2
            body = replicate (nb - 2) ("|" ++ replicate len ' ' ++ "|")
            top_bot = "+" ++ replicate len '-' ++ "+"

concatLines :: Int -> IO String
concatLines nb | nb <= 0 = return ""
concatLines nb = do
        u <- getLine
        p <- concatLines (nb - 1)
        return (u ++ p)

getInt :: IO (Maybe Int)
getInt = readInt <$> getLine