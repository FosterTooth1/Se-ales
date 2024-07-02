clc, clear, close all;

% Seleccionar una señal univariable de la naturaleza
% En este caso seleccionamos una señal de audio
[audio, frecuenciaMuestreo] = audioread('minion_audio.wav');
audio_completado = audio(:, 1); % Seleccionamos una columna porque es estereo

longitud = length(audio_completado);

% Punto 1: Aplicar la transformada Rapida de Fourier a dicha señal
transformadaFFT = fft(audio_completado);

% Comparacion visual de los espectros de amplitud
frecuencias = (0:longitud - 1) * (frecuenciaMuestreo / longitud);
amplitudFFT = abs(transformadaFFT / longitud);

% Punto 2: Mostrar graficamente el espectro de amplitud de la FFT
figure;
plot(frecuencias(1:longitud), amplitudFFT(1:longitud));
title('Espectro de Amplitud de la FFT');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');

% Punto 3: Implementar los 4 tipos de filtrado en frecuencia
%Filtro FIR Pasa-Altas con Fc = 500 Hz
frecuenciaCorteAlta = 500;
[filtroAlto, respuestaAlto] = fir1(48, frecuenciaCorteAlta / (frecuenciaMuestreo / 2), 'high');
audio_filtrado_alto = filter(filtroAlto, respuestaAlto, audio_completado);

%Filtro FIR Pasa-Bajas con Fc = 1000 Hz
frecuenciaCorteBaja = 1000;
[filtroBajo, respuestaBajo] = fir1(48, frecuenciaCorteBaja / (frecuenciaMuestreo / 2), 'low');
audio_filtrado_bajo = filter(filtroBajo, respuestaBajo, audio_filtrado_alto);

%Filtro FIR Pasa-Banda con Fc1 = 500 Hz y Fc2 = 2000 Hz
frecuenciaCorteBanda1 = 500;
frecuenciaCorteBanda2 = 2000;
[filtroBanda, respuestaBanda] = fir1(48, [frecuenciaCorteBanda1, frecuenciaCorteBanda2] / (frecuenciaMuestreo / 2), 'bandpass');
audio_filtrado_banda = filter(filtroBanda, respuestaBanda, audio_filtrado_bajo);

%Filtro FIR Rechaza-Banda con Fc1 = 500 Hz y Fc2 = 2000 Hz
[filtroNotch, respuestaNotch] = fir1(48, [frecuenciaCorteBanda1, frecuenciaCorteBanda2] / (frecuenciaMuestreo / 2), 'stop');
audio_filtrado_notch = filter(filtroNotch, respuestaNotch, audio_filtrado_banda);

% Punto 4: Visualizar graficamente la señal filtrada
figure;
plot(audio_filtrado_notch);
title('Señal con los 4 filtros');
xlabel('Tiempo');
ylabel('Amplitud');

% Punto 5: Visualizar graficamente la comparación en el dominio del tiempo
figure;
plot(audio_completado);
hold on;
plot(audio_filtrado_notch);
title('Comparacion en el dominio del tiempo: Original vs Filtrada');
legend('Original', 'Filtrada');
xlabel('Tiempo');
ylabel('Amplitud');

% Punto 6: Visualizar gráficamente la comparación en el dominio de la frecuencia
transformadaFiltrada = fft(audio_filtrado_notch);
amplitudFiltrada = abs(transformadaFiltrada / longitud);

figure;
plot(frecuencias(1:longitud), amplitudFFT(1:longitud));
hold on;
plot(frecuencias(1:longitud), amplitudFiltrada(1:longitud));
title('Comparacion en el dominio de la frecuencia: Original vs Filtrada');
legend('Original', 'Filtrada');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');