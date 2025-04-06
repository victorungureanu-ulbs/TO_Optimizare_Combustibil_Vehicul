%Parameters[] param;
%param.add = new Parameters(1.2, 2.3, 30, 7); //0
%param.add = new Parameters(1.2, 2.3, 20, 7); //1


fprintf('____________________________________________\n');
fprintf('____________________________________________\n');
fprintf('____________________TEST1___________________\n');
fprintf('____________________________________________\n');
fprintf('____________________________________________\n');

muchii =  [1, 3; 2, 3; 2, 4; 3, 4; 3, 5; 4, 5; 1, 4; 1, 5; 2, 5; 4, 3];
distante = [5, 2, 1, 9, 2, 4, 15, 20, 10, 3];
tipuri_drum = [1, 1, 1.2, 1, 1.1, 0.9, 0.8, 1, 1.2, 1];

% Viteza si greutatea masinii pot fi ajustate
greutate = 1500;
viteza = 60;

%Populam graful
g = Graph(5);
for i = 1:length(muchii)
    cost = Cost(distante(i), tipuri_drum(i), greutate, viteza);
    consum_energie = cost.getConsumEnergie();
    g.addEdge(muchii(i, 1), muchii(i, 2), consum_energie);
end

% Alegem nodurile de start și destinație
start_node = 1;
goal_node = 5;


% A*
start_t0 = datetime('now');
fprintf('____________________________________________\n');
fprintf('Testare A*\n');
fprintf('____________________________________________\n');
[dist_astar, parent_astar] = g.astarSimplu(start_node, goal_node);
endt_t1 = datetime('now');
timpAStar = milliseconds(endt_t1 - start_t0);
fprintf('Algoritmul A* a durat:%.2f milisecunde\n',timpAStar);


% Dijkstra
start_t0 = datetime('now');
fprintf('____________________________________________\n');
fprintf('Testare Djikstra\n');
fprintf('____________________________________________\n');
[dist_dijkstra, parent_dijkstra] = g.dijkstra(start_node);
endt_t1 = datetime('now');
timpDijkstra = milliseconds(endt_t1 - start_t0);
fprintf('Algoritmul Dijkstra a durat:%.2f milisecunde\n',timpDijkstra);

% Cautare Bruta
start_t0 = datetime('now');
fprintf('____________________________________________\n');
fprintf('Testare Cautare Bruta\n');
fprintf('____________________________________________\n');
g.bruteForceSearch(start_node, goal_node);
endt_t1 = datetime('now');
timpCautareBruta = milliseconds(endt_t1 - start_t0);
fprintf('Algoritmul de Cautare Bruta a durat:%.2f milisecunde\n',timpCautareBruta);


fprintf('____________________________________________\n');
fprintf('____________________________________________\n');
fprintf('____________________TEST2___________________\n');
fprintf('____________________________________________\n');
fprintf('____________________________________________\n');

muchii2 = [
    1, 2; 2, 3; 3, 4; 4, 5; 5, 6; 6, 7; 7, 8; 8, 9; 9, 10; 10, 11;
    11, 12; 12, 13; 13, 14; 14, 15; 15, 16; 16, 17; 17, 18; 18, 19; 19, 20; 20, 21;
    21, 22; 22, 23; 23, 24; 24, 25; 25, 26; 26, 27; 27, 28; 28, 29; 29, 30; 30, 31;
    31, 32; 32, 33; 33, 34; 34, 35; 35, 36; 36, 37; 37, 38; 38, 39; 39, 40; 40, 41;
    41, 42; 42, 43; 43, 44; 44, 45; 45, 46; 46, 47; 47, 48; 48, 49; 49, 50; 50, 51;
    51, 52; 52, 53; 53, 54; 54, 55; 55, 56; 56, 57; 57, 58; 58, 59; 59, 60; 60, 61;
    61, 62; 62, 63; 63, 64; 64, 65; 65, 66; 66, 67; 67, 68; 68, 69; 69, 70; 70, 71;
    71, 72; 72, 73; 73, 74; 74, 75; 75, 76; 76, 77; 77, 78; 78, 79; 79, 80; 80, 81;
    81, 82; 82, 83; 83, 84; 84, 85; 85, 86; 86, 87; 87, 88; 88, 89; 89, 90; 90, 91;
    91, 92; 92, 93; 93, 94; 94, 95; 95, 96; 96, 97; 97, 98; 98, 99; 99, 100;
    17, 42; 73, 11; 26, 82; 53, 15; 39, 67; 91, 8; 64, 31; 5, 88; 47, 22; 79, 60;
    34, 95; 56, 13; 87, 28; 10, 69; 44, 99; 72, 23; 36, 54; 77, 16; 45, 89; 61, 30;
    2, 93; 58, 25; 81, 49; 20, 75; 63, 33; 14, 85; 70, 48; 37, 98; 52, 24; 96, 7;
    29, 66; 83, 41; 12, 57; 46, 94; 21, 78; 68, 35; 90, 4; 27, 51; 74, 38; 19, 86;
    59, 32; 43, 97; 65, 9; 40, 84; 71, 18; 1, 76; 55, 92; 28, 62; 80, 50; 6, 100;
    48, 97; 14, 82; 34, 59; 71, 26; 3, 89; 56, 22; 76, 42; 29, 68; 91, 15; 45, 96;
    20, 65; 74, 37; 12, 85; 53, 33; 27, 78; 94, 16; 49, 99; 7, 61; 81, 40; 23, 67;
    95, 30; 44, 10; 72, 54; 38, 86; 60, 25; 5, 93; 52, 35; 77, 19; 31, 64; 87, 43;
    17, 66; 58, 39; 83, 11; 47, 70; 21, 92; 63, 36; 9, 79; 50, 24; 75, 2; 32, 98;
    57, 46; 13, 69; 84, 28; 41, 100; 73, 18; 25, 90; 55, 51; 8, 80; 62, 29; 4, 88
    ];

