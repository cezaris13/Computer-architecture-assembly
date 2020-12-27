;------------------------------------------------------------------------
%include 'yasmmac.inc'  
org 100h                        ; visos COM programos prasideda nuo 100h
                                ; Be to, DS=CS=ES=SS !

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .text                   ; kodas prasideda cia 

   startas:                     ; nuo cia vykdomas kodas
      call procSetGraphicsMode
      mov si, 160
      mov di, 100
      mov cl, 15 
      call procPutPixel 
      
     
      finit 
      fldpi
      fadd st0, st0
      fild word [N]
      fdivr st0, st1 
      fstp dword [dphi]

      mov ax, [N]

      .ciklas:
      finit;apskaiciuojama x koordinate
      fld dword [phi]
      fcos 
      fmul dword [R]
      fild word [xc]
      fadd st0, st1
      frndint
      fistp word [x]
      fdecstp      

      fld dword [phi];y koordinate
      fsin
      fmul dword [R2]
      fild word [yc]   
      fadd st0, st1
      frndint
      fistp word [y]
      fdecstp
      mov si, [x]
      mov di, [y]
      mov cl, 4 
      cmp si,320;jei neisitenka i ekrano rezius nepiesiam pixelio ir linijos
      jae .end
      cmp di,200
      jae .end
    
      .linija:;spalviname elipse
      mov si, [x]
      mov di, [y]
      mov cl, 4 
      call procPutPixel
      mov di,[y]
      inc di 
      mov [y],di
      cmp di,100
      jl .linija
      .linija2:
      mov si, [x]
      mov di, [y]
      mov cl, 4 
      call procPutPixel
      mov di,[y]
      dec di 
      mov [y],di
      cmp di,100
      jg .linija2
        .end:
      fld dword [phi];padidiname delta phi
      fadd dword [dphi]
      fstp  dword [phi]
     
      dec ax  
      jne .ciklas         
      call procWaitForEsc 
      exit
      

%include 'yasmlib.asm'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .data                   ; duomenys
     R:
     dd  400.0
     R2:
     dd 30.00
     phi: 
     dd  0.0
     dphi:
     dd  0.0
     xc: 
     dw 160
     yc:
     dw 100
     x: 
     dw  0
     y:
     dw 0
     
     N:
     dw 20000  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .bss                    ; neinicializuoti duomenys  
