function [p, a, lb, am] = PeriArea(im_cln)
    % Encuentra los contornos y etiquetas de los objetos en la imagen binaria
    [B, L, N] = bwboundaries(im_cln, 'noholes');
    
    % Inicializa variables
    am = 0;
    lb = 0;
    
    % Bucle sobre cada objeto encontrado
    for i = 1:N
        bound = B{i};
        p(i) = 0; % Inicializa el perímetro para el objeto i
        
        % Bucle sobre los puntos en el contorno del objeto
        for k = 1:length(bound) - 1
            % Comprueba si el punto siguiente está en la misma fila o columna
            if ((bound(k, 1) == bound(k + 1, 1)) || (bound(k, 2) == (bound(k + 1, 2))))
                p(i) = p(i) + 1; % Incrementa el perímetro
            else
                % Diagonal (8-vecindad)
                p(i) = p(i) + sqrt(2);
            end
        end
        
        % Encuentra las coordenadas (f, c) de los píxeles pertenecientes al objeto i
        [f, c] = find(L == i);
        
        % Calcula el área del objeto i
        a(i) = length(f);
        
        % Actualiza el objeto más grande encontrado hasta ahora
        if (i > 1 && am < a(i))
            am = a(i);
            lb = i;
        end
        
        % Si es el primer objeto, inicializa lb y am
        if (i == 1)
            am = a(i);
            lb = i;
        end
    end
    
    % Filtra la imagen para mostrar solo el objeto más grande
    L(L ~= lb) = 0;
    
    % Muestra la imagen filtrada en una subplot con un título
    subplot(1, 2, 2);
    imshow(L);
    title('Tumor detectado');
end
