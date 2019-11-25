# lw-eg-monodepth
Light-Weight Edge-Guided Self-supervised Monocular Depth Estimation

## Create Dataset Link
```
mkdir dataset
ln -s ~/path/to/kitti/ ./dataset/
ln -s ~/path/to/cityscapes/ ./dataset/
```

## Train
```
sh ./bash/bash_train.sh
```

## Evaluation 
We have prepared two bash scripts to evaluate the performance of Kitti and Eigen splits on Kitti dataset. Please change the varaiables in the scripts to run the evaluation. You will get the similar results we have in the paper.
* Example
```
sh ./bash/bash_evaluate_kitti.sh
```
You will recieve the results as shown:
```
now testing 200 files
done.
Total time:  4.48
Inferece FPS:  42.44
writing disparities.
done.
>>> 
>>> Kitti: Native Evaluation
   abs_rel,     sq_rel,        rms,    log_rms,     d1_all,         a1,         a2,         a3
    0.1134,     1.1636,      5.734,      0.201,     27.379,      0.853,      0.945,      0.979
>>> Kitti: Post-Processing Evaluation
   abs_rel,     sq_rel,        rms,    log_rms,     d1_all,         a1,         a2,         a3
    0.1079,     1.0259,      5.464,      0.192,     26.395,      0.857,      0.949,      0.982
>>> Kitti: Edge-Guided Post-Processing Evaluation
   abs_rel,     sq_rel,        rms,    log_rms,     d1_all,         a1,         a2,         a3
    0.1077,     1.0238,      5.387,      0.189,     26.152,      0.860,      0.951,      0.983
```
* We skip first 10 testing files in computing FPS due to the unstability of first few iterations. 

## Pre-built models

We have prepard the built models for references [here](https://drive.google.com/open?id=1njgQyNf4Bk5TEQoXzgN4vs31Texi0sxN).
