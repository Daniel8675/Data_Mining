data = readtable('Ukraine Explorer Inputs Prod - RefugeesSeries.csv');


% Zad 1
przyrost_bezwzgledny = diff(data.NoRefugees);
przyrost_wzgledny = diff(data.NoRefugees) ./ data.NoRefugees(1:end-1);
przyrost_logarytmiczny = diff(log(data.NoRefugees));

srednia_bezwzgledna = mean(przyrost_bezwzgledny);
odchylenie_std_bezwzgledne = std(przyrost_bezwzgledny);

srednia_wzgledna = mean(przyrost_wzgledny);
odchylenie_std_wzgledne = std(przyrost_wzgledny);

srednia_logarytmiczna = mean(przyrost_logarytmiczny);
odchylenie_std_logarytmiczne = std(przyrost_logarytmiczny);


osX = data.RefugeesDate(2:end);

subplot(4, 1, 1);
hold on;
plot(osX, przyrost_bezwzgledny);
plot(osX, srednia_bezwzgledna * ones(size(osX)), 'r--', 'LineWidth', 1);
plot(osX, (srednia_bezwzgledna + odchylenie_std_bezwzgledne) * ones(size(osX)), 'g--', 'LineWidth', 1);
plot(osX, (srednia_bezwzgledna - odchylenie_std_bezwzgledne) * ones(size(osX)), 'g--', 'LineWidth', 1);
hold off;
title('Przyrost bezwzględny');
xlabel('Data');
ylabel('Wartość');
axis tight;

subplot(4,1,2);
hold on;
plot(osX, przyrost_wzgledny);
plot(osX, srednia_wzgledna * ones(size(osX)), 'r--', 'LineWidth', 1);
plot(osX, (srednia_wzgledna + odchylenie_std_wzgledne) * ones(size(osX)), 'g--', 'LineWidth', 1);
plot(osX, (srednia_wzgledna - odchylenie_std_wzgledne) * ones(size(osX)), 'g--', 'LineWidth', 1);
hold off;
title('Przyrost względny');
xlabel('Data');
ylabel('Wartość');
axis tight;

subplot(4,1,3);
hold on;
plot(osX, przyrost_logarytmiczny);
plot(osX, srednia_logarytmiczna * ones(size(osX)), 'r--', 'LineWidth', 1);
plot(osX, (srednia_logarytmiczna + odchylenie_std_logarytmiczne) * ones(size(osX)), 'g--', 'LineWidth', 1);
plot(osX, (srednia_logarytmiczna - odchylenie_std_logarytmiczne) * ones(size(osX)), 'g--', 'LineWidth', 1);
hold off;
title('Przyrost logarytmiczny');
xlabel('Data');
ylabel('Wartość');
axis tight;

subplot(4,1,4);
hold on;
plot(data.RefugeesDate, data.NoRefugees);
plot(data.RefugeesDate, mean(data.NoRefugees) * ones(size(data.RefugeesDate)), 'r--', 'LineWidth', 1);
plot(data.RefugeesDate, ( mean(data.NoRefugees) +  std(data.NoRefugees)) * ones(size(data.RefugeesDate)), 'g--', 'LineWidth', 1);
plot(data.RefugeesDate, ( mean(data.NoRefugees) - std(data.NoRefugees)) * ones(size(data.RefugeesDate)), 'g--', 'LineWidth', 1);
hold off;
title('Dane Orginalne');
xlabel('Data');
ylabel('Wartość');
axis tight;


% Zad 2

x = linspace(0, length(data.NoRefugees), length(data.NoRefugees));
y = data.NoRefugees;


coeff = polyfit(x, y, 1);
trend = polyval(coeff, x);

residuals = y - trend;
error = sum(residuals.^2);

figure;
subplot(2,1,1);
plot(x, data.NoRefugees);
hold on;
plot(x, trend);
hold off;
axis tight;
title('Aproksymacja trendu liniowego')

subplot(2,1,2)
plot(x, error)
axis tight;
title('Błąd średnio-kwadratowy')

% Zad 3

figure;
sm_data_5 = smoothdata(y, 'movmean', 5);
subplot(3, 1, 1);
plot(x, y, 'b-', x, sm_data_5, 'r--');
title('Wygładzenie dla k = 5')
axis tight;

sm_data_10 = smoothdata(y, 'movmean', 10);
subplot(3, 1, 2);
plot(x, y, 'b-', x, sm_data_10, 'r--');
title('Wygładzenie dla k = 10')
axis tight;

sm_data_15 = smoothdata(y, 'movmean', 15);
subplot(3, 1, 3);
plot(x, y, 'b-', x, sm_data_15, 'r--');
title('Wygładzenie dla k = 15')
axis tight;


% Zad 4

coeff_3 = polyfit(x, y, 3);
trend_3 = polyval(coeff_3, x);

res_3 = y - trend_3.';

figure;
subplot(2,1,1);
plot(x, data.NoRefugees);
hold on;
plot(x, trend_3);
hold off;
axis tight;
title('Aproksymacja wielomianem 3-stopnia');

subplot(2,1,2);
plot(x, res_3);
title('Rezidua');
axis tight;

% Zad 5

% Metoda średniej ruchomej jest skuteczna w wygładzaniu danych, 
% eliminowaniu szumów i redukcji ekstremalnych wartości. 
% Jest szczególnie przydatna w przypadku analizy danych czasowych 
% lub szeregów czasowych, gdzie istotne jest wyłapywanie ogólnych trendów.

% Aproksymacja danych wielomianem stopnia 3 jest skuteczna w 
% identyfikowaniu trendów, odtwarzaniu ogólnego kształtu danych oraz 
% znalezieniu lokalnych ekstremów. 

% Warto również zauważyć, że analiza reziduów może być pomocna w ocenie
% skuteczności aproksymacji i wygładzania danych.

% Wybór między tymi metodami zależy od charakteru danych i celu analizy.
% Jeśli głównym celem jest wygładzenie danych i redukcja szumów, 
% metoda średniej ruchomej może być lepszym wyborem. 
% Jeśli celem jest identyfikowanie trendów i znajdowanie lokalnych 
% ekstremów, aproksymacja wielomianem stopnia 3 może być bardziej 
% odpowiednia.
