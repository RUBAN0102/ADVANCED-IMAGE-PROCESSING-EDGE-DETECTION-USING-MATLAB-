% ============================================================
% Project: Advanced Image Processing & Edge Detection Demo
% Author : Ruban
% ============================================================

clc; clear; close all;

%% === Step 1: Load Image Interactively ===
[file, path] = uigetfile({'*.png;*.jpg;*.jpeg;*.bmp','Image Files (*.png,*.jpg,*.jpeg,*.bmp)'}, ...
                          'Select an Image');
if isequal(file,0)
    error('No image selected. Please select an image to proceed.');
else
    I = imread(fullfile(path, file));
end

figure('Name','Advanced Image Processing Demo','NumberTitle','off');

%% === Step 2: Convert to Grayscale ===
grayImage = rgb2gray(I);

%% === Step 3: Histogram Analysis ===
subplot(2,3,1);
imshow(I); title('Original Image');

subplot(2,3,2);
imshow(grayImage); title('Grayscale Image');

subplot(2,3,3);
imhist(grayImage); title('Grayscale Histogram');

%% === Step 4: Edge Detection using Multiple Methods ===
edgeCanny   = edge(grayImage,'canny');
edgeSobel   = edge(grayImage,'sobel');
edgePrewitt = edge(grayImage,'prewitt');
edgeRoberts = edge(grayImage,'roberts');

subplot(2,3,4); imshow(edgeCanny); title('Canny Edge');
subplot(2,3,5); imshow(edgeSobel); title('Sobel Edge');
subplot(2,3,6); imshow(edgePrewitt); title('Prewitt Edge');

% Open a new figure for Roberts and overlay
figure('Name','Roberts & Edge Overlay','NumberTitle','off');

subplot(1,2,1);
imshow(edgeRoberts); title('Roberts Edge Detection');

%% === Step 5: Overlay Edges on Original Image ===
overlayImage = I;
% Highlight edges in red
if size(I,3)==3 % color image
    overlayImage(:,:,1) = I(:,:,1) + uint8(255*edgeCanny); % red channel
end

subplot(1,2,2);
imshow(overlayImage);
title('Canny Edges Overlay on Original');

%% === Step 6: Feature Detection (Optional) ===
figure('Name','Feature Detection','NumberTitle','off');
imshow(I); title('Detected Corners (Harris Method)');
hold on;
corners = detectHarrisFeatures(grayImage);
plot(corners.selectStrongest(50)); % highlight 50 strongest corners
hold off;

% ============================================================
% Explanation:
% 1. Original image is loaded interactively.
% 2. Grayscale conversion simplifies image to intensity values.
% 3. Histogram shows intensity distribution; useful for analysis.
% 4. Multiple edge detectors (Canny, Sobel, Prewitt, Roberts) applied for comparison.
% 5. Overlay demonstrates edges highlighted on original image.
% 6. Feature detection (Harris corners) shows key points in the image.
% ============================================================
