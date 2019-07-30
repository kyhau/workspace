"""
Case 1: zeros
Note that if you comment out/remove the `import gdal` line that this code works fine and as expected.
"""
import gdal
from shapely.geometry import Polygon

a = Polygon([(0, 0), (0, 1), (1, 1), (1, 0)])
coords = list(a.exterior.coords)
print(coords)


"""
OR  Case 2: adding the following
import shapely.speedsups
shapely.speedups.disable()
------------------------------------
import gdal
from shapely.geometry import Polygon

import shapely.speedsups
shapely.speedups.disable()

a = Polygon([(0, 0), (0, 1), (1, 1), (1, 0)])
coords = list(a.exterior.coords)
print(coords)
"""


"""
OR  Case 3: Change import order
------------------------------------
from shapely.geometry import Polygon
import gdal

a = Polygon([(0, 0), (0, 1), (1, 1), (1, 0)])
coords = list(a.exterior.coords)
print(coords)
"""