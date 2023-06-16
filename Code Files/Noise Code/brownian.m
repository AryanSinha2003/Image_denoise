% Load the image
img = imread('coins.jpg');

% Create a figure to display the images
figure;

% Loop through noise levels
for i = 1:9
    % Calculate noise level
    noise_level = i * 10;
    
    % Generate the Brownian noise
    noise = noise_level/100 * randn(size(img));
    noise = imresize(noise, size(img));
    noisy_img = double(img) + noise;
    
    % Convert the noisy image to uint8 format
    noisy_img = uint8(max(min(noisy_img, 255), 0));
    
    % Display the noisy image
    subplot(3, 3, i);
    imshow(noisy_img);
    title(sprintf('Noise Level: %d%%', noise_level));
end
