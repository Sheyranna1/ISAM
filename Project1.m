%% Project 1 Resolution
% Shey, Emily, Grace

close all
clear

%% Load the pics and do the stuff
hor_bars = imread("horiz_crop_F56_5_g.tif"); % Horizontal AKA Vertical res
hor_bars = im2gray(hor_bars); hor_bars = imcrop(hor_bars); 

vert_bars = imread("vert_crop_F56_5_g.tif"); % Vertical AKA Horizontal RES
vert_bars = imrotate(vert_bars, 90); 
vert_bars = im2gray(vert_bars); vert_bars = imcrop(vert_bars); 


%% Delta to multiply with each pixel column
hor_delta = 1 / size(hor_bars, 2); % Horizontal delta, aka how much we scoot per column
vert_delta = 1 / size(vert_bars, 2); % Vertical delta, because sometimes ccropped imgs not same size and we dont want crash


%% Crunching numbers
% calculating contrast for both orientations of bars

% for our lovely horizontal bars
hor_lw_ph = []; % initialize empty vector to fill later with lw/ph vals
hor_contrast = []; % same for contrast as it changes over each column

for i = 1:size(hor_bars, 2) % iterating through each column
    I_max_hor_col = max(double(hor_bars(:, i))); 
    I_min_hor_col = min(double(hor_bars(:, i)));
    hor_lw_ph(i) = i * hor_delta * 100; % including the scale factor 
    hor_contrast(i) = (I_max_hor_col - I_min_hor_col) / (I_max_hor_col + I_min_hor_col); % put it in the loop where it should have been lol
end

% for the vertical bars
vert_lw_ph = [];
vert_contrast = []; 

for i = 1:size(vert_bars, 2) 
    I_max_vert_col = max(double(vert_bars(:, i))); 
    I_min_vert_col = min(double(vert_bars(:, i))); 
    vert_lw_ph(i) = i * vert_delta * 100; 
    vert_contrast(i) = (I_max_vert_col - I_min_vert_col) / (I_max_vert_col + I_min_vert_col); 
end

%% The Limiting Resolution Line 
lim_res = 0.05; 

%% Plot time
figure;
plot(hor_lw_ph, hor_contrast, 'b'); hold on; 
plot(vert_lw_ph, vert_contrast, 'r'); 
yline(lim_res, 'r--', 'LineWidth', 2);

xlabel('lw/ph'); 
ylabel('Contrast');
title('LW/PH vs Contrast for Horizontal and Vertical Bars'); 
legend('Vertical Resolution', 'Horizontal Resolution', 'Limiting Resolution!!!!!'); 
