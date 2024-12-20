%% PC 2
% Nombre: Almendra Quispe
% Código: 20193348

% Sobre los datos: Fueron extraidos de las series rimestrales del BCRP
% variable 1: consumo privado (PN02541AQ)
% variable 2: Gasto no financiero (PN03304FQ)
% variable 3: PBI (PN39029BQ)

%% Cargamos la base de datos
clear;
clc;

cd 'C:\Users\almen\OneDrive\Escritorio\ESTADISTICA APLICADA\Pc_2'
series = 'series.xlsx';

data = readtable(series);

% variable 1: consumo privado
% variable 2: Gasto no financiero
% variable 3: PBI

% Definimos las variables y aplicampos logaritmos
Consumo_Privado_0 = table2array(data(:, 1));
Gasto_No_Financiero_0 = table2array(data(:, 2));
PBI_0 = table2array(data(:, 3));

% aplicamos logaritmos
Consumo_Privado_0 = log(Consumo_Privado_0);
Gasto_No_Financiero_0 = log(Gasto_No_Financiero_0);
PBI_0 = log(PBI_0);


% Verificar estacionariedad
[h1_log, pValue1_log] = adftest(Consumo_Privado_0); 
[h2_log, pValue2_log] = adftest(Gasto_No_Financiero_0);
[h3_log, pValue3_log] = adftest(PBI_0); 

disp(['pValue1_log: ', num2str(pValue1_log)]);
disp(['h1_log: ', num2str(h1_log)]);
disp(['pValue2_log: ', num2str(pValue2_log)]);
disp(['h2_log: ', num2str(h2_log)]);
disp(['pValue3_log: ', num2str(pValue3_log)]);
disp(['h3_log: ', num2str(h3_log)]);

% Mostrar resultados
disp('Resultados de la prueba de Dickey-Fuller aumentada :');
fprintf('Consumo Privado - p-valor: %.4f (Estacionaria: %d)\n', pValue1_log, h1_log);
fprintf('Gasto No Financiero - p-valor: %.4f (Estacionaria: %d)\n', pValue2_log, h2_log);
fprintf('PBI - p-valor: %.4f (Estacionaria: %d)\n', pValue3_log, h3_log);

% no son estacionarias

%%
% OJO: borramos lo que no se usara posteriormente
clear h1_log
clear h2_log
clear h3_log

clear pValue1_log
clear pValue2_log
clear pValue3_log

%% PREGUNTA 10
% Desestacionalice las tres series con promedios móviles y grafíquelas. 
% Explique brevemente el comportamiento de estas a través de estadísticos. 

% Definir el tamaño de la ventana para el promedio móvil
windowSize = 4;

% Calcular promedios móviles para cada serie desestacionalizada
movingAvg_Consumo = movmean(Consumo_Privado_0, windowSize);
movingAvg_Gasto = movmean(Gasto_No_Financiero_0, windowSize);
movingAvg_PBI = movmean(PBI_0, windowSize);

% Desestacionalización de las series originales
deseasonalized_Consumo = Consumo_Privado_0 - movingAvg_Consumo;
deseasonalized_Gasto = Gasto_No_Financiero_0 - movingAvg_Gasto;
deseasonalized_PBI = PBI_0 - movingAvg_PBI;

% Graficar las series desestacionalizadas
figure;

% Consumo Privado
subplot(3, 1, 1);
plot(deseasonalized_Consumo);
title('Consumo Privado Desestacionalizado');
xlabel('Período');
ylabel('Consumo Privado');
grid on;

% Gasto No Financiero
subplot(3, 1, 2);
plot(deseasonalized_Gasto);
title('Gasto No Financiero Desestacionalizado');
xlabel('Período');
ylabel('Gasto No Financiero');
grid on;

% PBI
subplot(3, 1, 3);
plot(deseasonalized_PBI);
title('PBI Desestacionalizado');
xlabel('Período');
ylabel('PBI');
grid on;


