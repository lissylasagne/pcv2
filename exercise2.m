function exercise2()
  I1 = imread("/home/lissy/Documents/ComputerVision/image1");
  I2 = imread("/home/lissy/Documents/ComputerVision/image2");
  I3 = imread("/home/lissy/Documents/ComputerVision/image3");
  
  figure(1);
  imshow(I1);
  [x1, y1] = ginput()
  disp("Pleade press ENTER when you're finished")
  
  length = ndims(x1);
  
  figure(2);
  imshow(I2);
  [x2, y2] = ginput(length+1)
  
  figure(3);
  imshow(I3);
  [x3, y3] = ginput(length+1)
  
