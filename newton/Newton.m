%Newton
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
df = @(x) -0.1*x^(-1.2)-0.25*x^(-1.5);

%Punto Inicial
x0=0.1;

%Busqueda
while diff > tol
    fx0=f(x0);
    dfx0=df(x0);
    x=x0-(f(x0)/df(x0));
    diff=abs(x-x0);
    x0=x;
    contador=contador+1;
fprintf('Iteracion: %d, diferencia: %9.7f\n', contador, diff);
end
fx=f(x);
fprintf('La raiz es %9.7f y f(x) %9.9f\n', x, fx);


