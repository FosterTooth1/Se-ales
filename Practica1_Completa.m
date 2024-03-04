close all;

% Señal 1: Presion atmosferica
altitud = 0:250:5000;
presion = [1,0.971,0.942,0.914,0.887,0.86,0.834,0.809,0.785,0.756,0.737,0.714,0.692,0.67,0.649,0.628,0.608,0.589,0.57,0.551,0.533];
%%presion = presion_superficie * exp(-altitud / escala_altitud);

figure(1)
plot(altitud, presion,'-o')
xlabel("Altitud(m)")
ylabel("presion(atm)")
title("presion atmosferica")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Señal 2: Sonido

frecuencia = 392; % Frecuencia del tono en Hz %nota sol
amplitud = 1; % Amplitud del sonido
fs = 200; % Frecuencia de muestreo en Hz 

% Generar vector de tiempo
t = 0:1/fs:4;

% Generar señal de sonido
sonido = amplitud * sin(2*pi*frecuencia*t);

% Graficar la forma de onda del sonido
figure(2)
plot(t, sonido);
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Forma de onda del sonido');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Señal 3: ph del suelo
pH = 14; % pH inicial del suelo
max_agua = 10000; % Máxima cantidad de agua en el suelo
min_agua = 0; % Mínima cantidad de agua en el suelo
incremento_agua = 1000; % Incremento en la cantidad de agua

% Generar vector de cantidad de agua en el suelo
cantidad_agua = min_agua:incremento_agua:max_agua;

% Simular relación entre pH y cantidad de agua en el suelo
pH_final = pH*cantidad_agua/max_agua;

% Graficar la relación entre pH y cantidad de agua en el suelo
figure(3)
plot(cantidad_agua, pH_final,'-o');
xlabel('Cantidad de agua en el suelo');
ylabel('pH del suelo');
title('Relación entre el pH del suelo y la cantidad de agua');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Señal 4: Elevación del nivel del mar
Tiempo = 2012:0.5:2021; % variable independiente
crecimiento_nivel_mar = [3.6, 3.4, 4, 3.8, 4.7, 4.5, 5.6, 5.4, 6.2, 6, 7.5, 7.3, 8.3, 8.1, 9, 8.8, 9.4, 9.2, 10]; % variable dependiente

% Grafica
figure(4)
plot(Tiempo, crecimiento_nivel_mar);
title('Elevación del Nivel del Mar');
xlabel('Año');
ylabel('Aumento nivel del Mar (cm)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Señal 5: Crecimiento de las plantas
cantidad_luz_solar = 150:25:1050; % variable independiente
velocidad_respiracion = [0, 0.12, 0.35, 0.6, 0.89, 1.23, 1.61, 2.04, 2.52, 3.05, 3.64, 4.29, 5.01, 5.81, 6.69, 7.66, 8.71, 9.87, 11.13, 12.52, 13.92, 15.48, 17.22, 19.17, 21.38, 23.89, 26.77, 30.11, 34, 38.55, 43.88, 50.09, 57.34, 65.82, 80, 80, 80]; % variable dependiente

% Grafica
figure(5)
plot(cantidad_luz_solar, velocidad_respiracion);
title('Crecimiento de las Plantas');
xlabel('Cantidad de Luz Solar (umol/co2/m2/s)x10');
ylabel('Velocidad de respiracion (umol/m2/s)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Señal 6: Formación de nubes en el cielo
Temperatura = 40:1:80; % variable independiente
humedad_aire = [100, 98.5, 96.5, 94.4, 92.56, 90.5, 88.5 , 85.3, 83.15, 79.3 , 76.3, 75.9, 73.3, 71.3 , 69.15 , 67.3 ,64 , 61.4 , 59.89, 57.7, 55, 52.39, 49.79, 47.19, 45.59, 42.99, 40.39, 38.79, 36.19, 35.59, 34.99, 33.39, 31.79, 29.19, 27.8, 26.6 , 25.5, 23.9, 22.5, 21.9, 20]; % variable dependiente

% Grafica
figure(6)
plot(Temperatura, humedad_aire);
title('Formación de Nubes en el Cielo');
xlabel('Temperatura (°F)');
ylabel('Humedad relativa del aire (%)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Señal 7: Temperatura de 14 días
dia = 0:10:130;
tempMaxima =[38,38,37,37,38,38,38,38,38,38,37,37,37,35];
tempminima =[20,20,20,20,21,21,20,19,19,18,18,20,19,19];

figure(7)
plot(dia,tempMaxima,'-o', dia, tempminima,'-o');
legend({'f(x) = Temperatura máxima','g(x) = Temperatura minima'},'Location','northeast');
xlabel("Día");
ylabel("Grados Celsius");
title("Temperatura de 25/02 - 09/03 Iguala Guerrero");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Señal 8: Velocidad del viento
dia2 = 0:1:7;
vientoIguala = [6,5,3,3,3,3,6,6];
vientoCDMX = [18,11,5,3,2,2,5,6];

figure(8)
plot(dia2,vientoIguala,'-o', dia2, vientoCDMX,'-o');
legend({'f(x) = vientoIguala','g(x) = vientoCDMX'},'Location','northeast');
xlabel("Día");
ylabel("Viento km/h");
title("Comparación de la velocidad del viento de Iguala - CDMX");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Señal 9: Flujo de un río
altura_pies = 0:1:10;
corriente = [0,100,200,250,300,350,400,500,1200,2400,6000];
figure(9)
plot(altura_pies,corriente,'-o');
xlabel("Altura del calibador de la corriente en pies");
ylabel("Corriente en pies cúbicos por segundo");
title("Flujo de la corriente");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Señal 10: Migración de las aves

anio = 1944:5:2004;
fecha = [9,8.93,8.9, 8.866, 8.7, 8.866,8.93,8.95, 9, 8.81,8.78, 8.72,8.7];

figure(10)
plot(anio, fecha,'-o');
xlabel("Año");
ylabel("Fecha de última observación");
title("Migración de las aves")