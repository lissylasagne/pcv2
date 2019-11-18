function exercise2()  
  [x1, y1] = processImage(4, "/home/lissy/Documents/ComputerVision/pcv2/image1", 1)
  #[x2, y2] = processImage(4, "/home/lissy/Documents/ComputerVision/pcv2/image2", 2)
  #[x3, y3] = processImage(4, "/home/lissy/Documents/ComputerVision/pcv2/image3", 3)

  #[x1_1, y1_1] = 
  coordinateTransformation(x1, y1)
  
function [x,y] = processImage(numPoints, imagePath, iterator)
  image = imread(imagePath);
  figure(iterator);
  imshow(image);
  [x, y] = ginput(numPoints);
  
function [out_x, out_y] = coordinateTransformation(in_x, in_y)
  #get mean of translation
  t_x = mean(in_x);
  t_y = mean(in_y);
  
  #translate points to the origin
  new_x = abs(in_x - t_x);
  new_y = abs(in_y - t_y);
  
  #get mean of the scale
  s_x = mean(new_x);
  s_y = mean(new_y);
  
  #matrix multiplied with points
  M1 = [ 1/s_x 0 0;
        0 1/s_y 0;
        0 0 1];
       
  M2 = [1 0 -t_x;
        0 1 -t_y;
        0 0 1];
        
  T = M1 * M2;

  for var = 1:rows(in_x)
    out = T * [in_x(var,1); in_y(var,1); 1];
    #use computed point to get the designmatrix
    designMatrix(out(1,1), out(2,1));
  end
  
function A = designMatrix(in_x, in_y)
  u = in_x * [in_x, in_y, 1];
  v = in_y * [in_x, in_y, 1];
  w = -1 * [in_x, in_y, 1];
  
  #matrix composition like in slides
  #TODO: normalize vectors???
  A = [w 0 0 0 u;
       0 0 0 w v]
