# -*- coding: utf-8 -*-
# Bisección
#La función a evaluar es f(x)=0.5p^(-0.2)+0.5p^(-0.5)-2=0
import sys
#Parametros
diff=1
tol=1.0e-6
contador=0
#Funcion
f = lambda x: 0.5*x**(-0.2)+0.5*x**(-0.5)-2
#Puntos iniciales
a=0.05
b=0.25
fa=f(a)
fb=f(b)

#Verificar si se cumple que fa*fb<0 (existe una raiz en el intervalo [a,b])

if fa*fb >= 0:
    print( 'Error: no hay una raiz en el intervalo propuesto')
    sys.exit()

#Bisección inicial
x=(a+b)/2
fx=f(x)

while diff > tol:
    if fa*fx < 0:
        b=x
        fb=fx
    else:
        a=x
        fa=fx
    x=(a+b)/2
    fx=f(x)
    diff=abs(x-a)
    contador = contador +1
    print( 'iteración: %d, distancia: %0.7f' % (contador, diff))
print( 'La solución es x: %0.7f, y el valor de la función es fx=: %0.9f' % (x, fx))
#print 'Solución: '+str(x)
