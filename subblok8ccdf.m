function [cdf3, PAPR3,seri_data3,BD_data]=subblok8ccdf(qpsk,BD_data,symbol_per_carrier,subcarrier,Phase_Set);

Vt = 8;   
V= 2*Vt; %Perbedaan PTS enhanced dgn biasa, terdapat peningkatan jumlah subblok, namun kombinasi tetap. N/2V
Choose = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1; 1 1 1 1 1 1 1 2 2 1 1 1 1 1 1 1; 1 1 1 1 1 1 2 1 1 2 1 1 1 1 1 1; 1 1 1 1 1 1 2 2 2 2 1 1 1 1 1 1;...
          1 1 1 1 1 2 1 1 1 1 2 1 1 1 1 1; 1 1 1 1 1 2 1 2 2 1 2 1 1 1 1 1; 1 1 1 1 1 2 2 1 1 2 2 1 1 1 1 1; 1 1 1 1 1 2 2 2 2 2 2 1 1 1 1 1;...
          1 1 1 1 2 1 1 1 1 1 1 2 1 1 1 1; 1 1 1 1 2 1 1 2 2 1 1 2 1 1 1 1; 1 1 1 1 2 1 2 1 1 2 1 2 1 1 1 1; 1 1 1 1 2 1 2 2 2 2 1 2 1 1 1 1;...
          1 1 1 1 2 2 1 1 1 1 2 2 1 1 1 1; 1 1 1 1 2 2 1 2 2 1 2 2 1 1 1 1; 1 1 1 1 2 2 2 1 1 2 2 2 1 1 1 1; 1 1 1 1 2 2 2 2 2 2 2 2 1 1 1 1;...
          1 1 1 2 1 1 1 1 1 1 1 1 2 1 1 1; 1 1 1 2 1 1 1 2 2 1 1 1 2 1 1 1; 1 1 1 2 1 1 2 1 1 2 1 1 2 1 1 1; 1 1 1 2 1 1 2 2 2 2 1 1 2 1 1 1;...
          1 1 1 2 1 2 1 1 1 1 2 1 2 1 1 1; 1 1 1 2 1 2 1 2 2 1 2 1 2 1 1 1; 1 1 1 2 1 2 2 1 1 2 2 1 2 1 1 1; 1 1 1 2 1 2 2 2 2 2 2 1 2 1 1 1;...
          1 1 1 2 2 1 1 1 1 1 1 2 2 1 1 1; 1 1 1 2 2 1 1 2 2 1 1 2 2 1 1 1; 1 1 1 2 2 1 2 1 1 2 1 2 2 1 1 1; 1 1 1 2 2 1 2 2 2 2 1 2 2 1 1 1;...
          1 1 1 2 2 2 1 1 1 1 2 2 2 1 1 1; 1 1 1 2 2 2 1 2 2 1 2 2 2 1 1 1; 1 1 1 2 2 2 2 1 1 2 2 2 2 1 1 1; 1 1 1 2 2 2 2 2 2 2 2 2 2 1 1 1;...          
          1 1 2 1 1 1 1 1 1 1 1 1 1 2 1 1; 1 1 2 1 1 1 1 2 2 1 1 1 1 2 1 1; 1 1 2 1 1 1 2 1 1 2 1 1 1 2 1 1; 1 1 2 1 1 1 2 2 2 2 1 1 1 2 1 1;...
          1 1 2 1 1 2 1 1 1 1 2 1 1 2 1 1; 1 1 2 1 1 2 1 2 2 1 2 1 1 2 1 1; 1 1 2 1 1 2 2 1 1 2 2 1 1 2 1 1; 1 1 2 1 1 2 2 2 2 2 2 1 1 2 1 1;...
          1 1 2 1 2 1 1 1 1 1 1 2 1 2 1 1; 1 1 2 1 2 1 1 2 2 1 1 2 1 2 1 1; 1 1 2 1 2 1 2 1 1 2 1 2 1 2 1 1; 1 1 2 1 2 1 2 2 2 2 1 2 1 2 1 1;...
          1 1 2 1 2 2 1 1 1 1 2 2 1 2 1 1; 1 1 2 1 2 2 1 2 2 1 2 2 1 2 1 1; 1 1 2 1 2 2 2 1 1 2 2 2 1 2 1 1; 1 1 2 1 2 2 2 2 2 2 2 2 1 2 1 1;...
          1 1 2 2 1 1 1 1 1 1 1 1 2 2 1 1; 1 1 2 2 1 1 1 2 2 1 1 1 2 2 1 1; 1 1 2 2 1 1 2 1 1 2 1 1 2 2 1 1; 1 1 2 2 1 1 2 2 2 2 1 1 2 2 1 1;...
          1 1 2 2 1 2 1 1 1 1 2 1 2 2 1 1; 1 1 2 2 1 2 1 2 2 1 2 1 2 2 1 1; 1 1 2 2 1 2 2 1 1 2 2 1 2 2 1 1; 1 1 2 2 1 2 2 2 2 2 2 1 2 2 1 1;...
          1 1 2 2 2 1 1 1 1 1 1 2 2 2 1 1; 1 1 2 2 2 1 1 2 2 1 1 2 2 2 1 1; 1 1 2 2 2 1 2 1 1 2 1 2 2 2 1 1; 1 1 2 2 2 1 2 2 2 2 1 2 2 2 1 1;...
          1 1 2 2 2 2 1 1 1 1 2 2 2 2 1 1; 1 1 2 2 2 2 1 2 2 1 2 2 2 2 1 1; 1 1 2 2 2 2 2 1 1 2 2 2 2 2 1 1; 1 1 2 2 2 2 2 2 2 2 2 2 2 2 1 1;...            
          1 2 1 1 1 1 1 1 1 1 1 1 1 1 2 1; 1 2 1 1 1 1 1 2 2 1 1 1 1 1 2 1; 1 2 1 1 1 1 2 1 1 2 1 1 1 1 2 1; 1 2 1 1 1 1 2 2 2 2 1 1 1 1 2 1;...
          1 2 1 1 1 2 1 1 1 1 2 1 1 1 2 1; 1 2 1 1 1 2 1 2 2 1 2 1 1 1 2 1; 1 2 1 1 1 2 2 1 1 2 2 1 1 1 2 1; 1 2 1 1 1 2 2 2 2 2 2 1 1 1 2 1;...
          1 2 1 1 2 1 1 1 1 1 1 2 1 1 2 1; 1 2 1 1 2 1 1 2 2 1 1 2 1 1 2 1; 1 2 1 1 2 1 2 1 1 2 1 2 1 1 2 1; 1 2 1 1 2 1 2 2 2 2 1 2 1 1 2 1;...
          1 2 1 1 2 2 1 1 1 1 2 2 1 1 2 1; 1 2 1 1 2 2 1 2 2 1 2 2 1 1 2 1; 1 2 1 1 2 2 2 1 1 2 2 2 1 1 2 1; 1 2 1 1 2 2 2 2 2 2 2 2 1 1 2 1;...
          1 2 1 2 1 1 1 1 1 1 1 1 2 1 2 1; 1 2 1 2 1 1 1 2 2 1 1 1 2 1 2 1; 1 2 1 2 1 1 2 1 1 2 1 1 2 1 2 1; 1 2 1 2 1 1 2 2 2 2 1 1 2 1 2 1;...
          1 2 1 2 1 2 1 1 1 1 2 1 2 1 2 1; 1 2 1 2 1 2 1 2 2 1 2 1 2 1 2 1; 1 2 1 2 1 2 2 1 1 2 2 1 2 1 2 1; 1 2 1 2 1 2 2 2 2 2 2 1 2 1 2 1;...
          1 2 1 2 2 1 1 1 1 1 1 2 2 1 2 1; 1 2 1 2 2 1 1 2 2 1 1 2 2 1 2 1; 1 2 1 2 2 1 2 1 1 2 1 2 2 1 2 1; 1 2 1 2 2 1 2 2 2 2 1 2 2 1 2 1;...
          1 2 1 2 2 2 1 1 1 1 2 2 2 1 2 1; 1 2 1 2 2 2 1 2 2 1 2 2 2 1 2 1; 1 2 1 2 2 2 2 1 1 2 2 2 2 1 2 1; 1 2 1 2 2 2 2 2 2 2 2 2 2 2 1 2;...            
          1 2 2 1 1 1 1 1 1 1 1 1 1 2 2 1; 1 2 2 1 1 1 1 2 2 1 1 1 1 2 2 1; 1 2 2 1 1 1 2 1 1 2 1 1 1 2 2 1; 1 2 2 1 1 1 2 2 2 2 1 1 1 2 2 1;...
          1 2 2 1 1 2 1 1 1 1 2 1 1 2 2 1; 1 2 2 1 1 2 1 2 2 1 2 1 1 2 2 1; 1 2 2 1 1 2 2 1 1 2 2 1 1 2 2 1; 1 2 2 1 1 2 2 2 2 2 2 1 1 2 2 1;...
          1 2 2 1 2 1 1 1 1 1 1 2 1 2 2 1; 1 2 2 1 2 1 1 2 2 1 1 2 1 2 2 1; 1 2 2 1 2 1 2 1 1 2 1 2 1 2 2 1; 1 2 2 1 2 1 2 2 2 2 1 2 1 2 2 1;...
          1 2 2 1 2 2 1 1 1 1 2 2 1 2 2 1; 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1; 1 2 2 1 2 2 2 1 1 2 2 2 1 2 2 1; 1 2 2 1 2 2 2 2 2 2 2 2 1 2 2 1;...
          1 2 2 2 1 1 1 1 1 1 1 1 2 2 2 1; 1 2 2 2 1 1 1 2 2 1 1 1 2 2 2 1; 1 2 2 2 1 1 2 1 1 2 1 1 2 2 2 1; 1 2 2 2 1 1 2 2 2 2 1 1 2 2 2 1;...
          1 2 2 2 1 2 1 1 1 1 2 1 2 2 2 1; 1 2 2 2 1 2 1 2 2 1 2 1 2 2 2 1; 1 2 2 2 1 2 2 1 1 2 2 1 2 2 2 1; 1 2 2 2 1 2 2 2 2 2 2 1 2 2 2 1;...
          1 2 2 2 2 1 1 1 1 1 1 2 2 2 2 1; 1 2 2 2 2 1 1 2 2 1 1 2 2 2 2 1; 1 2 2 2 2 1 2 1 1 2 1 2 2 2 2 1; 1 2 2 2 2 1 2 2 2 2 1 2 2 2 2 1;...
          1 2 2 2 2 2 1 1 1 1 2 2 2 2 2 1; 1 2 2 2 2 2 1 2 2 1 2 2 2 2 2 1; 1 2 2 2 2 2 2 1 1 2 2 2 2 2 2 1; 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1;...      
          2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2; 1 1 1 1 1 1 1 2 2 1 1 1 1 1 1 1; 1 1 1 1 1 1 2 1 1 2 1 1 1 1 1 1; 1 1 1 1 1 1 2 2 2 2 1 1 1 1 1 1;...
          2 1 1 1 1 2 1 1 1 1 2 1 1 1 1 2; 1 1 1 1 1 2 1 2 2 1 2 1 1 1 1 1; 1 1 1 1 1 2 2 1 1 2 2 1 1 1 1 1; 1 1 1 1 1 2 2 2 2 2 2 1 1 1 1 1;...
          2 1 1 1 2 1 1 1 1 1 1 2 1 1 1 2; 1 1 1 1 2 1 1 2 2 1 1 2 1 1 1 1; 1 1 1 1 2 1 2 1 1 2 1 2 1 1 1 1; 1 1 1 1 2 1 2 2 2 2 1 2 1 1 1 1;...
          2 1 1 1 2 2 1 1 1 1 2 2 1 1 1 2; 1 1 1 1 2 2 1 2 2 1 2 2 1 1 1 1; 1 1 1 1 2 2 2 1 1 2 2 2 1 1 1 1; 1 1 1 1 2 2 2 2 2 2 2 2 1 1 1 1;...
          2 1 1 2 1 1 1 1 1 1 1 1 2 1 1 2; 1 1 1 2 1 1 1 2 2 1 1 1 2 1 1 1; 1 1 1 2 1 1 2 1 1 2 1 1 2 1 1 1; 1 1 1 2 1 1 2 2 2 2 1 1 2 1 1 1;...
          2 1 1 2 1 2 1 1 1 1 2 1 2 1 1 2; 1 1 1 2 1 2 1 2 2 1 2 1 2 1 1 1; 1 1 1 2 1 2 2 1 1 2 2 1 2 1 1 1; 1 1 1 2 1 2 2 2 2 2 2 1 2 1 1 1;...
          2 1 1 2 2 1 1 1 1 1 1 2 2 1 1 2; 1 1 1 2 2 1 1 2 2 1 1 2 2 1 1 1; 1 1 1 2 2 1 2 1 1 2 1 2 2 1 1 1; 1 1 1 2 2 1 2 2 2 2 1 2 2 1 1 1;...
          2 1 1 2 2 2 1 1 1 1 2 2 2 1 1 2; 1 1 1 2 2 2 1 2 2 1 2 2 2 1 1 1; 1 1 1 2 2 2 2 1 1 2 2 2 2 1 1 1; 1 1 1 2 2 2 2 2 2 2 2 2 2 1 1 1;...          
          2 1 2 1 1 1 1 1 1 1 1 1 1 2 1 2; 1 1 2 1 1 1 1 2 2 1 1 1 1 2 1 1; 1 1 2 1 1 1 2 1 1 2 1 1 1 2 1 1; 1 1 2 1 1 1 2 2 2 2 1 1 1 2 1 1;...
          2 1 2 1 1 2 1 1 1 1 2 1 1 2 1 2; 1 1 2 1 1 2 1 2 2 1 2 1 1 2 1 1; 1 1 2 1 1 2 2 1 1 2 2 1 1 2 1 1; 1 1 2 1 1 2 2 2 2 2 2 1 1 2 1 1;...
          2 1 2 1 2 1 1 1 1 1 1 2 1 2 1 2; 1 1 2 1 2 1 1 2 2 1 1 2 1 2 1 1; 1 1 2 1 2 1 2 1 1 2 1 2 1 2 1 1; 1 1 2 1 2 1 2 2 2 2 1 2 1 2 1 1;...
          2 1 2 1 2 2 1 1 1 1 2 2 1 2 1 2; 1 1 2 1 2 2 1 2 2 1 2 2 1 2 1 1; 1 1 2 1 2 2 2 1 1 2 2 2 1 2 1 1; 1 1 2 1 2 2 2 2 2 2 2 2 1 2 1 1;...
          2 1 2 2 1 1 1 1 1 1 1 1 2 2 1 2; 1 1 2 2 1 1 1 2 2 1 1 1 2 2 1 1; 1 1 2 2 1 1 2 1 1 2 1 1 2 2 1 1; 1 1 2 2 1 1 2 2 2 2 1 1 2 2 1 1;...
          2 1 2 2 1 2 1 1 1 1 2 1 2 2 1 2; 1 1 2 2 1 2 1 2 2 1 2 1 2 2 1 1; 1 1 2 2 1 2 2 1 1 2 2 1 2 2 1 1; 1 1 2 2 1 2 2 2 2 2 2 1 2 2 1 1;...
          2 1 2 2 2 1 1 1 1 1 1 2 2 2 1 2; 1 1 2 2 2 1 1 2 2 1 1 2 2 2 1 1; 1 1 2 2 2 1 2 1 1 2 1 2 2 2 1 1; 1 1 2 2 2 1 2 2 2 2 1 2 2 2 1 1;...
          2 1 2 2 2 2 1 1 1 1 2 2 2 2 1 2; 1 1 2 2 2 2 1 2 2 1 2 2 2 2 1 1; 1 1 2 2 2 2 2 1 1 2 2 2 2 2 1 1; 1 1 2 2 2 2 2 2 2 2 2 2 2 2 1 1;...            
          2 2 1 1 1 1 1 1 1 1 1 1 1 1 2 2; 1 2 1 1 1 1 1 2 2 1 1 1 1 1 2 1; 1 2 1 1 1 1 2 1 1 2 1 1 1 1 2 1; 1 2 1 1 1 1 2 2 2 2 1 1 1 1 2 1;...
          2 2 1 1 1 2 1 1 1 1 2 1 1 1 2 2; 1 2 1 1 1 2 1 2 2 1 2 1 1 1 2 1; 1 2 1 1 1 2 2 1 1 2 2 1 1 1 2 1; 1 2 1 1 1 2 2 2 2 2 2 1 1 1 2 1;...
          2 2 1 1 2 1 1 1 1 1 1 2 1 1 2 2; 1 2 1 1 2 1 1 2 2 1 1 2 1 1 2 1; 1 2 1 1 2 1 2 1 1 2 1 2 1 1 2 1; 1 2 1 1 2 1 2 2 2 2 1 2 1 1 2 1;...
          2 2 1 1 2 2 1 1 1 1 2 2 1 1 2 2; 1 2 1 1 2 2 1 2 2 1 2 2 1 1 2 1; 1 2 1 1 2 2 2 1 1 2 2 2 1 1 2 1; 1 2 1 1 2 2 2 2 2 2 2 2 1 1 2 1;...
          2 2 1 2 1 1 1 1 1 1 1 1 2 1 2 2; 1 2 1 2 1 1 1 2 2 1 1 1 2 1 2 1; 1 2 1 2 1 1 2 1 1 2 1 1 2 1 2 1; 1 2 1 2 1 1 2 2 2 2 1 1 2 1 2 1;...
          2 2 1 2 1 2 1 1 1 1 2 1 2 1 2 2; 1 2 1 2 1 2 1 2 2 1 2 1 2 1 2 1; 1 2 1 2 1 2 2 1 1 2 2 1 2 1 2 1; 1 2 1 2 1 2 2 2 2 2 2 1 2 1 2 1;...
          2 2 1 2 2 1 1 1 1 1 1 2 2 1 2 2; 1 2 1 2 2 1 1 2 2 1 1 2 2 1 2 1; 1 2 1 2 2 1 2 1 1 2 1 2 2 1 2 1; 1 2 1 2 2 1 2 2 2 2 1 2 2 1 2 1;...
          2 2 1 2 2 2 1 1 1 1 2 2 2 1 2 2; 1 2 1 2 2 2 1 2 2 1 2 2 2 1 2 1; 1 2 1 2 2 2 2 1 1 2 2 2 2 1 2 1; 1 2 1 2 2 2 2 2 2 2 2 2 2 1 2 1;...            
          2 2 2 1 1 1 1 1 1 1 1 1 1 2 2 2; 1 2 2 1 1 1 1 2 2 1 1 1 1 2 2 1; 1 2 2 1 1 1 2 1 1 2 1 1 1 2 2 1; 1 2 2 1 1 1 2 2 2 2 1 1 2 2 1 1;...
          2 2 2 1 1 2 1 1 1 1 2 1 1 2 2 2; 1 2 2 1 1 2 1 2 2 1 2 1 1 2 2 1; 1 2 2 1 1 2 2 1 1 2 2 1 1 2 2 1; 1 2 2 1 1 2 2 2 2 2 2 1 1 2 2 1;...
          2 2 2 1 2 1 1 1 1 1 1 2 1 2 2 2; 1 2 2 1 2 1 1 2 2 1 1 2 1 2 2 1; 1 2 2 1 2 1 2 1 1 2 1 2 1 2 2 1; 1 2 2 1 2 1 2 2 2 2 1 2 1 2 2 1;...
          2 2 2 1 2 2 1 1 1 1 2 2 1 2 2 2; 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1; 1 2 2 1 2 2 2 1 1 2 2 2 1 2 2 1; 1 2 2 1 2 2 2 2 2 2 2 2 1 2 2 1;...
          2 2 2 2 1 1 1 1 1 1 1 1 2 2 2 2; 1 2 2 2 1 1 1 2 2 1 1 1 2 2 2 1; 1 2 2 2 1 1 2 1 1 2 1 1 2 2 2 1; 1 2 2 2 1 1 2 2 2 2 1 1 2 2 2 1;...
          2 2 2 2 1 2 1 1 1 1 2 1 2 2 2 2; 1 2 2 2 1 2 1 2 2 1 2 1 2 2 2 1; 1 2 2 2 1 2 2 1 1 2 2 1 2 2 2 1; 1 2 2 2 1 2 2 2 2 2 2 1 2 2 2 1;...
          2 2 2 2 2 1 1 1 1 1 1 2 2 2 2 2; 1 2 2 2 2 1 1 2 2 1 1 2 2 2 2 1; 1 2 2 2 2 1 2 1 1 2 1 2 2 2 2 1; 1 2 2 2 2 1 2 2 2 2 1 2 2 2 2 1;...
          2 2 2 2 2 2 1 1 1 1 2 2 2 2 2 2; 1 2 2 2 2 2 1 2 2 1 2 2 2 2 2 1; 1 2 2 2 2 2 2 1 1 2 2 2 2 2 2 1; 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1]; %2 adalah -1
           % size 256x(8x2) % kombinasi faktor fase dengan jumlah subblok 8 enhanced
          
