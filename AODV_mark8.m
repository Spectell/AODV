%%% This program-code may be unfinished.
clear
clf
%%% Rewritable
E = 20;         % Range of enviroment
NoN = 100;      % Number of node 
R = 10;         % Submit range of node
%%% fprintf
fprintf('------------------------------\n');
fprintf(' Range of enviroment = %d \n Number of node = %d \n Submit range of node = %d \n',E,NoN,R);
fprintf('------------------------------\n');
%%%
b = linspace(0,2*pi,100);
Node_line = randi([1,E],[1,NoN])+R;  %%% make node's position << need to remake?
Node_row  = randi([1,E],[1,NoN])+R;  

for i = 1:NoN 
    %%% make status of node 
    S_Node(i).line = Node_line(i);                %%% node's position
    S_Node(i).row  = Node_row(i); 
    S_Node(i).RREQ = [];                          %%% memory of RREQ
    S_Node(i).RREP = [];                          %%% memory of RREP
                                                  %%% Need to change range?

    S_Node(i).range = [R];                        %%% Submit range node
    %%%%%%%%%%%%%%%%%%     
    hold on
    plot(S_Node(i).range*cos(b)+Node_line(i),S_Node(i).range*sin(b)+Node_row(i));
end

hold off
M(i) = getframe; %% ループ文に囲まれている間のグラフをmovieとして保存する
text(S_Node(1).line,S_Node(1).row,'first'); 
text(S_Node(NoN).line,S_Node(NoN).row,'last');  
axis([0 E+3*R 0 E+2*R]);

count = 0;  % using test
k = 1;     % start at node-1

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
           disp('last node arrival!!!!');
           S_Node(NoN).RREQ = [S_Node(NoN).RREQ NoN];
       break
     end
    if isempty(k) == 1 
           disp('not arrival');
            break;
    end
end

%%%　RREP に探索経路を入れていきます

S_Node(NoN).RREP = fliplr(S_Node(NoN).RREQ);

if S_Node(NoN).RREQ > 0
    for i = 2:length(S_Node(NoN).RREQ)
        p = S_Node(NoN).RREP(i);
        S_Node(p).RREP = S_Node(NoN).RREP;
    end
    S_Node(1).RREP = fliplr(S_Node(1).RREP);
    disp(S_Node(1).RREP);
end


