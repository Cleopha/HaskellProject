module KMeansAlgorithm
    ( kMeansAlgorithm
    ) where

import GHC.Float
import System.Random
import RandomLimits
import DataTypes
import DataComparison
import Printing

generateClusterArray :: Int -> (Color, Color) -> IO [Cluster]
generateClusterArray 0 _ = return []
generateClusterArray nb (cMin@(Color rMin gMin bMin),
    cMax@(Color rMax gMax bMax)) = do
        r <- randomRIO (rMin, rMax)
        g <- randomRIO (gMin, gMax)
        b <- randomRIO (bMin, bMax)
        clusterArray <- generateClusterArray (nb - 1) (cMin, cMax)
        return (Cluster {centroid = Color {r = r, g = g, b = b},
        pixelArray = []} : clusterArray)

newClusterArray :: [Cluster] -> [Cluster]
newClusterArray = map newCluster

newCluster :: Cluster -> Cluster
newCluster cluster@(Cluster c@(Color r g b) _) =
    Cluster {centroid = Color {r = r, g = g, b = b}, pixelArray = []}

computeDistance :: Color -> Color -> Float
computeDistance c1@(Color r1 g1 b1) c2@(Color r2 g2 b2) =
    sqrt ((r1 - r2) * (r1 - r2) + (g1 - g2) * (g1 - g2) + (b1 - b2) * (b1 - b2))

pixelToCluster :: Pixel -> Int -> Int -> Float -> [Cluster] -> Int
pixelToCluster _ _ is _ [] = is
pixelToCluster px@(Pixel pt c1) i is d (cl@(Cluster c2 pxArr):clArr) =
    if nd < d
    then pixelToCluster px (i + 1) i nd clArr
    else pixelToCluster px (i + 1) is d clArr
    where
        nd = computeDistance c1 c2

emplacePixel :: Pixel -> Int -> [Cluster] -> [Cluster]
emplacePixel px 0 (cl@(Cluster _ pxArr):clArr) =
    cl {pixelArray = px : pxArr} : clArr
emplacePixel px i (cl:clArr) = cl : emplacePixel px (i - 1) clArr

colorSum :: [Pixel] -> Color -> Color
colorSum [] c = c
colorSum (px@(Pixel _ c@(Color r1 g1 b1)):pxArr) cs@(Color r2 g2 b2) =
    colorSum pxArr cs {r = r1 + r2, g = g1 + g2, b = b1 + b2}

computeCentroid :: [Pixel] -> Color
computeCentroid [] = Color {r = 0, g = 0, b = 0}
computeCentroid pxArr =
    Color {r = r / len, g = g / len, b = b / len}
    where
        c@(Color r g b) = colorSum pxArr Color {r = 0, g = 0, b = 0}
        len = int2Float (length pxArr)

computeAllCentroids :: [Cluster] -> [Cluster]
computeAllCentroids [] = []
computeAllCentroids (cl@(Cluster _ px):clArr) =
    case computeCentroid px of
        c@(Color 0 0 0) -> cl : computeAllCentroids clArr
        c -> cl {centroid = computeCentroid px} : computeAllCentroids clArr

computeClusters :: [Cluster] -> [Pixel] -> [Cluster]
computeClusters clArr [] = computeAllCentroids clArr
computeClusters clArr (px:pxArr) = computeClusters clArray pxArr
    where
        idx = pixelToCluster px 0 0 442 clArr
        clArray = emplacePixel px idx clArr

checkConvergence :: [Cluster] -> [Cluster] -> Float -> [Cluster]
checkConvergence [] [] _ = []
checkConvergence [] _ _ = []
checkConvergence _ [] _ = []
checkConvergence (cl1@(Cluster c1 _):clArr1) (cl2@(Cluster c2 _):clArr2) conv =
    if computeDistance c1 c2 <= conv
    then cl2 {centroid = c1} : checkConvergence clArr1 clArr2 conv
    else cl2 : checkConvergence clArr1 clArr2 conv

determineCluster :: [Cluster] -> [Pixel] -> Float -> Maybe [Cluster]
determineCluster clArr pxArr convergence =
    if clusterArrayEq clArr newClArr
    then Nothing
    else Just newClArr
    where
        nClArr = computeClusters (newClusterArray clArr) pxArr
        newClArr = checkConvergence clArr nClArr convergence

algorithm :: Config -> [Pixel] -> [Cluster] -> [Cluster]
algorithm conf@(Config _ c _) pxArr clArr =
    case determineCluster clArr pxArr c of
        Just newClArr -> algorithm conf pxArr newClArr
        Nothing -> clArr

kMeansAlgorithm :: Config -> [Pixel] -> IO ()
kMeansAlgorithm conf pixelArray = do
    clusterArray <- generateClusterArray (colorsNumber conf) colorsLimits
    printClusterArray (algorithm conf pixelArray clusterArray)
    where
        colorsLimits = randomLimits pixelArray
