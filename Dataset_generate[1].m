
if exist('to_folder', 'dir') == 7
    rmdir tiles s
end 
mkdir to_folder; 

first_iteration = 1 ;
for s = 1:2667
    filename1 = ['from_folder/' num2str(s,'%06d') '.jpg'];
    img_prev = imread(filename1);
    filename2 = ['from_folder/' num2str(s+1,'%06d') '.jpg'];
    img_next = imread(filename2);
    diff_hist = imhist(imresize(img_prev, [25 25]))-imhist(imresize(img_next, [25 25]));
    sum_diff = sum(diff_hist(:).^2) / 625;
    if first_iteration == 1
        cd to_folder
        tile_name = [num2str(s,'%04d') '.jpg'];
        tile = img_prev;
        imwrite(tile, tile_name);
        cd ..        
        first_iteration = 0;
    end
    [n,m] = size(img_next);
    if sum_diff > 10
       cd to_folder
       tile_name = [num2str(s,'%04d') '.jpg'];
       tile = img_next;
       imwrite(tile, tile_name);
       cd ..
   end
    
    
    
end
  
