module Main where

import PushswapChecker
import System.Environment
import System.Exit
import Data.Maybe

main :: IO ()
main = do
    args <- getArgs
    operations <- retrieveOperations
    l <- retrieveList args
    if checkOperations operations && notElem Nothing l then
        let l' = map fromJust l in
            let lists = executeOperations operations l' [] in
                checkSort lists
        else putStrLn "KO: Wrong input" >> exitWith (ExitFailure 84)
