#Newton
#La funcion a evaluar es f(x)=0.5p^(-0.2)+0.5p^(-0.5)-2=0
#Parametros
diff=1
tol=1*10.0^(-6)
contador=0

#Funciones
f = (x) -> 0.5*float(x)^(-0.2)+0.5*float(x)^(-0.5)-2
df = (x) -> -0.1*float(x)^(-1.2)-0.25*float(x)^(-1.5)

#Punto Inicial
x0=0.1

#Busqueda
while diff > tol
  fx0=f(x0)
  dfx0=df(x0)
  x=x0-fx0/dfx0
  diff=abs(x-x0)
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
