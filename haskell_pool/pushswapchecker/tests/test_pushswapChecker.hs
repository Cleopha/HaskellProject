module TestPushswapChecker(pushswapCheckerList) where

import PushswapChecker
import Test.HUnit


testSClassic :: Test
testSClassic = TestCase (assertEqual name expected got)
    where
        name = "s [1, 2]"
        got = s [1, 2]
        expected = [2, 1]

testSOneElem :: Test
testSOneElem = TestCase (assertEqual name expected got)
    where
        name = "s [1]"
        got = s [1]
        expected = [1]

testSNoElem :: Test
testSNoElem = TestCase (assertEqual name expected got)
    where
        name = "s []"
        got = s []
        expected = []

testScClassic :: Test
testScClassic = TestCase (assertEqual name expected got)
    where
        name = "sc [1, 2] [5, 6]"
        got = sc [1, 2] [5, 6]
        expected = ([2, 1], [6, 5])

testScOneElem :: Test
testScOneElem = TestCase (assertEqual name expected got)
    where
        name = "sc [1] [5]"
        got = sc [1] [5]
        expected = ([1], [5])

testScNoElem :: Test
testScNoElem = TestCase (assertEqual name expected got)
    where
        name = "sc [] []"
        got = sc [] []
        expected = ([], [])

testPClassic :: Test
testPClassic = TestCase (assertEqual name expected got)
    where
        name = "p [1, 2] [5, 6]"
        got = p [1, 2] [5, 6]
        expected = ([2], [1, 5, 6])

testPOneElem :: Test
testPOneElem = TestCase (assertEqual name expected got)
    where
        name = "p [1] [5]"
        got = p [1] [5]
        expected = ([], [1, 5])

testPNoElem :: Test
testPNoElem = TestCase (assertEqual name expected got)
    where
        name = "p [] []"
        got = p [] []
        expected = ([], [])

testRClassic :: Test
testRClassic = TestCase (assertEqual name expected got)
    where
        name = "r [1, 2, 3]"
        got = r [1, 2, 3]
        expected = [2, 3, 1]

testROneElem :: Test
testROneElem = TestCase (assertEqual name expected got)
    where
        name = "r [1]"
        got = r [1]
        expected = [1]

testRNoElem :: Test
testRNoElem = TestCase (assertEqual name expected got)
    where
        name = "r []"
        got = r []
        expected = []

testRrClassic :: Test
testRrClassic = TestCase (assertEqual name expected got)
    where
        name = "rr [1, 2, 3] [5, 6, 7]"
        got = rr [1, 2, 3] [5, 6, 7]
        expected = ([2, 3, 1], [6, 7, 5])

testRrOneElem :: Test
testRrOneElem = TestCase (assertEqual name expected got)
    where
        name = "rr [1] [5]"
        got = rr [1] [5]
        expected = ([1], [5])

testRrNoElem :: Test
testRrNoElem = TestCase (assertEqual name expected got)
    where
        name = "rr [] []"
        got = rr [] []
        expected = ([], [])

testRrcClassic :: Test
testRrcClassic = TestCase (assertEqual name expected got)
    where
        name = "rrc [1, 2, 3]"
        got = rrc [1, 2, 3]
        expected = [3, 1, 2]

testRrcOneElem :: Test
testRrcOneElem = TestCase (assertEqual name expected got)
    where
        name = "rrc [1]"
        got = rrc [1]
        expected = [1]

testRrcNoElem :: Test
testRrcNoElem = TestCase (assertEqual name expected got)
    where
        name = "rrc []"
        got = rrc []
        expected = []

testRrrClassic :: Test
testRrrClassic = TestCase (assertEqual name expected got)
    where
        name = "rrr [1, 2, 3] [5, 6, 7]"
        got = rrr [1, 2, 3] [5, 6, 7]
        expected = ([3, 1, 2], [7, 5, 6])

testRrrOneElem :: Test
testRrrOneElem = TestCase (assertEqual name expected got)
    where
        name = "rrr [1] [5]"
        got = rrr [1] [5]
        expected = ([1], [5])

testRrrNoElem :: Test
testRrrNoElem = TestCase (assertEqual name expected got)
    where
        name = "rrr [] []"
        got = rrr [] []
        expected = ([], [])

