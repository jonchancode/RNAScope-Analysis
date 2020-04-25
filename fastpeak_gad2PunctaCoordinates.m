% This function will read in an image and output coordinates of Gad2+ puncta

function [Gad2_coordinates] = fastpeak_gad2PunctaCoordinates(filename)

byte_img = imread(filename);
byte_img2 = enhanceSignal(byte_img);
filt = (fspecial('gaussian', 50,2));

%% FastPeakFind

threshold = threshold_finder_RNAscope(byte_img2,3); % three sigma

list_coordinates = FastPeakFind(byte_img2,threshold,filt);

coordinate_indices = 1:size(list_coordinates,1);
even_indices = coordinate_indices(mod(coordinate_indices,2) == 0);
odd_indices = coordinate_indices(mod(coordinate_indices,2) ~= 0);

Gad2_coordinates = [list_coordinates(odd_indices) list_coordinates(even_indices)];

end