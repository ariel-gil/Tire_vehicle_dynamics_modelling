clc
x=zeros(1,1); %matrix initiation
y=zeros(1,1);

m=input('enter parameter to cycle - X axis. \n Can still input parameter as fixed to plot later from command window (SA,FZ,IA,P) ');

count=1;
while count==1
    
l=input('input load in question (range set to +-15): ');
l=-l;
lmax=l+15;
lmin=l-15; %variability of test, can be adjusted 

sa=input('input SA in question: ');
samax=sa+.01;
samin=sa-.01; %variability of test, can be adjusted 

ia=input('input inclination angle: ');
iamax=ia+0.5;
iamin=ia-0.5; %variability, less needed for IA
ianame=ia;

p=input('input pressure: ');
pmax=p+0.5;
pmin=p-0.5; %variability, less needed for IA
pname=p;

X=input('input X axis in caps (can use other than initial, as check of variability): '); 
if X==SA   %loops to get var name
    xname='SA (deg)';
elseif X==FZ
    xname='FZ (lb)';
elseif X==P
    xname='P (psi)';
else xname='MissingName';
end

Y=input('input Y axis in caps: ');
if Y==MZ %second var name, y axis
    yname='MZ (ft-lb)';
elseif Y==NFY
    yname='NFY (unitless)';
i=1;
elseif Y==MZ
    yname='MZ (ft-lb)';
elseif Y==P 
    yname='P (psi)';
elseif Y==IA
    yname='IA (deg)';
else 
    yname='MissingName';
end
i=1;

if m==SA
   % pl=input('plot more than one fixed var on same graph? for yes, enter which (FZ,IA,P), or n for no') 
    %if pl==FZ
   %  l=input('input load in question (range set to +-15): ');
    % l=-l;
    % lmax=l+15;
     %lmin=l-15; %variability of test, can be adjusted  
     
    
  
    while i<61357 %while loop for reading 1 var at time and putting into sorting conditions
    fz=FZ(i);  
    ia=IA(i);
    p=P(i);
   
    if (fz >= lmin) && (fz <= lmax) && (ia>=iamin) && (ia<=iamax) && (p>=pmin) && (p<=pmax)
    x=[x;X(i)];
    y=[y;Y(i)];
  
    end
    i=i+1;
    
    end   
elseif m==IA
    fprintf('m=ia');
       while i<61357 %while loop for reading 1 var at time and putting into sorting conditions
    fz=FZ(i); 
    p=P(i);
    sa=SA(i);
    if (fz >= lmin) && (fz <= lmax) && (p>=pmin) && (p<=pmax) && (sa<=samax) && (sa>=samin)
    x=[x;X(i)];
    y=[y;Y(i)];
    end  
    
    i=i+1;
    end
    
elseif m==FZ
       while i<61357 %while loop for reading 1 var at time and putting into sorting conditions  
    ia=IA(i);
    p=P(i);
   
    if (ia>=iamin) && (ia<=iamax) && (p>=pmin) && (p<=pmax)
    x=[x;X(i)];
    y=[y;Y(i)];
    end  
    
    i=i+1;
       end
elseif m==P 
     while i<61357 %while loop for reading 1 var at time and putting into sorting conditions
    fz=FZ(i);  
    ia=IA(i);
   
    if (fz >= lmin) && (fz <= lmax) && (ia>=iamin) && (ia<=iamax)
    x=[x;X(i)];
    y=[y;Y(i)];
    end  
    
    i=i+1;
     end
end 
     
   
%[m,n]=size(sa250);
%[i,j]=size(fz250);
%fprintf('new vars:');
sz=1;
figure
scatter(x,y,sz)
hold on
if m==SA
title([tireid ' ' testid ' ' yname ' vs ' xname ' for ' num2str(l) ' lb with IA = ' num2str(ianame) ' and Pressure= ' num2str(pname)])
elseif m==IA
    title([yname ' vs ' xname ' for ' num2str(l) ' lb with and Pressure=' num2str(pname)])
elseif m==FZ
    title([yname ' vs ' xname 'with IA = ' num2str(ianame) ' and Pressure= ' num2str(pname)])
elseif m==P
    title([yname ' vs ' xname ' for ' num2str(l) ' lb with IA = ' num2str(ianame)])
end
    xlabel(xname)
ylabel(yname)
legend('show')

count=input('generate extra graphs? (ON SAME PLOT. USE ONLY FOR VISUAL COMPARISON, NOT CURVE FIT) 1/0: ');


end 
hold off 



