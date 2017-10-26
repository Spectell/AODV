% 作りかけ
clear

%%% 可変領域
L = 10;         % はんい
NoN = 20;       % ノード数
R = 2; % すべてのnodeが同じ能力の場合
       % ノードの最大通信範囲で座標ボードを大きく
%%%

A = zeros(L+R+R);  %%%　ノードの位置を座標で表現＿①

Node_line = randi([1,L],[1,NoN])+R; %%% ノードの座標を作成
Node_row  = randi([1,L],[1,NoN])+R;

for i = 1:NoN
    %%% (i)に当たるところで、nodeを表す
    S_Node(i).line = Node_line(i);                %%% Nodeの位置
    S_Node(i).row  = Node_row(i); 
    S_Node(i).RREQ = [];                 %%% どの順番でRREQが送られてきたのか ,はじめは0を入れておきます
    S_Node(i).range = [R];                        %%% Node の　通信はんい | ここを操作して　機器ごとの通信範囲を変える
    %%%     

    A(Node_line(i),Node_row(i)) = i;   %%%　ノードの位置を座標で表現＿②
end

spy(A);  %%% ノードの位置を座標で表現＿③
flag = 0;  % はじめ　node1 からnode20 へ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  あとで　findで書き直せるか試す
k = 1;

for roop = 1:6  %　取りあえず、６回してるだけ
   
for i = 1 : S_Node(k(1)).range
    %%% Aを使って参照し,S_Nodeにアクセスすることで実現する
    for j = i : S_Node(k(1)).range
        
      if A( S_Node(k(1)).line +i , S_Node(k(1)).row +j ) > 0 
      %%% ４つとも、ここに条件を追加する必要あり
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
    if S_Node(20).RREQ > 0
      flag = flag +1; %%%　　おわり
    end

    if isempty(k)==1 
       disp('not arrival');
       break
    end
    
    
end
