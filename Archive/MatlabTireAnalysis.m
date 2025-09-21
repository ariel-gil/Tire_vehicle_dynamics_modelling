sa250=zeros(1,1);
fz250=zeros(1,1);
sa200=zeros(1,1);
fz200=zeros(1,1);
sa150=zeros(1,1);
fz150=zeros(1,1);
sa100=zeros(1,1);
fz100=zeros(1,1);
sa50=zeros(1,1);
fz50=zeros(1,1);
i=1;
while i<20000
    fz=FZ(i);  %while loop working, taking one var at time
   
    if (fz >= -275) && (fz <= -225) 
    sa250=[sa250;SA(i)];
    fz250=[fz250;FZ(i)];
    end
    if (fz >= -215) && (fz <= -185) 
    sa200=[sa200;SA(i)];
    fz200=[fz200;FZ(i)];
        end
        if (fz >= -160) && (fz <= -140) 
    sa150=[sa150;SA(i)];
    fz150=[fz150;FZ(i)];
        end
        if (fz >= -110) && (fz <= -90) 
    sa100=[sa100;SA(i)];
    fz100=[fz100;FZ(i)];
        end
         if (fz >= -60) && (fz <= -30) 
    sa50=[sa50;SA(i)];
    fz50=[fz50;FZ(i)];
        end
    
    

fprintf('done\n');
i=i+1;
end
%[m,n]=size(sa250);
%[i,j]=size(fz250);
%fprintf('new vars:');

sz=4;
figure
scatter(sa250,fz250)%,sa200,mz200,sa150,mz150,sa100,mz100,sa50,mz50)
title('FZ vs SA for 250lb')
xlabel('SA')
ylabel('MZ')
legend('show')
figure
scatter(sa200,fz200)%,sa200,mz200,sa150,mz150,sa100,mz100,sa50,mz50)
title('FZ vs SA for 200lb')
xlabel('SA')
ylabel('FZ')
legend('show')
figure
scatter(sa150,fz150)%,sa200,mz200,sa150,mz150,sa100,mz100,sa50,mz50)
title('FZ vs SA for 150lb')
xlabel('SA')
ylabel('FZ')
legend('show')
figure
scatter(sa100,fz100)%,sa200,mz200,sa150,mz150,sa100,mz100,sa50,mz50)
title('FZ vs SA for 100lb')
xlabel('SA')
ylabel('FZ')
legend('show')
figure
scatter(sa50,fz50, sz)%,sa200,mz200,sa150,mz150,sa100,mz100,sa50,mz50)
title('FZ vs SA for 50lb')
xlabel('SA')
ylabel('Fz')
legend('show')




