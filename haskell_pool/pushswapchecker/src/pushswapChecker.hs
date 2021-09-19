module PushswapChecker(s, sc, p, r, rr, rrc, rrr, retrieveOperations, readInt,
retrieveList, executeOperation, executeOperations, checkSort, isSort,
checkOperations) where

import System.Exit
import Data.Tuple

s :: [Int] -> [Int]
s [] = []
s [a] = [a]
s (l:l':ls) = l' : l : ls

sc :: [Int] -> [Int] -> ([Int], [Int])
sc la lb = (s la, s lb)

p :: [Int] -> [Int] -> ([Int], [Int])
p [] l = ([], l)
p (l1:l1s) l2 = (l1s, l1 : l2)

r :: [Int] -> [Int]
r [] = []
r (l:ls) = ls ++ [l]

rr :: [Int] -> [Int] -> ([Int], [Int])
rr la lb = (r la, r lb)

rrc :: [Int] -> [Int]
rrc [] = []
rrc l = last l : init l

rrr :: [Int] -> [Int] -> ([Int], [Int])
rrr la lb = (rrc la, rrc lb)

retrieveOperations :: IO [String]
retrieveOperations = words <$> getLine

readInt :: String -> Maybe Int
readInt [] = Nothing
readInt str =   case reads str of
                [(val, "")] -> Just val
                _ -> Nothing

retrieveList :: [String] -> IO [Maybe Int]
retrieveList [] = pure []
retrieveList arr = pure (map (readInt::String -> Maybe Int) arr)

executeOperation :: String -> ([Int], [Int]) -> ([Int], [Int])
executeOperation "sa" (la, lb) = (s la, lb)
executeOperation "sb" (la, lb) = (la, s lb)
executeOperation "sc" (la, lb) = sc la lb
executeOperation "pa" (la, lb) = swap (p lb la)
executeOperation "pb" (la, lb) = p la lb
executeOperation "ra" (la, lb) = (r la, lb)
executeOperation "rb" (la, lb) = (la, r lb)
executeOperation "rr" (la, lb) = rr la lb
executeOperation "rra" (la, lb) = (rrc la, lb)
executeOperation "rrb" (la, lb) = (la, rrc lb)
executeOperation "rrr" (la, lb) = rrr la lb
executeOperation _ _ = ([], [])

executeOperations :: [String] -> [Int] -> [Int] -> ([Int], [Int])
executeOperations [] la lb = (la, lb)
executeOperations _ [] [] = ([], [])
executeOperations (op:ops) la lb = executeOperations ops la' lb'
    where
        (la', lb') = executeOperation op (la, lb)

isSort :: ([Int], [Int]) -> Bool
isSort ([], []) = True
isSort ([], _) = False
isSort (la:la':las, []) = la <= la' && isSort (la':las, [])
isSort ([_], []) = True
isSort (_, _) = False

avOps :: [String]
avOps = ["sa", "sb", "sc", "pa", "pb", "ra", "rb", "rr", "rra", "rrb", "rrr"]

checkOperations :: [String] -> Bool
checkOperations = foldr (\ op -> (&&) (op `elem` avOps)) True

checkSort :: ([Int], [Int]) -> IO ()
checkSort l
    | isSort l = putStrLn "OK"
    | otherwise = putStr "KO: " >> print l >> exitWith (ExitFailure 84)
