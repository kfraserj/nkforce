
.text
.global  set_tod_from_secs

## ENTRY POINT FOR REQUIRED FUNCTION
set_tod_from_secs:
        ## assembly instructions here;
        # The function takes two arguments ;
        # an int which will be in register edi = time_of_day_sec;
        # a pointer which will be in rsi = tod_t *tod;

        start:
          .cfi_startproc
          cmpl	$86400, %edi    # check if it's a valid time;
          ja	invalid_time      # jump to invalid_time;
          cmpl	$43199, %edi    # check if it's less than 43200;
          jg	larger_than_43200 # jump to larger_than_43200;
          cmpl	$3599, %edi     # check if it's less than 3600;
          jg	larger_than_3600  # jump to larger_than_3600;
                                # it's 12:00 AM ~ 12:59 AM;
          movw $12, 0(%rsi)     # tod -> hours = 12;
          movl %edi, %eax       # put %edi into %eax, %eax is the dividend;
          movl $60, %ecx        # put 60 into %ecx, %ecx is the divisor;
          cqto       # set %edx to zero to avoid overflow;
          idivl %ecx            # divide %eax by %ecx;
          movw %ax, 2(%rsi)    # %ax is the quotient;  tod->minutes = ?;
          movw %dx, 4(%rsi)    # %dx is the remainder; tod->seconds = ?;
          movb $0,   6(%rsi)    # it's AM; tod -> ispm = 0;
          movl $0, %eax         # want to return 0 to show the success;
        	ret                   # return

        invalid_time:
          movl	$1, %eax        # want to return 1 to show the failure;
          ret                   # return;
          .cfi_endproc

        larger_than_43200:          # it's 12:00 PM ~ 11:59 PM
          cmpl  $46800, %edi        # decide if it's 1:00 PM ~
          jg    equal_86400         # jump to equal_86400;
                                    # it's 12:00 PM ~ 12:59 PM;
          movw $12,0(%rsi)          # tod -> hours   = 12;
          movl %edi, %eax           # put %edi into %eax, %eax is the dividend
          subl $43200, %eax         # subtract %eax by 43200
          movl $60, %ecx            # put 60 into %ecx, %ecx is the divisor;
          xor  %edx, %edx           # set %edx to zero to avoid overflow;
          idivl %ecx                # divide %eax by %ecx;
          movw %ax, 2(%rsi)        # %ax is the quotient;  tod->minutes = ?;
          movw %dx, 4(%rsi)        # %dx is the remainder; tod->seconds = ?;
          movb $1,   6(%rsi)        # it's PM; tod -> ispm = 1;
          movl $0, %eax             # want to return 0 to show the success;
        	ret                       # return;


        larger_than_3600:           # it's 1:00 AM ~ 11:59 AM;
          xor  %edx, %edx           # set %edx to zero to avoid overflow;
          movl %edi, %eax           # put %edi into %eax, %eax is the dividend;
          movl $60, %ecx            # put 60 into %ecx, %ecx is the divisor;
          movl $3600, %r8d          # put 3600 into %r9d, %r8d is the divisor;
          idivl %r8d                # divide %eax by %r8d;
          movw %ax, 0(%rsi)        # %ax is the quotient; tod->hours = ?;
          movl %edx, %eax           # put %edx into %eax, %eax is the dividend;
          xor  %edx, %edx           # set %edx to zero to avoid overflow;
          idivl %ecx                # divide %eax by %ecx;
          movw %ax, 2(%rsi)        # %ax is the quotient;  tod->minutes = ?;
          movw %dx, 4(%rsi)        # %dx is the remainder; tod->seconds = ?;
          movb $0,   6(%rsi)        # it's AM; tod -> ispm = 0;
          movl $0, %eax             # want to return 0 to show the success;
        	ret                       # return;

        equal_86400:                # it's 12:00 AM
          cmpl $86400, %edi         # decide if it's 86400;
          jne larger_than_46800     # jump to larger_than_46800;
          movw $12,0(%rsi)          # tod -> hours   = 12;
          movw $0, 2(%rsi)          # tod -> minutes = 0;
          movw $0, 4(%rsi)          # tod -> seconds = 0;
          movb $0, 6(%rsi)          # tod -> ispm    = 0;
          movl $0, %eax             # want to return 0 to show the success;
        	ret                       # return;

        larger_than_46800:          # it's 1:00 PM ~ 11:59 PM;
          xor  %edx, %edx           # set %edx to zero to avoid overflow;
          movl %edi, %eax           # put %edi into %eax, %eax is the dividend;
          movl $60, %ecx            # put 60 into %ecx, %ecx is the divisor;
          movl $3600, %r8d          # put 3600 into %r8d, %r8d is the divisor;
          idivl %r8d                # divide %eax by %ecx;
          subl $12, %eax            # (time_of_day_sec / 3600) - 12;
          movw %ax, 0(%rsi)        # %ax is the quotient; tod->hours = ?;
          movl %edx, %eax           # put %edx into %eax, %eax is the dividend;
          xor  %edx, %edx           # set %edx to zero to avoid overflow;
          idivl %ecx                # divide %eax by %ecx;
          movw %ax, 2(%rsi)        # %ax is the quotient;  tod->minutes = ?;
          movw %dx, 4(%rsi)        # %dx is the remainder; tod->seconds = ?;
          movb $1,   6(%rsi)        # it's PM; tod -> ispm = 0;
          movl $0, %eax             # want to return 0 to show the success;
          ret                       # return;


