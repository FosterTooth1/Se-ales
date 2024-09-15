clc, clear, close all;

% Punto 1: Seleccionar una señal univariable de la naturaleza
% En este caso seleccionamos una señal de audio
[audio, frecuenciaMuestreo] = audioread('minion_audio.wav');
audio = audio(:, 1); % Seleccionamos una columna porque es estereo

% Punto 2: Realizar diferentes transformaciones sobre dicha señal
% Normalizacion
audio_normalizado = audio / max(abs(audio));

% Añadimos ruido blanco
ruido_blanco = 0.01 * randn(size(audio_normalizado));
audio_con_ruido = audio_normalizado + ruido_blanco;

% Transformación 3: Completar con ceros para longitud de potencia de dos
longitudPotenciaDos = 2^nextpow2(length(audio_con_ruido));
audio_completado = [audio_con_ruido; zeros(longitudPotenciaDos - length(audio_con_ruido), 1)];

% Punto 3: Aplicar la transformada rápida de Fourier a dicha señal
% Usar el algoritmo manual y la función fft de MATLAB
transformadaManual = transformadaRapidaFourierManual(audio_completado);
transformadaFFT = fft(audio_completado);

% Comparación visual de los espectros de amplitud
frecuencias = (0:longitudPotenciaDos - 1) * (frecuenciaMuestreo / longitudPotenciaDos);
amplitudManual = abs(transformadaManual / longitudPotenciaDos);
amplitudFFT = abs(transformadaFFT / longitudPotenciaDos);

figure;
subplot(2, 1, 1);
plot(frecuencias(1:longitudPotenciaDos), amplitudManual(1:longitudPotenciaDos));
title('Espectro de Amplitud de la FFT (manual)');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');

subplot(2, 1, 2);
plot(frecuencias(1:longitudPotenciaDos), amplitudFFT(1:longitudPotenciaDos));
title('Espectro de Amplitud de la FFT (MATLAB)');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');

% Punto 4: Mostrar graficamente el espectro de amplitud de la FFT
figure;
plot(frecuencias(1:longitudPotenciaDos), amplitudFFT(1:longitudPotenciaDos));
title('Espectro de Amplitud de la FFT');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');

% Punto 5: Implementar los 4 tipos de filtrado en frecuencia
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

% Punto 6: Visualizar graficamente la señal filtrada
figure;
plot(audio_filtrado_notch);
title('Señal con los 4 filtros');
xlabel('Tiempo');
ylabel('Amplitud');

% Punto 7: Visualizar graficamente la comparación en el dominio del tiempo
figure;
plot(audio_completado);
hold on;
plot(audio_filtrado_notch);
title('Comparacion en el dominio del tiempo: Original vs Filtrada');
legend('Original', 'Filtrada');
xlabel('Tiempo');
ylabel('Amplitud');

% Punto 8: Visualizar gráficamente la comparación en el dominio de la frecuencia
transformadaFiltrada = transformadaRapidaFourierManual(audio_filtrado_notch);
amplitudFiltrada = abs(transformadaFiltrada / longitudPotenciaDos);

figure;
plot(frecuencias(1:longitudPotenciaDos), amplitudFFT(1:longitudPotenciaDos));
hold on;
plot(frecuencias(1:longitudPotenciaDos), amplitudFiltrada(1:longitudPotenciaDos));
title('Comparacion en el dominio de la frecuencia: Original vs Filtrada');
legend('Original', 'Filtrada');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');

% Funcion transformadaRapidaFourierManual para realizar la FFT manualmente
function X = transformadaRapidaFourierManual(x)
    % Obtenemos la longitud de la señal de entrada
    N = length(x);

    % Aseguramos que la longitud de la señal es una potencia de 2
    if mod(log2(N), 1) ~= 0
        error('La longitud de la señal debe ser una potencia de 2');
    end

    % Llamar a la funcion recursiva para calcular la FFT
    X = fftRecursiva(x);
end

function X = fftRecursiva(x)
    % Función recursiva para calcular la FFT

    % Obtener la longitud de la señal de entrada
    N = length(x);

    % Caso base: si N es 1, la FFT es la señal misma
    if N == 1
        X = x;
        return;
    end

    % Dividir la señal en partes par e impar
    x_pares = x(1:2:end); % Elementos pares
    x_impares = x(2:2:end); % Elementos impares

    % Calcular la FFT de las partes par e impar de forma recursiva
    X_pares = fftRecursiva(x_pares);
    X_impares = fftRecursiva(x_impares);

    % Prealocar el vector de salida
    X = zeros(N, 1);

    % Calcular los términos de la FFT usando la simetria
    for k = 0:(N / 2 - 1)
        % Calcular el factor de la exponencial compleja
        W_Nk = exp(-2i * pi * k / N);
        
        % Combinar las FFT de las partes par e impar
        X(k + 1) = X_pares(k + 1) + W_Nk * X_impares(k + 1);
        X(k + N / 2 + 1) = X_pares(k + 1) - W_Nk * X_impares(k + 1);
    end
end

