% Parámetros
B = 1; % ancho de banda absoluto
f0 = B/2; % ancho de banda de 6dB
rolloff = [0, 0.25, 0.75, 1]; % factores de roll-off

% Tiempo y frecuencia
t = 0:1e-4:8; % tiempo
f = linspace(-2*B, 2*B, 1000); % frecuencia

% Graficar respuesta al impulso y respuesta en frecuencia
figure;

randomBits = randi([0 1],104,1);





for i = 1:length(rolloff)
    alpha = rolloff(i);
    f_delta = alpha*f0;
    f1 = f0 - f_delta;

    % Respuesta en frecuencia
    He = zeros(size(f));
    He(abs(f) < f1) = 1;
    He(f1 < abs(f) & abs(f) < B) = 0.5 * (1 + cos(pi*(abs(f(f1 < abs(f) & abs(f) < B))-f1)/(2*f_delta)));
    
    % Respuesta al impulso
    he = 2*f0 * (sin(2*pi*f0*t)./(2*pi*f0*t)) .* (cos(2*pi*f_delta*t)./(1-(4*f_delta*t).^2));

    % Graficar
    subplot(2, 1, 1);
    hold on;
    plot(t, he);
    xlabel('Tiempo (t)');
    ylabel('he(t)');
    title('Respuesta al impulso');

    subplot(2, 1, 2);
    hold on;
    plot(f, He);
    xlabel('Frecuencia (f)');
    ylabel('He(f)');
    title('Respuesta en frecuencia');
end

subplot(2, 1, 1);
legend('α = 0', 'α = 0.25', 'α = 0.75', 'α = 1');

subplot(2, 1, 2);
legend('α = 0', 'α = 0.25', 'α = 0.75', 'α = 1');