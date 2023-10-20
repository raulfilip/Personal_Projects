.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern malloc: proc
extern memset: proc

includelib canvas.lib
includelib broasca.inc
includelib masina.inc
extern BeginDrawing: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date
window_title DB "Froggy - Filip Raul gr 302110",0
area_width EQU 640
area_height EQU 480
area DD 0
rectangle_width equ 40 
rectangle_height equ 40
factor_ceas dd 5
factor_ceas1 dd 5
factor_ceas2 dd 5
factor_ceas3 dd 5
factor_ceas4 dd 5
factor_ceas5 dd 5
factor_ceas6 dd 5
factor_ceas7 dd 5
factor_ceas8 dd 5
factor_ceas9 dd 5
broaste_in_cuib dd 0
counter DD 0 ; numara evenimentele de tip timer
scor DD 0 ; nmemoreaza scorul
vieti dd 3;,memoreaza nr de vieti ramase
coordonata_x_broasca dd 600
coordonata_y_broasca dd 440

coordonata_x_masina1 dd 0
coordonata_y_masina1 equ 400

coordonata_x_masina2 dd 600
coordonata_y_masina2 equ 360

coordonata_x_masina3 dd 0
coordonata_y_masina3 equ 320

coordonata_x_masina4 dd 600
coordonata_y_masina4 equ 280

coordonata_x_bustean1 dd 0
coordonata_y_bustean1 equ 200

coordonata_x_bustean2 dd 520
coordonata_y_bustean2 equ 160

coordonata_x_bustean3 dd 240
coordonata_y_bustean3 equ 160

coordonata_x_bustean4 dd 80
coordonata_y_bustean4 equ 120

coordonata_x_bustean5 dd 400
coordonata_y_bustean5 equ 120

coordonata_x_bustean6 dd 440
coordonata_y_bustean6 equ 80

arg1 EQU 8
arg2 EQU 12
arg3 EQU 16
arg4 EQU 20

symbol_width EQU 10
symbol_height EQU 20
include digits.inc
include letters.inc

.code
; procedura make_text afiseaza o litera sau o cifra la coordonatele date
; arg1 - simbolul de afisat (litera sau cifra)
; arg2 - pointer la vectorul de pixeli
; arg3 - pos_x
; arg4 - pos_y
make_text proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	cmp eax, 'A'
	jl make_digit
	cmp eax, 'Z'
	jg make_digit
	sub eax, 'A'
	lea esi, letters
	jmp draw_text
make_digit:
	cmp eax, '0'
	jl make_space
	cmp eax, '9'
	jg make_space
	sub eax, '0'
	lea esi, digits
	jmp draw_text
make_space:	
	mov eax, 26 ; de la 0 pana la 25 sunt litere, 26 e space
	lea esi, letters
	
draw_text:
	mov ebx, symbol_width
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	mov dword ptr [edi], 0
	jmp simbol_pixel_next
simbol_pixel_alb:
	mov dword ptr [edi], 0FFFFFFh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_text endp
 
 line_horizontal macro x,y,len,color
   local bucla_linie
	mov eax,y
	 mov ebx,area_width
	 mul ebx
	 add eax,x
	 shl eax,2
	 add eax,area
	 mov ecx,len
	 bucla_linie:
	 mov dword ptr[eax],color
	 add eax,4
	  loop bucla_linie
 endm
 
  line_vertical macro x,y,len,color
   local bucla_linie
	mov eax,y
	 mov ebx,area_width
	 mul ebx
	 add eax,x
	 shl eax,2
	 add eax,area
	 mov ecx,len
	 bucla_linie:
	 mov dword ptr[eax],color
	 add eax, area_width*4
	  loop bucla_linie
 endm
 
   make_broasca macro x,y
	line_horizontal x+1,y, 39,000FF00h
	line_horizontal x,y+1, 40,000FF00h
	line_horizontal x,y+2, 40,000FF00h
	line_horizontal x,y+3, 40,000FF00h
	line_horizontal x,y+4, 40,000FF00h
	line_horizontal x,y+5, 40,000FF00h
	line_horizontal x,y+6, 40,000FF00h
	line_horizontal x,y+7, 40,000FF00h
	line_horizontal x,y+8, 40,000FF00h
	line_horizontal x,y+9, 40,000FF00h
	line_horizontal x,y+10, 40,000FF00h
	line_horizontal x,y+11, 40,000FF00h
	line_horizontal x,y+12, 40,000FF00h
	line_horizontal x,y+13, 40,000FF00h
	line_horizontal x,y+14, 40,000FF00h
	line_horizontal x,y+15, 40,000FF00h
	line_horizontal x,y+16, 40,000FF00h
	line_horizontal x,y+17, 40,000FF00h
	line_horizontal x,y+18, 40,000FF00h
	line_horizontal x,y+19, 40,000FF00h
	line_horizontal x,y+20, 40,000FF00h
	line_horizontal x,y+21, 40,000FF00h
	line_horizontal x,y+22, 40,000FF00h
	line_horizontal x,y+23, 40,000FF00h
	line_horizontal x,y+24, 40,000FF00h
	line_horizontal x,y+25, 40,000FF00h
	line_horizontal x,y+26, 40,000FF00h
	line_horizontal x,y+27, 40,000FF00h
	line_horizontal x,y+28, 40,000FF00h
	line_horizontal x,y+29, 40,000FF00h
	line_horizontal x,y+30, 40,000FF00h
	line_horizontal x,y+31, 40,000FF00h
	line_horizontal x,y+32, 40,000FF00h
	line_horizontal x,y+33, 40,000FF00h
	line_horizontal x,y+34, 40,000FF00h
	line_horizontal x,y+35, 40,000FF00h
	line_horizontal x,y+36, 40,000FF00h
	line_horizontal x,y+37, 40,000FF00h
	line_horizontal x,y+38, 40,000FF00h
	line_horizontal x,y+39, 40,000FF00h
	 make_text_macro 'F', area, x, y+10
	 make_text_macro 'R', area, x+10, y+10
	 make_text_macro 'O', area, x+20, y+10
	 make_text_macro 'G', area, x+30, y+10
 endm
 
    make_masina_1 macro x,y
	line_horizontal x,y, 40,0CC1017h
	line_horizontal x,y+1, 40,0CC1017h
	line_horizontal x,y+2, 40,0CC1017h
	line_horizontal x,y+3, 40,0CC1017h
	line_horizontal x,y+4, 40,0CC1017h
	line_horizontal x,y+5, 40,0CC1017h
	line_horizontal x,y+6, 40,0CC1017h
	line_horizontal x,y+7, 40,0CC1017h
	line_horizontal x,y+8, 40,0CC1017h
	line_horizontal x,y+9, 40,0CC1017h
	line_horizontal x,y+10, 40,0CC1017h
	line_horizontal x,y+11, 40,0CC1017h
	line_horizontal x,y+12, 40,0CC1017h
	line_horizontal x,y+13, 40,0CC1017h
	line_horizontal x,y+14, 40,0CC1017h
	line_horizontal x,y+15, 40,0CC1017h
	line_horizontal x,y+16, 40,0CC1017h
	line_horizontal x,y+17, 40,0CC1017h
	line_horizontal x,y+18, 40,0CC1017h
	line_horizontal x,y+19, 40,0CC1017h
	line_horizontal x,y+20, 40,0CC1017h
	line_horizontal x,y+21, 40,0CC1017h
	line_horizontal x,y+22, 40,0CC1017h
	line_horizontal x,y+23, 40,0CC1017h
	line_horizontal x,y+24, 40,0CC1017h
	line_horizontal x,y+25, 40,0CC1017h
	line_horizontal x,y+26, 40,0CC1017h
	line_horizontal x,y+27, 40,0CC1017h
	line_horizontal x,y+28, 40,0CC1017h
	line_horizontal x,y+29, 40,0CC1017h
	line_horizontal x,y+30, 40,0CC1017h
	line_horizontal x,y+31, 40,0CC1017h
	line_horizontal x,y+32, 40,0CC1017h
	line_horizontal x,y+33, 40,0CC1017h
	line_horizontal x,y+34, 40,0CC1017h
	line_horizontal x,y+35, 40,0CC1017h
	line_horizontal x,y+36, 40,0CC1017h
	line_horizontal x,y+37, 40,0CC1017h
	line_horizontal x,y+38, 40,0CC1017h
	line_horizontal x,y+39, 40,0CC1017h
	 make_text_macro 'C', area, x, y+10
	 make_text_macro 'A', area, x+10, y+10
	 make_text_macro 'R', area, x+20, y+10
	 make_text_macro '1', area, x+30, y+10
 endm
 
  make_masina_2 macro x,y
	line_horizontal x,y, 40,01D10CCh
	line_horizontal x,y+1, 40,01D10CCh
	line_horizontal x,y+2, 40,01D10CCh
	line_horizontal x,y+3, 40,01D10CCh
	line_horizontal x,y+4, 40,01D10CCh
	line_horizontal x,y+5, 40,01D10CCh
	line_horizontal x,y+6, 40,01D10CCh
	line_horizontal x,y+7, 40,01D10CCh
	line_horizontal x,y+8, 40,01D10CCh
	line_horizontal x,y+9, 40,01D10CCh
	line_horizontal x,y+10, 40,01D10CCh
	line_horizontal x,y+11, 40,01D10CCh
	line_horizontal x,y+12, 40,01D10CCh
	line_horizontal x,y+13, 40,01D10CCh
	line_horizontal x,y+14, 40,01D10CCh
	line_horizontal x,y+15, 40,01D10CCh
	line_horizontal x,y+16, 40,01D10CCh
	line_horizontal x,y+17, 40,01D10CCh
	line_horizontal x,y+18, 40,01D10CCh
	line_horizontal x,y+19, 40,01D10CCh
	line_horizontal x,y+20, 40,01D10CCh
	line_horizontal x,y+21, 40,01D10CCh
	line_horizontal x,y+22, 40,01D10CCh
	line_horizontal x,y+23, 40,01D10CCh
	line_horizontal x,y+24, 40,01D10CCh
	line_horizontal x,y+25, 40,01D10CCh
	line_horizontal x,y+26, 40,01D10CCh
	line_horizontal x,y+27, 40,01D10CCh
	line_horizontal x,y+28, 40,01D10CCh
	line_horizontal x,y+29, 40,01D10CCh
	line_horizontal x,y+30, 40,01D10CCh
	line_horizontal x,y+31, 40,01D10CCh
	line_horizontal x,y+32, 40,01D10CCh
	line_horizontal x,y+33, 40,01D10CCh
	line_horizontal x,y+34, 40,01D10CCh
	line_horizontal x,y+35, 40,01D10CCh
	line_horizontal x,y+36, 40,01D10CCh
	line_horizontal x,y+37, 40,01D10CCh
	line_horizontal x,y+38, 40,01D10CCh
	line_horizontal x,y+39, 40,01D10CCh
	 make_text_macro 'C', area, x, y+10
	 make_text_macro 'A', area, x+10, y+10
	 make_text_macro 'R', area, x+20, y+10
	 make_text_macro '2', area, x+30, y+10
 endm
 
 make_masina_3 macro x,y
	line_horizontal x,y, 40,0FA9005h
	line_horizontal x,y+1, 40,0FA9005h
	line_horizontal x,y+2, 40,0FA9005h
	line_horizontal x,y+3, 40,0FA9005h
	line_horizontal x,y+4, 40,0FA9005h
	line_horizontal x,y+5, 40,0FA9005h
	line_horizontal x,y+6, 40,0FA9005h
	line_horizontal x,y+7, 40,0FA9005h
	line_horizontal x,y+8, 40,0FA9005h
	line_horizontal x,y+9, 40,0FA9005h
	line_horizontal x,y+10, 40,0FA9005h
	line_horizontal x,y+11, 40,0FA9005h
	line_horizontal x,y+12, 40,0FA9005h
	line_horizontal x,y+13, 40,0FA9005h
	line_horizontal x,y+14, 40,0FA9005h
	line_horizontal x,y+15, 40,0FA9005h
	line_horizontal x,y+16, 40,0FA9005h
	line_horizontal x,y+17, 40,0FA9005h
	line_horizontal x,y+18, 40,0FA9005h
	line_horizontal x,y+19, 40,0FA9005h
	line_horizontal x,y+20, 40,0FA9005h
	line_horizontal x,y+21, 40,0FA9005h
	line_horizontal x,y+22, 40,0FA9005h
	line_horizontal x,y+23, 40,0FA9005h
	line_horizontal x,y+24, 40,0FA9005h
	line_horizontal x,y+25, 40,0FA9005h
	line_horizontal x,y+26, 40,0FA9005h
	line_horizontal x,y+27, 40,0FA9005h
	line_horizontal x,y+28, 40,0FA9005h
	line_horizontal x,y+29, 40,0FA9005h
	line_horizontal x,y+30, 40,0FA9005h
	line_horizontal x,y+31, 40,0FA9005h
	line_horizontal x,y+32, 40,0FA9005h
	line_horizontal x,y+33, 40,0FA9005h
	line_horizontal x,y+34, 40,0FA9005h
	line_horizontal x,y+35, 40,0FA9005h
	line_horizontal x,y+36, 40,0FA9005h
	line_horizontal x,y+37, 40,0FA9005h
	line_horizontal x,y+38, 40,0FA9005h
	line_horizontal x,y+39, 40,0FA9005h
	 make_text_macro 'C', area, x, y+10
	 make_text_macro 'A', area, x+10, y+10
	 make_text_macro 'R', area, x+20, y+10
	 make_text_macro '3', area, x+30, y+10
 endm
 
  make_masina_4 macro x,y
	line_horizontal x,y, 40,07B03ABh
	line_horizontal x,y+1, 40,07B03ABh
	line_horizontal x,y+2, 40,07B03ABh
	line_horizontal x,y+3, 40,07B03ABh
	line_horizontal x,y+4, 40,07B03ABh
	line_horizontal x,y+5, 40,07B03ABh
	line_horizontal x,y+6, 40,07B03ABh
	line_horizontal x,y+7, 40,07B03ABh
	line_horizontal x,y+8, 40,07B03ABh
	line_horizontal x,y+9, 40,07B03ABh
	line_horizontal x,y+10, 40,07B03ABh
	line_horizontal x,y+11, 40,07B03ABh
	line_horizontal x,y+12, 40,07B03ABh
	line_horizontal x,y+13, 40,07B03ABh
	line_horizontal x,y+14, 40,07B03ABh
	line_horizontal x,y+15, 40,07B03ABh
	line_horizontal x,y+16, 40,07B03ABh
	line_horizontal x,y+17, 40,07B03ABh
	line_horizontal x,y+18, 40,07B03ABh
	line_horizontal x,y+19, 40,07B03ABh
	line_horizontal x,y+20, 40,07B03ABh
	line_horizontal x,y+21, 40,07B03ABh
	line_horizontal x,y+22, 40,07B03ABh
	line_horizontal x,y+23, 40,07B03ABh
	line_horizontal x,y+24, 40,07B03ABh
	line_horizontal x,y+25, 40,07B03ABh
	line_horizontal x,y+26, 40,07B03ABh
	line_horizontal x,y+27, 40,07B03ABh
	line_horizontal x,y+28, 40,07B03ABh
	line_horizontal x,y+29, 40,07B03ABh
	line_horizontal x,y+30, 40,07B03ABh
	line_horizontal x,y+31, 40,07B03ABh
	line_horizontal x,y+32, 40,07B03ABh
	line_horizontal x,y+33, 40,07B03ABh
	line_horizontal x,y+34, 40,07B03ABh
	line_horizontal x,y+35, 40,07B03ABh
	line_horizontal x,y+36, 40,07B03ABh
	line_horizontal x,y+37, 40,07B03ABh
	line_horizontal x,y+38, 40,07B03ABh
	line_horizontal x,y+39, 40,07B03ABh
	 make_text_macro 'C', area, x, y+10
	 make_text_macro 'A', area, x+10, y+10
	 make_text_macro 'R', area, x+20, y+10
	 make_text_macro '4', area, x+30, y+10
 endm
 
 make_bustean_1 macro x,y
	line_horizontal x,y, 120,06B451Ch
	line_horizontal x,y+1, 120,06B451Ch
	line_horizontal x,y+2, 120,06B451Ch
	line_horizontal x,y+3, 120,06B451Ch
	line_horizontal x,y+4, 120,06B451Ch
	line_horizontal x,y+5, 120,06B451Ch
	line_horizontal x,y+6, 120,06B451Ch
	line_horizontal x,y+7, 120,06B451Ch
	line_horizontal x,y+8, 120,06B451Ch
	line_horizontal x,y+9, 120,06B451Ch
	line_horizontal x,y+10, 120,06B451Ch
	line_horizontal x,y+11, 120,06B451Ch
	line_horizontal x,y+12, 120,06B451Ch
	line_horizontal x,y+13, 120,06B451Ch
	line_horizontal x,y+14, 120,06B451Ch
	line_horizontal x,y+15, 120,06B451Ch
	line_horizontal x,y+16, 120,06B451Ch
	line_horizontal x,y+17, 120,06B451Ch
	line_horizontal x,y+18, 120,06B451Ch
	line_horizontal x,y+19, 120,06B451Ch
	line_horizontal x,y+20, 120,06B451Ch
	line_horizontal x,y+21, 120,06B451Ch
	line_horizontal x,y+22, 120,06B451Ch
	line_horizontal x,y+23, 120,06B451Ch
	line_horizontal x,y+24, 120,06B451Ch
	line_horizontal x,y+25, 120,06B451Ch
	line_horizontal x,y+26, 120,06B451Ch
	line_horizontal x,y+27, 120,06B451Ch
	line_horizontal x,y+28, 120,06B451Ch
	line_horizontal x,y+29, 120,06B451Ch
	line_horizontal x,y+30, 120,06B451Ch
	line_horizontal x,y+31, 120,06B451Ch
	line_horizontal x,y+32, 120,06B451Ch
	line_horizontal x,y+33, 120,06B451Ch
	line_horizontal x,y+34, 120,06B451Ch
	line_horizontal x,y+35, 120,06B451Ch
	line_horizontal x,y+36, 120,06B451Ch
	line_horizontal x,y+37, 120,06B451Ch
	line_horizontal x,y+38, 120,06B451Ch
	line_horizontal x,y+39, 120,06B451Ch
	
 endm
 
 
