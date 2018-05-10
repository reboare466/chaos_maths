%%%%% self organising map
clear
% close all

tic % start timing just because I like to know how long it takes

%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Set Algorithm Variables
%%%%%%%%%%%%%%%%%%%%%%%%

iterations = 10000; % how long to run sim (converge to image by this point)
L_i = 0.1; % initial learning coefficient (% of difference)
L_s = 0.995; % scaling factor of learning coefficient per itteration (force convergence)
local = 500; % magnitude of localisation of neighbourhood function (gaussian)

%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Set final image variables (size/#colours) and get/scale image
%%%%%%%%%%%%%%%%%%%%%%%%

n_colours = 10; % number of final colour levels
dim = [360,360]; % the maximum dimensions within which to place your image

image = imread('rohanflagoriginal.jpg'); % starting image
[sx,sy] = size(image(:,:,1)); % get image size

dim_ratio = dim(1)./dim(2); % check ratio of image size limits
im_ratio = sx./sy; % get ratio of starting image

if dim_ratio > im_ratio % check maximum image dimension
    scale = dim(2)./sy; % set scale factor
else
    scale = dim(1)./sx; % if dimension ratio different other set scale accordingly
end
image_new = imresize(image,scale,'bicubic'); % scale image

inputs = double(image_new)./256; % convert to double precision for maths
[sx2,sy2] = size(inputs(:,:,1)); % get scaled pixel dimensions

%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Select Best Colours via Self-Organising Map (maximally connected)
%%%%%%%%%%%%%%%%%%%%%%%%

nodes = rand(n_colours,3); % generate colour value matrix with rand entries

for j = 1:n_colours % for each colour entry
    nodes_coords = ceil([sx2.*rand,sy2.*rand]); % pick rand image coords
    % get colour from those coords (in the sample space)
    nodes(j,1) = inputs(nodes_coords(1),nodes_coords(2),1);
    nodes(j,2) = inputs(nodes_coords(1),nodes_coords(2),2);
    nodes(j,3) = inputs(nodes_coords(1),nodes_coords(2),3);
end

nodes_temp = nodes; % duplicate colours array

active_input = zeros(1,3); % initialise sampling array

for lambda = 1:iterations % for each of this number of steps
    input_coords = ceil([sx2.*rand,sy2.*rand]); % get rand coords
    % get colour from those coords
    active_input(1,1) = inputs(input_coords(1),input_coords(2),1);
    active_input(1,2) = inputs(input_coords(1),input_coords(2),2);
    active_input(1,3) = inputs(input_coords(1),input_coords(2),3);

    diff = zeros(size(nodes_temp)); % zero difference vector matrix (RGB)
    dist = zeros(1,n_colours); % zero distance magnitude matrix
    dist_min = 3; % initialise number for minimum distance
    for j = 1:n_colours % for every colour
        diff(j,:) = active_input - nodes_temp(j,:); % find difference vector
        dist(1,j) = sqrt(sum((diff(j,:)).^2)); % find distance magnitude
        if dist(1,j) < dist_min % if new min dist
            dist_min = dist(1,j); % store min dist
        end
    end

    for j = 1:n_colours % for each colour
        if dist(1,j) < 3 % check cut off distance (restricts nodes effected)
            % move colour closer to sample dependent on difference
            % and itteration number (for convergence)
            nodes_temp(j,:) = nodes_temp(j,:) ...
                            + (L_i.*L_s.^lambda) ...
                            .*diff(j,:).*exp(-local.*((dist(1,j)).^2));
        end
    end
end % repeat node adjustment

outputs = nodes_temp; % store final colour selection

%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Set Image Colours to Best Match SOM Colours
%%%%%%%%%%%%%%%%%%%%%%%%

image_inputs = double(image_new)./256; % normalise image RGB

for j = 1:sx2 % for each x-coord
    for k = 1:sy2 % for each y-coord
        dist2_min = 3; % initialise new minimum distance number
        for l = 1:n_colours % for each selected colour
            % check difference and distance to pixel colour
            diff2 = reshape(image_inputs(j,k,:),[1,3]) - outputs(l,:);
            dist2 = sqrt(sum((diff2).^2));
            if dist2 < dist2_min % check for minimum distance
                dist2_min = dist2; % store min distance
                index = l; % store min distance index
            end
        end
        % set pixel colour to closest selected colour
        image_inputs(j,k,:) = outputs(index,:);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Image Display
%%%%%%%%%%%%%%%%%%%%%%%%

h = figure; % open figure
imshow(uint8(image_inputs.*256)) % display converted image in figure

toc % output total script time

%imwrite(uint8(image_inputs.*256),'rohanflag.png')