function [avpre, avrec] = cat_apcal2(traingnd,testgnd, IX, N)
% ap=apcal(score,label)
% average precision (AP) calculation 

[numtrain, numtest] = size(IX);

avpre = 0;
avrec = 0;
apall = zeros(1,numtest);
for i = 1 : numtest
    y = IX(:,i);
    x=0;
    p=0;
    new_label=zeros(1,numtrain);
    new_label(traingnd==testgnd(i))=1;
    T = sum(new_label);
    num_return_NN = N;%5000; % only compute MAP on returned top 5000 neighbours.
    for j=1:num_return_NN
          if new_label(y(j))==1
            x=x+1;
          end
    end  
    pre = x / num_return_NN;
    rec = x / T;
    avpre = avpre + pre;
    avrec = avrec + rec; 
end
avpre = avpre / numtest;
avrec = avrec / numtest;

