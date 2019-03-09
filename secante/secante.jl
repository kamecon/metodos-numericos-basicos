#Newton
#La funcion a evaluar es f(x)=0.5p^(-0.2)+0.5p^(-0.5)-2=0
#Parametros
diff=1
tol=1*10.0^(-6)
contador=0

#Funcion
f = (x) -> 0.5*float(x)^(-0.2)+0.5*float(x)^(-0.5)-2

#Puntos Iniciales
x0=0.1
x_1=0.3

#Busqueda
while diff > tol
  fx0=f(x0)
  fx_1=f(x_1)
  cociente=(x0-x_1)/(fx0-fx_1)
  x=x0-(cociente*fx0)
  diff=abs(x-x0)
  x_1=x0
  x0=x
  contador=contador+1
@printf "Iteracion %d, diferencia %9.7f\n" contador diff
if contador > 200
    println("Error: Maximo numero de iteraciones alcanzado")
    break
end
end
fx=f(x)
@printf "La raiz es %9.7f y f(x) %9.9f" x fx
