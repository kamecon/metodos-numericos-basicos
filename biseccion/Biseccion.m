%Bisección
clear all
close all 
clc
%La función a evaluar es f(x)=0.5p^(-0.2)+0.5p^(-0.5)-2=0
%Parametros
diff=1;
tol=1*10^(-6);
contador=0;
%Funcion
f = @(x) 0.5*x^(-0.2)+0.5*x^(-0.5)-2;
%Bracket Inicial
a=0.05;
b=0.25;
fa=f(a);
fb=f(b);

%Verificar si se cumple que fa*fb<0 (existe una raiz en el intervalo [a,b])
if fa*fb >= 0
    disp(['Error: no hay una raiz en el intervalo propuesto'])
    break
end

%Biseccion Inicial
x=(a+b)/2;
fx=f(x);

%Busqueda
while diff > tol
    if fa*fx < 0
        b=x;
        fb=fx;
    else
        a=x;
        fa=fx;
    end
x=(a+b)/2;
fx=f(x);
diff=abs(x-a);
contador=contador+1;
fprintf('Iteracion: %d, diferencia: %9.7f\n', contador, diff);
end
%disp(['La raiz es  ',num2str(x),' y f(x)= ',num2str(fx)])
fprintf('La raiz es %9.7f y f(x) %9.9f\n', x, fx);


