%% This script will:
% 1. Create a convex hull around Opn4 signal to estimate the cell boundary
% 2. Count Gad2 puncta inside the convex hull
% 3. Display results

% Before beginning, make sure that you change the variable 'filename' below
% Also, install vlfeat (https://www.vlfeat.org/install-matlab.html)

% Variable "Gad2Puncta_inpolygon" will list coordinates of Gad2 puncta
% inside Opn4 convex hull
clear all; close all;

% Initialize vlfeat
run('C:/Users/takie/OneDrive/Desktop/MATLAB/vlfeat-0.9.21/toolbox/vl_setup');

%% This part of the code involves making a convex hull around Opn4 signal
% In order to estimate the boundary of Opn4+ cells

filename = 'example4'; % Change this to whatever your image base filename is

opn4_filename = [filename '_opn4.tif']; % Add '_opn4.tif' to the base file name above
gad2_filename = [filename '_gad2.tif']; % Add '_gad2.tif' to the base file name above

% Add the folder 'example_images' to search path
current_directory = pwd; % Get current folder
search_path = [current_directory '\example_images'];
addpath(search_path);

% Open the Opn4 and Gad2 images
opn4_img = imread(opn4_filename);
gad2_img = imread(gad2_filename);

% Obtain coordinates of convex hull that outline Opn4 signal
[polyCoordinates, polyArea] = convex_hull_Opn4(opn4_filename); 

%% Find Gad2 puncta in convex hull

% This function will find the coordinates of Gad2 puncta
gad2Puncta = fastpeak_gad2PunctaCoordinates(gad2_filename);

gad2Puncta_inpoly = []; 

for gad2Coordinate = 1:size(gad2Puncta,1)    
    if inpolygon(...
            gad2Puncta(gad2Coordinate,1), ...
            gad2Puncta(gad2Coordinate,2), ...
            polyCoordinates(:,1), ...
            polyCoordinates(:,2) ...
            )
       
        gad2Puncta_inpoly = [gad2Puncta_inpoly; gad2Puncta(gad2Coordinate,:)];        
    end  
end

%% Visualize Opn4 convex hull and Gad2 puncta in separate images
figure();

% Show convex hull around Opn4 puncta
subplot(1,2,1);
imshow(opn4_img); hold on; % show opn4 raw image
ax_opn4 = gca;
plot(ax_opn4,polyCoordinates(:,1),polyCoordinates(:,2),'Color', 'w');  % Show convex hull
title('Opn4 Convex Hull','Color','g');
hold off;

% Show gad2 puncta located inside convex hull
subplot(1,2,2);
imshow(gad2_img); hold on; % show opn4 raw image
ax_gad2 = gca;
plot(ax_gad2,polyCoordinates(:,1),polyCoordinates(:,2),'Color', 'w');  % Show convex hull
try
scatter(ax_gad2,gad2Puncta_inpoly(:,1),gad2Puncta_inpoly(:,2),'r') % Show Gad2 puncta
end
title('Gad2 Puncta','Color','r');
hold off;

