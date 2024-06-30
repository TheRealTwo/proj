extern printf

section .rodata
    fmt db "%s", 10, 0
    st db "EFLAGS: ", 0

section .data
    n dd 0
    buf_p dd buf

section .bss
    buf resd 32

section .text
global main
main:
    push ebp
    mov ebp, esp
    
    and esp, -16
    sub esp, 16
    
    mov dword [esp], st
    call printf
    
    
    xor eax, eax
    add eax, 1; to set some flags to zero
    pushfd
    pop eax
    mov ebx, eax
    
wr_buf:
    cmp dword [n], 32
    je exit
    inc dword [n]
    mov ecx, ebx
    shr ecx, 31; ecx >> 31
    mov edx, dword [buf_p]
    mov byte [edx], cl
    add byte [edx], '0'
    inc dword [buf_p]; (*buf_p)++
    shl ebx, 1; ebx << 1
    jmp wr_buf

exit:
    mov dword [esp + 4], buf
    mov dword [esp], fmt
    call printf
    
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
