

% Load the image
img = imread('coins.jpg');

% Create a figure to display the images
figure;

% Loop through noise levels
for i = 1:9
    % Calculate noise level
    noise_level = i * 10;
    
    % Create a sinusoidal grating
    [x,y] = meshgrid(1:size(img,2), 1:size(img,1));
    grating = sin(2*pi*y/32);
    
    % Add sinusoidal grating to the image
    noisy_img = im2double(img) + (noise_level/100)*grating;
    
    % Clip the values to [0,1]
    noisy_img(noisy_img < 0) = 0;
    noisy_img(noisy_img > 1) = 1;
    
    % Convert back to uint8 format
    noisy_img = im2uint8(noisy_img);
    
    % Display the noisy image
    subplot(3, 3, i);
    imshow(noisy_img);
    title(sprintf('Noise Level: %d%%', noise_level));
end