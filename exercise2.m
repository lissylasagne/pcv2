function exercise2()  
  #[x1, y1] = processImage(4, "/home/lissy/Documents/ComputerVision/pcv2/image1", 1)
  #[x2, y2] = processImage(4, "/home/lissy/Documents/ComputerVision/pcv2/image2", 2)
  #[x3, y3] = processImage(4, "/home/lissy/Documents/ComputerVision/pcv2/image3", 3)

  #coordinateTransformation(x1, y1)
  
  #using point from slide here
  x1 = [93; 729; 152; 703];
  y1 = [617; 742; 1103; 1233];
  x2 = [0; 639; 0; 0; 639];
  y2 = [0; 0; 639; 639];
  
  #get T and T'
  T1 = coordinates(x1, y1)
  T2 = coordinates(x2, y2)
  
  A = designMatrix(T1, T2, x1, y1, x2, y2)
  
  H_tilde = solveEquation(A)
  
  #reverse conditioning
  H = inv(T2) * H_tilde * T1
  
  
  
function [x,y] = processImage(numPoints, imagePath, iterator)
  image = imread(imagePath);
  figure(iterator);
  imshow(image);
  [x, y] = ginput(numPoints);
  
function T = coordinates(in_x, in_y)
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
  
function A = designMatrix(T1, T2, in_x1, in_y1, in_x2, in_y2)
  A = zeros(rows(in_x1)*2, 9);
  for var = 1:rows(in_x1)
    #get x tilde = T * x
    out1 = T1 * [in_x1(var,1); in_y1(var,1); 1];
    out2 = T2 * [in_x2(var,1); in_y2(var,1); 1];
    
    #use computed points to get the designmatrix
    #put the results in one big matrix
    A([(2*var)-1, 2*var], :) = designMatrixPart(out1(1,1), out1(2,1), out2(1,1), out2(2,1));
  end
  
#this function computes one part of the design matrix  
function A = designMatrixPart(in_x1, in_y1, in_x2, in_y2)
  u = in_x2 * [in_x1, in_y1, 1];
  u = u / u(1,3);
  
  v = in_y2 * [in_x1, in_y1, 1];
  v = v / v(1,3);
  w = -1 * [in_x1, in_y1, 1];
  
  #matrix composition like in slides
  A = [w 0 0 0 u;
       0 0 0 w v];
  
function H = solveEquation(A)
  [U, S, V] = svd (A);
  S_min = min(diag(S));
  
  for var = 1:rows(S)
    if S(var,var) == S_min
      row = var;
    end
  end
  
  #reshape the column of V
  H = reshape(V(:, row), sqrt(rows(V)), sqrt(rows(V)));