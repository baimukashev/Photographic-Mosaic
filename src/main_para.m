function mosaic_image = main_para(path_to_dataset,a,b,original_image );
tic

% given patch size
p = [a b];

% original image
img = imread(original_image);
dm = size(img)

% if too big, resized to 600*600, as 
% matlab shows an error loading large images
if dm(1) > 600 
    dm(1) = 600;
end
if dm(2) > 600
    dm(2) = 600;
end
imgR = imresize(img, [dm(1) dm(2)]);

% # patches in each row / column
pn = fix(dm(1)/p(1)) 
pm = fix(dm(2)/p(2))


% # resize the image to have the patches size above
rn = p(1) * fix(dm(1)/p(1))
rm = p(2) * fix(dm(2)/p(2))

%%%%%%%%%%%%
img_res = imresize(imgR, [rn rm+pm*2]);


img_save = img_res;

% look through all images in dataset
A = dir(fullfile(path_to_dataset,'*.jpg'));
namesA = { A.name };


% for each patch
for py = 1:pn
    for px = 1:pm
        
        % calculate the average color R, G, B intensity values
        intensityR = 0;
        intensityG = 0;
        intensityB = 0;

        for i = 1:p(1)
            for j=1:p(2)
                intensityR = intensityR + double(img_res(i+(py-1)*p(1),p(1)-i+j+(px-1)*p(2),1));
                intensityG = intensityG + double(img_res(i+(py-1)*p(1),p(1)-i+j+(px-1)*p(2),2));
                intensityB = intensityB + double(img_res(i+(py-1)*p(1),p(1)-i+j+(px-1)*p(2),3));
            end
            
        end
        
        % find mean 
        intensityR_mean = fix(intensityR/(p(1)*p(2)));
        intensityG_mean = fix(intensityG/(p(1)*p(2)));
        intensityB_mean = fix(intensityB/(p(1)*p(2)));
        
        % initialize the error and image
        min_error = 10000;
        tile_image = '000_000_000_.jpg';
        
        % for ech of the images in dataset compare the intensity values
        for i = 1 : numel( A )
            RGB = strsplit(namesA{i},'_');
            err = sqrt((str2double(RGB{1}) - intensityR_mean)^2 + ...
                       (str2double(RGB{2}) - intensityG_mean)^2 + ...
                       (str2double(RGB{3}) - intensityB_mean)^2);
            if min_error > err
                min_error = err;
                tile_image = namesA{i}; % track the tile imagewith lowest error
            end
        end
        %cd msfoldernew
        new_tile = imresize(imread(fullfile(path_to_dataset,tile_image)), [p(1) p(2)]);
        %cd ..
        for i = 1:p(1)
            for j=1:p(2)
                for r = 1:3
                    img_res(i+(py-1)*p(1),p(1)-i + j + (px-1)*p(2), r) = new_tile(i,j,r);
                end
            end
        end
        %imshow(img_res)
    end         
end

% show the result
figure
imshow(img_save);
title('Main image');

figure
mosaic_image = imcrop(img_res, [pm,1, pm*p(2)-pm, p(1)*pn]);
imshow(mosaic_image);
title('Mosaic image');
% time
time = toc/60

end




