clear
clc
%Loads/inputs
tf=43;
tr=43;
l=60;
w=600;
df=200;
h=12;
cgf=.45;
wf=w*cgf;
cgr=1-cgf;
wr=w*cgr;
a=l*cgr;
b=l*cgf;
%% 
%Inputs. 

glat=1.5
glong=-1.4
%% 


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
longtrans=((h/l)*w*glong)/2;
%loads: Dynamic 
%fl 1
%fr 2
%rl 3
%rr 4

fprintf('Dynamic Tire Loads: \n')
Lstat=[fls,frs;rls,rrs]
Ldyn=[fls-ftrans/2-longtrans/2,frs+ftrans/2-longtrans/2;rls-rtrans/2+longtrans/2,rrs+rtrans/2+longtrans/2;]

%Moment arms;
%SV: Like a bicycle model, but individual wheel forces. Longt only
if glong>0 
    fprintf('SCENARIO: Spinning out and Braking - Use for rear (assumed no DF)\n'); 
%Braking force at wheel center, assuming 1.4coeff long:
Flongf1=Ldyn(1)*glong;
Flongf2=Ldyn(3)*glong;
Flongr1=Ldyn(2)*glong;
Flongr2=Ldyn(4)*glong;

%Upright Moment arms (approximation, ignoring caster/kpi which are small anyway:
mlf=2.699; %front lower dist from bj to spindle
muf=3.920; %front upper """"""
mlr=4.19; %rear lower
mur=3.37; %rear upper 
%Brake moment arm
fcal=2.85;
rcal=2.73; 
%wheel radius
r=8.7;
Fbf1=Flongf1*r/fcal; %force at caliper mount, dist fcal/rcal from center of wheel
Fbf2=Flongf2*r/fcal;
Fbr1=Flongr1*r/rcal;
Fbr2=Flongr2*r/rcal;

Fllong=[(Fbf1*fcal+Flongf1*muf)/(mlf+muf),(Fbf2*fcal+Flongf2*muf)/(mlf+muf);(Fbr1*rcal+Flongr1*mur)/(mlf+mur),(Fbr2*rcal+Flongr2*mur)/(mlf+mur)
]
% Fl1=(Fbf1*fcal-Flongf1*muf)/(-mlf-muf) %Front lower longt force
% Fl2=(Fbf2*fcal-Flongf2*muf)/(-mlf-muf)
% Fl3=(Fbr1*rcal-Flongr1*mur)/(-mlf-mur) %Rear lower longt force
% Fl4=(Fbr2*rcal-Flongr2*mur)/(-mlf-mur)

Fulong=-[Flongf1+Fllong(1),Flongf2-Fllong(3);Flongr1-Fllong(2),Flongr2-Fllong(4)]
% Fu1=Flongf1-Fl1 %Front upper longt force
% Fu2=Flongf2-Fl2
% Fu3=Flongr1-Fl3 %Front lower Longt force
% Fu4=Flongr2-Fl4

elseif glong<0 
fprintf('SCENARIO: Worse case braking - Use for Front\n'); 
%adding in downforce 
Ldyn(1)=Ldyn(1)+200*cgf/2;
Ldyn(2)=Ldyn(2)+200*cgf/2;
Ldyn(3)=Ldyn(3)+200*cgr/2;
Ldyn(4)=Ldyn(4)+200*cgr/2
%Braking force at wheel center, assuming 1.4coeff long:
Flongf1=Ldyn(1)*glong;
Flongf2=Ldyn(3)*glong;
Flongr1=Ldyn(2)*glong;
Flongr2=Ldyn(4)*glong;

%Upright Moment arms (approximation, ignoring caster/kpi which are small anyway:
mlf=2.699; %front lower dist from bj to spindle
muf=3.920; %front upper """"""
mlr=4.19; %rear lower
mur=3.37; %rear upper 
%Brake moment arm
%fcal=2.85;
%rcal=2.73; 
%wheel radius
r=9.1;
%Fbf1=Flongf1*r/fcal; %force at caliper mount, dist fcal/rcal from center of wheel
%Fbf2=Flongf2*r/fcal;
%Fbr1=Flongr1*r/rcal;
%Fbr2=Flongr2*r/rcal;
fprintf('Format of results (All in Lbs): \n FL FR \n RL RR\n')
fprintf('Lower arms Long:\n')
Fllong=[(Flongf1*muf)/(mlf+muf),(Flongf2*muf)/(mlf+muf);(Flongr1*mur)/(mlf+mur),(Flongr2*mur)/(mlf+mur) 
]
% Fl1=(Fbf1*fcal-Flongf1*muf)/(-mlf-muf) %Front lower longt force
% Fl2=(Fbf2*fcal-Flongf2*muf)/(-mlf-muf)
% Fl3=(Fbr1*rcal-Flongr1*mur)/(-mlf-mur) %Rear lower longt force
% Fl4=(Fbr2*rcal-Flongr2*mur)/(-mlf-mur)
fprintf('Upper arms Long:\n')
Fulong=-[Flongf1-Fllong(1),Flongf2-Fllong(3);Flongr1-Fllong(2),Flongr2-Fllong(4)]
% Fu1=Flongf1-Fl1 %Front upper longt force
% Fu2=Flongf2-Fl2
% Fu3=Flongr1-Fl3 %Front lower Longt force
% Fu4=Flongr2-Fl4    
    
    
end    
    
    
%FV: Lat only 
%cornering force at tire patch.
Flatf1=Ldyn(1)*glat;
Flatf2=Ldyn(3)*glat;
Flatr1=Ldyn(2)*glat;
Flatr2=Ldyn(4)*glat; 

fprintf('\n Lower arms Lat:\n')
Fllat=[(Flatf1*muf+Flatf1*r)/(mlf+muf),(Flatf2*muf+Flatf2*r)/(mlf+muf);(Flatr1*mur+Flatr1*r)/(mlr+mur),(Flatr2*mur+Flatr2*r)/(mlr+mur);]

% Fl1long=(Flatf1*muf+Flatf1*r)/(mlf+muf);
% Fl2long=(Flatf2*muf+Flatf2*r)/(mlf+muf);
% Fl3long=(Flatr1*mur+Flatr1*r)/(mlr+mur) ;
% Fl4long=(Flatr2*mur+Flatr2*r)/(mlr+mur) ;
fprintf('Upper arms Lat:\n')
Fulat=[Flatf1-Fllat(1),Flatf2-Fllat(3);Flatr1-Fllat(2),Flatr2-Fllat(4);]





%TV: Steer from lat/long
scrubf=2.56;
scrubr=.82;

trailf=.24;
trailr=2.61;




