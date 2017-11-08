function [S_Node] = status_and_disp(E,R,NoN)

%%% Disp status
fprintf('------------------------------\n');
fprintf(' Sourse node is 1. Detination node is %d.\n This display Figure at (2:3). \n',NoN);
fprintf(' Range of enviroment = %d * %d \n Number of node = %d \n Submit range of node = %d \n',E,E,NoN,R);
fprintf('------------------------------\n');
%%%

b = linspace(0,2*pi,100);
Node_line = randi([1,E],[1,NoN])+R;  %%% make node's position << need to remake?
Node_row  = randi([1,E],[1,NoN])+R;  

for i = 1:NoN 
    %%% make status of node 
    S_Node(i).number = i;                         %%% number of node
    S_Node(i).line = Node_line(i);                %%% position of node
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
%%% 使ってない　＞＞ M(i) = getframe; %% ループ文に囲まれている間のグラフをmovieとして保存する
text(S_Node(1).line,S_Node(1).row,'first'); 
text(S_Node(NoN).line,S_Node(NoN).row,'last');  
axis([0 E+3*R 0 E+2*R]);

end