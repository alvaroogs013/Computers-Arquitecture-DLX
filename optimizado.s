.data
;; VARIABLES DE ENTRADA Y SALIDA: NO MODIFICAR ORDEN
; VARIABLE DE ENTRADA: (SE PODRA MODIFICAR EL VALOR ENTRE 1 Y 100)
valor_inicial: .word 3
;; VARIABLES DE SALIDA:
secuencia: .space 120*4
secuencia_tamanho: .word 0
secuencia_maximo: .word 0
secuencia_valor_medio: .float 0
lista: .space 9*4
lista_valor_medio: .float 0
;; FIN VARIABLES DE ENTRADA Y SALIDA

	.text
	.global main

main:	
	lw	r1, valor_inicial 
	lw	r4, valor_inicial
	addi	r2, r0, #1 ;; cargar el numero 1 en r2
	and	r7, r1, r2 ;; primer par/impar
	addi	r10, r0, #2 
	addi	r11, r0, #3
	

bucle:
	sw	secuencia(r6), r4;; guardar valor en secuencia
	addi	r5, r5, #1 ;;sumar 1 al tamanho
	addi	r6, r6, #4 ;; tamanho de de word

	
	sgt	r9, r8, r4
	
	bnez	r9, et1
	addi	r8,r4,#0

et1:
	add	r20,r20,r4
	
	
	and	r7, r4, r2 ;; ver si es par o impar
	beqz	r7, par
	jal	impar


par:
	div	r4, r4, r10
	jal 	bucle

impar:
	
	sub	r3, r4, r2 ;; comprobar si secuencia=1
	

	mult	r4, r4, r11
	addi	r4, r4, #1
	
	
	bnez	r3, bucle


	

	sw	secuencia_tamanho, r5
	sw	secuencia_maximo, r8
	
	movi2fp	f21, r20
	cvti2f	f21, f21
	movi2fp f22, r5
	cvti2f	f22, f22

	divf	f20, f21, f22
	sf	secuencia_valor_medio, f20

	mult	r21, r1, r5 ;;vIni*vT
	movi2fp	f4, r21
	cvti2f	f4, f4
	sf	lista, f4
	add	r30, r30, r4

	mult	r22, r8, r5 ;;vMax*vT
	movi2fp	f5, r22
	cvti2f	f5, f5
	sf	lista(r30), f5
	add	r30, r30, r4

	multf	f10, f20, f22 ;;vMed*vT
	sf	lista(r30), f10
	add	r30, r30, r4
	
	movi2fp	f23, r1
	cvti2f	f23, f23

	movi2fp	f24, r8
	cvti2f	f24, f24
		
 	divf	f11, f23, f24 ;;(vIni/vMax)*vT
	multf	f12, f11, f22
	sf	lista(r30), f12
	add	r30, r30, r4

	addf	f25, f4, f5 ;;(vIni*vT) + (vMax*vT)

	divf	f13, f23, f20 ;;(vIni/vMed)*vT
	multf	f14, f13, f22
	sf	lista(r30), f14
	add	r30, r30, r4

	addf	f25, f25, f10 ;; + vMed*vT
	addf	f25, f25, f12 ;; + (vIni/vMax)*vT

	divf	f15, f24, f23;; (vMax/vIni)*vT
	multf	f16, f15, f22
	sf	lista(r30), f16
	add	r30, r30, r4

	addf	f25, f25, f14 ;; + (vIni/vMed)*vT
	

	divf	f17, f24, f20 ;;(vMax/vMed)*vT
	multf	f18, f17, f22
	sf	lista(r30), f18
	add	r30, r30, r4

	addf	f25, f25, f16 ;; + (vMax/vIni)*vT

	
	divf	f26, f20, f23 ;;(vMed/vIni)*vT
	multf	f27, f26, f22
	sf	lista(r30), f27
	add	r30, r30, r4

	addf	f25, f25, f18 ;; + (vMax/vMed)*vT
	addi	r29, r0, #9
	movi2fp	f9, r29
	cvti2f	f9, f9

	divf	f28, f20, f24 ;;(vMed/vMax)*vT
	multf	f29, f28, f22
	sf	lista(r30), f29
	add	r30, r30, r4

	addf	f25, f25, f27 ;; + (vMed/vIni)*vT
	addf	f25, f25, f29 ;; + (vMed/vMax)*vT


	divf	f19, f25, f9
	sf	lista_valor_medio, f19

	trap	0