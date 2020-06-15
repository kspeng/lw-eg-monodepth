## convert npy to image
'''
date:   2020-06-14
author: kuo
'''
import os
import numpy as np
import scipy.misc
import matplotlib.pyplot as plt
import os
from PIL import Image

save_source = not True
postproc = True
surfix = ''

## setup root path
model_name = 'kitti_resASPP_8x100'
path2root   = '../models/{}/'.format(model_name)
path2out = path2root + 'kitti/' 
if not os.path.exists(path2out):
    os.makedirs(path2out)

## load npy
path2npy    = path2root + "disparities{}.npy".format(surfix)

npy         = np.load(path2npy)

## get dimension
num, _, _   = npy.shape
for n in np.arange(num):
    fName   = str(n).zfill(6)
    npy_    = npy[n,:-10,:]
    npy_    = np.array(Image.fromarray(npy_).resize([1242,375], Image.BILINEAR))#LANCZOS))  

    plt.imsave(os.path.join(path2out, "{}_disp.png".format(fName)), npy_, cmap='plasma')

    if n % 10 == 0:
        print("Status: {}%".format(np.round(n/num*100,2)))

print("Done!")



