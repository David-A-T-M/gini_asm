; Carga el valor float en el acumulador (EAX)
mov eax,flt

; Desplazamiento a la izquierda de EAX para eliminar el signo
rcl eax,1

; Guarda el valor de EAX en EBX para uso posterior
mov ebx,eax

; Limpia EDX
mov edx,4278190080

; Obtiene el exponente (bits 24-31 de EAX) y lo guarda en EAX
and eax,edx
shr eax,24
sub eax,7fh

; Guarda el exponente en EDX para uso posterior
mov edx,eax

; Elimina los 8 bits más a la izquierda de EAX (que contienen el exponente)
mov eax,ebx
rcl eax,8
mov ebx,eax

; Resta 17h (27) del exponente y guarda el resultado en ECX
mov ecx, 1fh
sub ecx,edx

; Inicializa EDX a 0
mov edx,00000000h

; Compara ECX con 0 (si el exponente es negativo)
cmp ecx,0

; Si el exponente es 0, salta a la etiqueta "loop2"
je loop2

; Desplaza EAX a la derecha una vez y OR con 80000000h (si el exponente es positivo)
loop1:
    shr eax,1
    or eax,80000000h
    sub ecx,1
    add edx,1
    cmp ecx,0
    ja loop1

; Etiqueta para el final del bucle de desplazamiento
loop2:

; Mueve el valor final de EAX a la variable de retorno "i"
mov i, eax

; Etiqueta para determinar el signo (opcional)
sign:

; Obtiene el bit de signo del valor float
mov eax,flt
and eax,80000000h

; Compara el bit de signo con 80000000h (signo negativo)
cmp eax,80000000h

; Si el signo es negativo, salta a la etiqueta "putsign"
je putsign

; Retorna el valor de "i" (positivo)
ret

; Etiqueta para retornar el valor negativo (opcional)
putsign:

; Retorna -i (negativo)
ret