section .text
	global _start

print_num:
  push rbx
  mov rsi,print_buf
  add rsi,63
  mov rcx,10
  mov [rsi],cl
  mov rbx,1
print_digit:
  inc rbx
  dec rsi
  mov rdx,0
  mov rcx,10
  div rcx
  mov cl,[rdx+hex]
  mov [rsi],cl
  test rax,rax
  jnz print_digit
  mov rax,1
  mov rdi,1
  mov rdx,rbx
  syscall
  pop rbx
  ret

count_occurrences:
  push rbx
  mov rbx,rax
  mov rdx,0
count_next:
  mov rcx,rbx
  and rcx,0xF
  mov rax,1
  shl rcx,2
  shl rax,cl
  add rdx,rax
  shr rbx,4
  jnz count_next
  mov rax,rdx
  pop rbx
  ret

index_of:
  mov rcx,16
  repne scasb
  mov rax,15
  sub rax,rcx
  ret

parse_input:
  push rbx
  mov rbx,0
  mov rsi,buffer
  mov rdx,0
parse_input_cards:
  mov al,[rsi]
  test al,al
  jz parse_input_end
  cmp al,0x20
  jnz parse_input_card
  call add_type
  mov [rbx*4+hands],edx
  mov rdx, 0
  jmp parse_input_bid
parse_input_card:
  mov rdi,cards
  call index_of
  shl rdx,4
  add rdx,rax
  inc rsi
  jmp parse_input_cards
parse_input_bid:
  inc rsi
  mov al,[rsi]
  test al,al
  jz parse_input_eof
  cmp al,0x0a
  jnz parse_input_digit
parse_input_eof:
  mov [rbx*4+bids],edx
  inc rbx
  inc rsi
  mov rdx, 0
  jmp parse_input_cards
parse_input_digit:
  mov rdi,hex
  call index_of
  imul rdx,rdx,10
  add rdx,rax
  jmp parse_input_bid
parse_input_end:
  mov rax,rbx
  pop rbx
  ret

add_type:
  mov rax,rdx
  push rdx
  call count_occurrences
  call count_occurrences
  pop rdx
  and rax,0xFFFFF0
  not rax
  test rax,0x100000
  jz hand_type_five
  test rax,0x10000
  jz hand_type_four
  test rax,0x1100
  jz hand_type_house
  test rax,0x1000
  jz hand_type_three
  test rax,0x200
  jz hand_type_twopair
  test rax,0x100
  jz hand_type_onepair
  jmp add_type_exit
hand_type_five:
  add rdx,0x100000
hand_type_four:
  add rdx,0x100000
hand_type_house:
  add rdx,0x100000
hand_type_three:
  add rdx,0x100000
hand_type_twopair:
  add rdx,0x100000
hand_type_onepair:
  add rdx,0x100000
add_type_exit:
  ret

sort_hands:
  push rbx
  mov rcx,1
sort_outer:
  mov rdx,rcx
sort_inner:
  test rdx,rdx
  jz sort_outer_next
  mov edi,[rdx*4+hands]
  mov esi,[rdx*4+hands-4]
  cmp esi,edi
  jle sort_outer_next
  mov eax,[rdx*4+bids]
  mov ebx,[rdx*4+bids-4]
  mov [rdx*4+bids],ebx
  mov [rdx*4+bids-4],eax
  mov [rdx*4+hands],esi
  mov [rdx*4+hands-4],edi
  dec rdx
  jmp sort_inner
sort_outer_next:
  inc rcx
  cmp rcx,[num_hands]
  jnz sort_outer
  pop rbx
  ret

calc_result:
  mov rax,0
  mov rcx,0
calc_next:
  inc rcx
  mov edx,[rcx*4+bids-4]
  imul rdx,rcx
  add rax,rdx
  cmp rcx,[num_hands]
  jnz calc_next
  ret

_start:
	mov rax,0
	mov rdi,0
	mov rsi,buffer
	mov rdx,65536
	syscall
	
	call parse_input
	mov [num_hands],rax
	
	call sort_hands
	
	call calc_result
	
	call print_num
	
	mov rax,60
	mov rdi,0
	syscall

section .data
  hex: db "0123456789abcdef"
  cards: db "XY23456789TJQKA"

section .bss
  num_hands: resq 1
  buffer: resb 65536
  hands: resd 1024
  bids: resd 1024
  print_buf: resb 64
