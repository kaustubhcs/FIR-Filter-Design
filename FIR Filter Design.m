%% Filter Design the Watermelon Algorithm
%

%%
% Initialization

clear all;
clc;

%%
% Code start

disp('Function Start');

%%
% Inputs to the System

%%
%

%n = 1:10;
n = 100;

%%
% STOP Band Frequency
Ws =  0.35*pi;

%%
% Del 'S'

dels = 0.005;


%%
% PASS Band Frequency
Wp = 0.25*pi;


%%
%

Wc = (Ws + Wp) / 2;

%%
%
delta = Ws - Wp;

%%
% Peak of First Side Lobe

slp = -20 * log(dels) / log(10);
% slp
%%
%

fpv = [13 27 32 43 58];

%%
flag_rect = false;
flag_barlett = false;
flag_hanning = false;
flag_hamming = false;
flag_blackman = false;

classifier = 0;
%%
if (slp <= fpv(1))
    
     classifier = 1;    

end


%%
if (slp > fpv(1) && slp <= fpv(2))
    classifier = 2;
end


%%
if (slp > fpv(2) && slp <= fpv(3))
    classifier = 3;
end

%%
if (slp > fpv(3) && slp <= fpv(4))
    classifier = 4;
end

%%
if (slp > fpv(4) && slp <= fpv(5))
    classifier = 5;
end
%%

switch(classifier)
   
    case 1
        flag_rect = true;
      
          
    case 2 
        flag_barlett = true;
      
        
    case 3
        flag_hanning = true;
      
        
    case 4
        flag_hamming = true;
      
        
    case 5
        flag_blackman = true;
      
        
    case 0
        disp('Defaulted Case, Filter unable to be designed')
               
end


%%

if (flag_rect == 1)
    disp('Designing Rectangular Window');
    N = 4*pi/delta;
    alpha = (N-1)/2;
%%
%
r=rem(alpha,1);
%%
%
if r>0
    
    alpha = alpha-r;
   
    if rem(alpha,2)
        
        alpha = alpha + 2;
    else
        
        alpha = alpha + 1;
    end
    
else 
    
    if rem(alpha,2)
        alpha = alpha;
        
    else
        
        alpha = alpha + 1;
    end
    
end
    
    window = rectwin(2*alpha);
    
end
%%

if (flag_barlett)
    disp('Designing Barlett Window');
    N = 8*pi/delta;
    alpha = (N-1)/2;
%%
%
r=rem(alpha,1);
%%
%
if r>0
    
    alpha = alpha-r;
   
    if rem(alpha,2)
        
        alpha = alpha + 2;
    else
        
        alpha = alpha + 1;
    end
    
else 
    
    if rem(alpha,2)
        alpha = alpha;
        
    else
        
        alpha = alpha + 1;
    end
    
end
    
    window = bartlett(2*alpha);
    
end
%%

if (flag_hanning)
    
    disp('Designing Hanning Window');
    N = 8*pi/delta;
    alpha = (N-1)/2;
%%
%
r=rem(alpha,1);
%%
%
if r>0
    
    alpha = alpha-r;
   
    if rem(alpha,2)
        
        alpha = alpha + 2;
    else
        
        alpha = alpha + 1;
    end
    
else 
    
    if rem(alpha,2)
        alpha = alpha;
        
    else
        
        alpha = alpha + 1;
    end
    
end
    
    window = hann(2*alpha);
    
end
%%

if (flag_hamming)
    disp('Designing Hamming Window');
    N = 8*pi/delta;
    alpha = (N-1)/2;
%%
%
r=rem(alpha,1);
%%
%
if r>0
    
    alpha = alpha-r;
   
    if rem(alpha,2)
        
        alpha = alpha + 2;
    else
        
        alpha = alpha + 1;
    end
    
else 
    
    if rem(alpha,2)
        alpha = alpha;
        
    else
        
        alpha = alpha + 1;
    end
    
end
    
    window = hamming(2*alpha);
    
    
end
%%

if (flag_blackman)
    disp('Designing Blackman Window');
    N = 12*pi/delta;
    alpha = (N-1)/2;
%%
%
r=rem(alpha,1);
%%
%
if r>0
    
    alpha = alpha-r;
   
    if rem(alpha,2)
        
        alpha = alpha + 2;
    else
        
        alpha = alpha + 1;
    end
    
else 
    
    if rem(alpha,2)
        alpha = alpha;
        
    else
        
        alpha = alpha + 1;
    end
    
end
    
    window = blackman(2*alpha);
    
end

%%
%

for ktb = 1:(2*alpha)

hd(ktb) = (Wc * sin(Wc*(ktb-alpha)))/(pi*(ktb-alpha));
end

for ktb = 1:(2*alpha)
% ktb
H(ktb) = hd(ktb) * window(ktb);

end

H(alpha) = Wc/pi;


t = 1:(2*alpha);
stem(t,H)