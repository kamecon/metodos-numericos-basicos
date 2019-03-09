clear all
close all
%% Param�tros
tic
%Funcion de Utilidad
Beta=0.95;
Gamma=0.5;
%Iteracion
TOL=1*10^(-6);
itermax=2000;
distance=1;
n=1;
%GRID
NA=1000;
%Funci�n Valor
V1=zeros(NA,1);
V=zeros(NA,1);
%V=AGRID.^(1/2);
%Funci�n Pol�tica Inicial
A_pindex=zeros(NA,1,'uint32');
A_prime=zeros(NA,1);
CONSUMO=zeros(NA,1);
disp('==================================================================')
disp('		Valores de los Parametros	')
disp(['Factor subjetivo de descuento               ',num2str(Beta)])
disp(['Grado de aversi�n al riesgo                 ',num2str(Gamma)])
disp(['N�mero de activos                           ',num2str(NA)])
disp('==================================================================')

%% Generaci�n del GRID
disp('  Generando el Grid	')
AGRID=linspace(0,100,NA);
%% UPPER BOUND
%Determinamos el limite superior de busqueda en la iteraci�n de la funci�n
%valor, asi evitamos que la funci�n pierda el tiempo buscando en valores
%del capital ma�ana que implican valores negativos del consumo (no
%factibles)
disp('	Calculando el l�mite m�ximo de busqueda para cada activo hoy	')
IUB=zeros(1,NA,'uint32');
for ia= 1:NA %loop sobre activos hoy
    ingreso=AGRID(ia);
    for ia_p=1:NA %loop sobre activos ma�ana
        a_prime=AGRID(ia_p);
        if ingreso > a_prime
            IUB(ia)=ia_p;
%         else
%             ia_p=NA+1;
        end
    end
end


%% Iteraci�n Funci�n Valor
disp('==================================================================')
disp('	Iterando la Funci�n Valor	')
disp(['Numero m�ximo de iteraciones               ',num2str(itermax)])
disp(['Factor de tolerancia                       ',num2str(TOL)])
disp('==================================================================')



while distance>TOL && n<itermax;
    
%Valores cuando a=0 [AGRID(1)]
V1(1)=V(2)-100;
A_pindex(1)=1;
CONSUMO(1)=0;
A_prime(1)=AGRID(A_pindex(1));
    
for ia=2:NA
    A_pindex(ia)=IUB(ia);
    consumo=AGRID(ia)-AGRID(A_pindex(ia));
    VMAX=((consumo^(1-(1/Gamma)))/(1-(1/Gamma)))+(Beta*V(A_pindex(ia)));
    for ia_p=max(IUB(ia)-1,1):-1:1
        consumo_temp=AGRID(ia)-AGRID(ia_p);
        RHS=(consumo_temp^(1-(1/Gamma)))/(1-(1/Gamma))+Beta*V(ia_p);
        if RHS>VMAX
            VMAX=RHS;
            A_pindex(ia)=ia_p;
        end
    end
    V1(ia)=VMAX;
    A_prime(ia)=AGRID(A_pindex(ia));
    CONSUMO(ia)=AGRID(ia)-A_prime(ia);
end
distance=max(abs(V1-V)./abs(V));
fprintf('Iteracion: %d, diferencia: %9.7f\n', n, distance);
V=V1;
n=n+1;

end
toc
if n>=itermax
     disp(['Advertencia: Numero maximo de iteraciones alcanzado ',num2str(n)])
else
disp(['El algoritmo ha convergido en '...
            num2str(n),' iteraciones'])
disp(['Operacion realizada en '...
         num2str(toc),' segundos'])
end
%% Funciones de pol�tica y gr�ficos
consumo_analitico=AGRID*(1-(Beta^Gamma));
activos_analitico=AGRID*(Beta^Gamma);
vf_analitico=((1-Beta^Gamma)^(-1/Gamma))*(AGRID(10:NA).^(1-(1/Gamma))/(1-(1/Gamma)));
figure
plot(AGRID(10:NA),V1(10:NA),'b',AGRID(10:NA),vf_analitico,'r')
   grid
   xlabel('Activos en t')
   ylabel('Funci�n Valor')
   title(['Funci�n Valor �ptima alcanzada luego de ',num2str(n),' iteraciones con error '...
         num2str(distance)])
   legend('Num�rico', 'Anal�tico','Location','SouthEast')

figure
plot(AGRID,A_prime,'b',AGRID,activos_analitico,'r')
grid
   xlabel('Activos en t')
   ylabel('Activos en t+1')
   title('Funci�n de Pol�tica para el activo ')
   legend('Num�rico', 'Anal�tico','Location','SouthEast')
   
figure
plot(AGRID,CONSUMO,'b',AGRID,consumo_analitico, 'r')
grid
   xlabel('Activos en t')
   ylabel('Consumo en t')
   title('Funci�n de Pol�tica para el consumo ')
legend('Num�rico', 'Anal�tico','Location','SouthEast')
