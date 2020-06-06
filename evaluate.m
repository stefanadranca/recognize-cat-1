function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  ##cale director poze cu pisici
  path_to_cats = path_to_testset;
  path_to_cats = strcat (path_to_cats, "cats/");
  ##cale director poze fara pisici
  path_to_noncats = strcat (path_to_testset, "not_cats/");
  images1 = strcat (path_to_cats, readdir (path_to_cats));
  images2 = strcat (path_to_noncats, readdir (path_to_noncats));
  images1 = char (images1);
  images2 = char (images2);
  n1 = rows (images1); #numarul de fisiere din directorul cu pisici
  n2 = rows (images2); #numarul de fisiere din directorul cu poze fara pisici
  x = zeros (1, 3 * count_bins + 1);
  x(1, 3 * count_bins + 1) = 1;
  nr_cats = 0;
  nr_cats_n = 0;
  ##determinarea tipului de histograma ceruta
  if strcmp (histogram, "RGB")
    ok = 1;
  elseif strcmp (histogram, "HSV")
    ok = 0;
  else
    disp ("Eroare: nu ati scris corect tipul histogramei");
  endif
  ##vectorul de caracteristici pentru pozele cu pisici
  for i = 3 : n1 - 1
    if (ok == 1)
      x = rgbHistogram (images1(i, :), count_bins);
    else
      x = hsvHistogram (images1(i, :), count_bins);
    endif
    x(3 * count_bins + 1) = 1;
    if (w' * x') >= 0
      nr_cats = nr_cats + 1; #poze incadrate corect ca fiind cu pisici
    endif
  endfor
  ##vectorul de caracteristici pentru pozele fara pisci
  for i = 3 : n2 - 1
    if (ok == 1)
       x = rgbHistogram (images2(i, :), count_bins);
    else
      x = hsvHistogram (images2(i, :), count_bins);  
    endif
    x(3 * count_bins + 1) = 1;
    if (w' * x') >= 0 #poze incadrate gresit ca fiind cu pisici
     nr_cats_n = nr_cats_n + 1;
   endif
  endfor
  ##determinarea procentului : nr incadrari corecte/nr total de poze
  percentage = (nr_cats + n2 - 3 - nr_cats_n) / (n1 + n2 - 6);
endfunction