; un macro ca sa apelam mai usor desenarea simbolului
make_text_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text 
	add esp, 16
endm



; functia de desenare - se apeleaza la fiecare click
; sau la fiecare interval de 200ms in care nu s-a dat click
; arg1 - evt (0 - initializare, 1 - click , 2 - - timer , 3 - s a apasat o tasta ) 
; arg2 - x
; arg3 - y

draw proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1]
	cmp eax, 1
	jz evt_click
	cmp eax, 2
	jz evt_timer ; nu s-a efectuat click pe nimic
	cmp eax, 3
	jz evt_tasta ; nu s-a efectuat click pe nimic
	;mai jos e codul care intializeaza fereastra cu pixeli albi
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 255
	push area
	call memset
	add esp, 12
	
	
	
	;mov eax,40
	; desenare_baza:
	;line_horizontal 0,eax, 640,0FF00h
	; cmp eax,80
	; je sf_desenare_baza
	; add eax,1
	; loop desenare_baza
	; sf_desenare_baza:
	
	
	
	
	jmp afisare_litere
	
evt_click:

	 
evt_tasta:
mov eax,[ebp+arg2]
cmp eax,'W'
je inainte
jne sf_comp
inainte:
mov eax,coordonata_y_broasca
sub eax,40
mov coordonata_y_broasca,eax
sf_comp:

mov eax,[ebp+arg2]
cmp eax,'A'
je stanga
jne sf_comp1
stanga:
mov eax,coordonata_x_broasca
cmp eax,0
je sf_comp1
sub eax,40
mov coordonata_x_broasca,eax
sf_comp1:

mov eax,[ebp+arg2]
cmp eax,'D'
je dreapta
jne sf_comp2
dreapta:
mov eax,coordonata_x_broasca
cmp eax,600
je sf_comp2
add eax,40
mov coordonata_x_broasca,eax
sf_comp2:

mov eax,[ebp+arg2]
cmp eax,'S'
je jos
jne sf_comp3
jos:
mov eax,coordonata_y_broasca
cmp eax,440
je sf_comp3
add eax,40
mov coordonata_y_broasca,eax
sf_comp3:

mov eax,[ebp+arg2]
cmp eax,'R'
je restart
jne sf_comp4
restart:
mov vieti,3
mov counter,0
mov scor,0
mov coordonata_x_broasca,320
mov coordonata_y_broasca,440
mov factor_ceas,10
mov factor_ceas1,10
mov factor_ceas2,10
mov factor_ceas3,10
mov factor_ceas4,10
mov factor_ceas5,10
mov factor_ceas6,10
mov factor_ceas7,10
mov factor_ceas8,10
mov factor_ceas9,10
mov broaste_in_cuib,0
sf_comp4:



