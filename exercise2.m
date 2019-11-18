function exercise2()
  I1 = imread("/home/lissy/Documents/ComputerVision/pcv2/image1");
  I2 = imread("/home/lissy/Documents/ComputerVision/pcv2/image2");
  I3 = imread("/home/lissy/Documents/ComputerVision/pcv2/image3");
  
  figure(1);
  imshow(I1);
  [x1, y1] = ginput()
  disp("Pleade press ENTER when you're finished")
  
  length = rows(x1);
  
  figure(2);
  imshow(I2);
  [x2, y2] = ginput(length)
  
  figure(3);
  imshow(I3);
  [x3, y3] = ginput(length)
  
