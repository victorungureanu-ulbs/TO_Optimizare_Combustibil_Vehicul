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
[distante, parinti] = g.dijkstra(2);
