## Image Processing Course Project

### This folder contains the files for the project. 

1. Tile images is in the folder "Dataset"

2. Files dataset_calculate_mean.m, dataset_generate.m, dataset_standart_deviation.m, 
	 dataset_rename_images.m are used in the preparation step of the Dataset. Therefore, they are NOT needed to run.
	 
3. Files main_para and main_rect are main documents for paralelogram and rectangular 
implementation of the mosaic. 

4. To run the script 

main_para (path_to_dataset, a, b, original_photo)

a,b - size of the patch for rectangular and parallelogram. 
a - length, b - height of parallelogram or width in case of the rectangular

Example: 
main_para ('Dataset', 15, 25, 'Original_photos/house.jpg')

4. Original photos are saved in the folder "Original_photos"

5. Report is is presented in pdf file. 

6. Folder Results contains some examples for three images.   
