function [enhanced_image] = enhanceSignal(I)

max_intensity = double(max(max(I)));
normalized_max_intensity = max_intensity/255;

if normalized_max_intensity < 1.0 && normalized_max_intensity > 0
enhanced_image = imadjust(I,[0 normalized_max_intensity],[0,1]);
else
    
enhanced_image = I;

end

end