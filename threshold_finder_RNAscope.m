
%% This function will find threshold for a single image 


function threshold = threshold_finder_RNAscope(image_array,n_std)

threshold = [];
rgb_img = image_array;
n_channels = 1;

for ch_i = 1:n_channels
    
    ch_img = rgb_img(:,:,ch_i);
    hist_fit = fitdist(ch_img(:),'HalfNormal');
    threshold(ch_i) = n_std*hist_fit.sigma;
    ch_img_thresh(:,:,ch_i) = double(ch_img).*double((ch_img>threshold(ch_i)));
    
end

end