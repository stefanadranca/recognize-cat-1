function [H S V] = rgb_hsv(R, G, B)
  Rp = double (R) / 255;
  Gp = double (G) / 255;
  Bp = double (B) / 255;
  [n m] = size (R);
  H = zeros (n, m);
  S = H;
  V = H;
  Cmax1(:, :) = max (Rp(:, :), Gp(:, :));
  Cmax(:, :) = max (Cmax1(:, :), Bp(:, :));
  Cmin1(:, :) = min (Rp(:, :), Gp(:, :)); 
  Cmin(:, :) = min (Cmin1(:, :), Bp(:, :));
  D = Cmax - Cmin;
  ##Cmax = Rp
  H(find (D != 0 & Cmax == Rp)) = 60...
  * (mod ((Gp(find (D != 0 & Cmax == Rp))...
  - Bp(find (D != 0 & Cmax == Rp)))./D(find (D != 0 & Cmax == Rp)), 6));
  ##Cmax = Gp
  H(find (D != 0 & Cmax == Gp)) = 60*((Bp(find (D != 0 & Cmax == Gp))...
  - Rp(find (D != 0 & Cmax == Gp)))./D(find (D != 0 & Cmax == Gp)) + 2);
  ##Cmax = Bp
  H(find (D != 0 & Cmax == Bp)) = 60*((Rp(find (D != 0 & Cmax == Bp))...
  - Gp(find (D != 0 & Cmax == Bp)))./D(find (D != 0 & Cmax == Bp)) + 4);
  H = double(H)/360;
  S(find (Cmax != 0)) = D(find (Cmax != 0))./Cmax(find (Cmax != 0));
  V = Cmax;
endfunction
