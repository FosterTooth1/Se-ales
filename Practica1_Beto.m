% Señal 1: Elevación del nivel del mar
Tiempo = 2012:0.5:2021; % variable independiente
crecimiento_nivel_mar = [3.6, 3.4, 4, 3.8, 4.7, 4.5, 5.6, 5.4, 6.2, 6, 7.5, 7.3, 8.3, 8.1, 9, 8.8, 9.4, 9.2, 10]; % variable dependiente

% Señal 2: Crecimiento de las plantas
cantidad_luz_solar = 150:25:1050; % variable independiente
velocidad_respiracion = [0, 0.12, 0.35, 0.6, 0.89, 1.23, 1.61, 2.04, 2.52, 3.05, 3.64, 4.29, 5.01, 5.81, 6.69, 7.66, 8.71, 9.87, 11.13, 12.52, 13.92, 15.48, 17.22, 19.17, 21.38, 23.89, 26.77, 30.11, 34, 38.55, 43.88, 50.09, 57.34, 65.82, 80, 80, 80]; % variable dependiente

% Señal 3: Formación de nubes en el cielo
Temperatura = 40:1:80; % variable independiente
humedad_aire = [100, 98.5, 96.5, 94.4, 92.56, 90.5, 88.5 , 85.3, 83.15, 79.3 , 76.3, 75.9, 73.3, 71.3 , 69.15 , 67.3 ,64 , 61.4 , 59.89, 57.7, 55, 52.39, 49.79, 47.19, 45.59, 42.99, 40.39, 38.79, 36.19, 35.59, 34.99, 33.39, 31.79, 29.19, 27.8, 26.6 , 25.5, 23.9, 22.5, 21.9, 20]; % variable dependiente

% Graficar las señales
figure;

% Señal 1: Elevación del nivel del mar
subplot(3, 1, 1);
plot(Tiempo, crecimiento_nivel_mar);
title('Elevación del Nivel del Mar');
xlabel('Año');
ylabel('Aumento nivel del Mar (cm)');

% Señal 2: Crecimiento de las plantas
subplot(3, 1, 2);
plot(cantidad_luz_solar, velocidad_respiracion);
title('Crecimiento de las Plantas');
xlabel('Cantidad de Luz Solar (umol/co2/m2/s)x10');
ylabel('Velocidad de respiracion (umol/m2/s)');

% Señal 3: Formación de nubes en el cielo
subplot(3, 1, 3);
plot(Temperatura, humedad_aire);
title('Formación de Nubes en el Cielo');
xlabel('Temperatura (°F)');
ylabel('Humedad relativa del aire (%)');

% Ajustar las subtramas
sgtitle('Gráficas de Señales');