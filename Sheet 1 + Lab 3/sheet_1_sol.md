# Sheet 1 Solution

This [link](https://www.malavida.com/en/soft/emu8086/download) has an easy to use 8086 emulator. However, in the coding exercises, you will have to use a real compiler and assembler. The simulation will be on the DOSBox emulator.

## Question 1

State another way to increase the processing power of the CPU other than increasing the frequency.

### Solution

There are alot of ways to increase the processing power of the CPU other than increasing the frequency. Some of them are listed below:

1. Increasing the number of cores.
2. Pipelining. (Fetch and execute at the same time).

## Question 2

Are the following instructions valid? Why? Why not?
### Solution
#### Q2.A
``` x86asm
MOV AX, 27
```
This is a valid instruction. The Final value of AX will be _0x1b_, which is _27_ in decimal.

#### Q2.B
``` x86asm
MOV AL, 97F
```
There are a number of issues with this instruction.
1. We are trying to fit `97F`, which is a $4 \times 3 = 12$ bit number into the `AL` register, which is an 8 bit register. This is not possible.
2. There is no suffix for the immediate value. Numbers in commands should be suffixed with `h` for hexadecimal, `d` for decimal and `b` for binary. If no suffix is given, the assembler assumes that the number is in decimal.

The correct instruction would be
``` x86asm
MOV AX, 97Fh
```

#### Q2.C
``` x86asm
MOV DS, 9BF2
```
This is not a valid instruction. The `DS` is the **d**ata **s**egment register. Segment registers **Can NOT** be loaded with immediate values. Load the immediate value you want in a general purpose register first, then `MOV` that value into the desired segment register. Also, any number in assembly should be suffixed according to its base (binary, decimal, or hexadecimal).

#### Q2.D
``` x86asm
MOV CX, 397
```
This is a valid instruction. The final value of `CX` will be _018D_, which is _397_ in decimal.

#### Q2.E
``` x86asm
MOV 81, 9516
```
This is a valid instruction. This moves 9516 to [81]

#### Q2.F
``` x86asm
MOV CS, 3490
```
This is not a valid instruction. The `CS` is the **c**ode **s**egment register. Segment registers **Can NOT** be loaded with immediate values. Load the immediate value you want in a general purpose register first, then `MOV` that value into the desired segment register. Also, any number in assembly should be suffixed according to its base (binary, decimal, or hexadecimal).

#### Q2.G
``` x86asm
MOV DS, BX
```
This instruction is valid. The starting address of the data segment is now the value in `BX`

#### Q2.H
``` x86asm
MOV BX,CS
```
This is a valid instruction.

#### Q2.I
``` x86asm
MOV CH, AX
```

`MOV` requries its two operands to be of the same size. `CH` is an 8 bit register, while `AX` is a 16 bit register. This instruction is not valid.

#### Q2.J
``` x86asm
MOV AX, 23FB9
```
This is not a valid instruction. The `AX` register is a 16 bit register. It can not hold a 20 bit number. Besides, any number in assembly should be suffixed according to its base (binary, decimal, or hexadecimal).

#### Q2.K
``` x86asm
MOV CS, BH
```
This instruction is invalid. While we are using a register to load the segment register, the register used is an 8 bit register. Segment registers are 16 bit registers. The `MOV` command requires its operands to be of the same size.

#### Q2.L
``` x86asm
MOV AX, DL
```
This instruction is invalid. The `MOV` command requires its operands to be of the same size.

### Q2 Summary
| Question | Validity | Reason |
| :---: | :---: | :---: |
| A | Yes | - |
| B | No | 1. Trying to fit a 12 bit number into an 8 bit register. <br> 2. No suffix for the immediate value. |
| C | No | 1. Trying to load a segment register with an immediate value. <br> 2. No suffix for the immediate value. |
| D | Yes | - |
| E | Yes | - |
| F | No | 1. Trying to load a segment register with an immediate value. <br> 2. No suffix for the immediate value. |
| G | Yes | - |
| H | Yes | - |
| I | No | The `MOV` command requires its operands to be of the same size. |
| J | No | 1. Trying to fit a 20 bit number into a 16 bit register. <br> 2. No suffix for the immediate value. |
| K | No | The `MOV` command requires its operands to be of the same size. |
| L | No | The `MOV` command requires its operands to be of the same size. |

## Question 3

If an instruction that needs to be fetched is in physical memory location `389F2` and `CS = 2700`, does the code segment range include it or not? If not, what value should be assigned to `CS` if the `IP` must be = `1282`?

### Required Concepts
- The physical address.
- The logical address.
- How to convert from the logical address to the physical address.

### Required
- Can we find the instruction in the code segment?
- If not, what value should be assigned to `CS` if the `IP` must be = `1282`?

### Givens
- The instruction is in physical memory location `389F2`.
- The code segment starts at `CS = 2700`.
- The `IP` must be = `1282`.

### Solution
The code segment starts at `CS = 2700:0000` and ends at `2700:FFFF`. In order to find whether the instruction is in the code segment or not, we need to find the range of the address space of the code segment.

To calculate the physical address, we perform two operations:

1. Multiply the `CS` by `10h`. This is equivalent to shifting the CS by 4 bits to the left.
2. Add the offset.

In order to find the range of the `CS`, we do these operations twice:
1. Lower range: `(CS * 10h) + 0000 = 270000h`
2. Upper range: `(CS * 10h) + FFFF = 36FFFFh`

We can clearly see that the instruction located at `389F2` is not in the code segment address space. Given the current configuration, this instruction will not be executed.


The second part of the question asks you to fix this problem, given that the `IP` is equal to `1282h`
### Solution

Remember the formula

    Physical address = (CS*10h)+IP

By substituting:

    389F2 = (CS*10h)+1282

Work the math:

    389F2 - 1282 = CS * 10h
    37770        = CS * 10h

Now remember, multiplying by `10h` is just shifting one whole hexadecimal digit to the **left**. Dividing is just the opposite. Dividing shifts the number one whole digit to the **right** instead.

    3777 = CS

### Q3 Summary

1. No.
2. `3777`

## Question 4
Assume that `SP = FF2EH`, `AX = 3291H`, `BX = F43CH`, and `CX = 09`. Find the content of the stack and stack pointer after the execution of each of the following instructions:

```x86asm
PUSH AX
PUSH BX
POP AX
PUSH CX
POP BX
```

### Required Concepts
1. Basic stack knowledge.
2. Stack pointer rules in `x86 assembly`.

### Required
- After each instruction, what are the contents of the stack and the stack pointer?

### Givens
1. `SP = FF2Eh`
2. `AX = 3291h`
3. `BX = F43Ch`
4. `CX = 0009h`
5. Instructions.

### Solution

There are two things that we need to know:
1. In the memory, the program data and the stack are opposite to each other.
    - This is better memory management, allows both the data and the stack to grow in the memory freely as long as they don't collide.
2. The stack pointer decrements by `2` with every `push` and increments by `2` with every `pop`. This is because the width of the stack is `8-bits`, not 16.

Based on the above information, we can solve this question as follows:

#### Instruction 1
```x86asm
PUSH AX ; 3291h
```
- The stack pointer decrements by 2 when pushing. `SP = FF2Eh` &rarr; `SP = FF2Ch`
- The value is then stored in `SS:SP`, in little endian.

Stack contents:
| Offset | Data | |
|:-:|:-:|:-: |
|FF2Eh|-||
|FF2Dh|32h||
|FF2Ch|91h|&larr; SP|



#### Instruction 2
```x86asm
PUSH BX ; F43Ch
```
- The stack pointer decrements by 2 when pushing. `SP = FF2Ch` &rarr; `SP = FF2Ah`

Stack contents:
| Offset | Data ||
|:-:|:-:|:-:|
|FF2Eh|-||
|FF2Dh|32h||
|FF2Ch|91h||
|FF2Bh|F4h||
|FF2Ah|3Ch|&larr; SP|

#### Instruction 3
``` x86asm
POP AX
```
- The stack pointer increments by 2 when popping. `SP = FF2Ah` &rarr; `SP = FF2Ch`
- Value of `AX` is now `F43Ch`

Stack contents:
| Offset | Data ||
|:-:|:-:|:-:|
|FF2Eh|-||
|FF2Dh|32h||
|FF2Ch|91h|&larr; SP|
|FF2Bh|F4h||
|FF2Ah|3Ch||

#### Instruction 4
```x86asm
PUSH CX ; 0009h
```
- The stack pointer decrements by 2 when pushing. `SP = FF2Ch` &rarr; `SP = FF2Ah`

Stack contents:
| Offset | Data ||
|:-:|:-:|:-:|
|FF2Eh|-||
|FF2Dh|32h||
|FF2Ch|91h||
|FF2Bh|00h||
|FF2Ah|09h|&larr; SP|

#### Instruction 5
```x86asm
POP BX
```
- The stack pointer increments by 2 when popping. `SP = FF2Ah` &rarr; `SP = FF2Ch`
- Value of `BX` is now `0009h`

Stack contents:
| Offset | Data ||
|:-:|:-:|:-:|
|FF2Eh|-||
|FF2Dh|32h||
|FF2Ch|91h|&larr; SP|
|FF2Bh|00h||
|FF2Ah|09h||

## Question 5
What is the function of the following code? Can you suggest a better alternative? Why is your alternative better?

### Required Concepts
- General stack knowledge.

```x86asm
PUSH AX
PUSH BX
POP AX
POP BX
```

### Solution

Let's see what would the 8086 do in this situation:

After the first two instruction, the stack will look like this:
|Stack|
|:-:|
|`BL`|
|`BH`|
|`AL`|
|`AH`|

Now, we pop the top of the stack, which is `BL` and `BH` (`BX`) into `AX`. Can you see now what this code does?

This code swaps the contents of `AX` and `BX`. A better alternative to this code snippet is to use this command:

```x86asm
XCHG AX, BX
```
Which does the same functionality with less code size in less clock cycles. Always keep your assembly cheat sheet with you when coding and make sure it has a description of the commands, even if its a small one.

## Question 6
What is the main disadvantage of the stack as temporary storage compared to having a large number of registers inside the CPU?

### Solution
- The stack resides in the RAM.
    - The 8086 is a chip that doesnt have any RAM or ROM.
    - This means that the RAM is not on the same IC as the 8086.
    - This means much slower access time in comparison with the registers.

## Question 7
Find the status of the CF, PF, AF, ZF, and SF for the following operations.

### Required Concepts
- How to efficiently use your Casio calculator.
- What affects each flag.
- What instructions affect what flags.
    - Make sure your cheat sheet includes this information.

### Flags
- `CF: Carry Flag` This is set when the operation results in a carry.
- `PF: Parity Flag` This is set when there is even parity in the result (the number of bits that equal `1` in the result is even).
- `AF: Auxiliary Flag` This is set if the lower nibble has a carry out.
- `ZF: Zero Flag` This is set if the result is zero.
- `SF: Sign Flag` This is set if the result is negative. (This flag always equals the most significant bit of the result, becuase its the sign bit).
- `OF: Overflow Flag` This is set if the result is an invalid two's complement. If we add two positive numbers the result should be positive, and if we add two negative numbers the result should be negative. Anything other than that sets the `OF`.
### Q7.A
```x86asm
MOV BL, 9FH
ADD BL, 61H
```
- The `MOV` instruction in 8086 does not affect any flag.
- The `ADD` instruction affects `CF, PF, AF, ZF, SF, and OF`.

The result of the addition is `9fh + 61h = 100h`.

- Note that the `1` is a carry, which sets the `CF`.
- Without the carry, the result is `00`. This has _zero_ ones. _Zero_ is an even number and thus, the `PF` is set.
- The sum of the first digit in each operand `F + 1 = 10` produces a carry. This sets the `AF`.
- Without the carry, the result is `00`. This sets the `ZF`
- The most significant bit of the result is the `SF`. The `SF` is zero.

Keep in mind that the value of BL is now 00

Flags:
|CF|PF|AF|ZF|SF|
|-|-|-|-|-
|1|1|1|1|0

### Q7.B
```x86asm
MOV AL, 23H
ADD AL, 97H
```

- `MOV` affects no flags.
- `ADD` affects `CF, PF, AF, ZF, SF, and OF`.

Addition result: `23h + 97h = BAh`
- No carry &rarr; `CF = 0`
- Odd number of ones &rarr; `PF = 0`
- The summation of the first digit produces no carry &rarr; `AF = 0`
- The result is not zero &rarr; `ZF = 0`
- The result is negative &rarr; `SF = 1`


Flags:
|CF|PF|AF|ZF|SF
|-|-|-|-|-
|0|0|0|0|1

### Q7.C
```x86asm
MOV DX, 10FFH
ADD DX, 1H
```
Addition result: `10FFh + 1h = 1100h`
- No carry &rarr; `CF = 0`
- Even number of ones `PF = 1`
- The summation of the first digit produces a carry &rarr; `AF = 1`
- The result is not zero &rarr; `ZF = 0`
- The result is not negative &rarr; `SF = 0`
- A positive result is obtained from the addition two positive numbers &rarr; `OF = 0`

Flags:
|CF|PF|AF|ZF|SF
|-|-|-|-|-
|0|1|1|0|0

### Q7 Summary
||CF|PF|AF|ZF|SF
|-|-|-|-|-|-
|Point A|1|1|1|1|0|
|Point B|0|0|0|0|1|
|Point C|0|1|1|0|0|

## Q8
Assume that the registers have the following values (all in hex) and that `CS=1000, DS = 2000, SS = 3000, SI = 4000, DI : 5000, BX = 6080, BP = 7000, AX=25FF, CX = 8791, and DX = 1299`. Calculate the physical address of the memory where the operand is stored and the contents of the memory locations in each of the following addressing examples.

### Required Concepts
- 8086 addressing modes.
- Physical and logical address conversions.

### Addressing Modes
The 8086 has 7 addressing modes:
![8086 Addressing Modes](image.png)

### Solution

### Q8.A
```x86asm
; AX = 25FFh
; SI = 4000h
MOV [SI], AL
```

- The `AL` register has `FFh` stored.
- The `SI` is an offset relative to the data segment
- This is the register indirect addressing mode.
- The 8086 gets the data from `AL`&rarr;`FFh`, and stores the result in `DS:SI`
- This means that `2000:4000` now contains `FFh`.
    - The physical address is `(2000h * 10h) + 4000 = 24000h`

### Q8.B
```x86asm
; SI = 4000h
; BX = 6080h
; AX = 25FFh
MOV [SI+BX+8], AH
```
- The `AH` register has `25h` stored.
- The `SI` is an offset relative to the data segment
- This is the based indexed relative addressing mode.
- The 8086 gets the data from `AH`&rarr;`25h`, and stores the result in `DS:(SI+BX+displacement)`
- This means that `2000:(4000+6080+8)` now contains `25h`
    - Physical address: `2A088h`

### Q8.C
```x86asm
; BX = 6080h
; AX = 25FFh
MOV [BX], AX
```
Just like **Q8.A** but with a 16-bit register.

- `DS:BX` &rarr; `2000:6080`
- `[26080h] = FFh`
- `[26081h] = 25h`

### Q8.D
```x86asm
; DI = 5000h
; BX = 6080h
MOV [DI+6], BX
```
- This is the index relative addressing mode.
- Store `BX` in `DS:DI+6`
    - `2000:5006`&rarr;`25006h`
    - `25006`&rarr;`80h`
    - `25007`&rarr;`60h`

### Q8.E
```x86asm
; DI = 5000h
; BX = 6080h
; CX = 8791h
MOV [DI][BX]+28, CX
```
- This is the based index relative addressing mode.
- Similar to **Q8.B**, but with a 16 bit register.
- Store `CX` in `DS:SI+BX+28`
- `DS:SI+BX+28`&rarr;`2000:4000+6080+28`&rarr;`2A0A8h`
- `2A0A8h`&rarr;`91h`
- `2A0A9h`&rarr;`87h`

### Q8.F
```x86asm
; BP = 7000h
; SI = 4000h
; DX = 1299h
MOV [BP][SI]+10, DX
```
- This is the based index relative addressing mode.
- The offset in the `BP` is relative to the stack segment.
    - This is very important.
- Store `DX` in `SS:BP+SI+10`
- `SS:BP+SI+10`&rarr;`3000:7000+4000+10`&rarr;`3B010h`
- `3B010h`&rarr;`99h`
- `3B011h`&rarr;`12h`

### Q8 Summary
|Q|Physical Address|Data|
|:-:|:-:|:-:|
|A|24000h|FFh|
|B|2A088h|25h|
|C|26080h<br>26081h|FFh<br>25h|
|D|25006h<br>25007h|80h<br>60h|
|E|2A0A8h<br>2A0A9h|91h<br>87h|
|F|3B010h<br>3B011h|99h<br>12h|

## Question 9
Make the following programs in `ARM Assembly`, for the Cortex M3 platform.
- Calculate the sum of the first ten numbers of Fibonacci series. Store the result in `r0`.
- Calculate the sum of the numbers 1: `N` where `N` is stored in `r1`. Store the result in `r0`.

#### Required Concepts
- The `MOV` command.
- The `ldr` command.
- The `ADD` command.
- Loops in Assembly.

Keep in mind that `ARM Assembly` instructions must be indented by at least one space.

#### The `MOV` Command
```armasm
    MOV r0, r1     ; The contents of r1 are now in r0.
    MOV r0, #123   ; Decimal value 123 is now in r0.
    MOV r0, #0xFA  ; 0xFA is now in r0.
```
There are some special considerations when moving immediates into registers, consider the following command:
```armasm
MOV r0, #0xFACEB00C ; Illegal Instrucion ?!
```
Due to some restrictions in the arm instructions, the immediates that can be `MOV`ed into registers need to follow some rules:

1. Any 8-bit immediate value, giving a range of 0x0-0xFF (0-255).
2. Any 8-bit immediate value, shifted left by any number.
3. Any 8-bit pattern duplicated in all four bytes of a register.
4. Any 8-bit pattern duplicated in bytes 0 and 2, with bytes 1 and 3 set to 0.
5. Any 8-bit pattern duplicated in bytes 1 and 3, with bytes 0 and 2 set to 0

A simple solution is to use the `ldr` command instead, which can load a register with a 32 bit value, or an address.
```armasm
    ldr r0, =0xFACEB00C ; Works just fine.
```

### The `Add` Command
```armasm
    add r0, r1, r2 ; r0 now contains the sum of r1 and r2
    add r0, r1, #2 ; r0 is now r1 + 2
    add r0, #2, r1 ; Invalid instruction. The immediate must come second.
    add r0, #1, #2 ; Invalid instruction. Can't add two immediates.
```

### Assembly Loops
The normal for loop we are all familiar with does not exist in neither the x86 nor the ARM Assembly. Instead, we have _"conditional branches"_

Based on a condition that occurs (the status of a certain flag of the programmer's choice) a branch is (or is not) executed.  Consider the following:


```armasm
; ARM Assembly loop demonstration. This loop runs r2 times.

    mov r2, #3 ; Load the decimal value 3 into r0
               ; This will be our loop counter.

    mov r0, #0 ; Initialize the r0 register.

loop_start ; This is a label.
           ; This is not an instruction.
           ; Labels are not indented.

    dummy instruction 1
    dummy instruction 2
    dummy instruction 3

    ; Now, based on what happens on your code, some flags will change.
    ; Use the conditions that you see fit to select the optimal
    ; branching instruction.

    subs r2, #1    ; Decrement r2.
                   ; Any command suffixed by an "s" affects the flags.
                   ; We want to go back to our loop_start label if the
                   ; counter (the r2 register) is not equal to zero.

    bne loop_start ; The branch not equal "bne" command jumps to the
                   ; label if the zero flag is not set.
```

### Q9.A
Calculate the sum of the first ten numbers of Fibonacci series. Store the result in `r0`.

#### Solution
Each number in the Fibonacci series is equal to the sum of the two numbers before it.

The series starts with 0, 1.

We need to first calculate the _ith_ fibbonaci number, then, accumulate it in the r0 register.

### Q9.B
Calculate the sum of the numbers 1: `N` where `N` is stored in `r1`. Store the result in `r0`.

#### Solution

We use a counter to count the number of iterations in a loop. We also accumulate said counter in the r0 register. This can be easily done by loading a register with the `N` value and looping in reverse.


