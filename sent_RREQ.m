function [S_Node] = sent_RREQ(S_Node,NoN,k)



while(1)
    for i = 1 : NoN
        if i ~= k  % equal point does not arrival.
            % k_RREQ sent i_RREQ 
            % by using (k's submit range) and (distance from i to k).
           if sqrt( (S_Node(k(1)).line - S_Node(i).line)^2+(S_Node(k(1)).row - S_Node(i).row)^2 )<= S_Node(k(1)).range
                % 空なら入れる
                if all(S_Node(i).RREQ ~= k(1)) || (length(S_Node(i).RREQ) > length(S_Node(k(1)).RREQ)+1)
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
     %%% ここが実際のものと違うので，変えていく．RREPが来たら終了？
     if S_Node(NoN).RREQ > 0
           S_Node(NoN).RREQ = [S_Node(NoN).RREQ  NoN];
           disp('RREQ messege arrival Destination node.');
       break
     end

end

end
