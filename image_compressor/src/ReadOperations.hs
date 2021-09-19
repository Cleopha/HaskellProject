module ReadOperations
    ( readPositiveInt
    , readPositiveFloat
    , readColor
    ) where

import Text.Read

readPositiveInt :: String -> Maybe Int
readPositiveInt str = case readMaybe str :: Maybe Int of
        Just nb ->  if nb >= 0
                    then Just nb
                    else Nothing
        Nothing -> Nothing

readPositiveFloat :: String -> Maybe Float
readPositiveFloat str = case readMaybe str :: Maybe Float of
        Just nb ->  if nb >= 0
                    then Just nb
                    else Nothing
        Nothing -> Nothing

readColor :: String -> Maybe Int
readColor str = case readMaybe str :: Maybe Int of
        Just nb ->  if nb >= 0 && nb < 256
                    then Just nb
                    else Nothing
        Nothing -> Nothing