### Data area associated with the next function
.data

blank:
        .int 0b00000000000000000000000000000000

pm:
        .int 0b00100000000000000000000000000000

am:
        .int 0b00010000000000000000000000000000

mask:                       # declare multiple ints in a row
        .int 0b0111111
        .int 0b0000110
        .int 0b1011011
        .int 0b1001111
        .int 0b1100110
        .int 0b1101101
        .int 0b1111101
        .int 0b0000111
        .int 0b1111111
        .int 0b1101111

.text
.global  set_display_bits_from_tod

## ENTRY POINT FOR REQUIRED FUNCTION
set_display_bits_from_tod:
        ## assembly instructions here
        # a packed tod_t struct in rdi
        # an integer pointer in rsi
        start2:
        .cfi_startproc
        push %rbx               # going to be used as a dividen
        push %rbp               # going to be used as a pointer for mask array
        push %r12               # going to be used for finding right element in the mask array

        movw %di, %r8w          # put tod.hours into %r8w
        sarq $16 , %rdi         # shift to right by 16
        movw %di, %r10w         # put tod.minutes into %r10w
        sarq $32 , %rdi         # shift to right by 16
        movb %dil, %cl          # put tod.ispm into %cl

        cmpw $12, %r8w          # see if %rdi gives us a valid time
        jg invalid_time2        # jump to invalid_time2
        cmpw $60, %r10w         # see if %rdi gives us a valid time
        jg invalid_time2        # jump to invalid_time2

        movzwl %r8w, %r8d       # extend 16-bit register to 32-bit
        movzwl %r10w, %r10d     # extend 16-bit register to 32-bit
        movzbl %cl , %ecx       # extend 8-bit  register to 32-bit

        # determine min_ones, min_tens, hr_ones here
        xor  %rdx, %rdx         # set %rdx to zero to avoid overflow
        movq %r10 , %rax        # put %r10 into %rax; %rax is the dividend
        movq $10 , %rbx         # put   10 into %rbx; %rbx is the divisor
        idivq %rbx              # divide

        # use mask to find min_ones
        leaq mask(%rip),%rbp    # put the address of mask into %rbp; %rbp now it the pointer
        movl (%rbp, %rdx, 4), %r10d   # %r10d = array[%rdx]; the min_ones
        # determine min_tens
        movl (%rbp, %rax, 4), %r11d   # %r11d = array[%rax]; the min_tens
        sall $7, %r11d          # shift %r11d to left by 7

        cmpl $10, %r8d          # see if the hours is less than 10
        jl hrs_less_than_10     # jump to hrs_less_than_10

        # determine hr_ones
        xor  %rdx, %rdx         # set %rdx to zero to avoid overflow
        movq %r8,  %rax         # put %r8 into %rax; %rax is the dividend
        movq $10,  %rbx         # put  10 into %rbx; %rbx is the divisor
        idivq %rbx              # divide
        # use mask to find hr_ones
        movl (%rbp, %rdx,4), %r8d     # %r8d = array[%r8d]; the hr_ones
        sall $14, %r8d          # shift %r8d to left by 14

        # since the time is larger than 10, we know the hr_tens must be 1
        # use mask to find hr_tens
        movq $1, %r12           # put 1 into %r12
        movl (%rbp, %r12, 4), %r9d    # %r9d = array[%r9d], the hr_tens
        sall $21, %r9d          # shift %r9d to left by 21

        cmpq $1, %rcx           # see if the time is AM or PM
        jne its_am              # jump to its_am
        # it's pm
        movl $0, (%rsi)         # initialize (%rsi) with 0
        movl pm(%rip), %ecx     # put data.pm into %ecx
        orl %ecx , (%rsi)       # add ispm to (%rsi)
        orl %r10d, (%rsi)       # add min_ones to (%rsi)
        orl %r11d, (%rsi)       # add min_tens to (%rsi)
        orl %r8d , (%rsi)       # add hr_ones  to (%rsi)
        orl %r9d , (%rsi)       # add hr_tens  to (%rsi)
        movq $0, %rax           # want to return 0 to show the success;
        pop %r12                # pop callee register
        pop %rbp                # pop callee register
        pop %rbx                # pop callee register
        ret                     # return;


        invalid_time2:
          movq	$1, %rax        # want to return 1 to show the failure;
          pop %r12              # pop callee register
          pop %rbp              # pop callee register
          pop %rbx              # pop callee register
          ret                   # return;
          .cfi_endproc

        hrs_less_than_10:

        # determine hr_ones
        xor  %rdx, %rdx         # set %rdx to zero to avoid overflow
        movq %r8,  %rax         # put %r8 into %rax; %rax is the dividend
        movq $10,  %rbx         # put  10 into %rbx; %rbx is the divisor
        idivq %rbx              # divide
        # use mask to find hr_ones
        movl (%rbp, %rdx, 4), %r8d    # %r8d  = array[%r8d], the hr_ones
        sall $14, %r8d          # shift %r8d to left by 14

        # make hr_tens, using blank
        # since the time is less than 10, we know the hr_tens must be blank
        movl blank(%rip), %r9d  # put data.blank into %r9d
        cmpq $1, %rcx           # see if the time is AM or PM
        jne its_am              # jump to its_am
        # it's pm
        movl $0, (%rsi)         # initialize (%rsi) with 0
        movl pm(%rip), %ecx     # put data.pm into %ecx
        orl %ecx , (%rsi)       # add ispm to (%rsi)
        orl %r10d, (%rsi)       # add min_ones to (%rsi)
        orl %r11d, (%rsi)       # add min_tens to (%rsi)
        orl %r8d , (%rsi)       # add hr_ones  to (%rsi)
        orl %r9d , (%rsi)       # add hr_tens  to (%rsi)
        movq $0, %rax           # want to return 0 to show the success;
        pop %r12                # pop callee register
        pop %rbp                # pop callee register
        pop %rbx                # pop callee register
        ret                     # return;

        its_am:
        # it's am
        movl $0, (%rsi)         # initialize (%rsi) with 0
        movl am(%rip), %ecx     # put data.am into %ecx
        orl %ecx , (%rsi)       # add ispm to (%rsi)
        orl %r10d, (%rsi)       # add min_ones to (%rsi)
        orl %r11d, (%rsi)       # add min_tens to (%rsi)
        orl %r8d , (%rsi)       # add hr_ones  to (%rsi)
        orl %r9d , (%rsi)       # add hr_tens  to (%rsi)
        movq $0, %rax           # want to return 0 to show the success;
        pop %r12                # pop callee register
        pop %rbp                # pop callee register
        pop %rbx                # pop callee register
        ret                     # return;

