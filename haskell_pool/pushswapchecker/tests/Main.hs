module Main where

import Test.HUnit
import TestPushswapChecker

main :: IO Counts
main = do
    runTestTT pushswapCheckerList
