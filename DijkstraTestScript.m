%Parameters[] param;
%param.add = new Parameters(1.2, 2.3, 30, 7); //0
%param.add = new Parameters(1.2, 2.3, 20, 7); //1

g = Graph(5);
%g.addEdge(1, 2, param[0]); 
g.addEdge(1, 3, 5);  
g.addEdge(2, 3, 2);   
g.addEdge(2, 4, 1);   
g.addEdge(3, 4, 9);  
g.addEdge(3, 5, 2);  
g.addEdge(4, 5, 4); 

%Suplimentar pentru a nu avea INFINIT intre 1 si 4, 1 si 5
g.addEdge(1, 4, 15); 
g.addEdge(1, 5, 20); 
g.addEdge(2, 5, 10); 
g.addEdge(4, 3, 3);  




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
fprintf('Algoritmul A* a durat:%.2f milisecunde\n',timpAStar*1000);


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