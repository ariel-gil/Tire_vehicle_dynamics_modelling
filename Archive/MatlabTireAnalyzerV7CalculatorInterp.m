clc

%calculator. 
%parameters, not self input for now. 
Tf=47.5;
Tr=45.5;
L=63;
M=630;
CGF=.46;
WF=M*CGF;
CGR=M*(1-CGF);
% WR
% Glat;
% Glong;

% %loads:stat
% lfs
% rfs
% lrs
% rrs
% %loads under accel
% lfd 
% rfd
% lrd
% rrd
% %trans
% ftrans
% rtrans
% longtrans
% %coeffs lat
% latclf
% latcrf
% latclr
% latcrr
% %coeff long
% longclf
% longcrf
% longclr
% longcrr
% %forcelat
% flatf
% rlatf
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
% 




















x=zeros(1,1); %matrix initiation
y=zeros(1,1);

%pressure pre-definition.
p=12;
pmax=p+.5;
pmin=p-.5;


%cases for interpolation of load (will make load an array later, 4x10)
fz=220;

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
if ia<2
    iamin=0;
    iamax=2; 
end
if ia>2   %accounting for above case. Interpolation above range will work in this case. 
    iamax=4; 
    iamin=2;
end

saval=11.37;

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
               
                if (sain>=saval-.1) && (sain<=saval+.1)
                    %fprintf('SA in range');
              t1=t1+1;
                nfymax1=(nfymax1+NFY(i))
                end 
                
            elseif (iain>=iamax-.5) && (iain<=iamax+.5) %case 2 max
                if (sain>=saval-.1) && (sain<=saval+.1)
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
                if (sain>=saval-.1) && (sain<=saval+.1)
                    NFY(i);
                t2=t2+1;    
                nfymin1=(nfymin1+NFY(i));
                
                end 
            elseif (iain>=iamax-.5) && (iain<=iamax+.5) %case 2 min
                
                if (sain>=saval-.1) && (sain<=saval+.1)
                                      NFY(i)
                t4=t4+1;    
                nfymin2=(nfymin2+NFY(i));
                
                end 
            end
            
                  
            
        end
        
    end
     
    i=i+1; %while loop counter. 
    
    end   

     
t1
t2
t3
t4
nfymax1=nfymax1/t1
nfymin1=nfymin1/t2
nfymax2=nfymax2/t3
nfymin2=nfymin2/t4
i

%interpolation with looped values
kfz=(fz-fzmin)/(fzmax-fzmin) %so val of 1 is max
kia=(ia-iamin)/(iamax-iamin) %so val of 1 is max, 0 is min

int1= kfz*(nfymax1-nfymin1)+nfymin1
int2= kfz*(nfymax2-nfymin2)+nfymin2
nfyx= (1-kia)*(int1)+(kia)*(int2)




