! PROGRAM golden search

program golden

    ! variable declaration
    implicit none
    integer :: contador
    real*8 :: a, b, x1, x2, f1, f2, diff, theta
    real*8, parameter :: W= 1d0, p(2)=(/1d0, 2d0/) 
    real*8, parameter :: tol = 1d-6

    ! Parametros
    diff = 1
    contador = 0
    theta = (3d0 - sqrt(5d0))/2d0
    
    ! Puntos iniciales
    a = 0d0
    b = (W - p(1)*0.01d0)/p(2)
    

    ! Busqueda
    do while (diff > tol)

      x1 = a + theta*(b-a)
      x2 = a + (1-theta)*(b-a)
      f1 = testfun2(x1)*(-1)
      f2 = testfun2(x2)*(-1)
      if (f1 < f2) then
        b = x2
      else
        a = x1
      endif 
     diff=abs(b-a) 
	 contador=contador +1

      if (contador > 200)then
        write(*,'(/a)')' Numero maximo de iteraciones alcanzado '
        stop
      endif
      
	
     write(*,'(/a,i4,a,f12.7)')' Iteracion  ',contador,'  diferencia ',diff,
      
    enddo

    write(*,'(/a,f12.7,a,f12.9)')' x1 = ',(W-p(2)*x2)/p(1),'    x2 = ',x2
	write(*,'(/a,f12.7)')' f(x) = ',-f1

    contains

    function testfun2(x)

        implicit none
    
        ! input arguments
        real*8, intent(in) :: x
    	real*8, parameter :: W= 1d0, p(2)=(/1d0, 2d0/)
        ! function value
        real*8 :: testfun2
          
        ! executable code
        testfun2 = ((W-p(2)*x)/p(1))**0.4d0 + (1+x)**0.5d0
    
    end function


end program