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

        %%%%%%Algoritmul A*%%%%%%%%
         % Algoritm A* simplificat (similar cu Dijkstra)
        function [dist, parent] = astarSimplu(obj, start, goal)
            fprintf('A* - Găsire drum de la nodul %d la nodul %d\n', start, goal);

            % Inițializare distanțe și părinți
            g_score = inf(1, obj.V);  % costul real până la nod (similar cu dist din Dijkstra)
            f_score = inf(1, obj.V);  % costul estimat total (g + h)
            parent = -ones(1, obj.V);

            g_score(start) = 0;
            f_score(start) = 0;  % fără euristică la început

            % Similar cu "visited" din Dijkstra, dar A* poate revizita nodurile
            closed = false(1, obj.V);  % noduri procesate complet
            
            % Vector boolean pentru a verifica rapid prezența în open
            in_open = false(1, obj.V);
            in_open(start) = true;

            % Lista de noduri deschise (de explorat) - începe cu nodul de start
            open = [start];

            while ~isempty(open)
                % Găsim nodul cu f_score minim din lista open
                [~, idx] = min(f_score(open));
                current = open(idx);

                % Eliminăm nodul curent din lista open
                open(idx) = [];
                in_open(current) = false;

                % Marcăm ca procesat
                closed(current) = true;

                % Verificăm dacă am ajuns la destinație
                if current == goal
                    % Afișăm rezultatul
                    fprintf('Drum găsit!\n');
                    fprintf('Cost total: %f\n', g_score(goal));

                    % Afișăm drumul
                    fprintf('Drum: ');
                    path = [];
                    node = goal;
                    while node ~= -1
                        path = [node, path];
                        node = parent(node);
                    end
                    fprintf('%d ', path);
                    fprintf('\n');

                    dist = g_score;  % returnăm costurile pentru compatibilitate cu Dijkstra
                    return;
                end

                % Explorăm vecinii (similar cu Dijkstra)
                for i = 1:size(obj.adj{current}, 1)
                    weight = obj.adj{current}(i, 1);  % greutatea muchiei
                    neighbor = obj.adj{current}(i, 2);  % vecinul

                    % Sărim peste nodurile deja procesate complet
                    if closed(neighbor)
                        continue;
                    end

                    % Calculăm noul cost g
                    tentative_g = g_score(current) + weight;

                    % Verificăm dacă am găsit un drum mai bun
                    if tentative_g < g_score(neighbor)
                        % Actualizăm informațiile pentru vecin
                        parent(neighbor) = current;
                        g_score(neighbor) = tentative_g;

                        % Folosim o euristică reală care direcționează către țintă
                        %h_score = abs(neighbor - goal);
                        h_score = 1;

                        f_score(neighbor) = g_score(neighbor) + h_score;

                        % Adăugăm vecinul în lista open dacă nu este deja
                        if ~in_open(neighbor)
                            open = [open, neighbor];
                            in_open(neighbor) = true;
                        end
                    end
                end
            end

            fprintf('Nu există drum între nodurile %d și %d.\n', start, goal);
            dist = g_score;  % returnăm costurile pentru compatibilitate
        end
        %%%%%%Algoritmul A*%%%%%%%%

        %%%%%%Algoritmul Dijkstra%%%%%%%
        %Algoritmul Dijkstra
        function [dist, parent] = dijkstra(obj, start)
            fprintf('Distante cu plecare din nodul de start: %d\n', start);
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
                min_dist = inf;
                u = -1;
                for j = 1:obj.V
                    if ~visited(j) && dist(j) < min_dist
                        min_dist = dist(j);
                        u = j;
                    end
                end

                % Daca nu mai avem noduri accesibile, ieșim
                if u == -1
                    break;
                end

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


            %AFISARE Rezultat
            fprintf('Nod\tConsum\tCale\n');
            for i = 1:obj.V
                if isinf(dist(i))
                    fprintf('%d\tINF\t\tNu exista cale\n', i);  % Nu exista drum
                else
                    fprintf('%d\t%f\t\t', i, dist(i));  % Printam distanta
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
 
        %%%%%%Algoritmul Dijkstra%%%%%%%


        %%%%%%Algoritmul de Cautare Bruta%%%%%%%
        % Funcția principală pentru căutarea brută
        function bruteForceSearch(obj, start, sfarsit)
            vizitat = false(1, obj.V);
            drumCurent = [];
            drumCelMaiBun = [];
            minCost = inf;

            % Pornim cautarea recursiva
            [minCost, drumCelMaiBun] = obj.searchPath(start, sfarsit, vizitat, drumCurent, 0, minCost, drumCelMaiBun);

            % Afisam rezultatul
            if isinf(minCost)
                fprintf('Nu exista drum intre nodurile %d si %d\n', start, sfarsit);
            else
                fprintf('Cel mai scurt drum gasit:\n');
                fprintf('Cost total: %f\n', minCost);
                fprintf('Drum: ');
                fprintf('%d ', drumCelMaiBun);
                fprintf('\n');
            end
        end

        % Funcția recursivă pentru cautarea drumurilor
        function [minCost, drumCelMaiBun] = searchPath(obj, curent, sfarsit, vizitat, drumCurent, costCurent, minCost, drumCelMaiBun)
            % Marcam nodul curent ca vizitat
            vizitat(curent) = true;
            drumCurent = [drumCurent, curent];

            % Daca am ajuns la destinatie, verificam daca am gasit un drum mai bun
            if curent == sfarsit
                if costCurent < minCost
                    minCost = costCurent;
                    drumCelMaiBun = drumCurent;
                end
            else
                % Exploram toți vecinii nevizitați
                for i = 1:size(obj.adj{curent}, 1)
                    weight = obj.adj{curent}(i, 1);
                    vecin = obj.adj{curent}(i, 2);

                    if ~vizitat(vecin) && costCurent + weight < minCost
                        [minCost, drumCelMaiBun] = obj.searchPath(vecin, sfarsit, vizitat, drumCurent, costCurent + weight, minCost, drumCelMaiBun);
                    end
                end
            end

            % Backtracking
            vizitat(curent) = false;
            drumCurent(end) = []; %end este in aceasta situatie ultimul index. 
        end
        %%%%%%Algoritmul de Cautare Bruta%%%%%%%


%%/METODE
end
end
