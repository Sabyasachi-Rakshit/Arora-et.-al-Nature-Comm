 function survival_lifetime_FC
% Sabyasachi(May 2011)
% The input data is lifetime_force. What it will do is: it will calculate
% the surv prob of time where the lowest value has maximum survival prob
% and decreases with incrases time.
close all
%clear all
di=dir('**.txt');
for i1=1:length(di);
    clear LT T Ts N i j W
    name=di(i1).name;
    fprintf(1,'%s %s\n','analyzing file : ',name);
    fid=fopen(name);
    fid1=fopen(tempname, 'w+');
%      line = fgets(fid);
%     A = sscanf(line);
    LT = load(name);
    T=LT(:,1);
    Ts=sort(T);
    nu=length(T);
    N=zeros(nu,1);
    W=nan*ones(nu,2);
    for i=1:nu
        for j=1:nu
            if  T(i)>=Ts(j);
                N(j)=N(j)+1;
            end
        end
    end
    W(:,1)=Ts;
    W(:,2)=N;
    name2=strcat('time_counts_',name);
    dlmwrite(name2,W,'delimiter','\t');
    %     H_f=figure;
    plot(Ts,N,'.k');
    hold on
    zoom on
    pause

end
zoom off
% if exist('H_f==1')
%     delete(H_f)
% end
close 'all'
end




