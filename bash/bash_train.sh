#!/bin/bash
encoder_='resASPP'
batch_=8
epoch_=100
dataset_='kitti'


model_name="$(printf '%s_%s_%dx%d' ${dataset_%} ${encoder_%} ${batch_%} ${epoch_%})"
echo ">>> ${model_name}"

#singularity run --nv ~/workspace/envImg/tfcv.img \
python \
monodepth_main.py --mode train \
--data_path "$(printf './dataset/%s/data/' ${dataset_%})" \
--filenames_file "$(printf 'utils/filenames/%s_train_files.txt' ${dataset_%})" \
--log_directory ./models/ \
--model_name ${model_name} \
--dataset ${dataset_} \
--encoder ${encoder_} \
--batch_size ${batch_} \
--num_epochs ${epoch_}

