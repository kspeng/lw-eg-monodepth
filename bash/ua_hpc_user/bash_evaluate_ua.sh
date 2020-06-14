#!/bin/bash
encoder_='resASPP'
batch_=8
epoch_=100
dataset_='kitti'
split_='kitti'
ckpt_=362500

model_name="$(printf '%s_%s_%dx%d' ${dataset_%} ${encoder_%} ${batch_%} ${epoch_%})"
echo ">>> ${model_name}"

/xdisk/ditzler/mig2020/rsgrps/ditzler/kspeng/envImg \
monodepth_main.py --mode test \
--data_path ./data/dataset/kitti/stereo2015/ \
--filenames_file utils/filenames/ua_test_files.txt \
--log_directory ../log/ \
--encoder ${encoder_} \
--checkpoint_path $(printf 'models/%s/model-%d' ${model_name%} ${ckpt_%})

echo ">>> ${backbone%}"
echo ">>> Kitti: Native Evaluation"
python utils/evaluate_kitti.py --split ${split_} \
--gt_path ./data/dataset/kitti/stereo2015/ \
--predicted_disp_path $(printf 'models/%s/disparities.npy' ${model_name%})

echo ">>> Kitti: Post-Processing Evaluation"
python utils/evaluate_kitti.py --split ${split_} \
--gt_path ./data/dataset/kitti/stereo2015/ \
--predicted_disp_path $(printf 'models/%s/disparities_pp.npy' ${model_name%})

echo ">>> Kitti: Edge-Guided Post-Processing Evaluation"
python utils/evaluate_kitti.py --split ${split_} \
--gt_path ./data/dataset/kitti/stereo2015/ \
--predicted_disp_path $(printf 'models/%s/disparities_ppp.npy' ${model_name%})