evt_timer:
	inc counter
	
	
	joc_castigat:
	mov eax,broaste_in_cuib
	cmp eax,5
	je joc_castigat_da
	jne game_over
	joc_castigat_da:
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 255
	push area
	call memset
	add esp, 12
	;scriem un mesaj
	 make_text_macro 'A', area, 110, 100
	 make_text_macro 'I', area, 120, 100
	 make_text_macro 'C', area, 140, 100
	 make_text_macro 'A', area, 150, 100
	make_text_macro 'S', area, 160, 100
	 make_text_macro 'T', area, 170, 100
	make_text_macro 'I', area, 180, 100
	 make_text_macro 'G', area, 190, 100
	make_text_macro 'A', area, 200, 100
	 make_text_macro 'T', area, 210, 100
	jmp sfarsit_joc
	
	game_over:
	mov eax,vieti
	cmp eax,0
	je game_over_da
	jne md1
	game_over_da:
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 255
	push area
	call memset
	add esp, 12
	;scriem un mesaj
	 make_text_macro 'G', area, 110, 100
	 make_text_macro 'A', area, 120, 100
	 make_text_macro 'M', area, 130, 100
	 make_text_macro 'E', area, 140, 100
	
	make_text_macro 'O', area, 160, 100
	make_text_macro 'V', area, 170, 100
	make_text_macro 'E', area, 180, 100
	make_text_macro 'R', area, 190, 100
	
	jmp sfarsit_joc
	
	md1:
	
	verifica_broasca_cuib:
	mov eax,coordonata_y_broasca
	cmp eax,40
	je broaste_in_cuib2
	jne verifica_broasca_pe_bustean6
	broaste_in_cuib2:
	mov eax,scor
	add eax,1000
	mov ebx,counter
	sub eax,ebx
	mov scor,eax
	mov eax,broaste_in_cuib
	add eax,1
	mov broaste_in_cuib,eax
	
	verifica_broasca_pe_bustean6:
	
	mov ecx, coordonata_y_broasca
	mov ebx,coordonata_y_bustean6
	cmp ebx,ecx
	je cmp_mai_departe10
	jne verifica_broasca_pe_bustean5
	cmp_mai_departe10:
	mov ecx, coordonata_x_broasca
	mov ebx,coordonata_x_bustean6
	cmp ecx,ebx
	jge cmp_mai_departe11
	jne verifica_broasca_pe_bustean5
	cmp_mai_departe11:
	mov ecx, coordonata_x_broasca
	mov ebx,coordonata_x_bustean6
	add ebx,80
	cmp ecx,ebx
	jle safe
	
	verifica_broasca_pe_bustean5:
	
	mov ecx, coordonata_y_broasca
	mov ebx,coordonata_y_bustean5
	cmp ebx,ecx
	je cmp_mai_departe8
	jne verifica_broasca_pe_bustean4
	cmp_mai_departe8:
	mov ecx, coordonata_x_broasca
	mov ebx,coordonata_x_bustean5
	cmp ecx,ebx
	jge cmp_mai_departe9
	jne verifica_broasca_pe_bustean4
	cmp_mai_departe9:
	mov ecx, coordonata_x_broasca
	mov ebx,coordonata_x_bustean5
	add ebx,80
	cmp ecx,ebx
	jle safe
	
	verifica_broasca_pe_bustean4:
	
	mov ecx, coordonata_y_broasca
	mov ebx,coordonata_y_bustean4
	cmp ebx,ecx
	je cmp_mai_departe6
	jne verifica_broasca_pe_bustean3
	cmp_mai_departe6:
	mov ecx, coordonata_x_broasca
	mov ebx,coordonata_x_bustean4
	cmp ecx,ebx
	jge cmp_mai_departe7
	jne verifica_broasca_pe_bustean3
	cmp_mai_departe7:
	mov ecx, coordonata_x_broasca
	mov ebx,coordonata_x_bustean4
	add ebx,80
	cmp ecx,ebx
	jle safe
	
	verifica_broasca_pe_bustean3:
	
	mov ecx, coordonata_y_broasca
	mov ebx,coordonata_y_bustean3
	cmp ebx,ecx
	je cmp_mai_departe4
	jne verifica_broasca_pe_bustean2
	cmp_mai_departe4:
	mov ecx, coordonata_x_broasca
	mov ebx,coordonata_x_bustean3
	cmp ecx,ebx
	jge cmp_mai_departe5
	jne verifica_broasca_pe_bustean2
	cmp_mai_departe5:
	mov ecx, coordonata_x_broasca
	mov ebx,coordonata_x_bustean3
	add ebx,80
	cmp ecx,ebx
	jle safe
	
	verifica_broasca_pe_bustean2:
	
	mov ecx, coordonata_y_broasca
	mov ebx,coordonata_y_bustean2
	cmp ebx,ecx
	je cmp_mai_departe2
	jne verifica_broasca_pe_bustean1
	cmp_mai_departe2:
	mov ecx, coordonata_x_broasca
	mov ebx,coordonata_x_bustean2
	cmp ecx,ebx
	jge cmp_mai_departe3
	jne verifica_broasca_pe_bustean1
	cmp_mai_departe3:
	mov ecx, coordonata_x_broasca
	mov ebx,coordonata_x_bustean2
	add ebx,80
	cmp ecx,ebx
	jle safe
	
	verifica_broasca_pe_bustean1:
	
	mov ecx, coordonata_y_broasca
	mov ebx,coordonata_y_bustean1
	cmp ebx,ecx
	je cmp_mai_departe
	jne eticheta1
	cmp_mai_departe:
	mov ecx, coordonata_x_broasca
	mov ebx,coordonata_x_bustean1
	cmp ecx,ebx
	jge cmp_mai_departe1
	jne eticheta1
	cmp_mai_departe1:
	mov ecx, coordonata_x_broasca
	mov ebx,coordonata_x_bustean1
	add ebx,80
	cmp ecx,ebx
	jle safe
	
	
	eticheta1:
	mov eax,80
	mov ebx,200
	mov ecx, coordonata_y_broasca
	cmp ecx,eax
	jge verif_mai_departe
	jmp safe
	verif_mai_departe:
	cmp ecx,ebx
	jle broasca_lovita
	safe:
	
	
	
	mov eax,coordonata_x_broasca
	mov ebx,coordonata_x_masina1
	cmp eax,ebx
	je verificare_y1
	jne comparare_2
	verificare_y1:
	mov eax,coordonata_y_broasca
	mov ebx, coordonata_y_masina1
	cmp eax,ebx
	je broasca_lovita
	jne comparare_2
	
	
	broasca_lovita:
	mov eax,vieti
	sub eax,1
	mov vieti,eax
	mov coordonata_x_broasca,320
	mov coordonata_y_broasca,440
	
	
	comparare_2:
	mov eax,coordonata_x_broasca
	mov ebx,coordonata_x_masina2
	cmp eax,ebx
	je verificare_y2
	jne comparare_3
	verificare_y2:
	mov eax,coordonata_y_broasca
	mov ebx, coordonata_y_masina2
	cmp eax,ebx
	je broasca_lovita
	jne comparare_3
	comparare_3:
	
	
	mov eax,coordonata_x_broasca
	mov ebx,coordonata_x_masina3
	cmp eax,ebx
	je verificare_y3
	jne comparare_4
	verificare_y3:
	mov eax,coordonata_y_broasca
	mov ebx, coordonata_y_masina3
	cmp eax,ebx
	je broasca_lovita
	jne comparare_4
	comparare_4:
	
	mov eax,coordonata_x_broasca
	mov ebx,coordonata_x_masina4
	cmp eax,ebx
	je verificare_y4
	jne comparare_5
	verificare_y4:
	mov eax,coordonata_y_broasca
	mov ebx, coordonata_y_masina4
	cmp eax,ebx
	je broasca_lovita
	jne comparare_5
	comparare_5:
	
	mov eax, counter 
	mov ebx, factor_ceas
	cmp eax,ebx
	je mutare_masina_1
	jne nu_se_muta_masina1
	mutare_masina_1:
	mov eax, factor_ceas
	add eax,5
	mov factor_ceas,eax
	mov eax, coordonata_x_masina1
	mov ebx,40
	add eax,ebx
	mov coordonata_x_masina1,eax
	cmp coordonata_x_masina1,640
	je resetare_0
	jne nu_se_muta_masina1
	resetare_0:
	mov eax, 0
	mov coordonata_x_masina1,eax
	nu_se_muta_masina1:
	
	
	mov eax, counter 
	mov ebx, factor_ceas2
	cmp eax,ebx
	je mutare_masina_3
	jne nu_se_muta_masina3
	mutare_masina_3:
	mov eax, factor_ceas2
	add eax,3
	mov factor_ceas2,eax
	mov eax, coordonata_x_masina3
	mov ebx,40
	add eax,ebx
	mov coordonata_x_masina3,eax
	cmp coordonata_x_masina3,640
	je resetare_03
	jne nu_se_muta_masina3
	resetare_03:
	mov eax, 0
	mov coordonata_x_masina3,eax
	nu_se_muta_masina3:
	
	mov eax, counter 
	mov ebx, factor_ceas1
	cmp eax,ebx
	je mutare_masina_2
	jne nu_se_muta_masina2
	mutare_masina_2:
	mov eax, factor_ceas1
	add eax,4
	mov factor_ceas1,eax
	mov eax, coordonata_x_masina2
	mov ebx,40
	sub eax,ebx
	mov coordonata_x_masina2,eax
	cmp coordonata_x_masina2,0
	jl resetare_600
	jne nu_se_muta_masina2
	resetare_600:
	mov eax, 640
	mov coordonata_x_masina2,eax
	nu_se_muta_masina2:
	
	mov eax, counter 
	mov ebx, factor_ceas3
	cmp eax,ebx
	je mutare_masina_4
	jne nu_se_muta_masina4
	mutare_masina_4:
	mov eax, factor_ceas3
	add eax,2
	mov factor_ceas3,eax
	mov eax, coordonata_x_masina4
	mov ebx,40
	sub eax,ebx
	mov coordonata_x_masina4,eax
	cmp coordonata_x_masina4,0
	jl resetare_6004
	jne nu_se_muta_masina4
	resetare_6004:
	mov eax, 640
	mov coordonata_x_masina4,eax
	nu_se_muta_masina4:
	
	
	mov eax, counter 
	mov ebx, factor_ceas4
	cmp eax,ebx
	je mutare_bustean_1
	jne nu_se_muta_bustean1
	mutare_bustean_1:
	mov eax, factor_ceas4
	add eax,20
	mov factor_ceas4,eax
	mov eax, coordonata_x_bustean1
	mov ebx,40
	add eax,ebx
	mov coordonata_x_bustean1,eax
	cmp coordonata_x_bustean1,560
	je resetare_00
	jne nu_se_muta_bustean1
	resetare_00:
	mov eax, 0
	mov coordonata_x_bustean1,eax
	nu_se_muta_bustean1:
	
	mov eax, counter 
	mov ebx, factor_ceas5
	cmp eax,ebx
	je mutare_bustean_2
	jne nu_se_muta_bustean2
	mutare_bustean_2:
	mov eax, factor_ceas5
	add eax,20
	mov factor_ceas5,eax
	mov eax, coordonata_x_bustean2
	mov ebx,40
	sub eax,ebx
	mov coordonata_x_bustean2,eax
	cmp coordonata_x_bustean2,0
	je resetare_002
	jne nu_se_muta_bustean2
	resetare_002:
	mov eax, 520
	mov coordonata_x_bustean2,eax
	nu_se_muta_bustean2:
	
	
	mov eax, counter 
	mov ebx, factor_ceas6
	cmp eax,ebx
	je mutare_bustean_3
	jne nu_se_muta_bustean3
	mutare_bustean_3:
	mov eax, factor_ceas6
	add eax,20
	mov factor_ceas6,eax
	mov eax, coordonata_x_bustean3
	mov ebx,40
	sub eax,ebx
	mov coordonata_x_bustean3,eax
	cmp coordonata_x_bustean3,0
	je resetare_003
	jne nu_se_muta_bustean3
	resetare_003:
	mov eax, 520
	mov coordonata_x_bustean3,eax
	nu_se_muta_bustean3:
	
	
	
	mov eax, counter 
	mov ebx, factor_ceas7
	cmp eax,ebx
	je mutare_bustean_4
	jne nu_se_muta_bustean4
	mutare_bustean_4:
	mov eax, factor_ceas7
	add eax,20
	mov factor_ceas7,eax
	mov eax, coordonata_x_bustean4
	mov ebx,40
	add eax,ebx
	mov coordonata_x_bustean4,eax
	cmp coordonata_x_bustean4,560
	je resetare_004
	jne nu_se_muta_bustean4
	resetare_004:
	mov eax, 0
	mov coordonata_x_bustean4,eax
	nu_se_muta_bustean4:
	
	mov eax, counter 
	mov ebx, factor_ceas8
	cmp eax,ebx
	je mutare_bustean_5
	jne nu_se_muta_bustean5
	mutare_bustean_5:
	mov eax, factor_ceas8
	add eax,20
	mov factor_ceas8,eax
	mov eax, coordonata_x_bustean5
	mov ebx,40
	add eax,ebx
	mov coordonata_x_bustean5,eax
	cmp coordonata_x_bustean5,560
	je resetare_005
	jne nu_se_muta_bustean5
	resetare_005:
	mov eax, 0
	mov coordonata_x_bustean5,eax
	nu_se_muta_bustean5:
	
	mov eax, counter 
	mov ebx, factor_ceas9
	cmp eax,ebx
	je mutare_bustean_6
	jne nu_se_muta_bustean6
	mutare_bustean_6:
	mov eax, factor_ceas9
	add eax,20
	mov factor_ceas9,eax
	mov eax, coordonata_x_bustean6
	mov ebx,40
	sub eax,ebx
	mov coordonata_x_bustean6,eax
	cmp coordonata_x_bustean6,0
	je resetare_006
	jne nu_se_muta_bustean6
	resetare_006:
	mov eax, 520
	mov coordonata_x_bustean6,eax
	nu_se_muta_bustean6:
	
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 255
	push area
	call memset
	add esp, 12
	
		;desenare bucata 1 iarba
	line_horizontal 0,440, 25600,01D8034h
	;desenare bucata 1 drum
	line_horizontal 0,401, 24960,0444444h
	line_horizontal 0,400, 40,0FFFFFFh
	line_horizontal 40,400, 40,0444444h
	line_horizontal 80,400, 40,0FFFFFFh
	line_horizontal 120,400, 40,0444444h
	line_horizontal 160,400, 40,0FFFFFFh
	line_horizontal 200,400, 40,0444444h
	line_horizontal 240,400, 40,0FFFFFFh
	line_horizontal 280,400, 40,0444444h
	line_horizontal 320,400, 40,0FFFFFFh
	line_horizontal 360,400, 40,0444444h
	line_horizontal 400,400, 40,0FFFFFFh
	line_horizontal 440,400, 40,0444444h
	line_horizontal 480,400, 40,0FFFFFFh
	line_horizontal 520,400, 40,0444444h
	line_horizontal 560,400, 40,0FFFFFFh
	line_horizontal 600,400, 40,0444444h
	
	
	;desenare bucata 2 drum
	line_horizontal 0,361, 24320,0444444h
	line_horizontal 0,399, 40,0FFFFFFh
	line_horizontal 40,399, 40,0444444h
	line_horizontal 80,399, 40,0FFFFFFh
	line_horizontal 120,399, 40,0444444h
	line_horizontal 160,399, 40,0FFFFFFh
	line_horizontal 200,399, 40,0444444h
	line_horizontal 240,399, 40,0FFFFFFh
	line_horizontal 280,399, 40,0444444h
	line_horizontal 320,399, 40,0FFFFFFh
	line_horizontal 360,399, 40,0444444h
	line_horizontal 400,399, 40,0FFFFFFh
	line_horizontal 440,399, 40,0444444h
	line_horizontal 480,399, 40,0FFFFFFh
	line_horizontal 520,399, 40,0444444h
	line_horizontal 560,399, 40,0FFFFFFh
	line_horizontal 600,399, 40,0444444h
	
	;desenare bucata 3 drum
	line_horizontal 600,320, 40,0FFFFFFh
	line_horizontal 0,320, 40,0444444h
	line_horizontal 40,320, 40,0FFFFFFh
	line_horizontal 80,320, 40,0444444h
	line_horizontal 120,320, 40,0FFFFFFh
	line_horizontal 160,320, 40,0444444h
	line_horizontal 200,320, 40,0FFFFFFh
	line_horizontal 240,320, 40,0444444h
	line_horizontal 280,320, 40,0FFFFFFh
	line_horizontal 320,320, 40,0444444h
	line_horizontal 360,320, 40,0FFFFFFh
	line_horizontal 400,320, 40,0444444h
	line_horizontal 440,320, 40,0FFFFFFh
	line_horizontal 480,320, 40,0444444h
	line_horizontal 520,320, 40,0FFFFFFh
	line_horizontal 560,320, 40,0444444h
	line_horizontal 0,321, 24320,0444444h
	
	;desenare bucata 4 drum
	line_horizontal 600,319, 40,0FFFFFFh
	line_horizontal 0,319, 40,0444444h
	line_horizontal 40,319, 40,0FFFFFFh
	line_horizontal 80,319, 40,0444444h
	line_horizontal 120,319, 40,0FFFFFFh
	line_horizontal 160,319, 40,0444444h
	line_horizontal 200,319, 40,0FFFFFFh
	line_horizontal 240,319, 40,0444444h
	line_horizontal 280,319, 40,0FFFFFFh
	line_horizontal 320,319, 40,0444444h
	line_horizontal 360,319, 40,0FFFFFFh
	line_horizontal 400,319, 40,0444444h
	line_horizontal 440,319, 40,0FFFFFFh
	line_horizontal 480,319, 40,0444444h
	line_horizontal 520,319, 40,0FFFFFFh
	line_horizontal 560,319, 40,0444444h
	line_horizontal 0,280, 24960,0444444h
	
	;desenare bucata nisip
	line_horizontal 0,240, 25600,0F1C232h
	;desenare bucata apa
	line_horizontal 0,80, 102400,03D85C6h
	;;desenare bucata culcus
	line_horizontal 0,40, 25600,038761Dh
	
	
	desenare_bustean_6:
	cmp coordonata_x_bustean6,0
	jne next_x_bustean6
	je desenare_bustean6_0_y
	desenare_bustean6_0_y:
	make_bustean_1 0,coordonata_y_bustean6
	jmp desenare_bustean_5
	next_x_bustean6:
	
	cmp coordonata_x_bustean6,40
	jne next_x_bustean61
	je desenare_bustean6_40_y
	desenare_bustean6_40_y:
	make_bustean_1 40,coordonata_y_bustean6
	jmp desenare_bustean_5
	next_x_bustean61:
	
	cmp coordonata_x_bustean6,80
	jne next_x_bustean62
	je desenare_bustean6_80_y
	desenare_bustean6_80_y:
	make_bustean_1 80,coordonata_y_bustean6
	jmp desenare_bustean_5
	next_x_bustean62:
	
	cmp coordonata_x_bustean6,120
	jne next_x_bustean63
	je desenare_bustean6_120_y
	desenare_bustean6_120_y:
	make_bustean_1 120,coordonata_y_bustean6
	jmp desenare_bustean_5
	next_x_bustean63:
	
	cmp coordonata_x_bustean6,160
	jne next_x_bustean64
	je desenare_bustean6_160_y
	desenare_bustean6_160_y:
	make_bustean_1 160,coordonata_y_bustean6
	jmp desenare_bustean_5
	next_x_bustean64:
	
	cmp coordonata_x_bustean6,200
	jne next_x_bustean65
	je desenare_bustean6_200_y
	desenare_bustean6_200_y:
	make_bustean_1 200,coordonata_y_bustean6
	jmp desenare_bustean_5
	next_x_bustean65:
	
	cmp coordonata_x_bustean6,240
	jne next_x_bustean66
	je desenare_bustean6_240_y
	desenare_bustean6_240_y:
	make_bustean_1 240,coordonata_y_bustean6
	jmp desenare_bustean_5
	next_x_bustean66:
	
	cmp coordonata_x_bustean6,280
	jne next_x_bustean67
	je desenare_bustean6_280_y
	desenare_bustean6_280_y:
	make_bustean_1 280,coordonata_y_bustean6
	jmp desenare_bustean_5
	next_x_bustean67:
	
	cmp coordonata_x_bustean6,320
	jne next_x_bustean68
	je desenare_bustean6_320_y
	desenare_bustean6_320_y:
	make_bustean_1 320,coordonata_y_bustean6
	jmp desenare_bustean_5
	next_x_bustean68:
	
	cmp coordonata_x_bustean6,360
	jne next_x_bustean69
	je desenare_bustean6_360_y
	desenare_bustean6_360_y:
	make_bustean_1 360,coordonata_y_bustean6
	jmp desenare_bustean_5
	next_x_bustean69:
	
	cmp coordonata_x_bustean6,400
	jne next_x_bustean610
	je desenare_bustean6_400_y
	desenare_bustean6_400_y:
	make_bustean_1 400,coordonata_y_bustean6
	jmp desenare_bustean_5
	next_x_bustean610:
	
	cmp coordonata_x_bustean6,440
	jne next_x_bustean611
	je desenare_bustean6_440_y
	desenare_bustean6_440_y:
	make_bustean_1 440,coordonata_y_bustean6
	jmp desenare_bustean_5
	next_x_bustean611:
	
	cmp coordonata_x_bustean6,480
	jne next_x_bustean612
	je desenare_bustean6_480_y
	desenare_bustean6_480_y:
	make_bustean_1 480,coordonata_y_bustean6
	jmp desenare_bustean_5
	next_x_bustean612:
	
	cmp coordonata_x_bustean6,520
	jne next_x_bustean613
	je desenare_bustean6_520_y
	desenare_bustean6_520_y:
	make_bustean_1 520,coordonata_y_bustean6
	jmp desenare_bustean_5
	next_x_bustean613:
	
	desenare_bustean_5:
	cmp coordonata_x_bustean5,0
	jne next_x_bustean5
	je desenare_bustean5_0_y
	desenare_bustean5_0_y:
	make_bustean_1 0,coordonata_y_bustean5
	jmp desenare_bustean_4
	next_x_bustean5:
	
	cmp coordonata_x_bustean5,40
	jne next_x_bustean51
	je desenare_bustean5_40_y
	desenare_bustean5_40_y:
	make_bustean_1 40,coordonata_y_bustean5
	jmp desenare_bustean_4
	next_x_bustean51:
	
	cmp coordonata_x_bustean5,80
	jne next_x_bustean52
	je desenare_bustean5_80_y
	desenare_bustean5_80_y:
	make_bustean_1 80,coordonata_y_bustean5
	jmp desenare_bustean_4
	next_x_bustean52:
	
	cmp coordonata_x_bustean5,120
	jne next_x_bustean53
	je desenare_bustean5_120_y
	desenare_bustean5_120_y:
	make_bustean_1 120,coordonata_y_bustean5
	jmp desenare_bustean_4
	next_x_bustean53:
	
	cmp coordonata_x_bustean5,160
	jne next_x_bustean54
	je desenare_bustean5_160_y
	desenare_bustean5_160_y:
	make_bustean_1 160,coordonata_y_bustean5
	jmp desenare_bustean_4
	next_x_bustean54:
	
	cmp coordonata_x_bustean5,200
	jne next_x_bustean55
	je desenare_bustean5_200_y
	desenare_bustean5_200_y:
	make_bustean_1 200,coordonata_y_bustean5
	jmp desenare_bustean_4
	next_x_bustean55:
	
	cmp coordonata_x_bustean5,240
	jne next_x_bustean56
	je desenare_bustean5_240_y
	desenare_bustean5_240_y:
	make_bustean_1 240,coordonata_y_bustean5
	jmp desenare_bustean_4
	next_x_bustean56:
	
	cmp coordonata_x_bustean5,280
	jne next_x_bustean57
	je desenare_bustean5_280_y
	desenare_bustean5_280_y:
	make_bustean_1 280,coordonata_y_bustean5
	jmp desenare_bustean_4
	next_x_bustean57:
	
	cmp coordonata_x_bustean5,320
	jne next_x_bustean58
	je desenare_bustean5_320_y
	desenare_bustean5_320_y:
	make_bustean_1 320,coordonata_y_bustean5
	jmp desenare_bustean_4
	next_x_bustean58:
	
	cmp coordonata_x_bustean5,360
	jne next_x_bustean59
	je desenare_bustean5_360_y
	desenare_bustean5_360_y:
	make_bustean_1 360,coordonata_y_bustean5
	jmp desenare_bustean_4
	next_x_bustean59:
	
	cmp coordonata_x_bustean5,400
	jne next_x_bustean510
	je desenare_bustean5_400_y
	desenare_bustean5_400_y:
	make_bustean_1 400,coordonata_y_bustean5
	jmp desenare_bustean_4
	next_x_bustean510:
	
	cmp coordonata_x_bustean5,440
	jne next_x_bustean511
	je desenare_bustean5_440_y
	desenare_bustean5_440_y:
	make_bustean_1 440,coordonata_y_bustean5
	jmp desenare_bustean_4
	next_x_bustean511:
	
	cmp coordonata_x_bustean5,480
	jne next_x_bustean512
	je desenare_bustean5_480_y
	desenare_bustean5_480_y:
	make_bustean_1 480,coordonata_y_bustean5
	jmp desenare_bustean_4
	next_x_bustean512:
	
	cmp coordonata_x_bustean5,520
	jne next_x_bustean513
	je desenare_bustean5_520_y
	desenare_bustean5_520_y:
	make_bustean_1 520,coordonata_y_bustean5
	jmp desenare_bustean_4
	next_x_bustean513:
	
	
	desenare_bustean_4:
	cmp coordonata_x_bustean4,0
	jne next_x_bustean4
	je desenare_bustean4_0_y
	desenare_bustean4_0_y:
	make_bustean_1 0,coordonata_y_bustean4
	jmp desenare_bustean_3
	next_x_bustean4:
	
	cmp coordonata_x_bustean4,40
	jne next_x_bustean41
	je desenare_bustean4_40_y
	desenare_bustean4_40_y:
	make_bustean_1 40,coordonata_y_bustean4
	jmp desenare_bustean_3
	next_x_bustean41:
	
	cmp coordonata_x_bustean4,80
	jne next_x_bustean42
	je desenare_bustean4_80_y
	desenare_bustean4_80_y:
	make_bustean_1 80,coordonata_y_bustean4
	jmp desenare_bustean_3
	next_x_bustean42:
	
	cmp coordonata_x_bustean4,120
	jne next_x_bustean43
	je desenare_bustean4_120_y
	desenare_bustean4_120_y:
	make_bustean_1 120,coordonata_y_bustean4
	jmp desenare_bustean_3
	next_x_bustean43:
	
	cmp coordonata_x_bustean4,160
	jne next_x_bustean44
	je desenare_bustean4_160_y
	desenare_bustean4_160_y:
	make_bustean_1 160,coordonata_y_bustean4
	jmp desenare_bustean_3
	next_x_bustean44:
	
	cmp coordonata_x_bustean4,200
	jne next_x_bustean45
	je desenare_bustean4_200_y
	desenare_bustean4_200_y:
	make_bustean_1 200,coordonata_y_bustean4
	jmp desenare_bustean_3
	next_x_bustean45:
	
	cmp coordonata_x_bustean4,240
	jne next_x_bustean46
	je desenare_bustean4_240_y
	desenare_bustean4_240_y:
	make_bustean_1 240,coordonata_y_bustean4
	jmp desenare_bustean_3
	next_x_bustean46:
	
	cmp coordonata_x_bustean4,280
	jne next_x_bustean47
	je desenare_bustean4_280_y
	desenare_bustean4_280_y:
	make_bustean_1 280,coordonata_y_bustean4
	jmp desenare_bustean_3
	next_x_bustean47:
	
	cmp coordonata_x_bustean4,320
	jne next_x_bustean48
	je desenare_bustean4_320_y
	desenare_bustean4_320_y:
	make_bustean_1 320,coordonata_y_bustean4
	jmp desenare_bustean_3
	next_x_bustean48:
	
	cmp coordonata_x_bustean4,360
	jne next_x_bustean49
	je desenare_bustean4_360_y
	desenare_bustean4_360_y:
	make_bustean_1 360,coordonata_y_bustean4
	jmp desenare_bustean_3
	next_x_bustean49:
	
	cmp coordonata_x_bustean4,400
	jne next_x_bustean410
	je desenare_bustean4_400_y
	desenare_bustean4_400_y:
	make_bustean_1 400,coordonata_y_bustean4
	jmp desenare_bustean_3
	next_x_bustean410:
	
	cmp coordonata_x_bustean4,440
	jne next_x_bustean411
	je desenare_bustean4_440_y
	desenare_bustean4_440_y:
	make_bustean_1 440,coordonata_y_bustean4
	jmp desenare_bustean_3
	next_x_bustean411:
	
	cmp coordonata_x_bustean4,480
	jne next_x_bustean412
	je desenare_bustean4_480_y
	desenare_bustean4_480_y:
	make_bustean_1 480,coordonata_y_bustean4
	jmp desenare_bustean_3
	next_x_bustean412:
	
	cmp coordonata_x_bustean4,520
	jne next_x_bustean413
	je desenare_bustean4_520_y
	desenare_bustean4_520_y:
	make_bustean_1 520,coordonata_y_bustean4
	jmp desenare_bustean_3
	next_x_bustean413:
	
	
	desenare_bustean_3:
	cmp coordonata_x_bustean3,0
	jne next_x_bustean3
	je desenare_bustean3_0_y
	desenare_bustean3_0_y:
	make_bustean_1 0,coordonata_y_bustean3
	jmp desenare_bustean_2
	next_x_bustean3:
	
	cmp coordonata_x_bustean3,40
	jne next_x_bustean31
	je desenare_bustean3_40_y
	desenare_bustean3_40_y:
	make_bustean_1 40,coordonata_y_bustean3
	jmp desenare_bustean_2
	next_x_bustean31:
	
	cmp coordonata_x_bustean3,80
	jne next_x_bustean32
	je desenare_bustean3_80_y
	desenare_bustean3_80_y:
	make_bustean_1 80,coordonata_y_bustean3
	jmp desenare_bustean_2
	next_x_bustean32:
	
	cmp coordonata_x_bustean3,120
	jne next_x_bustean33
	je desenare_bustean3_120_y
	desenare_bustean3_120_y:
	make_bustean_1 120,coordonata_y_bustean3
	jmp desenare_bustean_2
	next_x_bustean33:
	
	cmp coordonata_x_bustean3,160
	jne next_x_bustean34
	je desenare_bustean3_160_y
	desenare_bustean3_160_y:
	make_bustean_1 160,coordonata_y_bustean3
	jmp desenare_bustean_2
	next_x_bustean34:
	
	cmp coordonata_x_bustean3,200
	jne next_x_bustean35
	je desenare_bustean3_200_y
	desenare_bustean3_200_y:
	make_bustean_1 200,coordonata_y_bustean3
	jmp desenare_bustean_2
	next_x_bustean35:
	
	cmp coordonata_x_bustean3,240
	jne next_x_bustean36
	je desenare_bustean3_240_y
	desenare_bustean3_240_y:
	make_bustean_1 240,coordonata_y_bustean3
	jmp desenare_bustean_2
	next_x_bustean36:
	
	cmp coordonata_x_bustean3,280
	jne next_x_bustean37
	je desenare_bustean3_280_y
	desenare_bustean3_280_y:
	make_bustean_1 280,coordonata_y_bustean3
	jmp desenare_bustean_2
	next_x_bustean37:
	
	cmp coordonata_x_bustean3,320
	jne next_x_bustean38
	je desenare_bustean3_320_y
	desenare_bustean3_320_y:
	make_bustean_1 320,coordonata_y_bustean3
	jmp desenare_bustean_2
	next_x_bustean38:
	
	cmp coordonata_x_bustean3,360
	jne next_x_bustean39
	je desenare_bustean3_360_y
	desenare_bustean3_360_y:
	make_bustean_1 360,coordonata_y_bustean3
	jmp desenare_bustean_2
	next_x_bustean39:
	
	cmp coordonata_x_bustean3,400
	jne next_x_bustean310
	je desenare_bustean3_400_y
	desenare_bustean3_400_y:
	make_bustean_1 400,coordonata_y_bustean3
	jmp desenare_bustean_2
	next_x_bustean310:
	
	cmp coordonata_x_bustean3,440
	jne next_x_bustean311
	je desenare_bustean3_440_y
	desenare_bustean3_440_y:
	make_bustean_1 440,coordonata_y_bustean3
	jmp desenare_bustean_2
	next_x_bustean311:
	
	cmp coordonata_x_bustean3,480
	jne next_x_bustean312
	je desenare_bustean3_480_y
	desenare_bustean3_480_y:
	make_bustean_1 480,coordonata_y_bustean3
	jmp desenare_bustean_2
	next_x_bustean312:
	
	cmp coordonata_x_bustean3,520
	jne next_x_bustean313
	je desenare_bustean3_520_y
	desenare_bustean3_520_y:
	make_bustean_1 520,coordonata_y_bustean3
	jmp desenare_bustean_2
	next_x_bustean313:
	
	
	desenare_bustean_2:
	cmp coordonata_x_bustean2,0
	jne next_x_bustean2
	je desenare_bustean2_0_y
	desenare_bustean2_0_y:
	make_bustean_1 0,coordonata_y_bustean2
	jmp desenare_bustean_1
	next_x_bustean2:
	
	cmp coordonata_x_bustean2,40
	jne next_x_bustean21
	je desenare_bustean2_40_y
	desenare_bustean2_40_y:
	make_bustean_1 40,coordonata_y_bustean2
	jmp desenare_bustean_1
	next_x_bustean21:
	
	cmp coordonata_x_bustean2,80
	jne next_x_bustean22
	je desenare_bustean2_80_y
	desenare_bustean2_80_y:
	make_bustean_1 80,coordonata_y_bustean2
	jmp desenare_bustean_1
	next_x_bustean22:
	
	cmp coordonata_x_bustean2,120
	jne next_x_bustean23
	je desenare_bustean2_120_y
	desenare_bustean2_120_y:
	make_bustean_1 120,coordonata_y_bustean2
	jmp desenare_bustean_1
	next_x_bustean23:
	
	cmp coordonata_x_bustean2,160
	jne next_x_bustean24
	je desenare_bustean2_160_y
	desenare_bustean2_160_y:
	make_bustean_1 160,coordonata_y_bustean2
	jmp desenare_bustean_1
	next_x_bustean24:
	
	cmp coordonata_x_bustean2,200
	jne next_x_bustean25
	je desenare_bustean2_200_y
	desenare_bustean2_200_y:
	make_bustean_1 200,coordonata_y_bustean2
	jmp desenare_bustean_1
	next_x_bustean25:
	
	cmp coordonata_x_bustean2,240
	jne next_x_bustean26
	je desenare_bustean2_240_y
	desenare_bustean2_240_y:
	make_bustean_1 240,coordonata_y_bustean2
	jmp desenare_bustean_1
	next_x_bustean26:
	
	cmp coordonata_x_bustean2,280
	jne next_x_bustean27
	je desenare_bustean2_280_y
	desenare_bustean2_280_y:
	make_bustean_1 280,coordonata_y_bustean2
	jmp desenare_bustean_1
	next_x_bustean27:
	
	cmp coordonata_x_bustean2,320
	jne next_x_bustean28
	je desenare_bustean2_320_y
	desenare_bustean2_320_y:
	make_bustean_1 320,coordonata_y_bustean2
	jmp desenare_bustean_1
	next_x_bustean28:
	
	cmp coordonata_x_bustean2,360
	jne next_x_bustean29
	je desenare_bustean2_360_y
	desenare_bustean2_360_y:
	make_bustean_1 360,coordonata_y_bustean2
	jmp desenare_bustean_1
	next_x_bustean29:
	
	cmp coordonata_x_bustean2,400
	jne next_x_bustean210
	je desenare_bustean2_400_y
	desenare_bustean2_400_y:
	make_bustean_1 400,coordonata_y_bustean2
	jmp desenare_bustean_1
	next_x_bustean210:
	
	cmp coordonata_x_bustean2,440
	jne next_x_bustean211
	je desenare_bustean2_440_y
	desenare_bustean2_440_y:
	make_bustean_1 440,coordonata_y_bustean2
	jmp desenare_bustean_1
	next_x_bustean211:
	
	cmp coordonata_x_bustean2,480
	jne next_x_bustean212
	je desenare_bustean2_480_y
	desenare_bustean2_480_y:
	make_bustean_1 480,coordonata_y_bustean2
	jmp desenare_bustean_1
	next_x_bustean212:
	
	cmp coordonata_x_bustean2,520
	jne next_x_bustean213
	je desenare_bustean2_520_y
	desenare_bustean2_520_y:
	make_bustean_1 520,coordonata_y_bustean2
	jmp desenare_bustean_1
	next_x_bustean213:
	
	desenare_bustean_1:
	cmp coordonata_x_bustean1,0
	jne next_x_bustean1
	je desenare_bustean1_0_y
	desenare_bustean1_0_y:
	make_bustean_1 0,coordonata_y_bustean1
	jmp desenare_masina_4
	next_x_bustean1:
	
	cmp coordonata_x_bustean1,40
	jne next_x_bustean11
	je desenare_bustean1_40_y
	desenare_bustean1_40_y:
	make_bustean_1 40,coordonata_y_bustean1
	jmp desenare_masina_4
	next_x_bustean11:
	
	cmp coordonata_x_bustean1,80
	jne next_x_bustean12
	je desenare_bustean1_80_y
	desenare_bustean1_80_y:
	make_bustean_1 80,coordonata_y_bustean1
	jmp desenare_masina_4
	next_x_bustean12:
	
	cmp coordonata_x_bustean1,120
	jne next_x_bustean13
	je desenare_bustean1_120_y
	desenare_bustean1_120_y:
	make_bustean_1 120,coordonata_y_bustean1
	jmp desenare_masina_4
	next_x_bustean13:
	
	cmp coordonata_x_bustean1,160
	jne next_x_bustean14
	je desenare_bustean1_160_y
	desenare_bustean1_160_y:
	make_bustean_1 160,coordonata_y_bustean1
	jmp desenare_masina_4
	next_x_bustean14:
	
	cmp coordonata_x_bustean1,200
	jne next_x_bustean15
	je desenare_bustean1_200_y
	desenare_bustean1_200_y:
	make_bustean_1 200,coordonata_y_bustean1
	jmp desenare_masina_4
	next_x_bustean15:
	
	cmp coordonata_x_bustean1,240
	jne next_x_bustean16
	je desenare_bustean1_240_y
	desenare_bustean1_240_y:
	make_bustean_1 240,coordonata_y_bustean1
	jmp desenare_masina_4
	next_x_bustean16:
	
	cmp coordonata_x_bustean1,280
	jne next_x_bustean17
	je desenare_bustean1_280_y
	desenare_bustean1_280_y:
	make_bustean_1 280,coordonata_y_bustean1
	jmp desenare_masina_4
	next_x_bustean17:
	
	cmp coordonata_x_bustean1,320
	jne next_x_bustean18
	je desenare_bustean1_320_y
	desenare_bustean1_320_y:
	make_bustean_1 320,coordonata_y_bustean1
	jmp desenare_masina_4
	next_x_bustean18:
	
	cmp coordonata_x_bustean1,360
	jne next_x_bustean19
	je desenare_bustean1_360_y
	desenare_bustean1_360_y:
	make_bustean_1 360,coordonata_y_bustean1
	jmp desenare_masina_4
	next_x_bustean19:
	
	cmp coordonata_x_bustean1,400
	jne next_x_bustean110
	je desenare_bustean1_400_y
	desenare_bustean1_400_y:
	make_bustean_1 400,coordonata_y_bustean1
	jmp desenare_masina_4
	next_x_bustean110:
	
	cmp coordonata_x_bustean1,440
	jne next_x_bustean111
	je desenare_bustean1_440_y
	desenare_bustean1_440_y:
	make_bustean_1 440,coordonata_y_bustean1
	jmp desenare_masina_4
	next_x_bustean111:
	
	cmp coordonata_x_bustean1,480
	jne next_x_bustean112
	je desenare_bustean1_480_y
	desenare_bustean1_480_y:
	make_bustean_1 480,coordonata_y_bustean1
	jmp desenare_masina_4
	next_x_bustean112:
	
	cmp coordonata_x_bustean1,520
	jne next_x_bustean113
	je desenare_bustean1_520_y
	desenare_bustean1_520_y:
	make_bustean_1 520,coordonata_y_bustean1
	jmp desenare_masina_4
	next_x_bustean113:
	
	desenare_masina_4:
	cmp coordonata_x_masina4,0
	jne next_x_masina4
	je desenare_masina4_0_y
	desenare_masina4_0_y:
	make_masina_4 0,coordonata_y_masina4
	jmp desenare_masina_3
	next_x_masina4:
	
	cmp coordonata_x_masina4,40
	jne next_x_masina41
	je desenare_masina4_40_y
	desenare_masina4_40_y:
	make_masina_4 40,coordonata_y_masina4
	jmp desenare_masina_3
	next_x_masina41:
	
	cmp coordonata_x_masina4,80
	jne next_x_masina42
	je desenare_masina4_80_y
	desenare_masina4_80_y:
	make_masina_4 80,coordonata_y_masina4
	jmp desenare_masina_3
	next_x_masina42:
	
	cmp coordonata_x_masina4,120
	jne next_x_masina43
	je desenare_masina4_120_y
	desenare_masina4_120_y:
	make_masina_4 120,coordonata_y_masina4
	jmp desenare_masina_3
	next_x_masina43:
	
	cmp coordonata_x_masina4,160
	jne next_x_masina44
	je desenare_masina4_160_y
	desenare_masina4_160_y:
	make_masina_4 160,coordonata_y_masina4
	jmp desenare_masina_3
	next_x_masina44:
	
	cmp coordonata_x_masina4,200
	jne next_x_masina45
	je desenare_masina4_200_y
	desenare_masina4_200_y:
	make_masina_4 200,coordonata_y_masina4
	jmp desenare_masina_3
	next_x_masina45:
	
	cmp coordonata_x_masina4,240
	jne next_x_masina46
	je desenare_masina4_240_y
	desenare_masina4_240_y:
	make_masina_4 240,coordonata_y_masina4
	jmp desenare_masina_3
	next_x_masina46:
	
	cmp coordonata_x_masina4,280
	jne next_x_masina47
	je desenare_masina4_280_y
	desenare_masina4_280_y:
	make_masina_4 280,coordonata_y_masina4
	jmp desenare_masina_3
	next_x_masina47:
	
	cmp coordonata_x_masina4,320
	jne next_x_masina48
	je desenare_masina4_320_y
	desenare_masina4_320_y:
	make_masina_4 320,coordonata_y_masina4
	jmp desenare_masina_3
	next_x_masina48:
	
	cmp coordonata_x_masina4,360
	jne next_x_masina49
	je desenare_masina4_360_y
	desenare_masina4_360_y:
	make_masina_4 360,coordonata_y_masina4
	jmp desenare_masina_3
	next_x_masina49:
	
	cmp coordonata_x_masina4,400
	jne next_x_masina410
	je desenare_masina4_400_y
	desenare_masina4_400_y:
	make_masina_4 400,coordonata_y_masina4
	jmp desenare_masina_3
	next_x_masina410:
	
	cmp coordonata_x_masina4,440
	jne next_x_masina411
	je desenare_masina4_440_y
	desenare_masina4_440_y:
	make_masina_4 440,coordonata_y_masina4
	jmp desenare_masina_3
	next_x_masina411:
	
	cmp coordonata_x_masina4,480
	jne next_x_masina412
	je desenare_masina4_480_y
	desenare_masina4_480_y:
	make_masina_4 480,coordonata_y_masina4
	jmp desenare_masina_3
	next_x_masina412:
	
	cmp coordonata_x_masina4,520
	jne next_x_masina413
	je desenare_masina4_520_y
	desenare_masina4_520_y:
	make_masina_4 520,coordonata_y_masina4
	jmp desenare_masina_3
	next_x_masina413:
	
	
	cmp coordonata_x_masina4,560
	jne next_x_masina414
	je desenare_masina4_560_y
	desenare_masina4_560_y:
	make_masina_4 560,coordonata_y_masina4
	jmp desenare_masina_3
	next_x_masina414:
	
	cmp coordonata_x_masina4,600
	jne next_x_masina415
	je desenare_masina4_600_y
	desenare_masina4_600_y:
	make_masina_4 600,coordonata_y_masina4
	jmp desenare_masina_3
	next_x_masina415:
	
	desenare_masina_3:
	cmp coordonata_x_masina3,0
	jne next_x_masina3
	je desenare_masina3_0_y
	desenare_masina3_0_y:
	make_masina_3 0,coordonata_y_masina3
	jmp desenare_masina_2
	next_x_masina3:
	
	cmp coordonata_x_masina3,40
	jne next_x_masina31
	je desenare_masina3_40_y
	desenare_masina3_40_y:
	make_masina_3 40,coordonata_y_masina3
	jmp desenare_masina_2
	next_x_masina31:
	
	cmp coordonata_x_masina3,80
	jne next_x_masina32
	je desenare_masina3_80_y
	desenare_masina3_80_y:
	make_masina_3 80,coordonata_y_masina3
	jmp desenare_masina_2
	next_x_masina32:
	
	cmp coordonata_x_masina3,120
	jne next_x_masina33
	je desenare_masina3_120_y
	desenare_masina3_120_y:
	make_masina_3 120,coordonata_y_masina3
	jmp desenare_masina_2
	next_x_masina33:
	
	cmp coordonata_x_masina3,160
	jne next_x_masina34
	je desenare_masina3_160_y
	desenare_masina3_160_y:
	make_masina_3 160,coordonata_y_masina3
	jmp desenare_masina_2
	next_x_masina34:
	
	cmp coordonata_x_masina3,200
	jne next_x_masina35
	je desenare_masina3_200_y
	desenare_masina3_200_y:
	make_masina_3 200,coordonata_y_masina3
	jmp desenare_masina_2
	next_x_masina35:
	
	cmp coordonata_x_masina3,240
	jne next_x_masina36
	je desenare_masina3_240_y
	desenare_masina3_240_y:
	make_masina_3 240,coordonata_y_masina3
	jmp desenare_masina_2
	next_x_masina36:
	
	cmp coordonata_x_masina3,280
	jne next_x_masina37
	je desenare_masina3_280_y
	desenare_masina3_280_y:
	make_masina_3 280,coordonata_y_masina3
	jmp desenare_masina_2
	next_x_masina37:
	
	cmp coordonata_x_masina3,320
	jne next_x_masina38
	je desenare_masina3_320_y
	desenare_masina3_320_y:
	make_masina_3 320,coordonata_y_masina3
	jmp desenare_masina_2
	next_x_masina38:
	
	cmp coordonata_x_masina3,360
	jne next_x_masina39
	je desenare_masina3_360_y
	desenare_masina3_360_y:
	make_masina_3 360,coordonata_y_masina3
	jmp desenare_masina_2
	next_x_masina39:
	
	cmp coordonata_x_masina3,400
	jne next_x_masina310
	je desenare_masina3_400_y
	desenare_masina3_400_y:
	make_masina_3 400,coordonata_y_masina3
	jmp desenare_masina_2
	next_x_masina310:
	
	cmp coordonata_x_masina3,440
	jne next_x_masina311
	je desenare_masina3_440_y
	desenare_masina3_440_y:
	make_masina_3 440,coordonata_y_masina3
	jmp desenare_masina_2
	next_x_masina311:
	
	cmp coordonata_x_masina3,480
	jne next_x_masina312
	je desenare_masina3_480_y
	desenare_masina3_480_y:
	make_masina_3 480,coordonata_y_masina3
	jmp desenare_masina_2
	next_x_masina312:
	
	cmp coordonata_x_masina3,520
	jne next_x_masina313
	je desenare_masina3_520_y
	desenare_masina3_520_y:
	make_masina_3 520,coordonata_y_masina3
	jmp desenare_masina_2
	next_x_masina313:
	
	
	cmp coordonata_x_masina3,560
	jne next_x_masina314
	je desenare_masina3_560_y
	desenare_masina3_560_y:
	make_masina_3 560,coordonata_y_masina3
	jmp desenare_masina_2
	next_x_masina314:
	
	cmp coordonata_x_masina3,600
	jne next_x_masina315
	je desenare_masina3_600_y
	desenare_masina3_600_y:
	make_masina_3 600,coordonata_y_masina3
	jmp desenare_masina_2
	next_x_masina315:
	
	desenare_masina_2:
	cmp coordonata_x_masina2,0
	jne next_x_masina2
	je desenare_masina2_0_y
	desenare_masina2_0_y:
	make_masina_2 0,coordonata_y_masina2
	jmp desenare_masina_1
	next_x_masina2:
	
	cmp coordonata_x_masina2,40
	jne next_x_masina21
	je desenare_masina2_40_y
	desenare_masina2_40_y:
	make_masina_2 40,coordonata_y_masina2
	jmp desenare_masina_1
	next_x_masina21:
	
	cmp coordonata_x_masina2,80
	jne next_x_masina22
	je desenare_masina2_80_y
	desenare_masina2_80_y:
	make_masina_2 80,coordonata_y_masina2
	jmp desenare_masina_1
	next_x_masina22:
	
	cmp coordonata_x_masina2,120
	jne next_x_masina23
	je desenare_masina2_120_y
	desenare_masina2_120_y:
	make_masina_2 120,coordonata_y_masina2
	jmp desenare_masina_1
	next_x_masina23:
	
	cmp coordonata_x_masina2,160
	jne next_x_masina24
	je desenare_masina2_160_y
	desenare_masina2_160_y:
	make_masina_2 160,coordonata_y_masina2
	jmp desenare_masina_1
	next_x_masina24:
	
	cmp coordonata_x_masina2,200
	jne next_x_masina25
	je desenare_masina2_200_y
	desenare_masina2_200_y:
	make_masina_2 200,coordonata_y_masina2
	jmp desenare_masina_1
	next_x_masina25:
	
	cmp coordonata_x_masina2,240
	jne next_x_masina26
	je desenare_masina2_240_y
	desenare_masina2_240_y:
	make_masina_2 240,coordonata_y_masina2
	jmp desenare_masina_1
	next_x_masina26:
	
	cmp coordonata_x_masina2,280
	jne next_x_masina27
	je desenare_masina2_280_y
	desenare_masina2_280_y:
	make_masina_2 280,coordonata_y_masina2
	jmp desenare_masina_1
	next_x_masina27:
	
	cmp coordonata_x_masina2,320
	jne next_x_masina28
	je desenare_masina2_320_y
	desenare_masina2_320_y:
	make_masina_2 320,coordonata_y_masina2
	jmp desenare_masina_1
	next_x_masina28:
	
	cmp coordonata_x_masina2,360
	jne next_x_masina29
	je desenare_masina2_360_y
	desenare_masina2_360_y:
	make_masina_2 360,coordonata_y_masina2
	jmp desenare_masina_1
	next_x_masina29:
	
	cmp coordonata_x_masina2,400
	jne next_x_masina210
	je desenare_masina2_400_y
	desenare_masina2_400_y:
	make_masina_2 400,coordonata_y_masina2
	jmp desenare_masina_1
	next_x_masina210:
	
	cmp coordonata_x_masina2,440
	jne next_x_masina211
	je desenare_masina2_440_y
	desenare_masina2_440_y:
	make_masina_2 440,coordonata_y_masina2
	jmp desenare_masina_1
	next_x_masina211:
	
	cmp coordonata_x_masina2,480
	jne next_x_masina212
	je desenare_masina2_480_y
	desenare_masina2_480_y:
	make_masina_2 480,coordonata_y_masina2
	jmp desenare_masina_1
	next_x_masina212:
	
	cmp coordonata_x_masina2,520
	jne next_x_masina213
	je desenare_masina2_520_y
	desenare_masina2_520_y:
	make_masina_2 520,coordonata_y_masina2
	jmp desenare_masina_1
	next_x_masina213:
	
	
	cmp coordonata_x_masina2,560
	jne next_x_masina214
	je desenare_masina2_560_y
	desenare_masina2_560_y:
	make_masina_2 560,coordonata_y_masina2
	jmp desenare_masina_1
	next_x_masina214:
	
	cmp coordonata_x_masina2,600
	jne next_x_masina215
	je desenare_masina2_600_y
	desenare_masina2_600_y:
	make_masina_2 600,coordonata_y_masina2
	jmp desenare_masina_1
	next_x_masina215:
	
	desenare_masina_1:
	cmp coordonata_x_masina1,0
	jne next_x_masina1
	je desenare_masina_0_y
	desenare_masina_0_y:
	make_masina_1 0,coordonata_y_masina1
	jmp desenare_broasca
	next_x_masina1:
	
	cmp coordonata_x_masina1,40
	jne next_x_masina11
	je desenare_masina_40_y
	desenare_masina_40_y:
	make_masina_1 40,coordonata_y_masina1
	jmp desenare_broasca
	next_x_masina11:
	
	cmp coordonata_x_masina1,80
	jne next_x_masina12
	je desenare_masina_80_y
	desenare_masina_80_y:
	make_masina_1 80,coordonata_y_masina1
	jmp desenare_broasca
	next_x_masina12:
	
	cmp coordonata_x_masina1,120
	jne next_x_masina13
	je desenare_masina_120_y
	desenare_masina_120_y:
	make_masina_1 120,coordonata_y_masina1
	jmp desenare_broasca
	next_x_masina13:
	
	cmp coordonata_x_masina1,160
	jne next_x_masina14
	je desenare_masina_160_y
	desenare_masina_160_y:
	make_masina_1 160,coordonata_y_masina1
	jmp desenare_broasca
	next_x_masina14:
	
	cmp coordonata_x_masina1,200
	jne next_x_masina15
	je desenare_masina_200_y
	desenare_masina_200_y:
	make_masina_1 200,coordonata_y_masina1
	jmp desenare_broasca
	next_x_masina15:
	
	cmp coordonata_x_masina1,240
	jne next_x_masina16
	je desenare_masina_240_y
	desenare_masina_240_y:
	make_masina_1 240,coordonata_y_masina1
	jmp desenare_broasca
	next_x_masina16:
	
	cmp coordonata_x_masina1,280
	jne next_x_masina17
	je desenare_masina_280_y
	desenare_masina_280_y:
	make_masina_1 280,coordonata_y_masina1
	jmp desenare_broasca
	next_x_masina17:
	
	cmp coordonata_x_masina1,320
	jne next_x_masina18
	je desenare_masina_320_y
	desenare_masina_320_y:
	make_masina_1 320,coordonata_y_masina1
	jmp desenare_broasca
	next_x_masina18:
	
	cmp coordonata_x_masina1,360
	jne next_x_masina19
	je desenare_masina_360_y
	desenare_masina_360_y:
	make_masina_1 360,coordonata_y_masina1
	jmp desenare_broasca
	next_x_masina19:
	
	cmp coordonata_x_masina1,400
	jne next_x_masina110
	je desenare_masina_400_y
	desenare_masina_400_y:
	make_masina_1 400,coordonata_y_masina1
	jmp desenare_broasca
	next_x_masina110:
	
	cmp coordonata_x_masina1,440
	jne next_x_masina111
	je desenare_masina_440_y
	desenare_masina_440_y:
	make_masina_1 440,coordonata_y_masina1
	jmp desenare_broasca
	next_x_masina111:
	
	cmp coordonata_x_masina1,480
	jne next_x_masina112
	je desenare_masina_480_y
	desenare_masina_480_y:
	make_masina_1 480,coordonata_y_masina1
	jmp desenare_broasca
	next_x_masina112:
	
	cmp coordonata_x_masina1,520
	jne next_x_masina113
	je desenare_masina_520_y
	desenare_masina_520_y:
	make_masina_1 520,coordonata_y_masina1
	jmp desenare_broasca
	next_x_masina113:
	
	
	cmp coordonata_x_masina1,560
	jne next_x_masina114
	je desenare_masina_560_y
	desenare_masina_560_y:
	make_masina_1 560,coordonata_y_masina1
	jmp desenare_broasca
	next_x_masina114:
	
	cmp coordonata_x_masina1,600
	jne next_x_masina115
	je desenare_masina_600_y
	desenare_masina_600_y:
	make_masina_1 600,coordonata_y_masina1
	jmp desenare_broasca
	next_x_masina115:
	
	desenare_broasca:
	cmp coordonata_x_broasca,0
	je mai_departe_x_0
	jne next_x
	mai_departe_x_0:
	cmp coordonata_y_broasca,40
	je desenare_broasca_0_40
	jne next_Y
	desenare_broasca_0_40:
	make_broasca 0,40
	mov eax,scor
	add eax,100
	mov scor,eax
	mov coordonata_x_broasca,320
	mov coordonata_y_broasca,440
	jmp afisare_litere
	next_Y:
	cmp coordonata_y_broasca,80
	je desenare_broasca_0_80
	jne next_Y_1
	desenare_broasca_0_80:
	make_broasca 0,80
	jmp afisare_litere
	next_Y_1:
	cmp coordonata_y_broasca,120
	je desenare_broasca_0_120
	jne next_Y_2
	desenare_broasca_0_120:
	make_broasca 0,120
	jmp afisare_litere
	next_Y_2:
	cmp coordonata_y_broasca,160
	je desenare_broasca_0_160
	jne next_Y_3
	desenare_broasca_0_160:
	make_broasca 0,160
	jmp afisare_litere
	next_Y_3:
	cmp coordonata_y_broasca,200
	je desenare_broasca_0_200
	jne next_Y_4
	desenare_broasca_0_200:
	make_broasca 0,200
	jmp afisare_litere
	next_Y_4:
	cmp coordonata_y_broasca,240
	je desenare_broasca_0_240
	jne next_Y_5
	desenare_broasca_0_240:
	make_broasca 0,240
	jmp afisare_litere
	next_Y_5:
	cmp coordonata_y_broasca,280
	je desenare_broasca_0_280
	jne next_Y_6
	desenare_broasca_0_280:
	make_broasca 0,280
	jmp afisare_litere
	next_Y_6:
	cmp coordonata_y_broasca,320
	je desenare_broasca_0_320
	jne next_Y_7
	desenare_broasca_0_320:
	make_broasca 0,320
	jmp afisare_litere
	next_Y_7:
	cmp coordonata_y_broasca,360
	je desenare_broasca_0_360
	jne next_Y_8
	desenare_broasca_0_360:
	make_broasca 0,360
	jmp afisare_litere
	next_Y_8:
	cmp coordonata_y_broasca,400
	je desenare_broasca_0_400
	jne next_Y_9
	desenare_broasca_0_400:
	make_broasca 0,400
	jmp afisare_litere
	next_Y_9:
	cmp coordonata_y_broasca,440
	je desenare_broasca_0_440
	jne next_Y_10
	desenare_broasca_0_440:
	make_broasca 0,440
	jmp afisare_litere
	next_Y_10:
	
	
	
	
	next_x:
	cmp coordonata_x_broasca,40
	je mai_departe_x_40
	jne next_x_1
	mai_departe_x_40:
	cmp coordonata_y_broasca,40
	je desenare_broasca_40_40
	jne next_Y_11
	desenare_broasca_40_40:
	make_broasca 40,40
	mov eax,scor
	add eax,100
	mov scor,eax
	mov coordonata_x_broasca,320
	mov coordonata_y_broasca,440
	jmp afisare_litere
	next_Y_11:
	cmp coordonata_y_broasca,80
	je desenare_broasca_40_80
	jne next_Y_12
	desenare_broasca_40_80:
	make_broasca 40,80
	jmp afisare_litere
	next_Y_12:
	cmp coordonata_y_broasca,120
	je desenare_broasca_40_120
	jne next_Y_13
	desenare_broasca_40_120:
	make_broasca 40,120
	jmp afisare_litere
	next_Y_13:
	cmp coordonata_y_broasca,160
	je desenare_broasca_40_160
	jne next_Y_14
	desenare_broasca_40_160:
	make_broasca 40,160
	jmp afisare_litere
	next_Y_14:
	cmp coordonata_y_broasca,200
	je desenare_broasca_40_200
	jne next_Y_15
	desenare_broasca_40_200:
	make_broasca 40,200
	jmp afisare_litere
	next_Y_15:
	cmp coordonata_y_broasca,240
	je desenare_broasca_40_240
	jne next_Y_16
	desenare_broasca_40_240:
	make_broasca 40,240
	jmp afisare_litere
	next_Y_16:
	cmp coordonata_y_broasca,280
	je desenare_broasca_40_280
	jne next_Y_17
	desenare_broasca_40_280:
	make_broasca 40,280
	jmp afisare_litere
	next_Y_17:
	cmp coordonata_y_broasca,320
	je desenare_broasca_40_320
	jne next_Y_18
	desenare_broasca_40_320:
	make_broasca 40,320
	jmp afisare_litere
	next_Y_18:
	cmp coordonata_y_broasca,360
	je desenare_broasca_40_360
	jne next_Y_19
	desenare_broasca_40_360:
	make_broasca 40,360
	jmp afisare_litere
	next_Y_19:
	cmp coordonata_y_broasca,400
	je desenare_broasca_40_400
	jne next_Y_20
	desenare_broasca_40_400:
	make_broasca 40,400
	jmp afisare_litere
	next_Y_20:
	cmp coordonata_y_broasca,440
	je desenare_broasca_40_440
	jne next_x_1
	desenare_broasca_40_440:
	make_broasca 40,440
	jmp afisare_litere
	
	
	next_x_1:
	cmp coordonata_x_broasca,80
	je mai_departe_x_80
	jne next_x_2
	mai_departe_x_80:
	cmp coordonata_y_broasca,40
	je desenare_broasca_80_40
	jne next_Y_21
	desenare_broasca_80_40:
	make_broasca 80,40
	mov eax,scor
	add eax,100
	mov scor,eax
	mov coordonata_x_broasca,320
	mov coordonata_y_broasca,440
	jmp afisare_litere
	next_Y_21:
	cmp coordonata_y_broasca,80
	je desenare_broasca_80_80
	jne next_Y_22
	desenare_broasca_80_80:
	make_broasca 80,80
	jmp afisare_litere
	next_Y_22:
	cmp coordonata_y_broasca,120
	je desenare_broasca_80_120
	jne next_Y_23
	desenare_broasca_80_120:
	make_broasca 80,120
	jmp afisare_litere
	next_Y_23:
	cmp coordonata_y_broasca,160
	je desenare_broasca_80_160
	jne next_Y_24
	desenare_broasca_80_160:
	make_broasca 80,160
	jmp afisare_litere
	next_Y_24:
	cmp coordonata_y_broasca,200
	je desenare_broasca_80_200
	jne next_Y_25
	desenare_broasca_80_200:
	make_broasca 80,200
	jmp afisare_litere
	next_Y_25:
	cmp coordonata_y_broasca,240
	je desenare_broasca_80_240
	jne next_Y_26
	desenare_broasca_80_240:
	make_broasca 80,240
	jmp afisare_litere
	next_Y_26:
	cmp coordonata_y_broasca,280
	je desenare_broasca_80_280
	jne next_Y_27
	desenare_broasca_80_280:
	make_broasca 80,280
	jmp afisare_litere
	next_Y_27:
	cmp coordonata_y_broasca,320
	je desenare_broasca_80_320
	jne next_Y_28
	desenare_broasca_80_320:
	make_broasca 80,320
	jmp afisare_litere
	next_Y_28:
	cmp coordonata_y_broasca,360
	je desenare_broasca_80_360
	jne next_Y_29
	desenare_broasca_80_360:
	make_broasca 80,360
	jmp afisare_litere
	next_Y_29:
	cmp coordonata_y_broasca,400
	je desenare_broasca_80_400
	jne next_Y_30
	desenare_broasca_80_400:
	make_broasca 80,400
	jmp afisare_litere
	next_Y_30:
	cmp coordonata_y_broasca,440
	je desenare_broasca_80_440
	jne next_x_2
	desenare_broasca_80_440:
	make_broasca 80,440
	jmp afisare_litere
	
	
	next_x_2:
	cmp coordonata_x_broasca,120
	je mai_departe_x_120
	jne next_x_3
	mai_departe_x_120:
	cmp coordonata_y_broasca,40
	je desenare_broasca_120_40
	jne next_Y_31
	desenare_broasca_120_40:
	make_broasca 120,40
	mov eax,scor
	add eax,100
	mov scor,eax
	mov coordonata_x_broasca,320
	mov coordonata_y_broasca,440
	jmp afisare_litere
	next_Y_31:
	cmp coordonata_y_broasca,80
	je desenare_broasca_120_80
	jne next_Y_32
	desenare_broasca_120_80:
	make_broasca 120,80
	jmp afisare_litere
	next_Y_32:
	cmp coordonata_y_broasca,120
	je desenare_broasca_120_120
	jne next_Y_33
	desenare_broasca_120_120:
	make_broasca 120,120
	jmp afisare_litere
	next_Y_33:
	cmp coordonata_y_broasca,160
	je desenare_broasca_120_160
	jne next_Y_34
	desenare_broasca_120_160:
	make_broasca 120,160
	jmp afisare_litere
	next_Y_34:
	cmp coordonata_y_broasca,200
	je desenare_broasca_120_200
	jne next_Y_35
	desenare_broasca_120_200:
	make_broasca 120,200
	jmp afisare_litere
	next_Y_35:
	cmp coordonata_y_broasca,240
	je desenare_broasca_120_240
	jne next_Y_36
	desenare_broasca_120_240:
	make_broasca 120,240
	jmp afisare_litere
	next_Y_36:
	cmp coordonata_y_broasca,280
	je desenare_broasca_120_280
	jne next_Y_37
	desenare_broasca_120_280:
	make_broasca 120,280
	jmp afisare_litere
	next_Y_37:
	cmp coordonata_y_broasca,320
	je desenare_broasca_120_320
	jne next_Y_38
	desenare_broasca_120_320:
	make_broasca 120,320
	jmp afisare_litere
	next_Y_38:
	cmp coordonata_y_broasca,360
	je desenare_broasca_120_360
	jne next_Y_39
	desenare_broasca_120_360:
	make_broasca 120,360
	jmp afisare_litere
	next_Y_39:
	cmp coordonata_y_broasca,400
	je desenare_broasca_120_400
	jne next_Y_40
	desenare_broasca_120_400:
	make_broasca 120,400
	jmp afisare_litere
	next_Y_40:
	cmp coordonata_y_broasca,440
	je desenare_broasca_120_440
	jne next_x_3
	desenare_broasca_120_440:
	make_broasca 120,440
	jmp afisare_litere
	
	next_x_3:
	
	
		cmp coordonata_x_broasca,160
	je mai_departe_x_160
	jne next_x_4
	mai_departe_x_160:
	cmp coordonata_y_broasca,40
	je desenare_broasca_160_40
	jne next_Y_41
	desenare_broasca_160_40:
	make_broasca 160,40
	mov eax,scor
	add eax,100
	mov scor,eax
	mov coordonata_x_broasca,320
	mov coordonata_y_broasca,440
	jmp afisare_litere
	next_Y_41:
	cmp coordonata_y_broasca,80
	je desenare_broasca_160_80
	jne next_Y_42
	desenare_broasca_160_80:
	make_broasca 160,80
	jmp afisare_litere
	next_Y_42:
	cmp coordonata_y_broasca,120
	je desenare_broasca_160_120
	jne next_Y_43
	desenare_broasca_160_120:
	make_broasca 160,120
	jmp afisare_litere
	next_Y_43:
	cmp coordonata_y_broasca,160
	je desenare_broasca_160_160
	jne next_Y_44
	desenare_broasca_160_160:
	make_broasca 160,160
	jmp afisare_litere
	next_Y_44:
	cmp coordonata_y_broasca,200
	je desenare_broasca_160_200
	jne next_Y_45
	desenare_broasca_160_200:
	make_broasca 160,200
	jmp afisare_litere
	next_Y_45:
	cmp coordonata_y_broasca,240
	je desenare_broasca_160_240
	jne next_Y_46
	desenare_broasca_160_240:
	make_broasca 160,240
	jmp afisare_litere
	next_Y_46:
	cmp coordonata_y_broasca,280
	je desenare_broasca_160_280
	jne next_Y_47
	desenare_broasca_160_280:
	make_broasca 160,280
	jmp afisare_litere
	next_Y_47:
	cmp coordonata_y_broasca,320
	je desenare_broasca_160_320
	jne next_Y_48
	desenare_broasca_160_320:
	make_broasca 160,320
	jmp afisare_litere
	next_Y_48:
	cmp coordonata_y_broasca,360
	je desenare_broasca_160_360
	jne next_Y_49
	desenare_broasca_160_360:
	make_broasca 160,360
	jmp afisare_litere
	next_Y_49:
	cmp coordonata_y_broasca,400
	je desenare_broasca_160_400
	jne next_Y_50
	desenare_broasca_160_400:
	make_broasca 160,400
	jmp afisare_litere
	next_Y_50:
	cmp coordonata_y_broasca,440
	je desenare_broasca_160_440
	jne next_x_4
	desenare_broasca_160_440:
	make_broasca 160,440
	jmp afisare_litere
	
	
	
	next_x_4:

	cmp coordonata_x_broasca,200
	je mai_departe_x_200
	jne next_x_5
	mai_departe_x_200:
	cmp coordonata_y_broasca,40
	je desenare_broasca_200_40
	jne next_Y_51
	desenare_broasca_200_40:
	make_broasca 200,40
	mov eax,scor
	add eax,100
	mov scor,eax
	mov coordonata_x_broasca,320
	mov coordonata_y_broasca,440
	jmp afisare_litere
	next_Y_51:
	cmp coordonata_y_broasca,80
	je desenare_broasca_200_80
	jne next_Y_52
	desenare_broasca_200_80:
	make_broasca 200,80
	jmp afisare_litere
	next_Y_52:
	cmp coordonata_y_broasca,120
	je desenare_broasca_200_120
	jne next_Y_53
	desenare_broasca_200_120:
	make_broasca 200,120
	jmp afisare_litere
	next_Y_53:
	cmp coordonata_y_broasca,160
	je desenare_broasca_200_160
	jne next_Y_54
	desenare_broasca_200_160:
	make_broasca 200,160
	jmp afisare_litere
	next_Y_54:
	cmp coordonata_y_broasca,200
	je desenare_broasca_200_200
	jne next_Y_55
	desenare_broasca_200_200:
	make_broasca 200,200
	jmp afisare_litere
	next_Y_55:
	cmp coordonata_y_broasca,240
	je desenare_broasca_200_240
	jne next_Y_56
	desenare_broasca_200_240:
	make_broasca 200,240
	jmp afisare_litere
	next_Y_56:
	cmp coordonata_y_broasca,280
	je desenare_broasca_200_280
	jne next_Y_57
	desenare_broasca_200_280:
	make_broasca 200,280
	jmp afisare_litere
	next_Y_57:
	cmp coordonata_y_broasca,320
	je desenare_broasca_200_320
	jne next_Y_58
	desenare_broasca_200_320:
	make_broasca 200,320
	jmp afisare_litere
	next_Y_58:
	cmp coordonata_y_broasca,360
	je desenare_broasca_200_360
	jne next_Y_59
	desenare_broasca_200_360:
	make_broasca 200,360
	jmp afisare_litere
	next_Y_59:
	cmp coordonata_y_broasca,400
	je desenare_broasca_200_400
	jne next_Y_60
	desenare_broasca_200_400:
	make_broasca 200,400
	jmp afisare_litere
	next_Y_60:
	cmp coordonata_y_broasca,440
	je desenare_broasca_200_440
	jne next_x_5
	desenare_broasca_200_440:
	make_broasca 200,440
	jmp afisare_litere
	
	
	
	
	next_x_5:
	
	cmp coordonata_x_broasca,240
	je mai_departe_x_240
	jne next_x_6
	mai_departe_x_240:
	cmp coordonata_y_broasca,40
	je desenare_broasca_240_40
	jne next_Y_61
	desenare_broasca_240_40:
	make_broasca 240,40
	mov eax,scor
	add eax,100
	mov scor,eax
	mov coordonata_x_broasca,320
	mov coordonata_y_broasca,440
	jmp afisare_litere
	next_Y_61:
	cmp coordonata_y_broasca,80
	je desenare_broasca_240_80
	jne next_Y_62
	desenare_broasca_240_80:
	make_broasca 240,80
	jmp afisare_litere
	next_Y_62:
	cmp coordonata_y_broasca,120
	je desenare_broasca_240_120
	jne next_Y_63
	desenare_broasca_240_120:
	make_broasca 240,120
	jmp afisare_litere
	next_Y_63:
	cmp coordonata_y_broasca,160
	je desenare_broasca_240_160
	jne next_Y_64
	desenare_broasca_240_160:
	make_broasca 240,160
	jmp afisare_litere
	next_Y_64:
	cmp coordonata_y_broasca,200
	je desenare_broasca_240_200
	jne next_Y_65
	desenare_broasca_240_200:
	make_broasca 240,200
	jmp afisare_litere
	next_Y_65:
	cmp coordonata_y_broasca,240
	je desenare_broasca_240_240
	jne next_Y_66
	desenare_broasca_240_240:
	make_broasca 240,240
	jmp afisare_litere
	next_Y_66:
	cmp coordonata_y_broasca,280
	je desenare_broasca_240_280
	jne next_Y_67
	desenare_broasca_240_280:
	make_broasca 240,280
	jmp afisare_litere
	next_Y_67:
	cmp coordonata_y_broasca,320
	je desenare_broasca_240_320
	jne next_Y_68
	desenare_broasca_240_320:
	make_broasca 240,320
	jmp afisare_litere
	next_Y_68:
	cmp coordonata_y_broasca,360
	je desenare_broasca_240_360
	jne next_Y_69
	desenare_broasca_240_360:
	make_broasca 240,360
	jmp afisare_litere
	next_Y_69:
	cmp coordonata_y_broasca,400
	je desenare_broasca_240_400
	jne next_Y_70
	desenare_broasca_240_400:
	make_broasca 240,400
	jmp afisare_litere
	next_Y_70:
	cmp coordonata_y_broasca,440
	je desenare_broasca_240_440
	jne next_x_6
	desenare_broasca_240_440:
	make_broasca 240,440
	jmp afisare_litere
	
	
	
	next_x_6:
	cmp coordonata_x_broasca,280
	je mai_departe_x_280
	jne next_x_7
	mai_departe_x_280:
	cmp coordonata_y_broasca,40
	je desenare_broasca_280_40
	jne next_Y_71
	desenare_broasca_280_40:
	make_broasca 280,40
	mov eax,scor
	add eax,100
	mov scor,eax
	mov coordonata_x_broasca,320
	mov coordonata_y_broasca,440
	jmp afisare_litere
	next_Y_71:
	cmp coordonata_y_broasca,80
	je desenare_broasca_280_80
	jne next_Y_72
	desenare_broasca_280_80:
	make_broasca 280,80
	jmp afisare_litere
	next_Y_72:
	cmp coordonata_y_broasca,120
	je desenare_broasca_280_120
	jne next_Y_73
	desenare_broasca_280_120:
	make_broasca 280,120
	jmp afisare_litere
	next_Y_73:
	cmp coordonata_y_broasca,160
	je desenare_broasca_280_160
	jne next_Y_74
	desenare_broasca_280_160:
	make_broasca 280,160
	jmp afisare_litere
	next_Y_74:
	cmp coordonata_y_broasca,200
	je desenare_broasca_280_200
	jne next_Y_75
	desenare_broasca_280_200:
	make_broasca 280,200
	jmp afisare_litere
	next_Y_75:
	cmp coordonata_y_broasca,240
	je desenare_broasca_280_240
	jne next_Y_76
	desenare_broasca_280_240:
	make_broasca 280,240
	jmp afisare_litere
	next_Y_76:
	cmp coordonata_y_broasca,280
	je desenare_broasca_280_280
	jne next_Y_77
	desenare_broasca_280_280:
	make_broasca 280,280
	jmp afisare_litere
	next_Y_77:
	cmp coordonata_y_broasca,320
	je desenare_broasca_280_320
	jne next_Y_78
	desenare_broasca_280_320:
	make_broasca 280,320
	jmp afisare_litere
	next_Y_78:
	cmp coordonata_y_broasca,360
	je desenare_broasca_280_360
	jne next_Y_79
	desenare_broasca_280_360:
	make_broasca 280,360
	jmp afisare_litere
	next_Y_79:
	cmp coordonata_y_broasca,400
	je desenare_broasca_280_400
	jne next_Y_80
	desenare_broasca_280_400:
	make_broasca 280,400
	jmp afisare_litere
	next_Y_80:
	cmp coordonata_y_broasca,440
	je desenare_broasca_280_440
	jne next_x_7
	desenare_broasca_280_440:
	make_broasca 280,440
	jmp afisare_litere
	
	
	
	
	next_x_7:
	cmp coordonata_x_broasca,320
	je mai_departe_x_320
	jne next_x_8
	mai_departe_x_320:
	cmp coordonata_y_broasca,40
	je desenare_broasca_320_40
	jne next_Y_81
	desenare_broasca_320_40:
	make_broasca 320,40
	mov eax,scor
	add eax,100
	mov scor,eax
	mov coordonata_x_broasca,320
	mov coordonata_y_broasca,440
	jmp afisare_litere
	next_Y_81:
	cmp coordonata_y_broasca,80
	je desenare_broasca_320_80
	jne next_Y_82
	desenare_broasca_320_80:
	make_broasca 320,80
	jmp afisare_litere
	next_Y_82:
	cmp coordonata_y_broasca,120
	je desenare_broasca_320_120
	jne next_Y_83
	desenare_broasca_320_120:
	make_broasca 320,120
	jmp afisare_litere
	next_Y_83:
	cmp coordonata_y_broasca,160
	je desenare_broasca_320_160
	jne next_Y_84
	desenare_broasca_320_160:
	make_broasca 320,160
	jmp afisare_litere
	next_Y_84:
	cmp coordonata_y_broasca,200
	je desenare_broasca_320_200
	jne next_Y_85
	desenare_broasca_320_200:
	make_broasca 320,200
	jmp afisare_litere
	next_Y_85:
	cmp coordonata_y_broasca,240
	je desenare_broasca_320_240
	jne next_Y_86
	desenare_broasca_320_240:
	make_broasca 320,240
	jmp afisare_litere
	next_Y_86:
	cmp coordonata_y_broasca,280
	je desenare_broasca_320_280
	jne next_Y_87
	desenare_broasca_320_280:
	make_broasca 320,280
	jmp afisare_litere
	next_Y_87:
	cmp coordonata_y_broasca,320
	je desenare_broasca_320_320
	jne next_Y_88
	desenare_broasca_320_320:
	make_broasca 320,320
	jmp afisare_litere
	next_Y_88:
	cmp coordonata_y_broasca,360
	je desenare_broasca_320_360
	jne next_Y_89
	desenare_broasca_320_360:
	make_broasca 320,360
	jmp afisare_litere
	next_Y_89:
	cmp coordonata_y_broasca,400
	je desenare_broasca_320_400
	jne next_Y_90
	desenare_broasca_320_400:
	make_broasca 320,400
	jmp afisare_litere
	next_Y_90:
	cmp coordonata_y_broasca,440
	je desenare_broasca_320_440
	jne next_x_8
	desenare_broasca_320_440:
	make_broasca 320,440
	jmp afisare_litere
	
	
	next_x_8:		
	cmp coordonata_x_broasca,360
	je mai_departe_x_360
	jne next_x_9
	mai_departe_x_360:
	cmp coordonata_y_broasca,40
	je desenare_broasca_360_40
	jne next_Y_91
	desenare_broasca_360_40:
	make_broasca 360,40
	mov eax,scor
	add eax,100
	mov scor,eax
	mov coordonata_x_broasca,320
	mov coordonata_y_broasca,440
	jmp afisare_litere
	next_Y_91:
	cmp coordonata_y_broasca,80
	je desenare_broasca_360_80
	jne next_Y_92
	desenare_broasca_360_80:
	make_broasca 360,80
	jmp afisare_litere
	next_Y_92:
	cmp coordonata_y_broasca,120
	je desenare_broasca_360_120
	jne next_Y_93
	desenare_broasca_360_120:
	make_broasca 360,120
	jmp afisare_litere
	next_Y_93:
	cmp coordonata_y_broasca,160
	je desenare_broasca_360_160
	jne next_Y_94
	desenare_broasca_360_160:
	make_broasca 360,160
	jmp afisare_litere
	next_Y_94:
	cmp coordonata_y_broasca,200
	je desenare_broasca_360_200
	jne next_Y_95
	desenare_broasca_360_200:
	make_broasca 360,200
	jmp afisare_litere
	next_Y_95:
	cmp coordonata_y_broasca,240
	je desenare_broasca_360_240
	jne next_Y_96
	desenare_broasca_360_240:
	make_broasca 360,240
	jmp afisare_litere
	next_Y_96:
	cmp coordonata_y_broasca,280
	je desenare_broasca_360_280
	jne next_Y_97
	desenare_broasca_360_280:
	make_broasca 360,280
	jmp afisare_litere
	next_Y_97:
	cmp coordonata_y_broasca,320
	je desenare_broasca_360_320
	jne next_Y_98
	desenare_broasca_360_320:
	make_broasca 360,320
	jmp afisare_litere
	next_Y_98:
	cmp coordonata_y_broasca,360
	je desenare_broasca_360_360
	jne next_Y_99
	desenare_broasca_360_360:
	make_broasca 360,360
	jmp afisare_litere
	next_Y_99:
	cmp coordonata_y_broasca,400
	je desenare_broasca_360_400
	jne next_Y_100
	desenare_broasca_360_400:
	make_broasca 360,400
	jmp afisare_litere
	next_Y_100:
	cmp coordonata_y_broasca,440
	je desenare_broasca_360_440
	jne next_x_9
	desenare_broasca_360_440:
	make_broasca 360,440
	jmp afisare_litere
	
	
	
	
	next_x_9:
	cmp coordonata_x_broasca,400
	je mai_departe_x_400
	jne next_x_10
	mai_departe_x_400:
	cmp coordonata_y_broasca,40
	je desenare_broasca_400_40
	jne next_Y_101
	desenare_broasca_400_40:
	make_broasca 400,40
	mov eax,scor
	add eax,100
	mov scor,eax
	mov coordonata_x_broasca,320
	mov coordonata_y_broasca,440
	jmp afisare_litere
	next_Y_101:
	cmp coordonata_y_broasca,80
	je desenare_broasca_400_80
	jne next_Y_102
	desenare_broasca_400_80:
	make_broasca 400,80
	jmp afisare_litere
	next_Y_102:
	cmp coordonata_y_broasca,120
	je desenare_broasca_400_120
	jne next_Y_103
	desenare_broasca_400_120:
	make_broasca 400,120
	jmp afisare_litere
	next_Y_103:
	cmp coordonata_y_broasca,160
	je desenare_broasca_400_160
	jne next_Y_104
	desenare_broasca_400_160:
	make_broasca 400,160
	jmp afisare_litere
	next_Y_104:
	cmp coordonata_y_broasca,200
	je desenare_broasca_400_200
	jne next_Y_105
	desenare_broasca_400_200:
	make_broasca 400,200
	jmp afisare_litere
	next_Y_105:
	cmp coordonata_y_broasca,240
	je desenare_broasca_400_240
	jne next_Y_106
	desenare_broasca_400_240:
	make_broasca 400,240
	jmp afisare_litere
	next_Y_106:
	cmp coordonata_y_broasca,280
	je desenare_broasca_400_280
	jne next_Y_107
	desenare_broasca_400_280:
	make_broasca 400,280
	jmp afisare_litere
	next_Y_107:
	cmp coordonata_y_broasca,320
	je desenare_broasca_400_320
	jne next_Y_108
	desenare_broasca_400_320:
	make_broasca 400,320
	jmp afisare_litere
	next_Y_108:
	cmp coordonata_y_broasca,360
	je desenare_broasca_400_360
	jne next_Y_109
	desenare_broasca_400_360:
	make_broasca 400,360
	jmp afisare_litere
	next_Y_109:
	cmp coordonata_y_broasca,400
	je desenare_broasca_400_400
	jne next_Y_110
	desenare_broasca_400_400:
	make_broasca 400,400
	jmp afisare_litere
	next_Y_110:
	cmp coordonata_y_broasca,440
	je desenare_broasca_400_440
	jne next_x_10
	desenare_broasca_400_440:
	make_broasca 400,440
	jmp afisare_litere
	
	
	
	
	next_x_10:
		cmp coordonata_x_broasca,440
	je mai_departe_x_440
	jne next_x_11
	mai_departe_x_440:
	cmp coordonata_y_broasca,40
	je desenare_broasca_440_40
	jne next_Y_111
	desenare_broasca_440_40:
	make_broasca 440,40
	mov eax,scor
	add eax,100
	mov scor,eax
	mov coordonata_x_broasca,320
	mov coordonata_y_broasca,440
	jmp afisare_litere
	next_Y_111:
	cmp coordonata_y_broasca,80
	je desenare_broasca_440_80
	jne next_Y_112
	desenare_broasca_440_80:
	make_broasca 440,80
	jmp afisare_litere
	next_Y_112:
	cmp coordonata_y_broasca,120
	je desenare_broasca_440_120
	jne next_Y_113
	desenare_broasca_440_120:
	make_broasca 440,120
	jmp afisare_litere
	next_Y_113:
	cmp coordonata_y_broasca,160
	je desenare_broasca_440_160
	jne next_Y_114
	desenare_broasca_440_160:
	make_broasca 440,160
	jmp afisare_litere
	next_Y_114:
	cmp coordonata_y_broasca,200
	je desenare_broasca_440_200
	jne next_Y_115
	desenare_broasca_440_200:
	make_broasca 440,200
	jmp afisare_litere
	next_Y_115:
	cmp coordonata_y_broasca,240
	je desenare_broasca_440_240
	jne next_Y_116
	desenare_broasca_440_240:
	make_broasca 440,240
	jmp afisare_litere
	next_Y_116:
	cmp coordonata_y_broasca,280
	je desenare_broasca_440_280
	jne next_Y_117
	desenare_broasca_440_280:
	make_broasca 440,280
	jmp afisare_litere
	next_Y_117:
	cmp coordonata_y_broasca,320
	je desenare_broasca_440_320
	jne next_Y_118
	desenare_broasca_440_320:
	make_broasca 440,320
	jmp afisare_litere
	next_Y_118:
	cmp coordonata_y_broasca,360
	je desenare_broasca_440_360
	jne next_Y_119
	desenare_broasca_440_360:
	make_broasca 440,360
	jmp afisare_litere
	next_Y_119:
	cmp coordonata_y_broasca,400
	je desenare_broasca_440_400
	jne next_Y_120
	desenare_broasca_440_400:
	make_broasca 440,400
	jmp afisare_litere
	next_Y_120:
	cmp coordonata_y_broasca,440
	je desenare_broasca_440_440
	jne next_x_11
	desenare_broasca_440_440:
	make_broasca 440,440
	jmp afisare_litere
	
	
	
	next_x_11:
		cmp coordonata_x_broasca,480
	je mai_departe_x_480
	jne next_x_12
	mai_departe_x_480:
	cmp coordonata_y_broasca,40
	je desenare_broasca_480_40
	jne next_Y_121
	desenare_broasca_480_40:
	make_broasca 480,40
	mov eax,scor
	add eax,100
	mov scor,eax
	mov coordonata_x_broasca,320
	mov coordonata_y_broasca,440
	jmp afisare_litere
	next_Y_121:
	cmp coordonata_y_broasca,80
	je desenare_broasca_480_80
	jne next_Y_122
	desenare_broasca_480_80:
	make_broasca 480,80
	jmp afisare_litere
	next_Y_122:
	cmp coordonata_y_broasca,120
	je desenare_broasca_480_120
	jne next_Y_123
	desenare_broasca_480_120:
	make_broasca 480,120
	jmp afisare_litere
	next_Y_123:
	cmp coordonata_y_broasca,160
	je desenare_broasca_480_160
	jne next_Y_124
	desenare_broasca_480_160:
	make_broasca 480,160
	jmp afisare_litere
	next_Y_124:
	cmp coordonata_y_broasca,200
	je desenare_broasca_480_200
	jne next_Y_125
	desenare_broasca_480_200:
	make_broasca 480,200
	jmp afisare_litere
	next_Y_125:
	cmp coordonata_y_broasca,240
	je desenare_broasca_480_240
	jne next_Y_126
	desenare_broasca_480_240:
	make_broasca 480,240
	jmp afisare_litere
	next_Y_126:
	cmp coordonata_y_broasca,280
	je desenare_broasca_480_280
	jne next_Y_127
	desenare_broasca_480_280:
	make_broasca 480,280
	jmp afisare_litere
	next_Y_127:
	cmp coordonata_y_broasca,320
	je desenare_broasca_480_320
	jne next_Y_128
	desenare_broasca_480_320:
	make_broasca 480,320
	jmp afisare_litere
	next_Y_128:
	cmp coordonata_y_broasca,360
	je desenare_broasca_480_360
	jne next_Y_129
	desenare_broasca_480_360:
	make_broasca 480,360
	jmp afisare_litere
	next_Y_129:
	cmp coordonata_y_broasca,400
	je desenare_broasca_480_400
	jne next_Y_130
	desenare_broasca_480_400:
	make_broasca 480,400
	jmp afisare_litere
	next_Y_130:
	cmp coordonata_y_broasca,440
	je desenare_broasca_480_440
	jne next_x_12
	desenare_broasca_480_440:
	make_broasca 480,440
	jmp afisare_litere
	
	
	next_x_12:
			cmp coordonata_x_broasca,520
	je mai_departe_x_520
	jne next_x_13
	mai_departe_x_520:
	cmp coordonata_y_broasca,40
	je desenare_broasca_520_40
	jne next_Y_131
	desenare_broasca_520_40:
	make_broasca 520,40
	mov eax,scor
	add eax,100
	mov scor,eax
	mov coordonata_x_broasca,320
	mov coordonata_y_broasca,440
	jmp afisare_litere
	next_Y_131:
	cmp coordonata_y_broasca,80
	je desenare_broasca_520_80
	jne next_Y_132
	desenare_broasca_520_80:
	make_broasca 520,80
	jmp afisare_litere
	next_Y_132:
	cmp coordonata_y_broasca,120
	je desenare_broasca_520_120
	jne next_Y_133
	desenare_broasca_520_120:
	make_broasca 520,120
	jmp afisare_litere
	next_Y_133:
	cmp coordonata_y_broasca,160
	je desenare_broasca_520_160
	jne next_Y_134
	desenare_broasca_520_160:
	make_broasca 520,160
	jmp afisare_litere
	next_Y_134:
	cmp coordonata_y_broasca,200
	je desenare_broasca_520_200
	jne next_Y_135
	desenare_broasca_520_200:
	make_broasca 520,200
	jmp afisare_litere
	next_Y_135:
	cmp coordonata_y_broasca,240
	je desenare_broasca_520_240
	jne next_Y_136
	desenare_broasca_520_240:
	make_broasca 520,240
	jmp afisare_litere
	next_Y_136:
	cmp coordonata_y_broasca,280
	je desenare_broasca_520_280
	jne next_Y_137
	desenare_broasca_520_280:
	make_broasca 520,280
	jmp afisare_litere
	next_Y_137:
	cmp coordonata_y_broasca,320
	je desenare_broasca_520_320
	jne next_Y_138
	desenare_broasca_520_320:
	make_broasca 520,320
	jmp afisare_litere
	next_Y_138:
	cmp coordonata_y_broasca,360
	je desenare_broasca_520_360
	jne next_Y_139
	desenare_broasca_520_360:
	make_broasca 520,360
	jmp afisare_litere
	next_Y_139:
	cmp coordonata_y_broasca,400
	je desenare_broasca_520_400
	jne next_Y_140
	desenare_broasca_520_400:
	make_broasca 520,400
	jmp afisare_litere
	next_Y_140:
	cmp coordonata_y_broasca,440
	je desenare_broasca_520_440
	jne next_x_13
	desenare_broasca_520_440:
	make_broasca 520,440
	jmp afisare_litere



	next_x_13:
			cmp coordonata_x_broasca,560
	je mai_departe_x_560
	jne next_x_14
	mai_departe_x_560:
	cmp coordonata_y_broasca,40
	je desenare_broasca_560_40
	jne next_Y_141
	desenare_broasca_560_40:
	make_broasca 560,40
	mov eax,scor
	add eax,100
	mov scor,eax
	mov coordonata_x_broasca,320
	mov coordonata_y_broasca,440
	jmp afisare_litere
	next_Y_141:
	cmp coordonata_y_broasca,80
	je desenare_broasca_560_80
	jne next_Y_142
	desenare_broasca_560_80:
	make_broasca 560,80
	jmp afisare_litere
	next_Y_142:
	cmp coordonata_y_broasca,120
	je desenare_broasca_560_120
	jne next_Y_143
	desenare_broasca_560_120:
	make_broasca 560,120
	jmp afisare_litere
	next_Y_143:
	cmp coordonata_y_broasca,160
	je desenare_broasca_560_160
	jne next_Y_144
	desenare_broasca_560_160:
	make_broasca 560,160
	jmp afisare_litere
	next_Y_144:
	cmp coordonata_y_broasca,200
	je desenare_broasca_560_200
	jne next_Y_145
	desenare_broasca_560_200:
	make_broasca 560,200
	jmp afisare_litere
	next_Y_145:
	cmp coordonata_y_broasca,240
	je desenare_broasca_560_240
	jne next_Y_146
	desenare_broasca_560_240:
	make_broasca 560,240
	jmp afisare_litere
	next_Y_146:
	cmp coordonata_y_broasca,280
	je desenare_broasca_560_280
	jne next_Y_147
	desenare_broasca_560_280:
	make_broasca 560,280
	jmp afisare_litere
	next_Y_147:
	cmp coordonata_y_broasca,320
	je desenare_broasca_560_320
	jne next_Y_148
	desenare_broasca_560_320:
	make_broasca 560,320
	jmp afisare_litere
	next_Y_148:
	cmp coordonata_y_broasca,360
	je desenare_broasca_560_360
	jne next_Y_149
	desenare_broasca_560_360:
	make_broasca 560,360
	jmp afisare_litere
	next_Y_149:
	cmp coordonata_y_broasca,400
	je desenare_broasca_560_400
	jne next_Y_150
	desenare_broasca_560_400:
	make_broasca 560,400
	jmp afisare_litere
	next_Y_150:
	cmp coordonata_y_broasca,440
	je desenare_broasca_560_440
	jne next_x_14
	desenare_broasca_560_440:
	make_broasca 560,440
	jmp afisare_litere
	
	
	next_x_14:	
				cmp coordonata_x_broasca,600
	je mai_departe_x_600
	jne next_x_15
	mai_departe_x_600:
	cmp coordonata_y_broasca,40
	je desenare_broasca_600_40
	jne next_Y_151
	desenare_broasca_600_40:
	make_broasca 600,40
	mov eax,scor
	add eax,100
	mov scor,eax
	mov coordonata_x_broasca,320
	mov coordonata_y_broasca,440
	jmp afisare_litere
	next_Y_151:
	cmp coordonata_y_broasca,80
	je desenare_broasca_600_80
	jne next_Y_152
	desenare_broasca_600_80:
	make_broasca 600,80
	jmp afisare_litere
	next_Y_152:
	cmp coordonata_y_broasca,120
	je desenare_broasca_600_120
	jne next_Y_153
	desenare_broasca_600_120:
	make_broasca 600,120
	jmp afisare_litere
	next_Y_153:
	cmp coordonata_y_broasca,160
	je desenare_broasca_600_160
	jne next_Y_154
	desenare_broasca_600_160:
	make_broasca 600,160
	jmp afisare_litere
	next_Y_154:
	cmp coordonata_y_broasca,200
	je desenare_broasca_600_200
	jne next_Y_155
	desenare_broasca_600_200:
	make_broasca 600,200
	jmp afisare_litere
	next_Y_155:
	cmp coordonata_y_broasca,240
	je desenare_broasca_600_240
	jne next_Y_156
	desenare_broasca_600_240:
	make_broasca 600,240
	jmp afisare_litere
	next_Y_156:
	cmp coordonata_y_broasca,280
	je desenare_broasca_600_280
	jne next_Y_157
	desenare_broasca_600_280:
	make_broasca 600,280
	jmp afisare_litere
	next_Y_157:
	cmp coordonata_y_broasca,320
	je desenare_broasca_600_320
	jne next_Y_158
	desenare_broasca_600_320:
	make_broasca 600,320
	jmp afisare_litere
	next_Y_158:
	cmp coordonata_y_broasca,360
	je desenare_broasca_600_360
	jne next_Y_159
	desenare_broasca_600_360:
	make_broasca 600,360
	jmp afisare_litere
	next_Y_159:
	cmp coordonata_y_broasca,400
	je desenare_broasca_600_400
	jne next_Y_160
	desenare_broasca_600_400:
	make_broasca 600,400
	jmp afisare_litere
	next_Y_160:
	cmp coordonata_y_broasca,440
	je desenare_broasca_600_440
	jne next_x_15
	desenare_broasca_600_440:
	make_broasca 600,440
	jmp afisare_litere
	next_x_15:
		
	jmp afisare_litere
	
