
% Load the image
img = imread('coins.jpg');

% Create a figure to display the images
figure;

% Loop through noise levels
for i = 1:9
    % Calculate noise level
    noise_level = i * 10;
    
    % Calculate the Rician noise parameters
    s = noise_level / 100 * double(max(img(:)));
    r = s / sqrt(2);
    
    % Generate the Rician noise
    noise = r * (randn(size(img)) + 1i * randn(size(img)));
    noisy_img = double(img) + real(noise);
    
    % Convert the noisy image to uint8 format
    noisy_img = uint8(max(min(noisy_img, 255), 0));
    
    % Display the noisy image
    subplot(3, 3, i);
    imshow(noisy_img);
    title(sprintf('Noise Level: %d%%', noise_level));
end