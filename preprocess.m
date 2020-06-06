function [X, y] = preprocess(path_to_dataset, histogram, count_bins)
  path_to_cats = path_to_dataset;
  ##cale catre director poze cu pisici
  path_to_cats = strcat (path_to_cats, "cats/");
  ##cale director poze fara pisici
  path_to_noncats = strcat (path_to_dataset, "not_cats/");
  ##matrice cu linii siruri de caractere reprezentand pathuri catre fisiere
  images1 = strcat (path_to_cats, readdir (path_to_cats));
  images2 = strcat (path_to_noncats, readdir (path_to_noncats));
  images1 = char (images1);
  images2 = char (images2);
  n1 = rows (images1);
  n2 = rows (images2);
 
  X = zeros (n1 + n2 - 6, 3 * count_bins);
  y = zeros (n1 + n2 -6, 1);
  
  ##determinarea tipului de histograma ceruta
  if strcmp (histogram, "RGB")
    ok = 1;
  elseif strcmp (histogram, "HSV")
    ok = 0;
  else
    disp ("Eroare: nu ati scris corect tipul histogramei");
  endif
  ##initializarea liniilor corespunzatoare pozelor cu pisici
  for i = 3 : n1 - 1
    if (ok == 1)
      X(i - 2, :) = rgbHistogram(images1(i, :), count_bins);
    else
       X(i - 2, :) = hsvHistogram(images1(i, :), count_bins); 
  endif
   y(i - 2) = 1;
  endfor
  ##initializarea liniilor corespunzatoare pozelor fara pisici
  for i = 3 : n2 - 1
    if (ok == 1)
      X(n1 - 5 + i, :) = rgbHistogram(images2(i, :), count_bins);
    else
      X(n1 - 5 + i, :) = hsvHistogram(images2(i, :), count_bins);
    endif
     y(n1 - 5 + i) = -1;
  endfor
endfunction