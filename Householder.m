function [Q, R] = Householder(A)
  [n m] = size (A);
  H = eye (n);
  In = H;
  vp = zeros (n, 1);
  for p = 1:min ([n - 1, m])
    #calculare reflector Householder
    vp(1:p - 1, 1) = 0;
    sigma = sign (A(p, p)) * norm (A(p:n, p));
    vp(p, 1) = A(p, p) + sigma;
    vp(p + 1:n, 1) = A(p + 1 : n, p);
    vt = vp';
    Hp = In - 2 * ((vp * vt) / (vt * vp));
    
    A = Hp * A;
    H = Hp * H;
  endfor
  Q = H';
  R = A;
endfunction