afisare_litere:
;afisam valoarea cuiburilor ocupate 
	mov ebx, 10
	mov eax, broaste_in_cuib
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 420, 10

	;afisam valoarea counter-ului curent (sute, zeci si unitati)
	mov ebx, 10
	mov eax, counter
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 80, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 70, 10
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 60, 10	
		;afisam valoarea scor-ului curent (mii ,sute, zeci si unitati)
	mov ebx, 10
	mov eax, scor
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 190, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 200, 10
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 210, 10
	;cifra miilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 220, 10
	
	
	;scriem un mesaj
	make_text_macro 'S', area, 140, 10
	make_text_macro 'C', area, 150, 10
	make_text_macro 'O', area, 160, 10
	make_text_macro 'R', area, 170, 10
	
	make_text_macro 'T', area, 10, 10
	make_text_macro 'I', area, 20, 10
	make_text_macro 'M', area, 30, 10
	make_text_macro 'P', area, 40, 10
	
	make_text_macro 'C', area, 260, 10
	make_text_macro 'U', area, 270, 10
	make_text_macro 'I', area, 280, 10
	make_text_macro 'B', area, 290, 10
	make_text_macro 'U', area, 300, 10
	make_text_macro 'R', area, 310, 10
	make_text_macro 'I', area, 320, 10
	make_text_macro 'O', area, 340, 10
	make_text_macro 'C', area, 350, 10
	make_text_macro 'U', area, 360, 10
	make_text_macro 'P', area, 370, 10
	make_text_macro 'A', area, 380, 10
	make_text_macro 'T', area, 390, 10
	make_text_macro 'E', area, 400, 10
	
	make_text_macro 'V', area, 510, 10
	make_text_macro 'I', area, 520, 10
	make_text_macro 'E', area, 530, 10
	make_text_macro 'T', area, 540, 10
	make_text_macro 'I', area, 550, 10
		;afisam vietile
	mov ebx, 10
	mov eax, vieti
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 570, 10
	; make_text_macro 'L', area, 130, 120
	; make_text_macro 'A', area, 140, 120
	
	; make_text_macro 'A', area, 100, 140
	; make_text_macro 'S', area, 110, 140
	; make_text_macro 'A', area, 120, 140
	; make_text_macro 'M', area, 130, 140
	; make_text_macro 'B', area, 140, 140
	; make_text_macro 'L', area, 150, 140
	; make_text_macro 'A', area, 160, 140
	; make_text_macro 'R', area, 170, 140
	; make_text_macro 'E', area, 180, 140
