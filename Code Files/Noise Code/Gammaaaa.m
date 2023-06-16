img = imread("train.jpg");
noiseLevel = 50;

% Adding Gamma noise to an image
gammaShape = 0.1;
gammaScale = noiseLevel/100;
noise = gamrnd(gammaShape, gammaScale, size(img));
noisyImg = double(img) + noise;
noisyImg(noisyImg < 0) = 0;
noisyImg(noisyImg > 255) = 255;
noisyImg = uint8(noisyImg);

% Display the noisy image
imshow(noisyImg);
