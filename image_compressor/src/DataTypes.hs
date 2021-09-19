module DataTypes
    ( Config(..)
    , Point(..)
    , Color(..)
    , Pixel(..)
    , Cluster(..)
    ) where

data Config = Config {
    colorsNumber :: Int,
    convergenceLimit :: Float,
    file :: String
} deriving (Show)

data Point = Point {
    x :: Int,
    y :: Int
} deriving (Show)

data Color = Color {
    r :: Float,
    g :: Float,
    b :: Float
} deriving (Show)

data Pixel = Pixel {
    point :: Point,
    color :: Color
} deriving (Show)

data Cluster = Cluster {
    centroid :: Color,
    pixelArray :: [Pixel]
} deriving (Show)
