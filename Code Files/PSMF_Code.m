% Read image and define switching threshold
I = imread('IMAGE.png');
ref_image = imread('REF_IMG.jpg');
ref_image = imresize(ref_image, [size(I,1) size(I,2)]);
threshold = 80;

% Define filter window size
filter_size = 3;

ier=0;

% Initialize output image
psmf_filtered_image = I;

% Traverse through each pixel of the image
[rows, cols, channels] = size(I);
for c = 1:channels
    for i = 1:rows
        for j = 1:cols
            % Extract filter window
            filter_window = zeros(filter_size*filter_size, 1);
            idx = 1;
            for k = max(1, i-filter_size):min(i+filter_size, rows)
                for l = max(1, j-filter_size):min(j+filter_size, cols)
                    filter_window(idx) = I(k, l, c);
                    idx = idx + 1;
                end
            end
            filter_window = filter_window(1:idx-1);
            % Sort filter window
            sorted_window = sort(filter_window);
            % Calculate median value of filter window
            if mod(numel(sorted_window), 2) == 0
                median_val = mean(sorted_window(numel(sorted_window)/2:numel(sorted_window)/2+1));
            else
                median_val = sorted_window(ceil(numel(sorted_window)/2));
            end
            % Compare to original pixel value
            if abs(median_val - I(i, j, c)) > threshold
                ier = ier + 1;
                psmf_filtered_image(i, j, c) = median_val;
            end
        end
    end
end

% Calculate performance metrics between reference and filtered images
mse = sum(sum(sum((double(ref_image) - double(psmf_filtered_image)).^2)))/(rows*cols*channels);
rmse = sqrt(mse);
max_i = double(max(ref_image(:)));
psnr = 20*log10(max_i/rmse);
[ssim_index, ~] = ssim(ref_image, psmf_filtered_image);

% Display performance metrics
fprintf('MSE: %.2f, RMSE: %.2f, PSNR: %.2f dB, SSIM: %.4f, IER: %d\n', mse, rmse, psnr, ssim_index, ier);
% Display original and filtered images
figure;
subplot(1,3,1);imshow(I);title('Noisy Image');
subplot(1,3,2);imshow(ref_image);title('Reference Image');
subplot(1,3,3);imshow(psmf_filtered_image);title('Filtered Image');
