function [x] = SST(A, b)
  [n m] = size (A);
  x = zeros (m, 1);
  ##calculul ultimului element din vectorul solutie
  x(min ([n, m]), 1) = b(min ([n, m]), 1)...
  / A(min ([n, m]), min ([n, m]));
  ##calculul elementelor din vectorul solutie pe baza celor calculate anterior
  for i = min ([n, m]) - 1 : -1 : 1
    x(i) = (b(i) - (A(i, i + 1:min ([n, m]))...
    * x(i + 1:min ([n, m])))) / A(i, i);
  endfor
end
