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

counter DD 0 ; numara evenimentele de tip timer
scor DD 0 ; nmemoreaza scorul
vieti dd 3;,memoreaza nr de vieti ramase
coordonata_x_broasca dd 320
coordonata_y_broasca dd 40

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
	line_horizontal x,y, 40,000FF00h
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
; arg1 - evt (0 - initializare, 1 - move_up , 2 - - timer , 3 - move_right 4 - move_down, 5 - move_left  ,6 - nu mai avem vieti,7 - ajungem_in_cuib , 8 - Cadem_in_apa, 9 -ne_loveste_masina , 10 -  ajungem_cu_busteanul_la_marginea_ecranului, 11 - sarim_pe_crocodil ,12 - umplemcuiburile) 
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
	
	
	
	
	jmp afisare_litere
	
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
	 jmp afisare_litere
evt_timer:
	inc counter
	
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
	line_horizontal 0,440, 25600,000FF00h
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
	add eax,110
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
	jmp afisare_litere
	
afisare_litere:
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
	make_text_macro edx, area, 350, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 340, 10
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 330, 10
	;cifra miilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 320, 10
	
	
	;scriem un mesaj
	make_text_macro 'S', area, 270, 10
	make_text_macro 'C', area, 280, 10
	make_text_macro 'O', area, 290, 10
	make_text_macro 'R', area, 300, 10
	
	make_text_macro 'T', area, 10, 10
	make_text_macro 'I', area, 20, 10
	make_text_macro 'M', area, 30, 10
	make_text_macro 'P', area, 40, 10
	
	make_text_macro 'V', area, 510, 10
	make_text_macro 'I', area, 520, 10
	make_text_macro 'E', area, 530, 10
	make_text_macro 'T', area, 540, 10
	make_text_macro 'I', area, 550, 10
	
	
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