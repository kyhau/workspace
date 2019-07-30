# Test that gdal can be imported
import gdal


# Test that we don't get a system crash - see https://trac.osgeo.org/gdal/ticket/6749#no1
def system_crash_test():
    import ogr

    def ogr_basic_16_make_geom():
        geom = ogr.Geometry(ogr.wkbPoint)
        geom.AddPoint_2D(0, 0)
        return geom

    def ogr_basic_16_gen_list(N):
        for i in range(N):
            geom = ogr_basic_16_make_geom()
            yield i

    list(ogr_basic_16_gen_list(2))

# Test that the gdal build has array support
def gdal_array_support():
    import osgeo
    try:
        from osgeo import _gdal_array
    except ImportError:
        print("The gdal build does not include support for gdal_array")
        raise

system_crash_test()
gdal_array_support()

print("Gdal run successfully!")

