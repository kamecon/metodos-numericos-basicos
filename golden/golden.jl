#Golden
#La funcion a evaluar es f(x)=[(W-p_2x_2)/p_1]^0.4+(1+x_2)^0.5
#Parametros
diff=1
tol=1*10.0^(-6)
contador=0
W=1
p=[1,2]
theta = (3 - 5^(1/2)) / 2


#Funcion
f = (x) -> ((W-(p[2]*float(x))) / p[1])^0.4 + (1+float(x))^0.5
#Puntos Iniciales
a=0
b=(W - (p[1]*0.01) ) / p[2]

#Busqueda
while diff > tol
    x1 = a + theta*(b-a)
    x2 = a + (1-theta)*(b-a)
    f1 = f(x1)*(-1)
    f2 = f(x2)*(-1)
    if f1 < f2
      b = x2
    else
      a = x1
    end
   diff=abs(b-a)
   contador=contador +1
@printf "Iteracion %d, diferencia %9.7f\n" contador diff
if contador > 200
    println("Error: Maximo numero de iteraciones alcanzado")
    break
end
end
fx=f(x1)
x1_opt=(W-p[2]*float(x2))/p[1]
@printf "El valor de X1 es %9.7f el de X2 %9.7f y f(x) %9.9f\n" x1_opt x2 fx

