%%% This program-code may be unfinished.
% use RREQ and RREP,RERR,ACK 
clear
clf

%%% ここで経路検出率を作成する
T = 1; %%% 経路検出回数
success = 0; %%% 経路検出の成功回数
plusNumber = 1; %%% 足していく端末数

for s = 1:plusNumber
disp("s");
for i = 1:T
   clf

%%%%%%%%%%%%%%%%%%%%%%%%%%% Rewritable %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
E = 1000;         % Range of enviroment
NoN = 15;        % Number of node
attack_NoN = 0; % 単純不正ノードの個数
R = 250;          % Submit range of node

%%%　この　k　と　j　が時間みたいなもの（実際には同時更新は実現できていない）
%%% kは　RREQ内での受け渡しの　優先順位　を格納する
%%% jは　RREP内での受け渡しの　優先順位　を格納する
k = 1;                 % RREQ start at node(1):Source node
j = NoN;               % RREP start at node(NoN):Distance node
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



    S_Node = status_and_disp(E,R,NoN,attack_NoN); % (Decide status of node) and (Disp node)

    for j = 1:1

        if isempty(k) == 1
            break
        end
    
    [S_Node,k] = sent_RREQ(S_Node,NoN,k);  % sent RREQ(:hello messeage)

    %%%　不正ノードに渡った時点で，終了する
    if ~(isempty(k) == 1)
        if S_Node(k(1)).attack == 2
            break
        end
    end
    
    S_Node = sent_RREP(S_Node,NoN);  % sent RREP

    %%% 成功回数を数えていく
    if S_Node(1).RREP > 0
       success = success + 1; 
    end
    
    
    end

end
%%% Aをグラフにしたらいい
A(s) = (success / T) * 100;
success = 0;

end

%%%　もし中間ノードが新しい経路を保持していれば
%%%  送信先の代わりにRREPメッセージを返すようになっている


