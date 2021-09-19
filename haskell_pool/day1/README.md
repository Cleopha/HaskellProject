# Day1
## Summary
  - [GHC and GHCI](#ghc-and-ghci)
  - [**Step 1** - Basic Functions](#step-1---basic-functions)
    - [Task 01](#task-01)
    - [Task 02](#task-02)
    - [Task 03](#task-03)
    - [Task 04](#task-04)
    - [Task 05](#task-05)
  - [**Step 2** - Tuples](#step-2---tuples)
    - [Task 06](#task-06)
    - [Task 07](#task-07)
    - [Task 08](#task-08)
    - [Task 09](#task-09)
    - [Task 10](#task-10)
  - [**Step 3** - Simple lists](#step-3---simple-lists)
    - [Task 11](#task-11)
    - [Task 12](#task-12)
    - [Task 13](#task-13)
    - [Task 14](#task-14)
    - [Task 15](#task-15)
    - [Task 16](#task-16)
    - [Task 17](#task-17)
    - [Task 18](#task-18)
    - [Task 19](#task-19)
    - [Task 20](#task-20)
    - [Task 21](#task-21)
    - [Task 22](#task-22)
  - [**Step 4** - Advanced lists](#step-4---advanced-lists)
    - [Task 23](#task-23)
    - [Task 24](#task-24)
    - [Task 25](#task-25)
    - [Task 26](#task-26)
    - [Task 27](#task-27)
    - [Task 28](#task-28)

## GHC and GHCI
For this functional pool, you will need **GHC**, The Glorious Glasgow Haskell Compilation System, in version 8 or superior (check the version installed in the official docker image if in doubt)  
You should have the commands ghc and ghci installed

> We will test your functions using GHCI, so you should use it to be sure everything works fine.  
> **GHCI** is the interactive version of GHC, which is very useful to test your functions:

```bash
ghci My.hs
Prelude> mySucc 41
42
```

## **Step 1** - Basic Functions
### Task 01

```hs
mySucc :: int -> int
```
A function which takes one Int as argument and returns its successor.  
> For example: mySucc 41 returns 42

### Task 02

```hs
myIsNeg :: Int -> Bool
```

> A function which takes one Int as argument and returns True if it’s negative or False otherwise.

### Task 03

```hs
myAbs :: Int -> Int
```

> A function which takes one Int as argument and returns it’s absolute value.

### Task 04

```hs
myMin :: Int -> Int -> Int
```

> A function which takes two Ints as arguments and returns the minimum of the two.

### Task 05

```hs
myMax :: Int -> Int -> Int
```

> A function which takes two Ints as arguments and returns the maximum of the two.

## **Step 2** - Tuples

Tuples are data structures which allow to "pack" values in groups.

### Task 06

```hs
myTuple :: a -> b -> (a, b)
```

> A function which takes two arguments and return a tuple of those.

### Task 07

```hs
myTruple :: a -> b -> c -> (a, b, c)
```

> A function which takes three arguments and return a tuple of those.

### Task 08

```hs
myFst :: (a, b) -> a
```

> A function which takes a tuple as argument and returns its first value.

### Task 09

```hs
mySnd :: (a, b) -> b
```

> A function which takes a tuple as argument and returns its second value.

### Task 10

```hs
mySwap :: (a, b) -> (b, a)
```

> A function which takes a tuple as argument and returns a new tuple, with it’s two values swaped.

## **Step 3** - Simple lists

### Task 11

```hs
myHead :: [a] -> a
```

> A function which takes a list as argument and returns its first value. If the list is empty, an exception is raised
with the function error.

### Task 12

```hs
myTail :: [a] -> [a]
```

> A function which takes a list as argument and returns a new list without its first element. If the list is empty, an exception is raised with the function error.

### Task 13

```hs
myLength :: [a] -> Int
```

> A function which takes a list as argument and returns the number of
elements in the list.

### Task 14

```hs
myNth :: [a] -> Int -> a
```

> A function which takes a list and an Int (N) as argument and returns the element at index N in the list, or an error if the index is too large or negative

### Task 15

```hs
myTake :: Int -> [a] -> [a]
```

> A function which takes an Int (N) and a list and returns a list with the Nth first elements of the list. If the list is too short the whole list is returned

### Task 16

```hs
myDrop :: Int -> [a] -> [a]
```

> A function which takes an Int (n) and a list and returns a list without the N first elements. If the list is too short an empty list is returned.

### Task 17

```hs
myAppend :: [a] -> [a] -> [a]
```

> A function which takes two lists and returns a new list with the second list appened to the first one.

### Task 18
```hs
myReverse :: [a] -> [a]
```

> A function which takes a list and returns a list with all its elements in reverse order.

### Task 19

```hs
myInit :: [a] -> [a]
```

> A function which takes a list and returns a list with all its elements except the last one, or an error if the list
is empty.

### Task 20

```hs
myLast :: [a] -> a
```

> A function which takes a list and returns its last element, or an error if the list is empty.

### Task 21

```hs
myZip :: [a] -> [b] -> [(a, b)]
```

> A function which takes two lists as arguments, and returns a list of tuples. The list produced is as long as the shortest list.

### Task 22

```hs
myUnzip :: [(a,b)] -> ([a], [b])
```

> A function which takes a list of tuples, and return a tuple of lists.

## **Step 4** - Advanced lists

### Task 23

```hs
myMap :: (a -> b) -> [a] -> [b
```

>  function which takes a function and a list, and apply this function to every element of the list.

### Task 24

```hs
myFilter :: (a -> Bool) -> [a] -> [a
```

> A function which takes a predicate (a function returning a boolean value) and a list, and returns a list of all the elements for which the predicate has returned True.

### Task 25

```hs
myFoldl :: (b -> a -> b) -> b -> [a] -> b
```

> A function which takes a function, a starting value and a list as argument.  
It takes the second argument and the first item of the list and applies the function to them, then feeds the function with this result and the second argument and so on.

```bash
ghci
Prelude> myFoldl (\ acc x -> acc + x) 0 [1,2,3,4,5]
15
Prelude> myFoldl myAppend "foo" ["bar","baz"]
"foobarbaz"
Prelude> myFoldl (\ acc x -> x : acc) [] [1,2,3,4,5]
[5,4,3,2,1]
```

### Task 26

```hs
myFoldr :: (a -> b -> b) -> b -> [a] -> b
```

> Like myFoldl, but from right to left.

### Task 27

```hs
myPartition :: (a -> Bool) -> [a] -> ([a], [a])
```

> A function which takes a predicate and a list as argument, and returns a tuple of lists, with in the first list the elements for which the predicate returns true, and in the second list the other elements.

### Task 28

```hs
myQuickSort :: (a -> a -> Bool) -> [a] -> [a]
```

> A function which takes a predicate and a list as arguments, and returns the list sorted according to the
predicate.

```bash
ghci
Prelude> myQuickSort (\ x y -> x < y) [9,1,8,2,7,3,6,4,5]
[1,2,3,4,5,6,7,8,9]
Prelude> myQuickSort (>) ["alice", "eve", "carl", "bob"]
["eve","carl","bob","alice"]
```


