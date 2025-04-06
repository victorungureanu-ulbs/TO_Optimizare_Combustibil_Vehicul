classdef Graph < handle
    properties
        V  %nr de noduri din graf
        adj  %lista de adiacență (stocăm muchiile și greutățile lor)
    end


%%METODE
    methods 
        % Constructor
        function obj = Graph(V)
            obj.V = V;
            % Initializare lista de adiacenta
            obj.adj = cell(1, V);
            for i = 1:V
                obj.adj{i} = [];
            end
        end
        
        %Funcție pentru a adăuga o muchie între nodul u(curent) și nodul v(vecin), cu greutatea weight
        function addEdge(obj, u, v, weight)
            %Folosim indexare cu baza 1
            %u = u + 1;
            %v = v + 1;
            
            %adăugăm muchia (u, v) cu greutatea
            obj.adj{u} = [obj.adj{u}; weight, v];
            %muchia inversă (v, u), pentru graf neorientat
            obj.adj{v} = [obj.adj{v}; weight, u];
        end
        
        %Algoritmul Dijkstra
        function [dist, parent] = dijkstra(obj, start)
            %Afisare propozitie de inceput
            fprintf('Distante cu plecare din Nodul: %d\n', start);
            %INITIALIZARE CU INFINIT - distante maxime
            %Vector de distanțe pentru fiecare nod
            dist = inf(1, obj.V);
            %Vector pentru parinti
            parent = -ones(1, obj.V);
            dist(start) = 0;  %Distanta la nodul initial este 0
            
            %Nodurile vizitate
            visited = false(1, obj.V);  %Nodurile vizitate

            for i = 1:obj.V
                % Gasim nodul nevizitat cu distanta minima
                [~, u] = min(dist .* ~visited);  
                visited(u) = true;  %Marcam ca vizitat
                %Iteram prin toti vecinii nodului respectiv
                for j = 1:size(obj.adj{u}, 1)
                    weight = obj.adj{u}(j, 1);  %Greutatea muchiei
                    v = obj.adj{u}(j, 2);  %Nodul vecin v

                    %Actualizare daca distanta e mai mica
                    if dist(u) + weight < dist(v)
                        dist(v) = dist(u) + weight;  %Actualizare distanta
                        parent(v) = u;  %Actualizare parinte
                    end
                end
            end
            
                %Iteram prin toti vecinii nodului curent
                for i = 1:size(obj.adj{u}, 1)
                    weight = obj.adj{u}(i, 1);  %Greutatea nodului
                    v = obj.adj{u}(i, 2);  %Nodul vecin v
                    
                    %Daca se gaseste un drum mai scurt actualizam
                    if dist(u) + weight < dist(v)
                        dist(v) = dist(u) + weight;  %distanta este modificata
                        parent(v) = u;
                        pq.push(dist(v), v);  %Vecinul adaugat in coada de prioritati
                    end
                end

            %AFISARE Rezultat
            fprintf('Nod\tConsum\tCale\n');
            for i = 1:obj.V
                if isinf(dist(i))
                    fprintf('%d\tINF\t\tNu exista cale\n', i);  % Nu exista drum
                else
                    fprintf('%d\t%d\t\t', i, dist(i));  % Printam distanta
                    path = [];  
                    current = i; 
                    while current ~= -1 
                        path = [current, path];  
                        current = parent(current);  
                    end
                    fprintf('%d ', path);  
                    fprintf('\n');
                end
            end
        end
        %%/METODE
    end 
end
