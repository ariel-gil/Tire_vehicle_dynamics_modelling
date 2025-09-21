clear
clc
load('C:\Users\ariel\Google Drive\RFR\Ryerson Formula Racing\RF-17\Engineering\Vehicle Dynamics\Suspension\TTC Data\Round 6\Run data\10 inch\Cornering\Matlab files\USCS\A1654run21.mat')
%calculator. 
%1. parameters, not self input for now. 
tf=47.5;
tr=45.5;
l=63;
m=630;
h=12;
cgf=.46;
wf=m*cgf;
cgr=1-cgf;
wr=m*cgr;
a=l*cgr;
b=l*cgf;
glat=1.5;
glong=0;


%2. Calculation intermidiates. 

%loads: Static
fls=wf/2;
frs=fls;
rls=wr/2;
rrs=rls;
%trans
ftrans=(wf*glat*h)/tf;
fprec=ftrans/fls;
rtrans=(wr*glat*h)/tr; 
rprec=rtrans/rls;
longtrans=((h/l)*m*glong)/2;
%loads: Dynamic 
%fl 1
%fr 2
%rl 3
%rr 4
Ldyn=[fls-ftrans;frs+ftrans;rls-rtrans;rrs+rtrans;]

%3. Value seeking program

p=12; %pressure pre-definition
pmax=p+.5;
pmin=p-.5;

Clat=zeros(4,1);

 for cor=1:4
      %for step=1:10 - will add later
      
%cases for interpolation of load 
fz=Ldyn(cor);

if fz<100 %accounting for below case. Interpolation below range will work in this case. 
    fzmax=-100; 
    fzmin=-50;
end
 if fz<=150&&fz>=100
        fzmax=-150;
        fzmin=-100;
 end
if fz<=200&&fz>=150
        fzmax=-200;
        fzmin=-150;
end

if fz>=200 %accounting for above case. Interpolation above range will work in this case. 
        fzmax=-250;
        fzmin=-200;
end
fz=-fz; %for future calcs, bring it to negative which is consistant with the data. 
        
%cases for IA interpolation
ia=0;
if ia<=2
    iamin=0;
    iamax=2; 
end
if ia>2   %accounting for above case. Interpolation above range will work in this case. 
    iamax=4; 
    iamin=2;
end

saval=[11,-11,11,-11];

nfymax1=0; %initial definition. Zero will not add into avarage. 
nfymin1=0;
nfymax2=0;
nfymin2=0;

nfxmax=0; %long grip 
nfxmin=0;
 
       
i=1;   %Loop counter initiation. can use for i=1:61357, is it faster?
  t1=0; %counter for avarage in inmost loop.
  t2=0;
  t3=0;
  t4=0;
  
 
      
    while i<61357 %while loop for reading 1 var at time and putting into sorting conditions
    fzin=FZ(i);  
    iain=IA(i);
    p=P(i);
    sain=SA(i);
   
   
    if  (p>=pmin) && (p<=pmax)
     
        if(fzin >= fzmax-15) && (fzin <= fzmax+15) 
         
            if (iain>=iamin-.5) && (iain<=iamin+.5) %case 1 max
               %if (SR(i)<.1) 
               
                if (sain>=saval(cor)-.1) && (sain<=saval(cor)+.1)
                    %fprintf('SA in range');
              t1=t1+1;
                nfymax1=(nfymax1+NFY(i)); 
                end 
                
            elseif (iain>=iamax-.5) && (iain<=iamax+.5) %case 2 max
                if (sain>=saval(cor)-.1) && (sain<=saval(cor)+.1)
                    NFY(i);
                t3=t3+1;    
                nfymax2=(nfymax2+NFY(i));
                
                end 
               end
           % elseif(SR(i)>.05)
               % s1=s1+1;
                %nfxmax=(nfxmax+NFX(i));
            %end
       
        elseif(fzin >= fzmin-15) && (fzin <= fzmin+15) 
            if (iain>=iamin-.5) && (iain<=iamin+.5)   %case 1 min 
                if (sain>=saval(cor)-.1) && (sain<=saval(cor)+.1)
                    NFY(i);
                t2=t2+1;    
                nfymin1=(nfymin1+NFY(i));
                
                end 
            elseif (iain>=iamax-.5) && (iain<=iamax+.5) %case 2 min
                
                if (sain>=saval(cor)-.1) && (sain<=saval(cor)+.1)
                NFY(i);
                t4=t4+1;    
                nfymin2=(nfymin2+NFY(i));
                
                end 
            end
           
        end
        
    end
     
    i=i+1; %while loop counter. 
    
    end   

     
t1;
t2;
t3;
t4;
cor
nfymax1=nfymax1/t1
nfymin1=nfymin1/t2
nfymax2=nfymax2/t3
nfymin2=nfymin2/t4
i;

%Interp primary ratios
kfz=(fz-fzmin)/(fzmax-fzmin);
kia=(ia-iamin)/(iamax-iamin);

%Weighed avarage dual case interp
cor
int1= kfz*(nfymax1-nfymin1)+nfymin1
int2= kfz*(nfymax2-nfymin2)+nfymin2
nfyx= (1-kia)*(int1)+(kia)*(int2)
Clat(cor)=nfyx
 end 

  Clat;
  glatf=(Ldyn(1)*abs(Clat(1))+Ldyn(2)*abs(Clat(2)))/(Ldyn(1)+Ldyn(2))
  glatr=(Ldyn(3)*abs(Clat(3))+Ldyn(4)*abs(Clat(4)))/(Ldyn(3)+Ldyn(4))
%4. Intermediate outputs

% %coeff long
% longclf
% longcrf
% longclr
% longcrr
% %forcelat
% flatf
% rlatf
% 
% % 5. Performance outputs
% 
% %lataccel
% flata
% rlata
% %longforce
% flongf
% rlongf
% %full car long accel
% brake
% accel
% %req brake dist
% fbias
% rbias