% Ajustar el tamaño de la figura
set(gcf, 'Position', [100, 100, 800, 600]);

%% Estadísticos descriptivos
% Estadísticos descriptivos para las series desestacionalizadas
mean_Consumo = mean(deseasonalized_Consumo);
median_Consumo = median(deseasonalized_Consumo);
std_Consumo = std(deseasonalized_Consumo);

mean_Gasto = mean(deseasonalized_Gasto);
median_Gasto = median(deseasonalized_Gasto);
std_Gasto = std(deseasonalized_Gasto);

mean_PBI = mean(deseasonalized_PBI);
median_PBI = median(deseasonalized_PBI);
std_PBI = std(deseasonalized_PBI);

% Mostrar los estadísticos descriptivos

disp('Consumo Privado:');
disp(['Media: ', num2str(mean_Consumo)]);
disp(['Mediana: ', num2str(median_Consumo)]);
disp(['Desviación estándar: ', num2str(std_Consumo)]);
disp(' ');

disp('Gasto No Financiero:');
disp(['Media: ', num2str(mean_Gasto)]);
disp(['Mediana: ', num2str(median_Gasto)]);
disp(['Desviación estándar: ', num2str(std_Gasto)]);
disp(' ');

disp('PBI:');
disp(['Media: ', num2str(mean_PBI)]);
disp(['Mediana: ', num2str(median_PBI)]);
disp(['Desviación estándar: ', num2str(std_PBI)]);

%%
% Verificar estacionariedad de las series desestacionalizadas
[h1_log, pValue1_log] = adftest(deseasonalized_Consumo); 
[h2_log, pValue2_log] = adftest(deseasonalized_Gasto);
[h3_log, pValue3_log] = adftest(deseasonalized_PBI); 

disp(['pValue1_log: ', num2str(pValue1_log)]);
disp(['h1_log: ', num2str(h1_log)]);
disp(['pValue2_log: ', num2str(pValue2_log)]);
disp(['h2_log: ', num2str(h2_log)]);
disp(['pValue3_log: ', num2str(pValue3_log)]);
disp(['h3_log: ', num2str(h3_log)]);

% Mostrar resultados
disp('Resultados de la prueba de Dickey-Fuller aumentada :');
fprintf('Consumo Privado - p-valor: %.4f (Estacionaria: %d)\n', pValue1_log, h1_log);
fprintf('Gasto No Financiero - p-valor: %.4f (Estacionaria: %d)\n', pValue2_log, h2_log);
fprintf('PBI - p-valor: %.4f (Estacionaria: %d)\n', pValue3_log, h3_log);

% Ahora sí son estacionarias

%%
% OJO: borramos lo que no se usara posteriormente
clear std_PBI
clear std_Gasto
clear std_Consumo

clear windowSize

clear movingAvg_PBI
clear movingAvg_Gasto
clear movingAvg_Consumo

clear median_PBI
clear median_Gasto
clear median_Consumo

clear mean_PBI
clear mean_Gasto
clear mean_Consumo

clear h1_log
clear h2_log
clear h3_log

clear pValue1_log
clear pValue2_log
clear pValue3_log

%% PREGUNTA 11:
% Con las tasas de variaciones porcentuales doce meses de las tres variables, 
% estime un modelo VAR de forma reducida con 2 rezagos y una constante. 
% Muestre sus resultados. 

% Calcular tasas de variaciones porcentuales a doce meses (ojo: trimestrales)
% OJO: se trabajará con las series destacionalizadas 

Y = [deseasonalized_Consumo, deseasonalized_Gasto, deseasonalized_PBI];
Y_pct = 100 * (Y(5:end, :) - Y(1:end-4, :)) ./ Y(1:end-4, :);

%%
% Definir el modelo VAR
p = 2; % número de rezagos
model = varm(size(Y_pct, 2), p); 
model.SeriesNames = ["consumo_privado" "gasto_no_fin" "pbi"];
model.Constant = 1;

% Estimación del modelo
est_model = estimate(model, Y_pct);

