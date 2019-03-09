# -*- coding: utf-8 -*-
"""
Created on Wed Apr 13 13:56:16 2016

@author: karomero
"""
import numpy as np
import time

t1=time.time()
#############################################
#Parametros
#############################################
#Funcion de utilidad
Beta=0.95  
Gamma=0.5
#Iteracion
TOL=1.0e-6
itermax=2000
distance=1.0
contador=1
#GRID
NA=101
#Funcion Valor
V1=np.empty((NA,1), dtype=float)
V=np.zeros((NA,1), dtype=float)
#Función Política Inicial
A_pindex=np.ones((NA,1), dtype=np.uint32)
A_prime=np.zeros((NA,1), dtype=float)
CONSUMO=np.empty((NA,1), dtype=float)
#Generación del GRID
print('  Generando el Grid	')
AGRID=np.linspace(0,100,NA)

## UPPER BOUND
#Determinmos el limite superior de busqueda en la iteración de la función
#valor, asi evitamos que la función pierda el tiempo buscando en valores
#del capital mañana que implican valores negativos del consumo (no
#factibles)
print('	Calculando el límite máximo de busqueda para cada activo hoy	')
IUB=np.empty((NA,1), dtype=np.int32)
IUB[0]=0
for ia in range(NA):
    ingreso=AGRID[ia]
    for ia_p in range(NA):
        a_prime=AGRID[ia_p]
        if ingreso > a_prime:
            IUB[ia]=ia_p
#############################################
#Iteracion de la Funcion Valor
#############################################            
print('	Iterando la Función Valor	')
while distance > TOL and contador < itermax:
    V1[0]=V[1]-100.0
    A_pindex[0]=0
    CONSUMO[0]=0.0
    #Iteración
    for ia in range(1,NA,1):
        A_pindex[ia]=IUB[ia]
        consumo=AGRID[ia]-AGRID[A_pindex[ia]]
        VMAX=consumo**(1-(1/Gamma)) / (1-(1/Gamma)) +  Beta*V[A_pindex[ia]]
        for ia_p in range(max(IUB[ia]-1,0),0,-1):
            consumo2=AGRID[ia]-AGRID[ia_p]
            RHS=consumo2**(1-(1/Gamma)) / (1-(1/Gamma)) +  Beta*V[ia_p]
            if RHS > VMAX:
                A_pindex[ia]=ia_p
                VMAX=RHS
        A_prime[ia]=AGRID[A_pindex[ia]]
        V1[ia]=VMAX
        CONSUMO[ia]=AGRID[ia]-A_prime[ia]
    distance=max(abs(V1-V)/abs(V))
    print ('iteracion: %d, distancia: %0.15f' % (contador, distance))
    V=V1
    #V=np.copy(V1)    
    V1=np.empty((NA,1), dtype=float)
    contador += 1

t2=time.time()
tiempo=t2-t1
if contador >= itermax:
    print ('Advertencia: Numero maximo de iteraciones alcanzado %d' % contador )
else:
    print ('El algoritmo ha convergido en %d iteraciones' % contador)
    print ('Operacion realizada en %f segundos' % tiempo)  

 #Funciones analíticas
consumo_analitico=AGRID*(1-(Beta**Gamma))
A_analitico=AGRID*(Beta**Gamma)
V_analitico=((1-(Beta**Gamma))**(-1/Gamma))*(AGRID[9:NA]**(1-(1/Gamma)) / (1-(1/Gamma)))
#############################################
#Graficos
#############################################
import matplotlib.pyplot as plt
plt.figure(figsize=(8,6), dpi=80)
V,VV = V, V_analitico
plt.plot(AGRID[9:NA], V[9:NA], color="blue", linewidth=2.5, linestyle="-")    
plt.plot(AGRID[9:NA], VV, color="red", linewidth=2.5, linestyle="-") 
plt.xlabel('Activos') 
plt.ylabel('Función Valor')
plt.title('Función Valor')
plt.legend(loc='lower right', frameon=False) 
plt.figure(figsize=(8,6), dpi=80)
A,AA = A_prime, A_analitico
plt.plot(AGRID, A, color="red", linewidth=1.0, linestyle="-")  
plt.plot(AGRID, AA, color="blue", linewidth=1.0, linestyle="-") 
plt.xlabel('Activos hoy') 
plt.ylabel('Activos hoy')
plt.title('Función de Política Activos')
plt.legend(loc='lower right', frameon=False) 
plt.figure(figsize=(10,6), dpi=80)
C,S = CONSUMO, consumo_analitico
plt.plot(AGRID, C, color="blue", linewidth=2.5, linestyle="-")
plt.plot(AGRID, S, color="red",  linewidth=2.5, linestyle="-")
plt.xlabel('Activos') 
plt.ylabel('Consumo')
plt.title('Función Consumo')
plt.legend(loc='lower right', frameon=False) 