Choose_Len = 256; 

qpsk=qpsk.';        %S/P
BD_data=BD_data'; 
for ii=1:symbol_per_carrier     
    A = zeros(V,subcarrier); 
    for k2=1:V  
        A(k2,k2:V:subcarrier)=qpsk(ii,k2:V:subcarrier);    %partisi subblok & qpsk   
    end   
    a = ifft(A,[],2);

% ------------ PTS ----------- 
    min_value = 10;  %treshold
    for n=1:Choose_Len 
        temp_phase = Phase_Set(Choose(n,:)).'; %mengubah kombinasi yg tadinya misal 1212 menjadi 1 -1 1 -1 ditransposes dari bentuk seri ke paralel
        temp_max = max(abs(sum(a.*repmat(temp_phase,1,subcarrier))));  %repmat untuk mengcopy yg terbaik tadi ke seluruh sublok, kemudian mencaari nilai maksimum 
        if temp_max<min_value % apabila puncak maksimum < threshold, maka puncak maksimum lah terkecil %sinyal kandidat dengan nilai terkecil
            min_value = temp_max; % kombinasi faktor fase yang terpilih yang dipilih dari 256 kombinasi misal yg terpilih 12121111 11112121
            Best_n = n;  %urutan kebrapa? misal yg paling bagus adalah kombinasi ke 24. kemudian looping terus sampek 256, dicari apakah paling bagus
        end 
    end 
    qpsk(ii,:) = sum(a.*repmat(Phase_Set(Choose(Best_n,:)).',1,subcarrier));  %diproses disini satupersatu
    use_phase=Phase_Set(Choose(Best_n,:));%mengubah kombinasi lagi misal yg tadinya paling bagus adalah 1211 menjadi 1 -1 1 1
    Signal_Power8 =abs(qpsk.^2);
    Peak_Power8 = max(Signal_Power8,[],2);
    Mean_Power8 = mean(Signal_Power8,2);
    PAPR_PTS8= 10*log10(Peak_Power8./Mean_Power8);
    for k2=1:V 
    no=repmat(use_phase(k2),1,subcarrier); % hasil dari use phase diinisialisasi sebagai k2[1,512] sebanyak subbloknya (8)
    BD_data(ii,k2:V:subcarrier)=no(k2:V:subcarrier); 
    end 
end
% figure(5)
% pts8=real(qpsk);
% plot(pts8)
% axis([0 inf -0.2 0.2])
% title(' PTS setelah reduksi subblok 8')
% xlabel('waktu')
% ylabel('Amplitudo')
% hold on;
% grid on;

qpsk3=qpsk.';
BD_data=BD_data';%num_subcarr*100 
seri_data=reshape(qpsk3,1,symbol_per_carrier*subcarrier); 
seri_data3 = seri_data;
[cdf3, PAPR3] = ecdf(PAPR_PTS8);

