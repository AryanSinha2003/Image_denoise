
% Load the image
img = imread('.jpg');

% Create a figure to display the images
figure;


    % Generate the Poisson noise
    noisy_img = imnoise(img, 'poisson');
    
    
    imshow(noisy_img);
    title(sprintf('Noise Level: %d%%', noise_level));

