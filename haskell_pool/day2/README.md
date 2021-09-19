# Day2

## Summary

  - [Task 01](#task-01)
  - [**Step 1** - Maybe](#step-1---maybe)
    - [Task 02](#task-02)
    - [Task 03](#task-03)
    - [Task 04](#task-04)
    - [Task 05](#task-05)
    - [Task 06](#task-06)
    - [Task 07](#task-07)
  - [**Step 2** - IO](#step-2---io)
    - [Task 08](#task-08)
    - [Task 09](#task-09)
    - [Task 10](#task-10)
    - [Task 11](#task-11)
    - [Task 12](#task-12)
    - [Task 13](#task-13)
  

### Task 01

```hs
myElem :: Eq a => a -> [a] -> Bool
```

> A function which takes an argument which implements equality and a list of the same type, and returns True if the argument is present in the list, False otherwise.

```bash
ghci DoOp.hs
Prelude> myElem 3 [1,2,3,4,5]
True
Prelude> myElem 7 [1,2,3,4,5]
False
```

## **Step 1** - Maybe
Maybe is a data type included in the Haskell’s standard library which is a simple and elegant way to handle errors without using exceptions. It’s also a monad.  

You can inspect it’s definition with ghci:
```bash
ghci
Prelude> :info Maybe
data Maybe a = Nothing | Just a – Defined in ‘GHC.Base’
```

### Task 02

```hs
safeDiv :: Int -> Int -> Maybe Int
```

> A function which takes two Ints as arguments, and returns Nothing if it’s a division by zero, or Just N (with N the result of the division) if it’s not.

```bash
ghci
Prelude> safeDiv 10 0
Nothing
Prelude> safeDiv 10 2
Just 5
```

### Task 03

```hs
safeNth :: [a] -> Int -> Maybe a
```

> A function similar to the function myNth, but which returns Nothing in case of an error, or Just N (with N
the result) in case of success

### Task 04

```hs
safeSucc :: Maybe Int -> Maybe Int
```

> A function which takes a Maybe Int and returns its successor wrapped in a maybe.

```bash
ghci
Prelude> safeSucc (Just 41)
Just 42
Prelude> safeSucc (safeDiv 10 2)
Just 6
Prelude> safeSucc (safeDiv 10 0)
Nothing
```

### Task 05

```hs
myLookup :: Eq a => a -> [(a,b)] -> Maybe b
```

> A function which takes an argument which implements equality and a list of tuples. Looks successively if the first element of each tuple is equal to the first argument. If a match is found, the second element of the tuple is returned wrapped in a Maybe. Otherwise, Nothing is returned

```bash
ghci
Prelude> myLookup 2 [(1,"foo"),(2,"bar"),(3,"baz")]
Just "bar"
Prelude> myLookup 5 [(1,"foo"),(2,"bar"),(3,"baz")]
Nothing
```

### Task 06

```hs
maybeDo :: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
```

> A functions which takes a function as argument and two more arguments wrapped in Maybes, and returns Nothing if any of the arguments are Nothing, or Just n (with n the result of the function applied to the arguments) otherwise

```bash
ghci
Prelude> maybeDo (\ x y -> x + y) (Just 1) (Just 2)
Just 3
Prelude> maybeDo (*) (safeDiv 10 0) (Just 5)
Nothing
Prelude> maybeDo (+) (safeDiv 10 5) (safeSucc $ Just 39)
Just 42
```

### Task 07

```hs
readInt :: [Char] -> Maybe Int
```

> A function which takes a string as argument and returns Nothing if its not a parsable number, or an Int
wrapped in a maybe otherwise.

```bash
ghci
Prelude> readInt "42"
Just 42
Prelude> readInt "foobar123"
Nothing
```

## **Step 2** - IO
To handle Inputs and Outputs (IO), Haskell uses the IO monad, which permits to keep our function pure,
while exchanging data from the outside world.  

### Task 08

```hs
getLineLength :: IO Int
```

> A function which reads a line from the standard input and returns its length as a IO Int.

### Task 09

```hs
printAndGetLength :: String -> IO Int
```

> A function which takes a string as argument, prints it on the standard output followed by a carriage return, and returns its length in the IO monad

```bash
ghci
Prelude> printAndGetLength "hello world"
hello world
11
```

### Task 10

```hs
printBox :: Int -> IO ()
```

> A function which takes an Int (N) as argument, and draw a box of height N and width N*2 on the standard output (see example bellow). If N is zero or less, it does nothing.

```bash
ghci
Prelude> printBox 5
+––––––––+
|        |
|        |
|        |
+––––––––+
Prelude>
```

### Task 11

```hs
concatLines :: Int -> IO String
```

> A function which takes an Int (N) as argument, read N lines from the standard input and returns a concatenation of these lines in the IO monad. If N is 0 or negative, an empty string is returned.

```bash
ghci
Prelude> concatLines 3
foo
bar
baz
"foobarbaz"
```

### Task 12

```hs
getInt :: IO (Maybe Int)
```

> A function which reads a line from the standard input and returns a Maybe Int in the IO monad.

```bash
ghci
Prelude> getInt
42
Just 42
```

### Task 13

A program called doop, which will be built by the command "make".
This program takes three arguments on the command line.  
The first and third arguments are numbers (signed integers).  
The second argument is an arithmetic operator (either + - * / or %) and returns the result of the operation.  
In case of error, your program must return 84.

> 

```bash
./doop 1 + 2
> 3
./doop 10 / 0
echo $?
> 84
```