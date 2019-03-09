! PROGRAM biseccion

program biseccion

    ! variable declaration
    implicit none
    integer :: iter,  contador
    real*8 :: x, a, b, fx, fa, fb, diff, tol
    

    ! Parametros
    diff=1
    tol=1d-6
    contador=0

    ! Bracket inicial
    a =  0.05d0
    b =  0.25d0
    fa = testbisec(a)
    fb = testbisec(b)

    ! check whether there is a root in [a,b]
    if(fa*fb >= 0d0)then
        stop 'Error: No hay una raiz en el intervalo propuesto'
    endif

    !Bisección inicial
    x = (a+b)/2d0
    fx = testbisec(x)

    ! Busqueda
    do while (diff > tol)

        if(fa*fx < 0d0)then
            b = x
            fb = fx
        else
            a = x
            fa = fx
        endif

         x = (a+b)/2d0
         fx = testbisec(x)
         diff=abs(x-a)
         contador=contador +1

         write(*,'(/a,i4,a,f12.7)')' Iteracion  ',contador,'  diferencia ',diff,
      
    enddo

    write(*,'(/a,f12.7,a,f12.9)')' x = ',x,'    f = ',fx,


    contains

    function testbisec(x)

        implicit none
    
        ! input arguments
        real*8, intent(in) :: x
    
        ! function value
        real*8 :: testbisec
          
        ! executable code
        testbisec = 0.5d0*x**(-0.2d0)+0.5d0*x**(-0.5d0)-2d0
    
    end function


end program