--
-- EPITECH PROJECT, 2021
-- day1
-- File description:
-- My
--

mySucc :: Int -> Int
mySucc n = n + 1

myIsNeg :: Int -> Bool
myIsNeg a = a < 0

myAbs :: Int -> Int
myAbs a = if a < 0 then a * (-1) else a

myMin :: Int -> Int -> Int
myMin x y = if x < y then x else y

myMax :: Int -> Int -> Int
myMax x y = if x > y then x else y

myTuple :: a -> b -> (a, b)
myTuple a b = (a, b)

myTruple :: a -> b -> c -> (a, b, c)
myTruple a b c = (a, b, c)

myFst :: (a, b) -> a
myFst (a, b) = a

mySnd :: (a, b) -> b
mySnd (a, b) = b

mySwap :: (a, b) -> (b, a)
mySwap (a, b) = (b, a)

myHead :: [a] -> a
myHead [] = error "e"
myHead (x:_) = x

myTail :: [a] -> [a]
myTail (_:x) = x
myTail [] = error "e"

myLength :: [a] -> Int
myLength [] = 0
myLength (_:a)  = 1 + myLength a

myNth :: [a] -> Int -> a
myNth [] _ = error "empty list"
myNth [a] b | b < 0 = error "index neg"
myNth (x:xs) 0 = x
myNth (x:xs) b = myNth xs (b -1)

myTake :: Int -> [a] -> [a]
myTake 0 _ = []
myTake _ [] = []
myTake nb (x:xs) =  x : myTake (nb -1) xs

myDrop :: Int -> [a] -> [a]
myDrop 0 a = a
myDrop _ [] = []
myDrop nb (x:xs) = myDrop (nb -1) xs

myAppend :: [a] -> [a] -> [a]
myAppend a [] = a
myAppend [] b = b
myAppend (x:xs) y = x : myAppend xs y

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myAppend (myReverse xs) [x]

myInit :: [a] -> [a]
myInit [] = error "empty list"
myInit [x] = []
myInit (x:xs) = x : myInit xs

myLast :: [a] -> a
myLast [] = error "empty list"
myLast [x] = x
myLast (x:xs) = myLast xs

myZip :: [a] -> [b] -> [(a ,b)]
myZip [] _ = []
myZip _ [] = []
myZip (x:xs) (y:ys) = (x, y) : myZip xs ys

myUnzip :: [(a, b)] -> ([a], [b])
myUnzip [] = ([], [])
myUnzip ((a, b):xs) = (a:as, b:bs)
    where
       (as, bs) = myUnzip xs

myMap :: (a -> b) -> [a] -> [b]
myMap _ [] = []
myMap f (a:as) = f a : myMap f as

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter _ [] = []
myFilter f (a:as)
    | f a = a : myFilter f as
    | otherwise = myFilter f as

myFoldl :: (b -> a -> b) -> b -> [a] -> b
myFoldl f b [] = b
myFoldl f b (a:as) =  myFoldl f (f b a) as

myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr f b = go
    where
    go [] = b
    go (a:as) = f a (go as)

myPartition :: (a -> Bool) -> [a] -> ([a], [a])
myPartition f [] = ([], [])
myPartition f (x:xs)
    | f x = (x : as, bs)
    | otherwise  = (as, x : bs)
    where
        (as, bs) = myPartition f xs

myQuickSort :: (a -> a -> Bool) -> [a] -> [a]
myQuickSort f [] = []
myQuickSort f (l:ls) = myQuickSort f false `ap` [l] `ap` myQuickSort f true
    where
        p = myPartition (f l) ls
        true = myFst p
        false = mySnd p
        ap = myAppend