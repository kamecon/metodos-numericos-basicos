! PROGRAM VFI_1
! In this program we implement VFI using brute force
! We search on all the endogenous state space for each state
! After we use some theoretical properties of the value
! and policy function to perform a more efficient search

include "VFI_1m.f90"

program VFI_01

! modules
  use globals

implicit none

! inicio timer
  call tic()

! Se crea el Grid
 call linspace(AGRID,0d0,100d0,NA+1)

! Se obtienen los límites superiores de la busqueda
! Así evitamos realizar cálculos en puntos no factibles
  call upperbound(IUB,AGRID,NA)

! Funcion Valor Inicial
 V(:) = 0d0

! Iteracion de la funcion valor
diff=1d0
contador=1
do while (diff > tol)

!Valores cuando a=0 
 V_prime(0) = V(1)-100d0
 a_index(0)=0
 c(0)=0d0
 a(0)=AGRID(a_index(0))


! Grid search       
do ia = 1,NA 											 ! Comenzamos en 1 porque ya hemos fijado los valores de cero
   
   a_index(ia) = max(IUB(ia),0)						 	 ! Empezamos por el a' factible más alto
   consumo1 = max(AGRID(ia) - AGRID(a_index(ia)), 1d-10) 
   VMAX	 = util_crra(consumo1) + beta*V(a_index(ia))	 ! Calculamos V con esa política (a'=IUB(a))
  
	do ia_p = max(IUB(ia)-1,0),0,-1 			 		 ! Una vez calculado V con el mayor a' factible, probamos con valores más bajos
   
	 consumo = max(AGRID(ia) - AGRID(ia_p), 1d-10)
     RHS = util_crra(consumo) + beta*V(ia_p)

   		if (RHS > VMAX) then							 ! Si un a' distinto (menor) genera un mayor V guardamos ese valor 
        	a_index(ia)= ia_p
            VMAX=RHS
       else
            exit
   	   endif

     enddo

     a(ia) = AGRID(a_index(ia))
     c(ia) = AGRID(ia) - a(ia)
     V_prime(ia) = VMAX
	 
enddo

! Si se alcanza el máximo número de iteraciones se detiene el programa
	if (contador > itermax)then
        write(*,'(/a)')' Numero maximo de iteraciones alcanzado '
        stop
    endif

! Se calcula la distancia      
diff = maxval(abs(V_prime(:) - V(:))/max(abs(V(:)), 1d-10))


      write(*,'(a,i5,a,f21.7)')' Iteracion  ',contador,'  diferencia ',diff,

! Se actualiza el contador
contador = contador +1
  
! Se actualiza la función valor
V = V_prime
      
enddo

!Fin timer
	call toc()

end program