distante2 = [
    12, 5, 18, 7, 14, 3, 11, 16, 9, 2, 19, 8, 15, 4, 13, 6, 17, 10, 1, 5,...
    15, 8, 12, 3, 19, 7, 14, 9, 2, 16, 4, 11, 18, 5, 13, 6, 20, 10, 1, 17,...
    8, 14, 3, 19, 7, 15, 6, 11, 2, 18, 9, 4, 16, 5, 12, 1, 19, 7, 13, 8,...
    14, 3, 17, 10, 5, 15, 9, 2, 18, 6, 12, 4, 16, 7, 11, 1, 19, 8, 13, 2,...
    17, 5, 14, 9, 3, 18, 10, 6, 15, 4, 11, 7, 19, 8, 12, 2, 16, 5, 9, 10,...
    9, 16, 4, 12, 7, 18, 3, 14, 6, 11, 2, 17, 8, 15, 5, 19, 7, 13, 4, 16,...
    9, 1, 18, 6, 12, 3, 15, 8, 14, 2, 17, 5, 19, 10, 1, 16, 7, 13, 9, 3,...
    18, 6, 11, 4, 20, 8, 15, 7, 13, 2, 17, 5, 19, 8, 14, 6, 11, 3, 16, 9,...
    1, 18, 7, 12, 4, 15, 8, 9, 3, 18, 6, 17, 4, 20, 8, 15, 7, 13, 3, 18,...
    6, 11, 9, 1, 16, 7, 13, 9, 3, 16, 5, 17, 9, 1, 11, 2, 19, 8, 7, 4
    ];
tipuri_drum2 = [

1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2,
1.0, 0.9, 1.1, 0.8, 1.2, 1.0, 0.9, 1.1, 0.8, 1.2
];

% Viteza si greutatea masinii pot fi ajustate
greutate2 = 1500;
viteza2 = 60;

% Creează un graf cu 100 de noduri
f = Graph(100);


%Populam graful
for i = 1:length(muchii2)
    cost = Cost(distante2(i), tipuri_drum2(i), greutate2, viteza2);
    consum_energie = cost.getConsumEnergie();
    f.addEdge(muchii2(i, 1), muchii2(i, 2), consum_energie);
end


% Definim nodurile de start si goal
start_node = 1;
goal_node = 99;



% A*
start_t0 = datetime('now');
fprintf('____________________________________________\n');
fprintf('Testare A*\n');
fprintf('____________________________________________\n');
[dist_astar, parent_astar] = f.astarSimplu(start_node, goal_node);
endt_t1 = datetime('now');
timpAStar = milliseconds(endt_t1 - start_t0);
fprintf('Algoritmul A* a durat:%.2f milisecunde\n',timpAStar);


% Dijkstra
start_t0 = datetime('now');
fprintf('____________________________________________\n');
fprintf('Testare Djikstra\n');
fprintf('____________________________________________\n');
[dist_dijkstra, parent_dijkstra] = f.dijkstra(start_node);
endt_t1 = datetime('now');
timpDijkstra = milliseconds(endt_t1 - start_t0);
fprintf('Algoritmul Dijkstra a durat:%.2f milisecunde\n',timpDijkstra);

% Cautare Bruta
start_t0 = datetime('now');
fprintf('____________________________________________\n');
fprintf('Testare Cautare Bruta\n');
fprintf('____________________________________________\n');
f.bruteForceSearch(start_node, goal_node);
endt_t1 = datetime('now');
timpCautareBruta = milliseconds(endt_t1 - start_t0);
fprintf('Algoritmul de Cautare Bruta a durat:%.2f milisecunde\n',timpCautareBruta);