function exercise2()  
  [x1, y1] = processImage(4, "/home/lissy/Documents/ComputerVision/pcv2/image1", 1)
  #[x2, y2] = processImage(4, "/home/lissy/Documents/ComputerVision/pcv2/image2", 2)
  #[x3, y3] = processImage(4, "/home/lissy/Documents/ComputerVision/pcv2/image3", 3)

  [t_x, t_y, s_x, s_y] = meanFunction(x1, y1)
  
function [x,y] = processImage(numPoints, imagePath, iterator)
  image = imread(imagePath);
  figure(iterator);
  imshow(image);
  [x, y] = ginput(numPoints);
  
function [t_x, t_y, s_x, s_y] = meanFunction(inx, iny)
  #get mean of translation
  t_x = mean(inx);
  t_y = mean(iny);
  
  #translate points to the origin
  new_x = abs(inx - t_x);
  new_y = abs(iny - t_y);
  
  #get mean of the scale
  s_x = mean(new_x);
  s_y = mean(new_y);