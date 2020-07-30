n = 50;
m = 50;
mkdir to_folder

folder ='C:\Users\Daulet\Desktop\project/msfilteredfolder';
A =dir( fullfile(folder, '*.jpg'));

fileNames = { A.name };
for iFile = 1 : numel( A )
    
   filename = ['from_folder/' fileNames{iFile}];
   %imgDs = fileNames{ iFile }
   %cd msfilteredfolder
   imgDs_rs = rgb2gray(imresize(imread(filename), [n m]));
   %cd ..
   st = std2(imgDs_rs);
   
   %disp(filename);
   %disp(st)  ;
   tile = imread(filename);
    
   % if standart devation is less than treshhold, lets save that image
    if st < 40
       cd to_folder
           tile_name = [ num2str(iFile,'%03d') '.jpg'];
           imwrite(tile, tile_name);
       cd ..
   end
   
end 

