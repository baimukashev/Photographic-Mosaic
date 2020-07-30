n = 25;
m = 25;
mkdir to_folder
for s = 1:1309

   filename = ['from_folder/' num2str(s,'%05d') '.jpg'];
   imgDs = imread(filename);
   
   imgDs_rs = imresize(imgDs, [n m]);
   intensityR = 0;
   intensityG = 0;
   intensityB = 0;
   for i = 1:25
       for j=1:25
           intensityR = intensityR + double(imgDs_rs(i,j,1));
           intensityG = intensityG + double(imgDs_rs(i,j,2));
           intensityB = intensityB + double(imgDs_rs(i,j,3));
       end
   end
   
   intensityR_mean = fix(intensityR/625);
   intensityG_mean = fix(intensityG/625);
   intensityB_mean = fix(intensityB/625);
   
   cd to_folder
       tile_name = [    num2str(intensityR_mean,'%03d') ... 
                    '_' num2str(intensityG_mean,'%03d') ...
                    '_' num2str(intensityB_mean,'%03d') '_' '.jpg'];
         
       tile = imgDs;
       imwrite(tile, tile_name);
   cd ..
   
end


