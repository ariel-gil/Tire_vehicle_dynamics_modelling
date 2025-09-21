clc

%calculator. 
%parameters, not self input for now. 
Tf=47.5;
Tr=45.5;
L=63;
M=630;
% CGF
% WF
% CGR
% WR
% Glat
% Glong

% %loads:stat
% % lfs
% % rfs
% % lrs
% % rrs
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





















x=zeros(1,1); %matrix initiation
y=zeros(1,1);

%pressure pre-definition.
p=12;
pmax=p+.5;
pmin=p-.5;


%cases for interpolation of load (will make load an array later, 4x10)
fz=125;
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
        
%cases for IA interpolation
ia=1;
if ia<2
    iamin=0;
    iamax=2; 
end
if ia>2   %accounting for above case. Interpolation above range will work in this case. 
    iamax=4; 
    iamin=2;
end

saval=4;

nfymax=0; %initial definition. Zero will not add into avarage. 
nfymin=0;
 
       
i=1;   %Loop counter initiation. can use for i=1:61357, is it faster?
  t1=1; %counter for avarage in inmost loop.
  t2=1;
  
    while i<61357 %while loop for reading 1 var at time and putting into sorting conditions
    fzin=FZ(i);  
    iain=IA(i);
    p=P(i);
    sain=SA(i);
   
    if  (p>=pmin) && (p<=pmax)
       % fprintf('p in range');
        if(fzin >= fzmax-15) && (fzin <= fzmax+15)
           %fprintf('FZ in range');
            if (iain>=iamax-.5) && (iain<=iamax+.5)
                %fprintf('IA in range');
                if (sain>=saval-.1) && (sain<=saval+.1)
                    %fprintf('SA in range');
                nfymax=(nfymax+NFY(i));
                t1=t1+1;
            
                end 
            end
        
    elseif(fzin >= fzmin-15) && (fzin <= fzmin+15)
            if (iain>=iamin-.5) && (iain<=iamin+.5)
                if (sain>=saval-.1) && (sain<=saval+.1)
                nfymin=(nfymin+NFY(i));
                t2=t2+1;
       
                end 
            end
        end
    end
    
    i=i+1; %while loop counter. 
    
    end   

     
t1
t2
nfymax=nfymax/t1
nfymin=nfymin/t2
i

%interpolation with looped values
kfz=(fz-fzmin)/(fzmax-fzmin);

