classdef Cost < handle
    properties
        distanta            % Distanta parcursa in km
        viteza               % Viteza medie in km/h
        greutate              % Greutatea vehiculului in kg
        tip_drum            % Tipul de drum (1 = drum plat)
    end
    
    methods
        % Constructor
        function obj = Cost(distanta, viteza, greutate, tip_drum)
            % Seteaza valorile implicite daca sunt omise
            if nargin < 4
                tip_drum = 1.0;
            end
            if nargin < 3
                greutate = 1500.0;
            end
            if nargin < 2
                viteza = 60.0;
            end
            if nargin < 1
                distanta = 0.0;
            end
            
            obj.distanta = distanta;
            obj.viteza = viteza;
            obj.greutate = greutate;
            obj.tip_drum = tip_drum;
        end
        
        % Calculeaza consumul de energie
        function consum_energie = getConsumEnergie(obj)
            % Formula simplificată pentru consumul de energie
            
            % Parametri de bază
            consum_baza = 0.1;  % kWh/km pentru un vehicul standard
            factor_greutate = obj.greutate / 1500.0;  % Raport față de greutatea standard
            
            % Factori care afectează consumul
            factor_viteza = 1.0 + 0.01 * abs(obj.viteza - 60);  % Consum optim la 60 km/h
            factor_drum = obj.tip_drum;  % Poate fi extins pentru diferite tipuri de drum
            
            % Calculul final
            consum_energie = obj.distanta * consum_baza * factor_greutate * factor_viteza * factor_drum;
        end
    end
end