.text
.global lcd_update
lcd_update:
	      ## assembly instructions here
        # also could use pushq %reg to make space for tod_t, and pop it at the end
        # also could use subq $8, %rsp to make space for tod_t, and addq $8, %rsp at the end
        pushq $0                          # make space for tod_t; %rsp is now pointing to it
        movq %rsp, %rsi                   # put %rsp into %rsi; %rsi is the 2nd argument
        movl TIME_OF_DAY_SEC(%rip), %edi  # put TIME_OF_DAY_SEC(%rip) into %edi; %edi is the 1st argument
        call set_tod_from_secs            # call the funtion
        cmpl $1, %eax                     # compare the return value with 1
        je invalid_time3                  # jump to invalid_time3 if %eax is 1

        leaq LCD_DISPLAY_PORT(%rip), %rsi # %rsi is pointing to the global variable LCD_DISPLAY_PORT
        movq (%rsp), %rdi                 # dereference %rsp and put its value into %rdi
        call set_display_bits_from_tod    # call the function
        cmpl $1, %eax                     # compare the return value with 1
        je invalid_time3                  # jump to invalid_time3 if %eax is 1
        movl $0, %eax                     # want to return 0 to show the success;
        addq $8, %rsp                     # restore the space

        ret

        invalid_time3:
        addq $8, %rsp                     # restore the space
        ret