testReadIntClassic :: Test
testReadIntClassic = TestCase (assertEqual name expected got)
    where
        name = "readInt \"42\""
        got = readInt "42"
        expected = Just 42

testReadIntNegative :: Test
testReadIntNegative = TestCase (assertEqual name expected got)
    where
        name = "readInt \"-84\""
        got = readInt "-84"
        expected = Just (-84)

testReadIntString :: Test
testReadIntString = TestCase (assertEqual name expected got)
    where
        name = "readInt \"str\""
        got = readInt "str"
        expected = Nothing

testReadIntMix1 :: Test
testReadIntMix1 = TestCase (assertEqual name expected got)
    where
        name = "readInt \"21test\""
        got = readInt "21test"
        expected = Nothing

testReadIntMix2 :: Test
testReadIntMix2 = TestCase (assertEqual name expected got)
    where
        name = "readInt \"read84\""
        got = readInt "read84"
        expected = Nothing

testReadIntMix3 :: Test
testReadIntMix3 = TestCase (assertEqual name expected got)
    where
        name = "readInt \"paris69KB\""
        got = readInt "paris69KB"
        expected = Nothing

--testRetrieveListClassic :: Test
--testRetrieveListClassic = TestCase (assertEqual name expected got)
--    where
--        name = "retrieveList [\"21\", \"42\", \"84\", \"69\", \"-84\", \"-3\"]"
--        got = retrieveList ["21", "42", "84", "69", "-84", "-3"]
--        expected = pure ([Just 21, Just 42, Just 84, Just 69, Just (-84), Just (-3)]) :: IO [Maybe Int]

--testRetrieveListInvalid :: Test
--testRetrieveListInvalid = TestCase (assertEqual name expected got)
--    where
--        name = "retrieveList [\"test\", \"42\", \"Epitech\"]"
--        got =  retrieveList ["test", "42", "Epitech"]
--        expected = pure ([Nothing, Just 42, Nothing]) :: IO [Maybe Int]

testIsSortSorted :: Test
testIsSortSorted = TestCase (assertEqual name expected got)
    where
        name = "isSort ([-84, -69, -42, -21, 13, 21, 42, 69, 84], [])"
        got = isSort ([-84, -69, -42, -21, 13, 21, 42, 69, 84], [])
        expected = True

testIsSortNotSorted :: Test
testIsSortNotSorted = TestCase (assertEqual name expected got)
    where
        name = "isSort ([-69, -42, -84, 13, 21, 69, -21, 42, 84], [])"
        got = isSort ([-69, -42, -84, 13, 21, 69, -21, 42, 84], [])
        expected = False

testIsSortEmpty :: Test
testIsSortEmpty = TestCase (assertEqual name expected got)
    where
        name = "isSort ([], [])"
        got = isSort ([], [])
        expected = True

testCheckOperationsValid :: Test
testCheckOperationsValid = TestCase (assertEqual name expected got)
    where
        name = "checkOperations [\"pa\", \"sc\", \"rr\", \"rrr\"]"
        got = checkOperations ["pa", "sc", "rr", "rrr"]
        expected = True

testCheckOperationsInvalid :: Test
testCheckOperationsInvalid = TestCase (assertEqual name expected got)
    where
        name = "checkOperations [\"yolo\", \"ra\"]"
        got = checkOperations ["yolo", "ra"]
        expected = False

pushswapCheckerList :: Test
pushswapCheckerList =
    TestList   [testSClassic, testSOneElem, testSNoElem, testScClassic,
                testScOneElem, testScNoElem, testPClassic, testPOneElem,
                testPNoElem, testRClassic, testROneElem, testRNoElem,
                testRrClassic, testRrOneElem, testRrNoElem, testRrcClassic,
                testRrcOneElem, testRrcNoElem, testRrrClassic, testRrrOneElem,
                testRrrNoElem, testReadIntClassic, testReadIntNegative,
                testReadIntString, testReadIntMix1, testReadIntMix2,
                testReadIntMix3, testIsSortSorted, testIsSortNotSorted,
                testIsSortEmpty, testCheckOperationsValid,
                testCheckOperationsInvalid]
