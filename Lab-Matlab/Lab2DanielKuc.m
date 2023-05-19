data = readtable('Ukraine Explorer Inputs Prod - RefugeesSeries.csv');

% Zad 1

data.NewSeries = randn(height(data), 1);

% Zad 2

corr = corrcoef(data.NoRefugees, data.NewSeries);

display(corr);

% Zad 3

euclidean = norm(data.NoRefugees - data.NewSeries);

p = 3;
minkowski = sum(abs(data.NoRefugees - data.NewSeries).^p)^(1/p);

display(euclidean);
display(minkowski);

% Zad 4a

okno_dl = 22;

szereg = data.NewSeries;
srednia = movmean(szereg, okno_dl);

licznik_skokowych = 0;
wzorzec_pojawienia = [];

for i = 1:length(szereg)
    if i > 1 && abs(szereg(i) - szereg(i-1)) > 1.5 * srednia(i)
        licznik_skokowych = licznik_skokowych + 1;
     
        wzorzec_pojawienia = [wzorzec_pojawienia, i];
        
        if licznik_skokowych >= 3
            disp("Znaleziono wzorzec pojawienia się co najmniej 3 kolejnych skokowych wartości.");
            disp("Indeksy skokowych wartości: ");
            disp(wzorzec_pojawienia);
            break;
        end
    else
        licznik_skokowych = 0;
        wzorzec_pojawienia = [];
    end
end

% Zad 4b

szereg = data.NewSeries;
wzorzec_pojawienia = [];

for i = 1:(length(szereg)-3)
    if (szereg(i+1) > szereg(i) && szereg(i+2) < szereg(i+1) && szereg(i+3) < szereg(i+2)) || ...
       (szereg(i+1) > szereg(i) && szereg(i+2) < szereg(i+1) && szereg(i+3) > szereg(i+2)) || ...
       (szereg(i+1) < szereg(i) && szereg(i+2) > szereg(i+1) && szereg(i+3) < szereg(i+2)) || ...
       (szereg(i+1) < szereg(i) && szereg(i+2) > szereg(i+1) && szereg(i+3) > szereg(i+2))
        
        wzorzec_pojawienia = [wzorzec_pojawienia, i:(i+3)];
        
        
        disp("Znaleziono wzorzec sekwencji o długości 4 próbek z wymaganą zmianą znaku skokowej zmiany.");
        disp("Indeksy sekwencji: ");
        disp(i:(i+3));
    end
end