sfarsit_joc:
final_draw:
	popa
	mov esp, ebp
	pop ebp
	ret
draw endp

start:
	;alocam memorie pentru zona de desenat
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	call malloc
	add esp, 4
	mov area, eax
	;apelam functia de desenare a ferestrei
	; typedef void (*DrawFunc)(int evt, int x, int y);
	; void __cdecl BeginDrawing(const char *title, int width, int height, unsigned int *area, DrawFunc draw);
	push offset draw
	push area
	push area_height
	push area_width
	push offset window_title
	call BeginDrawing
	add esp, 20
	
	;terminarea programului
	push 0
	call exit
end start

 line_horizontal macro x,y,len,color
   local bucla_linie
	mov eax,y
	 mov ebx,area_width
	 mul ebx
	 add eax,x
	 shl eax,2
	 add eax,area
	 mov ecx,len
	 bucla_linie:
	 mov dword ptr[eax],color
	 add eax,4
	  loop bucla_linie
 endm
 
  line_vertical macro x,y,len,color
   local bucla_linie
	mov eax,y
	 mov ebx,area_width
	 mul ebx
	 add eax,x
	 shl eax,2
	 add eax,area
	 mov ecx,len
	 bucla_linie:
	 mov dword ptr[eax],color
	 add eax, area_width*4
	  loop bucla_linie
 endm
 
