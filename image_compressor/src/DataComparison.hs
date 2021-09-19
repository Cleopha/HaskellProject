module DataComparison
    ( clusterArrayEq
    ) where

import DataTypes

pixelEq :: Pixel -> Pixel -> Bool
pixelEq px1@(Pixel p1@(Point x1 y1) c1@(Color r1 g1 b1))
        px2@(Pixel p2@(Point x2 y2) c2@(Color r2 g2 b2))
    | x1 == x2 && y1 == y2 && r1 == r2 && g1 == g2 && b1 == b2 = True
    | otherwise = False

pixelArrayEq :: [Pixel] -> [Pixel] -> Bool
pixelArrayEq [] [] = True
pixelArrayEq _ [] = False
pixelArrayEq [] _ = False
pixelArrayEq (px1:pa1) (px2:pa2) =  pixelEq px1 px2 && pixelArrayEq pa1 pa2

clusterEq :: Cluster -> Cluster -> Bool
clusterEq   cl1@(Cluster ce1@(Color r1 g1 b1) p1)
            cl2@(Cluster ce2@(Color r2 g2 b2) p2)
    | r1 == r2 && g1 == g2 && b1 == b2 = pixelArrayEq p1 p2
    | otherwise = False

clusterArrayEq :: [Cluster] -> [Cluster] -> Bool
clusterArrayEq [] [] = True
clusterArrayEq _ [] = False
clusterArrayEq [] _ = False
clusterArrayEq (c1:ca1) (c2:ca2) =  clusterEq c1 c2 && clusterArrayEq ca1 ca2
