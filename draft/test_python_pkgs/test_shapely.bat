@ECHO OFF
:: All commands halt the build and throw an error value.

SET "PYTHONPATH=c:\Python27\python.exe"
SET "PYTHONPATH=c:\Python34\python.exe"
SET "PYTHONPATH=c:\Python36\python.exe"
SET "PYTHONPATH=c:\Python37\python.exe"

virtualenv --python=%PYTHONPATH% env_test || exit /b 1
CALL env_test\Scripts\activate.bat || exit /b 2

pip install --no-cache-dir install "..\gdal_pkgs\devpi\gdal-2.0.3\GDAL-2.0.3+gdb-cp27-cp27m-win32.whl"
pip install shapely==1.6.4
python test_shapely.py

EXIT /B 0