; un macro ca sa apelam mai usor desenarea simbolului
make_text_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text
	add esp, 16
endm



; functia de desenare - se apeleaza la fiecare click
; sau la fiecare interval de 200ms in care nu s-a dat click
; arg1 - evt (0 - initializare, 1 - click, 2 - s-a scurs intervalul fara click)
; arg2 - x
; arg3 - y

draw proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1]
	cmp eax, 1
	jz evt_click
	cmp eax, 2
	jz evt_timer ; nu s-a efectuat click pe nimic
	;mai jos e codul care intializeaza fereastra cu pixeli albi
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 255
	push area
	call memset
	add esp, 12
	
	
	
	;mov eax,40
	; desenare_baza:
	;line_horizontal 0,eax, 640,0FF00h
	; cmp eax,80
	; je sf_desenare_baza
	; add eax,1
	; loop desenare_baza
	; sf_desenare_baza:
	
	
	
	
evt_click:
	; mov eax,0
	; mov eax,area_width
	; mov ebx,[ebp+arg3]
	; mul ebx
	; add eax,[ebp+arg2]
	; shl eax,2
	; add eax,area
	; mov dword ptr [eax],0FF0000h
	; mov dword ptr [eax+4],0FF0000h
	; mov dword ptr [eax-4],0FF0000h
	; mov dword ptr [eax+4*area_width],0FF0000h
	; mov dword ptr [eax-4*area_width],0FF0000h
	; jmp afisare_litere
	 ; line_horizontal 0,34 , 640,0FF0000h
	; line_horizontal 0,35 , 640,0FF0000h
	; line_horizontal 0,36 , 640,0FF0000h
	; line_horizontal 0,37 , 640,0FF0000h
	; line_horizontal 0,38 , 640,0FF0000h
	; line_horizontal 0,39 , 640,0FF0000h
	 ;jmp afisare_litere