summarize(est_model)

%%
% Mostrar los resultados del modelo estimado
results0 = summarize(est_model);
disp('Resultados del modelo VAR estimado:');
disp(results0);


% Coeficientes estimados
A1 = est_model.AR{1}; % Coeficientes del primer rezago
A2 = est_model.AR{2}; % Coeficientes del segundo rezago
const = est_model.Constant; % Constante

disp('Coeficientes del primer rezago:');
disp(A1);

disp('Coeficientes del segundo rezago:');
disp(A2);

disp('Constante:');
disp(const);

%% Verificamos la estabilidad del modelo
% Formar la matriz de coeficientes aumentada
K = size(A1, 1);
p = 2; % Número de rezagos
companion_matrix = [A1, A2; eye(K*(p-1)), zeros(K*(p-1), K)];

% Calcular los valores propios de la matriz compañera
eigenvalues = eig(companion_matrix);
stable = all(abs(eigenvalues) < 1);

% Resultados
disp('Valores propios del polinomio característico:');
disp(eigenvalues);
if stable
    disp('El modelo VAR es estable.');
else
    disp('El modelo VAR no es estable.');
end
% el modelo var es estable


%% PREGUNTA 12
% Realice tests de causalidad a la Granger, excluyendo el rezago de cada variable en 
% cada una de las ecuaciones presentes en el modelo VAR. Comente sus resultados (1 puntos)

% consumo_privado
gctest(est_model, "Type","leave-one-out", "Effect",'consumo_privado')
% Los rezagos de "consumo_privado" y "pbi" no tienen un efecto significativo en el Consumo privado.
% Los rezagos de "gasto_no_fin" tienen un efecto significativo en el "consumo_privado".

% gasto_no_fin
gctest(est_model, "Type","leave-one-out", "Effect",'gasto_no_fin')
% Los rezagos de "consumo_privado", "gasto_no_fin" y "pbi" no tienen un efecto significativo en el Gasto Público no financiero.

% pbi
gctest(est_model, "Type","leave-one-out", "Effect",'pbi')
% Los rezagos de "consumo_privado", "gasto_no_fin" y "pbi" no tienen un efecto significativo en el PBI.

%% PREGUNTA 13
% Calcule y grafique las funciones impulso respuesta ante un shock estructural del
% gasto público. (1 punto)

% Coeficientes de la representación VMA
max_horizon = 25; % Definir el horizonte máximo
vmacoefs = arma2ma(est_model.AR, [], max_horizon);

% Usamos la descomposición de Cholesky
S = chol(est_model.Covariance)';
diagS = diag(diag(S));

B_0 = inv(S / diagS);
D = diagS.^2;

% Estandarización de los shocks
S = inv(B_0) * (D .^ (1/2));

% Calculo de funciones impulso-respuesta para 'gasto_no_fin'
shock_variable = 'gasto_no_fin';
shock_index = find(strcmp(est_model.SeriesNames, shock_variable));

horizon = 10; % Definir el horizonte
IRF = zeros(horizon + 1, size(S, 1));

% h = 1
IRF(1, :) = S(shock_index, :);

% h = 2 en adelante
for i = 1:horizon
    if i <= length(vmacoefs)
        temp = vmacoefs{i} * S;
        IRF(i + 1, :) = temp(shock_index, :);
    else
        break;
    end
end

% Ajustar el tamaño de la figura
figure;
hold on;
colors = lines(size(IRF, 2)); % Obtener colores para cada variable

for i = 1:size(IRF, 2)
    plot(0:horizon, IRF(:, i), 'LineWidth', 2, 'Color', colors(i, :));
end

title('Funciones de respuesta al impulso ante un shock de Gasto Público no financiero', 'Interpreter', 'none');
xlabel('Horizonte');
ylabel('IRF');
legend(est_model.SeriesNames, 'Location', 'best');
grid on;
hold off;

set(gcf, 'Position', [100, 100, 800, 600]);


