! PROGRAM newton

program newton

    ! variable declaration
    implicit none
    integer :: contador
    real*8 :: x, xo, fx, diff, tol, fxo, dfxo
    

    ! Parametros
    diff=1
    tol=1d-6
    contador=0

    ! Punto inicial
    xo=0.1d0
    

    ! Busqueda
    do while (diff > tol)

      fxo=testfun(xo)
      dfxo=testdif(xo)
      x=xo-fxo/dfxo
      diff=abs(x-xo)
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

    function testdif(x)

        implicit none
    
        ! input arguments
        real*8, intent(in) :: x
    
        ! function value
        real*8 :: testdif
          
        ! executable code
        testdif = -0.1d0*x**(-1.2d0)-0.25d0*x**(-1.5d0)
    
    end function


end program