evt_timer:
	inc counter
	
afisare_litere:
	
	
	;scriem un mesaj
	; make_text_macro 'P', area, 110, 100
	; make_text_macro 'R', area, 120, 100
	; make_text_macro 'O', area, 130, 100
	; make_text_macro 'I', area, 140, 100
	; make_text_macro 'E', area, 150, 100
	; make_text_macro 'C', area, 160, 100
	; make_text_macro 'T', area, 170, 100
	
	; make_text_macro 'L', area, 130, 120
	; make_text_macro 'A', area, 140, 120
	
	; make_text_macro 'A', area, 100, 140
	; make_text_macro 'S', area, 110, 140
	; make_text_macro 'A', area, 120, 140
	; make_text_macro 'M', area, 130, 140
	; make_text_macro 'B', area, 140, 140
	; make_text_macro 'L', area, 150, 140
	; make_text_macro 'A', area, 160, 140
	; make_text_macro 'R', area, 170, 140
	; make_text_macro 'E', area, 180, 140

final_draw:
	popa
	mov esp, ebp
	pop ebp
	ret
draw endp

start:
	;alocam memorie pentru zona de desenat
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	call malloc
	add esp, 4
	mov area, eax
	;apelam functia de desenare a ferestrei
	; typedef void (*DrawFunc)(int evt, int x, int y);
	; void __cdecl BeginDrawing(const char *title, int width, int height, unsigned int *area, DrawFunc draw);
	push offset draw
	push area
	push area_height
	push area_width
	push offset window_title
	call BeginDrawing
	add esp, 20
	
	;terminarea programului
	push 0
	call exit
end start