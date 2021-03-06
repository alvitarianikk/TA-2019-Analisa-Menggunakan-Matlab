clear all; 
close all; 
clc; 

bit_per_symbol=2;                   
subcarrier=512;                  
symbol_per_carrier=1;             
       
IF=4;
N=subcarrier*symbol_per_carrier*IF;
BD_data=zeros(subcarrier,symbol_per_carrier);

baseband_datalength=subcarrier*symbol_per_carrier*bit_per_symbol;
        baseband_data=randint(1,baseband_datalength,2); 
        para_data=reshape(baseband_data,subcarrier,symbol_per_carrier*bit_per_symbol); %S/P
       
        % -------- QPSK ------------
data_length=baseband_datalength/subcarrier;
for i=1:subcarrier
   for i2=1:data_length/bit_per_symbol
        if para_data(i,2*i2-1)==0&para_data(i,2*i2)==0 
            qpskmod(i,i2)=1+j; 
        elseif para_data(i,2*i2-1)==0&para_data(i,2*i2)==1 
            qpskmod(i,i2)=-1+j; 
        elseif para_data(i,2*i2-1)==1&para_data(i,2*i2)== 0
            qpskmod(i,i2)=-1-j; 
        else 
            qpskmod(i,i2)=1-j; 
        end 
    end
end
       qpsk=qpskmod;
x=qpsk;
ich2 = real(qpsk); 
qch2 = imag(qpsk); 
figure(1); 
plot(ich2,qch2,'*b'); 
title('Konstelasi QPSK ')
grid on;

c1=0.90;
c3=0.40;
c5 =0.1732
G=10;
x=qpsk;
 for n = 1:length(x)
  v(n) = c1*x(n) + c3*x(n)*(abs(x(n)))^2+ c5*x(n)*(abs(x(n)))^4; 
    if n == 1 
       PA(n) =v(n);
    elseif n == 2
       PA(n)=0.2*PA(n-1)+v(n);  
    else
         PA(n)=0.2*PA(n-1)+v(n)+0.3*v(n-2); 
    end
 end
ich4 = real(PA);
qch4 = imag(PA); 
figure(5); 
plot(ich4,qch4,'*b'); 
title('Konstelasi PA TANPA PD')
grid on;
%Predistorter
for n = 1:length(x) 
    if n == 1 
u(n) = x(n);
    elseif n == 2
 u(n)=x(n)-0.2*u(n-1);  
    else
u(n)=-0.3*x(n-2)+x(n)-0.2*u(n-1);
    end
PD2(n) = c1*u(n)+c3*u(n)*(abs(u(n)))^2+c5*u(n)*(abs(u(n)))^4;   
% PA Hammer
if n == 1 
       PAPD(n) =PD2(n);
    elseif n == 2
       PAPD(n)=0.2*PAPD(n-1)+PD2(n);  
    else
         PAPD(n)=0.2*PAPD(n-1)+PD2(n)+0.2*PD2(n-2);
    end
end
%PA Hammer konstelasi
ich4 = real(PAPD); 
qch4 = imag(PAPD); 
figure(4); 
plot(ich4,qch4,'*b'); 
title('Konstelasi setelah PAPD')
% axis([-1.5 1.5 -1.5 1.5])
grid on;