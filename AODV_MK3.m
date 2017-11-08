%%% This program-code may be unfinished.
% use RREQ and RREP,RERR,ACK 
clear
clf

%%% Rewritable %%%%%%%%%%%%%%%%%%%%%%%%%%
E = 10;         % Range of enviroment
NoN = 8;        % Number of node 
R = 5;          % Submit range of node

attack_node = 1; % 不正ノード

%%%　この　k　と　j　が時間みたいなもの（実際には同時更新は実現できていない）
%%% kは　RREQ内での受け渡しの　優先順位　を格納する
%%% jは　RREP内での受け渡しの　優先順位　を格納する
k = 1;                 % RREQ start at node(1):Source node
j = NoN;               % RREP start at node(NoN):Distance node
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

S_Node = status_and_disp(E,R,NoN); % (Decide status of node) and (Disp node)

for i = 1:1

S_Node = sent_RREQ(S_Node,NoN,k);  % sent RREQ(:hello messeage)

S_Node = sent_RREP(S_Node,NoN,j);  % sent RREP

end

%%%　不正ノードを入れた場合のプログラム書いていきたい
%%%  RREQ来たら，そこでRREPを返す

%%%%%%%%%%%%%%%%%%%%%%%%　やらない %%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 動きを入れていきたい
%%% ルーティング構築中、構築後にランダムな + 移動が入るイメージ
%%% RREPのメッセージ　も探索してから送る感じなのか
%%% それともユニキャストで送るから、node指定のみでいけるのか気になる


