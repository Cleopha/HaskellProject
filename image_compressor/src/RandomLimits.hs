module RandomLimits
    ( randomLimits
    ) where

import DataTypes

randomLimits :: [Pixel] -> (Color, Color)
randomLimits (px@(Pixel _ c):pxArr) = (cMin, cMax)
    where
        cMin = colorMin c pxArr
        cMax = colorMax c pxArr

colorMin :: Color -> [Pixel] -> Color
colorMin c [] = c
colorMin cMin@(Color rMin gMin bMin) (px@(Pixel _ c@(Color r g b)):pxArr) =
    colorMin Color {r = min rMin r, g = min gMin g, b = min bMin b} pxArr

colorMax :: Color -> [Pixel] -> Color
colorMax c [] = c
colorMax cMax@(Color rMax gMax bMax) (px@(Pixel _ c@(Color r g b)):pxArr) =
    colorMax Color {r = max rMax r, g = max gMax g, b = max bMax b} pxArr
