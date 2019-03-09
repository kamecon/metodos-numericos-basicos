# -*- coding: utf-8 -*-
# Golden
#La función a evaluar es f(x)=[(W-p_2x_2)/p_1]^0.4+(1+x_2)^0.5
import sys
#Parametros
diff=1
tol=1.0e-6
contador=0
W=1
p=(1,2)
theta = (3 - 5**(1/2)) /2

#Funcion
f = lambda x: ((W-p[1]*x)/p[0])**0.4 + (1+x)**0.5
#Puntos iniciales
a=0;
b= (W - (p[0]*0.01))/p[1]
#Busqueda    
while diff > tol:
    x1 = a + theta*(b-a)
    x2 = a + (1-theta)*(b-a)
    f1 = f(x1)*(-1)
    f2 = f(x2)*(-1)
    if f1 < f2:
        b = x2
    else:
        a=x1
    diff=abs(b-a)
    contador = contador +1
    print ('iteración: %d, distancia: %0.7f' % (contador, diff))
    if contador >= 200:
        print ('Error: Maximo numero de iteraciones alcanzado')
        sys.exit()
fx=-f1
x1_opt=(W-p[1]*x2)/p[0]
print ('El valor de X1 es: %0.7f, el de X2: %0.7f y el valor de la función es fx=: %0.9f' % (x1_opt,x2, fx))
#print 'Solución: '+str(x)