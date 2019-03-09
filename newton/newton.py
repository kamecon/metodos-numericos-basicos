# -*- coding: utf-8 -*-
# Newton
#La función a evaluar es f(x)=0.5p^(-0.2)+0.5p^(-0.5)-2=0
import sys
#Parametros
diff=1
tol=1.0e-6
contador=0
#Funciones
f = lambda x: 0.5*x**(-0.2)+0.5*x**(-0.5)-2
df = lambda x: -0.1*x**(-1.2)-0.25*x**(-1.5)
#Punto inicial
x0=0.1

#Busqueda    
while diff > tol:
    f0=f(x0)
    df0=df(x0)
    x=x0-f0/df0
    diff=abs(x-x0)
    x0=x
    contador = contador +1
    print 'iteración: %d, distancia: %0.7f' % (contador, diff)
    if contador >= 200:
        print 'Error: Maximo numero de iteraciones alcanzado'
        sys.exit()
fx=f(x)
print 'La solución es x: %0.7f, y el valor de la función es fx=: %0.9f' % (x, fx)
#print 'Solución: '+str(x)