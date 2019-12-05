# lw-eg-monodepth
This is the implementation of the paper: Light-Weight Edge-Guided Self-supervised Monocular Depth Estimation [[arXiv](https://arxiv.org/abs/1911.11705)]. This work is evolved from the project [Monodepth](https://github.com/mrharicot/monodepth). Please cite our paper if you use our results. Thanks.
```
@article{ kuo2019arXiv,
    author={Kuo-Shiuan Peng and Gregory Ditzler and Jerzy Rozenblit},
    title={ Edge-Guided Occlusion Fading Reduction for a Light-Weighted Self-Supervised Monocular Depth Estimation },
    journal={ arXiv },
    pages={1911.11705}, 
    year={2019}}
```

## Main Contributions
Our work focus on the network optimization and occlusion fading reduction using post-procssing. We introduce Atrous Spatial Pyramid Pooling (ASPP) module into DispNet to improve the performance and reduce the computational costs including paramters and inference time. The proposed Light-Weight Dispnet is shown as below
<p align="center">
  <img src="https://github.com/kspeng/lw-eg-monodepth/blob/master/fig/lw-eg-network.jpg" alt="lw-dispnet">
</p>
The proposed network is lighter, faster, and better than the conventional DispNet. 


Furthermore, we also resolve the occlusion fading issue of self-supervision method on Depth Estimation. We proposed an Edge-Guided post-processing method involving from Godard et. al.[ref](https://github.com/mrharicot/monodepth) to produce the depth estimation results with minimal halo effects. We detect the clear edges and occlusion fading using an edge detector. Then the flip trick is used to keep the clear edges and remove the occlusion fading to yield the final result. The architecture of the proposed Edge-Guided post-processing method is shown as below:
<p align="center">
  <img src="https://github.com/kspeng/lw-eg-monodepth/blob/master/fig/lw-eg-post-proc.png" alt="lw-dispnet">
</p>

The performance is visualized as follows:
<p align="center">
  <img src="https://github.com/kspeng/lw-eg-monodepth/blob/master/fig/lw-eg-mde-demo.png" alt="lw-dispnet">
  <img src="https://github.com/kspeng/lw-eg-monodepth/blob/master/fig/lw-eg-mde-demo-2.png" alt="lw-dispnet">    
</p>
The G.T. is the ground truth, pp is the prior of Godard et. al., and EG-PP is the propsoed method. Please to refer to our paper to see all the details. 

## System Requirements
This work is implemented using Tensorflow 1.5, CUDA 10.0, cuDNN 7.6, and anaconda/python 3.7 under Ubuntu 18.04LTS. There may have some warnings from Tensorflow 1.5, but it won't effect the simmulation.  

## Create Dataset Link
Please download the kitti and cityscape dataset and converted the input image to JPEG format in your own path. Then create the link to local directories inside the project as following. 
```
mkdir dataset
ln -s ~/path/to/kitti/ ./dataset/
ln -s ~/path/to/cityscapes/ ./dataset/
```

## Train
We have prepared two bash scripts to train our models on KITTI and Cityscapes dataset. After preparing the dataset, please run bash file as following (Take kitti dataset as example): 
```
sh ./bash/bash_train_kitti.sh
```
Please configurate the model and output file path by your preference.

## Evaluation 
We have prepared two bash scripts to evaluate the performance of Kitti and Eigen splits on Kitti dataset. Please change the varaiables in the scripts to run the evaluation. You will get the similar results we have in the paper.
* Example on vggASPP model with KITTI training result.
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

We have prepared the built models for references [here](https://drive.google.com/drive/folders/1njgQyNf4Bk5TEQoXzgN4vs31Texi0sxN?usp=sharing).
