function [w] = learn(X, y)
  w = zeros (columns (X) + 1, 1);
  Xp = X;
  Xp(:, columns (X) + 1) = 1;
  [Q R] = Householder (Xp);
  w = SST (R, Q' * y);
end
