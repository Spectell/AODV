%%% Sorry. This program-code is unfinished.
clear

%%% Rewritable
L = 10;         % length
NoN = 20;       %　No. of node 
R = 2;          % Submit range node
%%%

A = zeros(L+R+R);  %%% node's position__(1)

Node_line = randi([1,L],[1,NoN])+R;  %%% make node's position
Node_row  = randi([1,L],[1,NoN])+R;

for i = 1:NoN
    %%% status of node
    S_Node(i).line = Node_line(i);                %%% node's position
    S_Node(i).row  = Node_row(i); 
    S_Node(i).RREQ = [];                          %%% memory of RREQ
    S_Node(i).range = [R];                        %%% Submit range node
    %%%     

    A(Node_line(i),Node_row(i)) = i;   %%% write node's position__(2)
end

spy(A);    %%% display node's position__(3)
flag = 0;  % using test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rewrite by using find ?
k = 1;     % start at node-1

for roop = 1:6  % Here is test. if here is complete--->> while(1)
   
for i = 1 : S_Node(k(1)).range
        %%% send RREQ
        %%% access S_Node.RREQ by using (A:node's position__(4))
    for j = i : S_Node(k(1)).range
      if A( S_Node(k(1)).line +i , S_Node(k(1)).row +j ) > 0 
      %%% need adding requirement
     S_Node(A( S_Node(k(1)).line +i , S_Node(k(1)).row +j )).RREQ = ...
         [S_Node(A( S_Node(k(1)).line +i , S_Node(k(1)).row +j )).RREQ k(1)];
     k = [k A( S_Node(k(1)).line +i , S_Node(k(1)).row +j )];
      end
      if A( S_Node(k(1)).line -i , S_Node(k(1)).row +j ) > 0

    S_Node(A( S_Node(k(1)).line -i , S_Node(k(1)).row +j )).RREQ = ...
         [S_Node(A( S_Node(k(1)).line -i , S_Node(k(1)).row +j )).RREQ k(1)];
     k = [k A( S_Node(k(1)).line -i , S_Node(k(1)).row +j )];

      end
      if A( S_Node(k(1)).line -i , S_Node(k(1)).row -j ) > 0 

    S_Node(A( S_Node(k(1)).line -i , S_Node(k(1)).row -j )).RREQ = ...
         [S_Node(A( S_Node(k(1)).line -i , S_Node(k(1)).row -j )).RREQ k(1)];
     k = [k A( S_Node(k(1)).line -i , S_Node(k(1)).row -j )];

      end
      if A( S_Node(k(1)).line +i , S_Node(k(1)).row -j ) > 0
  
    S_Node(A( S_Node(k(1)).line +i , S_Node(k(1)).row -j )).RREQ = ...
         [S_Node(A( S_Node(k(1)).line +i , S_Node(k(1)).row -j )).RREQ k(1)];
     k = [k A( S_Node(k(1)).line +i , S_Node(k(1)).row -j )];

      end
    end            
end
k(1)=[];
    if S_Node(NoN).RREQ > 0
      flag = flag +1; %%%　last node
    end

    if isempty(k)==1 
       disp('not arrival');
       break
    end
    
    
end
