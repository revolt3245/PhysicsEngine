function[Mi, AMi, AMA] = KKT_Sys(M, A)
Mi = inv(M);
AMi = A/M;
AMA = AMi*A'; 
end