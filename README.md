# RNAScope-Analysis
This code was used to analyze RNAscope images in Sonoda et al., 2020
The purpose was to estimate the proportion of ipRGCs (which express Opn4) express Gad2. Therefore, we used probes to detect Opn4 mRNA and Gad2 mRNA in mouse retinal sections

It is important to note that we took high magnification images so that only 1 ipRGC was imaged/field of view. This made it unnecessary to use a clustering algorithm to determine how many ipRGCs were in a single field of view. This is a simplified version of the code we used. For analyses used in our study, we modified this to batch analyze all images at once.

This code will: 
1. Draw a convex hull around Opn4 mRNA signal in order to estimate the cell boundaries of an ipRGC
2. Then it will count the number of Gad2 puncta that reside in this boundary created
3. It will then display this

Instructions:
1. Make sure you have downloaded and installed the vlfeat computer vision toolbox for MATLAB. Instructions can be found here: https://www.vlfeat.org/install-matlab.html
2. Download the entire master branch on github
3. Make the folder you downloaded your current folder in MATLAB
4. Open the script called RUN_single_image.m
5. Change the variable 'filename' on line 19 to the name of any of the examples images provided. Exclude the 'opn4.tif' and 'gad2.tif' part of the filename when designating this variable. That will get added later in the subsequent lines.
Example images are contained in the "example_images" folder of folder you downloaded.
6. Run the script

