% Read image
I = imread('impulse_20-plants.png');
I = im2double(I);

% Display original image
figure;imshow(I);title("original image");

% Apply Fourier Transform to each color channel
R = fft2(I(:,:,1));
G = fft2(I(:,:,2));
B = fft2(I(:,:,3));

% Define a low-pass filter
[x, y] = size(I(:,:,1));
r = 75;
low_pass_filter = zeros(x, y);
for i = 1:x
    for j = 1:y
        if ((i-x/2)^2 + (j-y/2)^2)^(1/2) < r
            low_pass_filter(i, j) = 1;
        end
    end
end

% Resize filter to match dimensions of Fourier Transform
low_pass_filter = imresize(low_pass_filter, [size(I(:,:,1), 1), size(I(:,:,1), 2)]);

% Apply filter to frequency domain for each color channel
Rshift = fftshift(R);
Gshift = fftshift(G);
Bshift = fftshift(B);
Rfiltered_shift = Rshift .* low_pass_filter;
Gfiltered_shift = Gshift .* low_pass_filter;
Bfiltered_shift = Bshift .* low_pass_filter;
Rfiltered = ifftshift(Rfiltered_shift);
Gfiltered = ifftshift(Gfiltered_shift);
Bfiltered = ifftshift(Bfiltered_shift);
filtered_image = cat(3, real(ifft2(Rfiltered)), real(ifft2(Gfiltered)), real(ifft2(Bfiltered)));

% Display filtered image
figure;imshow(filtered_image);title('Filtered Image');

% Calculate performance metrics between noisy and denoised images
mse = sum(sum(sum((double(I) - filtered_image).^2)))/(x*y*3);
rmse = sqrt(mse);
max_i = double(max(I(:)));
psnr = 20*log10(max_i/rmse);
ssim_index = ssim(I, filtered_image);

% Display performance metrics
fprintf('MSE: %.2f, RMSE: %.2f, PSNR: %.2f dB, SSIM: %.4f', mse, rmse, psnr, ssim_index);