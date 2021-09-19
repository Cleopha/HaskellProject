module StringOperations
    ( stringToArray
    ) where

charInString :: Char -> String -> Bool
charInString c (s:str)  | c == s = True
                        | otherwise = charInString c str
charInString c _ = False

stringToken :: String -> String -> String
stringToken (s:str) delim   | charInString s delim = []
                            | otherwise = s : stringToken str delim
stringToken [] _ = []

stringToArray :: String -> String -> [String]
stringToArray (s:str) delim
    | not (charInString s delim) = stringToArray str delim
    | otherwise = case stringToken str delim of
        "" -> stringToArray str delim
        string -> string : stringToArray str delim
stringToArray [] _ = []
