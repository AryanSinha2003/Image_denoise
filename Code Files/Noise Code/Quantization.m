% Load the image
img = imread('plants.jpg');

% Create a figure to display the images
figure;

% Loop through noise levels
for i = 1:9
    % Calculate noise level
    noise_level = i * 10;
    
    % Calculate number of quantization levels
    n_levels = floor(256 / (100 / noise_level));
    
    % Generate the quantization noise
    q_noise = randn(size(img)) * n_levels / 256;
    noisy_img = im2double(img) + q_noise;
    noisy_img = im2uint8(noisy_img / max(noisy_img(:)));
    
    % Display the noisy image
    subplot(3, 3, i);
    imshow(noisy_img);
    title(sprintf('Noise Level: %d%%', noise_level));
end
