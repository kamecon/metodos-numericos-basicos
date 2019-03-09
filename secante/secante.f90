! PROGRAM secante

program newton

    ! variable declaration
    implicit none
    integer :: contador
    real*8 :: x, xo, x_1, fx, diff, tol, fxo, fx_1, cociente
    

    ! Parametros
    diff=1
    tol=1d-6
    contador=0

    ! Puntos iniciales
    xo=0.1d0
    x_1=0.3d0
    

    ! Busqueda
    do while (diff > tol)

      fxo=testfun(xo)
      fx_1=testfun(x_1)
      cociente=(xo-x_1)/(fxo-fx_1)
      x=xo-cociente*fxo
      diff=abs(x-xo)
      x_1=xo
      xo=x
      contador=contador +1

      if (contador > 200)then
        write(*,'(/a)')' Numero maximo de iteraciones alcanzado '
        stop
      endif
      

      write(*,'(/a,i4,a,f12.7)')' Iteracion  ',contador,'  diferencia ',diff,
      
    enddo

    fx=testfun(x)

    write(*,'(/a,f12.7,a,f12.9)')' x = ',x,'    f = ',fx,


    contains

    function testfun(x)

        implicit none
    
        ! input arguments
        real*8, intent(in) :: x
    
        ! function value
        real*8 :: testfun
          
        ! executable code
        testfun = 0.5d0*x**(-0.2d0)+0.5d0*x**(-0.5d0)-2d0
    
    end function


end program