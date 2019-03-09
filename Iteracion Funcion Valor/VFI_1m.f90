! MODULE globals

module globals

implicit none

! Model parameters

! Utility function
real*8, parameter :: beta = 0.95d0 		!Factor subjetivo de descuento
real*8, parameter :: gamma = 0.5d0 		!Elasticidad de sustitucion
real*8, parameter :: a0=100d0	   		!Activos iniciales (para la simulación)

!Parametros de la Iteración
real*8, parameter :: tol = 1d-6    		!Tolerancia
real*8 :: diff					   		!Diferencia
integer :: contador, ia, ia_p		   	!Numero e indice de iteraciones
integer, parameter :: itermax = 2000  	!Máximo número de iteraciones

!Error euler
real*8 :: err, err_temp, err2			
real*8 :: err_temp2			   		

!Parametros del Grid
integer, parameter :: NA = 1000			!Numero de activos en el grid
real*8 :: AGRID(0:NA)					!Grid de activos
integer :: IUB(NA+1)					!Upper bound index (ver upperbound subroutine)

!Valores temporales de la iteración
real*8 :: consumo						
real*8 :: consumo1
real*8 :: VMAX
real*8 :: RHS


!Funciones valor y políticas
real*8 :: V(0:NA), V_prime(0:NA), a(0:NA), c(0:NA)
integer :: a_index(0:NA)
   
contains

!Functions and subroutines

	subroutine linspace(x,x_start,x_end,x_len)
	!Equivalente al linspace de Matlab
	!Argumentos de entrada:
	!	x_start: inicio del grid
	!	x_end: fin del grid
	!	x_len: tamaño del grid
	!Argumentos de salida:
	!	x: grid
    
    	real*8, dimension(:), intent(out) :: x
        real*8, intent(in) :: x_start, x_end
        integer, intent(in) :: x_len
        !Local variables
        real*8 :: dx
        integer :: i

        dx= (x_end - x_start)/(x_len - 1)
        x(0:x_len) = (/ ((x_start + ((i-1)*dx)), i=0, x_len) /)
     end subroutine

    subroutine upperbound(x,grid,LEN)
	!Determinamos el limite superior de busqueda en la iteración de la función
	!valor, asi evitamos que la función pierda el tiempo buscando en valores
	!del capital mañana que implican valores negativos del consumo (no
	!factibles)
    !Argumentos de entrada:
	!	grid: el grid de activos
	!	NA: numero de activos
	!Argumentos de salida:
	!	x: limite superior
    
     integer, dimension(:), intent(out) :: x
     real*8, dimension(:), intent(in) :: grid
     integer, intent(in) :: LEN
     !Local variables
     real*8 :: aprime2, income2
     integer :: ih, ia_m
     
	 IUB(1)=0
     do ih = 2,LEN
       income2=grid(ih)
       do ia_m = 1,LEN
         aprime2=grid(ia_m)
         if (income2 > aprime2) then
           x(ih)=ia_m
         endif
       enddo
     enddo

    end subroutine
         
           

     function util_crra(x)
    !Funcion de utilidad
    !Argumentos de entrada:
 	!   x: consumo
	!Argumentos de salida:
	!	utilidad empleando la función:
    !   U = x^(1-1/gamma) / (1-1/gamma)

        implicit none
    
        ! input arguments
        real*8, intent(in) :: x
    	! function value
        real*8 :: util_crra
          
        ! executable code
        util_crra = x**(1d0 - 1d0/gamma) / (1d0 - 1d0/gamma)
    
    end function

end module