#!/bin/bash
encoder_='resASPP'
batch_=8
epoch_=100
dataset_='kitti'
split_='kitti'
ckpt_=362500

data_path_='/xdisk/ditzler/mig2020/rsgrps/ditzler/kspeng/workspace/dataset/'

model_name="$(printf '%s_%s_%dx%d' ${dataset_%} ${encoder_%} ${batch_%} ${epoch_%})"
echo ">>> ${model_name}"

singularity run --nv /xdisk/ditzler/mig2020/rsgrps/ditzler/kspeng/envImg/tfcvpy36tf15.img \
monodepth_main.py --mode test \
--data_path "$(printf '%s%s/stereo2015/' ${data_path_%} ${dataset_%})" \
--filenames_file utils/filenames/kitti_stereo_2015_test_files.txt \
--log_directory ../log/ \
--encoder ${encoder_} \
--checkpoint_path $(printf 'models/%s/model-%d' ${model_name%} ${ckpt_%})

echo ">>> ${backbone%}"
echo ">>> Kitti: Native Evaluation"
singularity run --nv /xdisk/ditzler/mig2020/rsgrps/ditzler/kspeng/envImg/tfcvpy36tf15.img \
utils/evaluate_kitti.py --split ${split_} \
--gt_path "$(printf '%s%s/stereo2015/' ${data_path_%} ${dataset_%})" \
--predicted_disp_path $(printf 'models/%s/disparities.npy' ${model_name%})

echo ">>> Kitti: Post-Processing Evaluation"
singularity run --nv /xdisk/ditzler/mig2020/rsgrps/ditzler/kspeng/envImg/tfcvpy36tf15.img \
utils/evaluate_kitti.py --split ${split_} \
--gt_path "$(printf '%s%s/stereo2015/' ${data_path_%} ${dataset_%})" \
--predicted_disp_path $(printf 'models/%s/disparities_pp.npy' ${model_name%})

echo ">>> Kitti: Edge-Guided Post-Processing Evaluation"
singularity run --nv /xdisk/ditzler/mig2020/rsgrps/ditzler/kspeng/envImg/tfcvpy36tf15.img \
utils/evaluate_kitti.py --split ${split_} \
--gt_path "$(printf '%s%s/stereo2015/' ${data_path_%} ${dataset_%})" \
--predicted_disp_path $(printf 'models/%s/disparities_ppp.npy' ${model_name%})

