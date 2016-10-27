

%% MW: 8 uses of 'col', 5 uses of Intervalp - all below


%assigned intervals
[~,col]=size(Interval);
if col>1
    Intervalp=Interval;
    Interval=col-1;
end

AInterval(Interval,1)=0;
crackinterval(Ncase,Interval)=0;%initialization of crack in each intervals

%MW: I guess this is only producing simulation results within the assigned
%intervals
if col>1 % cutoff those out side of the 1st and last marker
    crackpos(crackpos<Intervalp(1))=0;
    crackpos(crackpos>Intervalp(col))=0;
end

for i=1:Ncase
    for j=1:Nflaws
        if crackpos(i,j)>0
        if col==1
           crackinterval(i,ceil(crackpos(i,j)*Interval))=1;%crackinterval(i,ceil(crackpos(i,j)*Interval))=1;
        end
        if col>1
        for ii=1:col-1
         if crackpos(i,j)>= Intervalp(1,ii) & crackpos(i,j)<Intervalp(1,ii+1)
            crackinterval(i,ii)=1;%crackinterval(i,ii)=crackinterval(i,ii)+1;%10-04-2012;%
%             if crackpos(i,j)==Intervalp(1,col);%10-04-2012
%                 crackinterval(i,ii)=crackinterval(i,ii)+1;%10-04-2012
%             end
         end
         end
        end
        end
    end
end

%% 
