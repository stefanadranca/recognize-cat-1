function [sol] = rgbHistogram(path_to_image, count_bins)
  ##citirea imaginii intr-o matrice tridimensionala
  image = imread (path_to_image);
  [rows col h] = size (image); #dimensiunile imaginii
  red = image(:, :, 1); #matricea asociata culorii rosu
  green = image(:, :, 2); #matricea asociata culorii verde
  blue = image(:, :, 3); #matricea asociata nuantelor de albastru
  count = zeros (1, count_bins);
  sol = zeros (1, 3 * count_bins);
  edges = [0:(256 / count_bins):256];
  ##vector auxiliar pentru valorile ce trebuie adaugate la fiecare iteratie
  ad = zeros (count_bins + 1, 1);
  for i = 1:rows
    ##elementele corespunzatoare R din vectorul solutie
    ad = histc (red(i, :), edges);
    sol(1:count_bins) = sol(1:count_bins) + ad(1:count_bins);
    ##elementele corespunzatoare G din vectorul solutie
    ad = histc (green(i, :), edges);
    sol(count_bins + 1 : 2 * count_bins) = sol(count_bins...
    + 1 : 2 * count_bins) + ad(1:count_bins);
    ##elementele corespunzatoare B din vectorul solutie
    ad = histc (blue(i, :), edges);
    sol(2 * count_bins + 1 : 3 * count_bins)...
    = sol(2 * count_bins + 1 : 3 * count_bins) + ad(1:count_bins);
  endfor
end