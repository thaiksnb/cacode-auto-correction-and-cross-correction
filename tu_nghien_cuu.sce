function PRN = cacode(i,j) // функции для генерования x(t) и y(t)

t = 1:1023;

PRN = ones(1,1023);

G2tap1 = uint8(i);

G2tap2 = uint8(j);

G1 = [1,1,1,1,1,1,1,1,1,1];

G2 = [1,1,1,1,1,1,1,1,1,1];

G1 = uint8(G1);

G2 = uint8(G2);

PRN = uint8(PRN);

for i=1:1023

G1fb = uint8(bitxor(G1(3),G1(10)));

G2fb = uint8(bitxor(G2(2),G2(3)));

G2fb = uint8(bitxor(G2fb, G2(6)));

G2fb = uint8(bitxor(G2fb, G2(8)));

G2fb = uint8(bitxor(G2fb, G2(9)));

G2fb = uint8(bitxor(G2fb, G2(10)));

// if((G2(2)==G2(3)) & (G2(2)==G2(6)) & (G2(2)==G2(8)) & (G2(2)==G2(9)) & (G2(2)==G2(10))) then

// G2fb = 0;

// else

// G2fb = 1;

// end

G2out = uint8(bitxor(G2(G2tap1),G2(G2tap2)));;

PRN(i) = uint8(bitxor(G1(10),G2out));

G1(10) = G1(9);

G1(9) = G1(8);

G1(8) = G1(7);

G1(7) = G1(6);

G1(6) = G1(5);

G1(5) = G1(4);

G1(4) = G1(3);

G1(3) = G1(2);

G1(2) = G1(1);

G1(1) = G1fb;

G2(10) = G2(9);

G2(9) = G2(8);

G2(8) = G2(7);

G2(7) = G2(6);

G2(6) = G2(5);

G2(5) = G2(4);

G2(4) = G2(3);

G2(3) = G2(2);

G2(2) = G2(1);

G2(1) = G2fb;

end
endfunction
X = cacode(5,9);//x(t)
X_31= ones(1,31713);
Y = cacode(1,9);//y(t)
Y_31 = ones(1,31713);
t31 = 1:31713;
for i=1:31713 // Преобразовать в массив PRN 31
    X_31(i) = X(int((i-0.5)/31)+1);
    Y_31(i) = Y(int((i-0.5)/31)+1);
end
C_1= zeros(1,31713);
for j=1:31713 //автоколлекция
   for i=1:31713

      k = i-j;

      if(k<1) then k = k+31713;
      end

      if(X_31(i) == X_31(k)) then C_1(j) = C_1(j) +1;
      end     
         
   end
   
   
end
C_2= zeros(1,31713);
for j=1:31713//Кроссколлекция
    for i=1:31713

      k = i-j;

      if(k<1) then k = k+31713;
      end

      if(X_31(i) == Y_31(k)) then C_2(j) = C_2(j) +1;
      end     
         
   end
end
wn = 0;//График Дискретной функции
scf(wn);
plot2d(t31,C_1,2);
xgrid;
wn= wn+1;
scf(wn);
plot2d(t31,C_2,2);
xgrid;
wn= wn+1;
