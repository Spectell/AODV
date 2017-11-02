%%% This program-code may be unfinished.
clear
AODV = [];
%%% Rewritable
E= 100;         % Range of enviroment
NoN = 200;      % Number of node 
R = 15;         % Submit range of node
%%%

A = zeros(E+R+R);  %%% node's position__(1)
Node_line = randi([1,E],[1,NoN])+R;  %%% make node's position << need to remake?
Node_row  = randi([1,E],[1,NoN])+R;  

for i = 1:NoN 
    %%% status of node 
    S_Node(i).line = Node_line(i);                %%% node's position
    S_Node(i).row  = Node_row(i); 
    S_Node(i).RREQ = [];                          %%% memory of RREQ
                                                  %%% Need to change range? 
    S_Node(i).range = [R];                        %%% Submit range node
    %%%%%%%%%%%%%%%%%%     
    A(Node_line(i),Node_row(i)) = i;   %%% write node's position__(2)
end

spy(A);    %%% display node's position__(3)
count = 0;  % using test
k = 1;     % start at node-1
%%%%%%%%%%%%%%%%%%%%% may rewrite by using (find)
s = [];

while(1)

    for i = 1 : NoN
        if i ~= k  % equal point does not arrival.
            % k_RREQ sent i_RREQ 
            % by using (k's submit range) and (distance from i to k).
           if sqrt( (S_Node(k(1)).line - S_Node(i).line)^2+(S_Node(k(1)).row - S_Node(i).row)^2 )<= S_Node(k(1)).range
            if all(S_Node(i).RREQ ~= k(1)) || (length(S_Node(i).RREQ) > length(S_Node(k(1)).RREQ)+1)      
                S_Node(i).RREQ = [S_Node(k(1)).RREQ k(1)];
                k =[k i];
            end
           end
        end
    end
     k(1)=[];
   
     if S_Node(NoN).RREQ > 0
           disp('last node arrival');
           disp(S_Node(NoN).RREQ);
        break
     end
     
    if isempty(k) == 1 
           disp('not arrival');
            break
    end
    count = count+1;
end


