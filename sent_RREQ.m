function [S_Node,k] = sent_RREQ(S_Node,NoN,k)



while(1)
%%% 探索ノード　と　すべてのノード　を比べてやる
    for i = 1 : NoN
        if i ~= k  % equal point does not arrival.
            % k_RREQ sent i_RREQ 
            % by using (k's submit range) and (distance from i to k).
            
        %%% パケットをもらったとしても破棄するだけのブラックホール型は，居ても居ないのとおなじだと考えたらいい．
        %%% ノード数減らしたのと，ノード数そのままを比べたらよさそう．ただ，電力消費については送信分が取られそうな気はする．
        
           if sqrt( (S_Node(k(1)).line - S_Node(i).line)^2+(S_Node(k(1)).row - S_Node(i).row)^2 )<= S_Node(k(1)).range
                % (RREQの長さが短いほうを入れる && 自分のルートが入っていないもの) || (何も入っていない) 
                if (all(S_Node(i).RREQ ~= k(1)) && (length(S_Node(i).RREQ) > length(S_Node(k(1)).RREQ)+1)) || isempty(S_Node(i).RREQ) == 1
                    S_Node(i).RREQ = [S_Node(k(1)).RREQ k(1)];
                    k = [k i];
                end
           end
        end
    end
     k(1)=[];
     %%% 探索する場所がなくなったら終了
    if isempty(k) == 1 
           disp('RREQ messege not arrival Destination node');
            break;
    end
    
    %%% 不正ノードがきたら
      if S_Node(k(1)).attack == 1
    S_Node(k(1)).attack = 2;  %%% attack に2が入ったら印にする
    disp('<<<<<<<<<<<<<<<fault>>>>>>>>>>>>>>>>');
    break;
      end    
    
    
     %%% ここが実際のものと違うので，変えていく．RREPが来たら終了？
     if S_Node(NoN).RREQ > 0
         if all(S_Node(NoN).RREQ ~= NoN)  % 無理やり，RREQの最後にNoN値を入れている
           S_Node(NoN).RREQ = [S_Node(NoN).RREQ  NoN];     %%% ここを変えたほうがいい
         end
           disp('RREQ messege arrival Destination node.');
       break
     end
     
     
end

end
