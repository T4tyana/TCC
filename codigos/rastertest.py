#!python3
# -*- coding: utf-8 -*-

import gdal
import numpy as np
import matplotlib.pyplot as plt
from dbconn import Conn

def rasterShow(conn):
	print( conn.protected_string )
	ds = gdal.Open(conn.string, 0)
	if ds:
		band = ds.GetRasterBand(1)
		image = band.ReadAsArray()
		plt.imshow(image, cmap="gray")
		plt.show()
	else:
		print("Connection error!")

connWizard = Conn(rasterShow)
connWizard.show()
