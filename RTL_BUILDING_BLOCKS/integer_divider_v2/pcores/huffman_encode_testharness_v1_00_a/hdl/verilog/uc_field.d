// <A NAME="uc_field_start"></A>
//*****************************************************************************
// *
// * $RCSfile: uc_field.d,v $
// *
//* $Id: uc_field.d,v 1.1 2010/12/08 22:14:14 vsananda Exp $
//* $Change: 44304 $
//* $Revision: 1.1 $
//* $Date: 2010/12/08 22:14:14 $
//* $Revision: 1.1 $
//* $Date: 2010/12/08 22:14:14 $
//* $Author: vsananda $
//* $State: Exp $
//* $Locker:  $
//*
//* Copyright (c) 1997-2003 by Advanced Micro Devices, Inc.
//*
//* Advanced Micro Devices Proprietary Information
//*
// ****************************************************************************/

`ifndef _UC_FIELD_D_

`define _UC_FIELD_D_


//************************************************************************

//`define SLEDGE                     // this is now in k8_pa.d so that we can run the whacker

// Values for Mrom/ram size

// NOTE:  Changing ROM/RAM size requires updating all of the values below
`define MROMSIZE        13'h1C00       // size of the ROM
`define MROMSIZE_dec    7168           //   (decimal version)
`define MRAMSIZE        13'h0080       // size of the patch RAM
`define MRAMSIZE_dec    128             //   (decimal version)

`define MRAMBASE        13'h1f80       // base address of the patch RAM
`define MRAMBASE_12_7   6'b1_1111_1    // string for matching rom vs ram addresses
`define MRAMBASE_12_5   8'b1_1111_100  // string for matching rom vs ram addresses

`define ITRAPBASE_12_2 11'b1_1111_1110_00 // Trap/Emulate Base Address in patch RAM

`define MCODESIZE (`MRAMSIZE + `MRAMBASE) // highest address

//************************************************************************
// Microcode COP Fields

`define FP_SSE_OP  63     // cop opcode[9], this is set for fp sse cops.
`define FPUOP      63:56  // 8-bit fp cop opcode
`define OPCD       63:54  // Lower 10-bits of integer cop opcode.
`define DSTCTL     53:52
`define OPA        51:46  // ENCODINGS FOR THE OPA FIELD
`define OPA_LO     48:46
`define OPA_LSB    46
`define FLGSEL     45
`define FLG        44:40
`define FPOPCD     39     // Extended cop opcode bit.  This is set for all FP cops, cleared for integer cops.
`define LDST       38:37  // LsType[1:0]
`define SEG_BIT3   36     // If MSB set, then the addr size is 32, supervisor.
`define SEG        36:33
`define OPSZ       32:30
`define OPC        29:24  // ENCODINGS FOR THE OPC FIELD
`define OPC_LO     26:24
`define OPC_LSB    24
`define OPBTYP     23:22
`define DISPCTL    21
`define INTCHK     20
`define MEMACC     19:15
`define MIMMD_SIGN 16     // micro-addr, micro-immed: sign/zero extended, 16 bit immediate.
`define MIMMD      15:0   // 16 bit immediate.
`define OPB        14:9
`define OPB_LO     11:9
`define OPB_LSB    9
`define MCTYP      8:7
`define MCONST_MSB 6      // MSB of MCONST, used for sign ext.
`define MCONST     6:0
`define SREG       8:0

//************************************************************************
// ENCODINGS FOR THE INTEGER COP OPCODE FIELD: {cop[`FPOPCD],cop[`OPCD]}

// These two defines are used only by the microcode assembler to set to fp and sse bits in the integer opcode.
`define UC_OP_IS_FPOP         11'b10000000000 // Integer opcode[10] is set for all fp cops.
`define UC_OP_IS_SSE_OP       11'b01000000000 // Integer opcode[9]  is set for all fp sse cops.

// The general layout of the integer cop opcode[10:0] field:
// 
// 000_0000_Rxxx  normal arithmetic - R indicates reverse
// 000_0001_Axxx  rotate - A indicates by one
// 000_0010_xxxx  add1
// 000_0011_xxxx  sub1/divsub/andnot/sext/zext
// 000_0100_xxxx  unconditional jump/call/ret/nop
// 000_0101_xxxx  movA
// 000_0110_xxxx  movB
// 000_0111_xxxx  mul/load-seg/movflgs/lea/push - other wierd stuff (could be in 001_xxxx_xxxx too)
// 000_1xxx_cccc  conditional operation
//      000         add
//      001         set
//      010         relative-branch
//      011         <unused, was ASSERTcc>
//      100         move
//      101         (cmove, if we need it)
//      110         sub
//      111         subr
// 001_00xx_xxxx  whole space reserved for NULL
// 001_01xx_xxxx  really random stuff that doesn't fit above
// 001_10xx_xxxx  really random stuff that doesn't fit above
// 001_11xx_xxxx  really random stuff that doesn't fit above
// 10x_xxxx_xxxx  FPU x87/MMX ops
// 11x_xxxx_xxxx  FPU SSE ops

// The cop opcode[10:0] definitions for all integer ops:

`define UC_OP_ADD             11'b000_0000_0000        // Add
`define UC_OP_OR              11'b000_0000_0001        // Logical Inclusive OR
`define UC_OP_ADC             11'b000_0000_0010        // Add with Carry
`define UC_OP_SBB             11'b000_0000_0011        // Integer Subract with Borrow  (A-B-CF)
`define UC_OP_AND             11'b000_0000_0100        // Logical AND
`define UC_OP_SUB             11'b000_0000_0101        // Integer Subtract
`define UC_OP_XOR             11'b000_0000_0110        // Logical Exclusice OR
`define UC_OP_LEA_ALU         11'b000_0000_1000        // Add (Immediates come from Displacement)
`define UC_OP_SBBR            11'b000_0000_1011        // Reverse Integer Subtract with Borrow (B-A-CF)
`define UC_OP_SUBR            11'b000_0000_1101        // Reverse Subtract/NEG (B-A)

`define UC_OP_ROL             11'b000_0001_0000        // Rotate A left by B
`define UC_OP_ROR             11'b000_0001_0001        // Rotate A right by B
`define UC_OP_SHL             11'b000_0001_0100        // Shift A Left by B
`define UC_OP_SHR             11'b000_0001_0101        // Shift A Right by B
`define UC_OP_SAR             11'b000_0001_0111        // Shift A Right Arithmetic by B  BOZO - what should the encoding be?
`define UC_OP_ROL1            11'b000_0001_1000        // Rotate A Left by B+1
`define UC_OP_ROR1            11'b000_0001_1001        // Rotate A Right by B+1
`define UC_OP_RCL1            11'b000_0001_1010        // Rotate {A, CF} Left by B+1
`define UC_OP_RCR1            11'b000_0001_1011        // Rotate {A, CF} Right by B+1
`define UC_OP_SHL1            11'b000_0001_1100        // Shift A Left by B+1
`define UC_OP_SHR1            11'b000_0001_1101        // Shift A Right by B+1
`define UC_OP_SAR1            11'b000_0001_1111        // Shift A Right by 1, preserve sign bit. B must = 0

`define UC_OP_ADD1            11'b000_0010_0000        // Increment by 1, Add + 1     (A+B+1)

`define UC_OP_SUB1            11'b000_0011_0000        // Decrement by 1, Subtract -1 (A-B-1)
`define UC_OP_DIVSUB          11'b000_0011_0111        // Special Op to initialize DivideFlag
`define UC_OP_SUBR1           11'b000_0011_1000        // NOT / Subtract Reverse -1 (B-A-1)
`define UC_OP_ANDN            11'b000_0011_1010        // A & (~B)
`define UC_OP_ANDNR           11'b000_0011_1011        // (~A) & B
`define UC_OP_ZEXT            11'b000_0011_1110        // Zero extend byte/word/dword to dword
`define UC_OP_SEXT            11'b000_0011_1111        // Sign extend byte/word/dword to dword

`define UC_OP_JABS            11'b000_0100_0000        // Unconditional absolute branch
`define UC_OP_CALLABS         11'b000_0100_0001        // Unconditional absolute call
`define UC_OP_JREL            11'b000_0100_0100        // Unconditional relative branch
`define UC_OP_CALLREL         11'b000_0100_0101        // Unconditional relative call
`define UC_OP_JFAR            11'b000_0100_1000        // Unconditional absolute branch, no prediction
`define UC_OP_JRESYNC         11'b000_0100_1001        // Unconditional absolute branch, no prediction
`define UC_OP_JFARMAN         11'b000_0100_1010        // Unconditional absolute branch, no prediction, manual CsBase update
`define UC_OP_JRSVD           11'b000_0100_1011        // Reserved to make decoding of StallXfer easier in the Meng
`define UC_OP_RET             11'b000_0100_1100        // Unconditional absolute return

`define UC_OP_MOVA            11'b000_0101_0000        // Move A to result

`define UC_OP_MOVB            11'b000_0110_0000        // Move B to result
`define UC_OP_DIVL            11'b000_0110_0110        // Unsigned 16,32, or 64-bit divide, low cop, unique to JG 
`define UC_OP_IDIVL           11'b000_0110_0111        //   signed 16,32, or 64-bit divide, low cop, unique to JG
`define UC_OP_DIV8            11'b000_0110_1100        // Unsigned 8-bit divide, follows what HS has
`define UC_OP_IDIV8           11'b000_0110_1101        //   signed 8-bit divide, follows what HS has
`define UC_OP_DIVH            11'b000_0110_1110        // Unsigned 16,32, or 64-bit divide, high cop, change from  DIVd (for HS) to  DIVH (for JG)
`define UC_OP_IDIVH           11'b000_0110_1111        //   signed 16,32, or 64-bit divide, high cop, change from IDIVd (for HS) to IDIVH (for JG) 

`define UC_OP_MUL             11'b000_0111_0000        // Unsigned multiply
`define UC_OP_IMUL            11'b000_0111_0001        // Signed multiply
`define UC_OP_MULL            11'b000_0111_0010        // Unsigned multiply, two destinations
`define UC_OP_IMULL           11'b000_0111_0011        // Signed multiply, two destinations
`define UC_OP_MULH            11'b000_0111_0100        // Place holder Op for second result destination.
`define UC_OP_DIVSTEP         11'b000_0111_0111        // A + B or A + (~B) + 1 depending on DivideFlag
`define UC_OP_POPCNT          11'b000_0111_1000        // Population Count - Number of set bits of operand
`define UC_OP_CLZR            11'b000_0111_1010        // Count Leading Zeroes Reverse (from the msb to the lsb)
`define UC_OP_LDAFH           11'b000_0111_1011        // Load Alternate fault handler
`define UC_OP_MOVFLGS         11'b000_0111_1100        // Merge EFLAGS with A based on mask B
`define UC_OP_SETCNT          11'b000_0111_1110        // Set count for REP string prediction
`define UC_OP_LOAD            11'b000_0111_1111        // Load from Mem zero-extended, no dependency on dest reg.

`define UC_OP_ADDO            11'b000_1000_0000        // Add if   OF==1
`define UC_OP_ADDNO           11'b000_1000_0001        // Add if !(OF==1)
`define UC_OP_ADDB            11'b000_1000_0010        // Add if   CF==1
`define UC_OP_ADDNB           11'b000_1000_0011        // Add if !(CF==1)
`define UC_OP_ADDZ            11'b000_1000_0100        // Add if   ZF==1
`define UC_OP_ADDNZ           11'b000_1000_0101        // Add if !(ZF==1)
`define UC_OP_ADDBE           11'b000_1000_0110        // Add if   CF==1 || ZF==1
`define UC_OP_ADDNBE          11'b000_1000_0111        // Add if !(CF==1 || ZF==1)
`define UC_OP_ADDS            11'b000_1000_1000        // Add if   SF==1
`define UC_OP_ADDNS           11'b000_1000_1001        // Add if !(SF==1)
`define UC_OP_ADDP            11'b000_1000_1010        // Add if   PF==1
`define UC_OP_ADDNP           11'b000_1000_1011        // Add if !(PF==1)
`define UC_OP_ADDL            11'b000_1000_1100        // Add if   SF<>OF
`define UC_OP_ADDNL           11'b000_1000_1101        // Add if !(SF<>OF)
`define UC_OP_ADDLE           11'b000_1000_1110        // Add if   ZF==1 || SF<>OF
`define UC_OP_ADDNLE          11'b000_1000_1111        // Add if !(ZF==1 || SF<>OF)

`define UC_OP_SETO            11'b000_1001_0000        // Set Byte if   OF==1  (A=don't care, B must =0)
`define UC_OP_SETNO           11'b000_1001_0001        // Set Byte if !(OF==1)(A=don't care, B must =0)
`define UC_OP_SETB            11'b000_1001_0010        // Set Byte if   CF==1(A=don't care, B must =0)
`define UC_OP_SETNB           11'b000_1001_0011        // Set Byte if !(CF==1)(A=don't care, B must =0)
`define UC_OP_SETZ            11'b000_1001_0100        // Set Byte if   ZF==1(A=don't care, B must =0)
`define UC_OP_SETNZ           11'b000_1001_0101        // Set Byte if !(ZF==1)(A=don't care, B must =0)
`define UC_OP_SETBE           11'b000_1001_0110        // Set Byte if   CF==1 || ZF==1(A=don't care, B must =0)
`define UC_OP_SETNBE          11'b000_1001_0111        // Set Byte if !(CF==1 || ZF==1)(A=don't care, B must =0)
`define UC_OP_SETS            11'b000_1001_1000        // Set Byte if   SF==1(A=don't care, B must =0)
`define UC_OP_SETNS           11'b000_1001_1001        // Set Byte if !(SF==1)(A=don't care, B must =0)
`define UC_OP_SETP            11'b000_1001_1010        // Set Byte if   PF==1(A=don't care, B must =0)
`define UC_OP_SETNP           11'b000_1001_1011        // Set Byte if !(PF==1)(A=don't care, B must =0)
`define UC_OP_SETL            11'b000_1001_1100        // Set Byte if   SF<>OF(A=don't care, B must =0)
`define UC_OP_SETNL           11'b000_1001_1101        // Set Byte if !(SF<>OF)(A=don't care, B must =0)
`define UC_OP_SETLE           11'b000_1001_1110        // Set Byte if   ZF==1 || SF<>OF(A=don't care, B must =0)
`define UC_OP_SETNLE          11'b000_1001_1111        // Set Byte if !(ZF==1 || SF<>OF)(A=don't care, B must =0)

`define UC_OP_JO              11'b000_1010_0000        // Relative Branch if   OF==1
`define UC_OP_JNO             11'b000_1010_0001        // Relative Branch if !(OF==1)
`define UC_OP_JB              11'b000_1010_0010        // Relative Branch if   CF==1
`define UC_OP_JNB             11'b000_1010_0011        // Relative Branch if !(CF==1)
`define UC_OP_JZ              11'b000_1010_0100        // Relative Branch if   ZF==1
`define UC_OP_JNZ             11'b000_1010_0101        // Relative Branch if !(ZF==1)
`define UC_OP_JBE             11'b000_1010_0110        // Relative Branch if   CF==1 || ZF==1
`define UC_OP_JNBE            11'b000_1010_0111        // Relative Branch if !(CF==1 || ZF==1)
`define UC_OP_JS              11'b000_1010_1000        // Relative Branch if   SF==1
`define UC_OP_JNS             11'b000_1010_1001        // Relative Branch if !(SF==1)
`define UC_OP_JP              11'b000_1010_1010        // Relative Branch if   PF==1
`define UC_OP_JNP             11'b000_1010_1011        // Relative Branch if !(PF==1)
`define UC_OP_JL              11'b000_1010_1100        // Relative Branch if   SF<>OF
`define UC_OP_JNL             11'b000_1010_1101        // Relative Branch if !(SF<>OF)
`define UC_OP_JLE             11'b000_1010_1110        // Relative Branch if   ZF==1 || SF<>OF
`define UC_OP_JNLE            11'b000_1010_1111        // Relative Branch if !(ZF==1 || SF<>OF)

`define UC_OP_CMOVO           11'b000_1100_0000        // Move A  if   OF==1
`define UC_OP_CMOVNO          11'b000_1100_0001        // Move A  if !(OF==1)
`define UC_OP_CMOVB           11'b000_1100_0010        // Move A  if   CF==1
`define UC_OP_CMOVNB          11'b000_1100_0011        // Move A  if !(CF==1)
`define UC_OP_CMOVZ           11'b000_1100_0100        // Move A  if   ZF==1
`define UC_OP_CMOVNZ          11'b000_1100_0101        // Move A  if !(ZF==1)
`define UC_OP_CMOVBE          11'b000_1100_0110        // Move A  if   CF==1 || ZF==1
`define UC_OP_CMOVNBE         11'b000_1100_0111        // Move A  if !(CF==1 || ZF==1)
`define UC_OP_CMOVS           11'b000_1100_1000        // Move A  if   SF==1
`define UC_OP_CMOVNS          11'b000_1100_1001        // Move A  if !(SF==1)
`define UC_OP_CMOVP           11'b000_1100_1010        // Move A  if   PF==1
`define UC_OP_CMOVNP          11'b000_1100_1011        // Move A  if !(PF==1)
`define UC_OP_CMOVL           11'b000_1100_1100        // Move A  if   SF<>OF
`define UC_OP_CMOVNL          11'b000_1100_1101        // Move A  if !(SF<>OF)
`define UC_OP_CMOVLE          11'b000_1100_1110        // Move A  if   ZF==1 || SF<>OF
`define UC_OP_CMOVNLE         11'b000_1100_1111        // Move A  if !(ZF==1 || SF<>OF)

`define UC_OP_CMOVRO          11'b000_1101_0000        // Move B  if   OF==1
`define UC_OP_CMOVRNO         11'b000_1101_0001        // Move B  if !(OF==1)
`define UC_OP_CMOVRB          11'b000_1101_0010        // Move B  if   CF==1
`define UC_OP_CMOVRNB         11'b000_1101_0011        // Move B  if !(CF==1)
`define UC_OP_CMOVRZ          11'b000_1101_0100        // Move B  if   ZF==1
`define UC_OP_CMOVRNZ         11'b000_1101_0101        // Move B  if !(ZF==1)
`define UC_OP_CMOVRBE         11'b000_1101_0110        // Move B  if   CF==1 || ZF==1
`define UC_OP_CMOVRNBE        11'b000_1101_0111        // Move B  if !(CF==1 || ZF==1)
`define UC_OP_CMOVRS          11'b000_1101_1000        // Move B  if   SF==1
`define UC_OP_CMOVRNS         11'b000_1101_1001        // Move B  if !(SF==1)
`define UC_OP_CMOVRP          11'b000_1101_1010        // Move B  if   PF==1
`define UC_OP_CMOVRNP         11'b000_1101_1011        // Move B  if !(PF==1)
`define UC_OP_CMOVRL          11'b000_1101_1100        // Move B  if   SF<>OF
`define UC_OP_CMOVRNL         11'b000_1101_1101        // Move B  if !(SF<>OF)
`define UC_OP_CMOVRLE         11'b000_1101_1110        // Move B  if   ZF==1 || SF<>OF
`define UC_OP_CMOVRNLE        11'b000_1101_1111        // Move B  if !(ZF==1 || SF<>OF)

`define UC_OP_SUBO            11'b000_1110_0000        // Subtract if   OF==1
`define UC_OP_SUBNO           11'b000_1110_0001        // Subtract if !(OF==1)
`define UC_OP_SUBB            11'b000_1110_0010        // Subtract if   CF==1
`define UC_OP_SUBNB           11'b000_1110_0011        // Subtract if !(CF==1)
`define UC_OP_SUBZ            11'b000_1110_0100        // Subtract if   ZF==1
`define UC_OP_SUBNZ           11'b000_1110_0101        // Subtract if !(ZF==1)
`define UC_OP_SUBBE           11'b000_1110_0110        // Subtract if   CF==1 || ZF==1
`define UC_OP_SUBNBE          11'b000_1110_0111        // Subtract if !(CF==1 || ZF==1)
`define UC_OP_SUBS            11'b000_1110_1000        // Subtract if   SF==1
`define UC_OP_SUBNS           11'b000_1110_1001        // Subtract if !(SF==1)
`define UC_OP_SUBP            11'b000_1110_1010        // Subtract if   PF==1
`define UC_OP_SUBNP           11'b000_1110_1011        // Subtract if !(PF==1)
`define UC_OP_SUBL            11'b000_1110_1100        // Subtract if   SF<>OF
`define UC_OP_SUBNL           11'b000_1110_1101        // Subtract if !(SF<>OF)
`define UC_OP_SUBLE           11'b000_1110_1110        // Subtract if   ZF==1 || SF<>OF
`define UC_OP_SUBNLE          11'b000_1110_1111        // Subtract if !(ZF==1 || SF<>OF)

`define UC_OP_SUBRO           11'b000_1111_0000        // Reverse Subtract if   OF==1
`define UC_OP_SUBRNO          11'b000_1111_0001        // Reverse Subtract if !(OF==1)
`define UC_OP_SUBRB           11'b000_1111_0010        // Reverse Subtract if   CF==1
`define UC_OP_SUBRNB          11'b000_1111_0011        // Reverse Subtract if !(CF==1)
`define UC_OP_SUBRZ           11'b000_1111_0100        // Reverse Subtract if   ZF==1
`define UC_OP_SUBRNZ          11'b000_1111_0101        // Reverse Subtract if !(ZF==1)
`define UC_OP_SUBRBE          11'b000_1111_0110        // Reverse Subtract if   CF==1 || ZF==1
`define UC_OP_SUBRNBE         11'b000_1111_0111        // Reverse Subtract if !(CF==1 || ZF==1)
`define UC_OP_SUBRS           11'b000_1111_1000        // Reverse Subtract if   SF==1
`define UC_OP_SUBRNS          11'b000_1111_1001        // Reverse Subtract if !(SF==1)
`define UC_OP_SUBRP           11'b000_1111_1010        // Reverse Subtract if   PF==1
`define UC_OP_SUBRNP          11'b000_1111_1011        // Reverse Subtract if !(PF==1)
`define UC_OP_SUBRL           11'b000_1111_1100        // Reverse Subtract if   SF<>OF
`define UC_OP_SUBRNL          11'b000_1111_1101        // Reverse Subtract if !(SF<>OF)
`define UC_OP_SUBRLE          11'b000_1111_1110        // Reverse Subtract if   ZF==1 || SF<>OF
`define UC_OP_SUBRNLE         11'b000_1111_1111        // Reverse Subtract if !(ZF==1 || SF<>OF)

`define UC_OP_NULL            11'b001_0000_0000        // NULL Op: dispatch nothing to AGU or EXU

`define UC_OP_BS              11'b001_0100_1100        // RCL of A by B+1, CF=1
`define UC_OP_BR              11'b001_0100_1101        // RCL of A by B+1, CF=0
`define UC_OP_BC              11'b001_0100_1110        // RCL of A by B+1, CF=!CF

`define UC_OP_PUSH            11'b001_0101_0000        // Push onto Stack
`define UC_OP_ROR0            11'b001_0101_0010        // ROL A, B; ROR A, B
`define UC_OP_NAND            11'b001_0101_0101        // ~(A&B)

`define UC_OP_LEA             11'b001_1000_1101        // Load Effective Address

`define UC_OP_NOP             11'b001_1001_0000        // Nop, bypasses execution unit, completes in firob (also used for Wait)
`define UC_OP_CBW             11'b001_1001_1000        // Convert Byte to Word (A=operand, B=merge src)
`define UC_OP_CWD             11'b001_1001_1001        // Shift A Right Arithmetic by Opsize-1  BOZO - what should the encoding be?

`define UC_OP_MOVSDR          11'b001_1011_0000        // Load Segment Descriptor, Real Mode
`define UC_OP_MOVSDP          11'b001_1011_0001        // Load Segment Descriptor, Protected Mode
`define UC_OP_MOVZXB          11'b001_1011_0110        // Move Byte with Zero Extend (A=operand, B=merge src)
`define UC_OP_MOVZXW          11'b001_1011_0111        // Move Word with Zero Extend (A=operand, B=merge src)
`define UC_OP_MOVSDI          11'b001_1011_1000        // Load Segment Descriptor from IDT
`define UC_OP_MOVSXD          11'b001_1011_1101        // Move Double with Sign Extend (A=operand, B=merge src)
`define UC_OP_MOVSXB          11'b001_1011_1110        // Move Byte with Sign Extend (A=operand, B=merge src)
`define UC_OP_MOVSXW          11'b001_1011_1111        // Move Word with Sign Extend (A=operand, B=merge src)

`define UC_OP_BSWAP           11'b001_1100_0000        // Byte Swap A (B is don't care 0)
`define UC_OP_BITREV          11'b001_1100_0001        // Reverse (mirror) all bits
// Modified these because BSWAP 16 bit is undefined and forces 0
`define UC_OP_MOVBE           11'b001_1100_0010        // movbe memory->reg - uses BSWAP hardware - uses Swap A
`define UC_OP_MOVBEB          11'b001_1100_0011        // movbe reg->reg - uses BSWAP hardware - uses Swap B (A is don't care)


`define UC_OP_CMC             11'b001_1111_0101        // Complement Carry Flag



//************************************************************************
// ENCODINGS FOR THE _DESCTL FIELD

`define UC_DSTCTL_DSTA_MRGA   2'h0
`define UC_DSTCTL_DSTC_MRGA   2'h1
`define UC_DSTCTL_DSTB_MRGB   2'h2
`define UC_DSTCTL_NODEST      2'h3  // don't write a result register

`define UC_DSTCTL_FP_WRREGC   2'h0  // Write integer register pointed to by RegPtrC
`define UC_DSTCTL_FP_INVERT   2'h1
`define UC_DSTCTL_FP_INVALID  2'h2  // Set Fp register C to invalid dest
`define UC_DSTCTL_FP_NONE     2'h3

//************************************************************************
// Integer register pointer definitions

// Renamed registers:
`define   UC_REG_EAX        6'h00
`define   UC_REG_ECX        6'h01
`define   UC_REG_EDX        6'h02
`define   UC_REG_EBX        6'h03
`define   UC_REG_ESP        6'h04
`define   UC_REG_EBP        6'h05
`define   UC_REG_ESI        6'h06
`define   UC_REG_EDI        6'h07
`define   UC_REG_R8         6'h08
`define   UC_REG_R9         6'h09
`define   UC_REG_R10        6'h0a
`define   UC_REG_R11        6'h0b
`define   UC_REG_R12        6'h0c
`define   UC_REG_R13        6'h0d
`define   UC_REG_R14        6'h0e
`define   UC_REG_R15        6'h0f
`define   UC_REG_TMP0       6'h10
`define   UC_REG_TMP1       6'h11
`define   UC_REG_TMP2       6'h12
`define   UC_REG_TMP3       6'h13
`define   UC_REG_TMP4       6'h14
`define   UC_REG_TMP5       6'h15
`define   UC_REG_TMP6       6'h16
`define   UC_REG_TMP7       6'h17
`define   UC_REG_TMP8       6'h18
`define   UC_REG_TMP9       6'h19
`define   UC_REG_MSTATE     6'h1a
`define   UC_REG_EFLAG      6'h1b
`define   UC_REG_FPDP       6'h1c  // x87 Floating Point Data Pointer
`define   UC_REG_RCVESP     6'h1d  // Recovery ESP

// Writeable alternate regs:
`define   UC_REG_LSFAR      6'h20  // LS fault alternate handler entry point
`define   UC_REG_INTHAR     6'h21  // intchk alternate hander entry point
`define   UC_REG_FIROBCTL   6'h22  // firob control register [2:0] == {SmiMask, FerrMask, RF}
`define   UC_REG_EFLAGSCTL  6'h23  // EflagsCtl register

// ME-substitutions:
`define   UC_REG_MREG2      6'h28  // MENG will sub x86 operand from bits 2:0 of ModRM byte or SIB byte.
                                   // (Also known as 'regm' to microcode.)
`define   UC_REG_MBASE      6'h29  // MENG will sub x86 base reg for 2 address reg case.
`define   UC_REG_MINDEX     6'h2A  // MENG will sub x86 index reg for 2 address reg case.
`define   UC_REG_MOPREG     6'h2B  // MENG will sub x86 opcode encoded in opcode byte.
`define   UC_REG_MREG1      6'h2C  // MENG will sub x86 operand from bits 5:3 of ModRM byte.
                                   // (Also known as 'reg' to microcode.)
`define   UC_REG_SETCNT     6'h2D  // MENG will sub lower 5-bits of sequencer setcnt counter (BOp only).

// Bobcat ALU Immediate Mux Selects:
`define   UC_REG_EIPADDER   6'h30  // relative branch or RIP-relative lea_alu
`define   UC_REG_NEIP       6'h31  // next sequential EIP
`define   UC_REG_PREDMACRO  6'h32  // predicted macro branch target EIP
`define   UC_REG_SPD        6'h33  // SpecEspDelta[9:2], sign-extended (used on ALU BOp or AGU COp)
`define   UC_REG_FEIP       6'h34  // Retired Effective Instruction Pointer
`define   UC_REG_IMMDISP    6'h35  // 32-bit Immediate and 32-bit Displacement: {Imm0_5[31:0], Disp0_5[31:0]}
`define   UC_REG_IMM        6'h36  // 32-bit Immediate
`define   UC_REG_FIROBCTLRD 6'h37  // FIROBCTLRD

// Other readable alternate "registers"
`define   UC_REG_ZERO       6'h3F  // Replaces operand with zero value.


//************************************************************************

// Bit disables FIROB alternate Interrupt Handler Address Register
`define INTHAR_DISABLE  14'h2000


//************************************************************************
// ENCODINGS FOR THE FLAG SEL field
`define UC_FLGSEL_MACRO   1'h0
`define UC_FLGSEL_MICRO   1'h1

// ENCODINGS FOR THE FLAG RD/WR FIELD
`define UC_FLG_WROF     5'h01           // write OF
`define UC_FLG_WRCF     5'h02           // write CF
`define UC_FLG_WRMF     5'h04           // write MF (Misc Flags, ie SZAP)
`define UC_FLG_RDOFMF   5'h08           // read OF, MF
`define UC_FLG_RDCFMF   5'h10           // read CF, MF


//************************************************************************
// ENCODINGS FOR THE LOAD/STORE FIELD field
`define UC_LDST_NOLS      2'h0
`define UC_LDST_LOAD      2'h1
`define UC_LDST_STORE     2'h2
`define UC_LDST_LDOPST    2'h3

`define UC_LDST_FPULDOP   2'h3

// LsType 2-bit vector fields
`define LSTYPE_LD  0    // bit 0 indicates a load
`define LSTYPE_ST  1    // bit 1 indicates a store


//************************************************************************
// <A NAME="uc_field_seg"></A>
// ENCODINGS FOR THE SEGMENT REGISTER field
// Hardware is relying on things implied in these specific encodings. Don't Change!
// MSB =1 forces the address size to 32!
`define UC_SEG_ES         4'h0
`define UC_SEG_CS         4'h1
`define UC_SEG_SS         4'h2
`define UC_SEG_DS         4'h3
`define UC_SEG_FS         4'h4
`define UC_SEG_GS         4'h5
`define UC_SEG_HS         4'h6          // ucode temp segment register
`define UC_SEG_DEFAULT    4'h7
`define UC_SEG_MODRM      4'h8

// The actual hardware forces the address size to 64 for all the following segments if EFER.LMA=1, otherwise forces
// the address size to 32. After that, drops to the actual segment.
`define UC_SEG_CS_64      4'h9          // Forces the address size to 64. After that, drops to the actual CS.

`define UC_SEG_GDTR       4'hA
`define UC_SEG_LDTR       4'hB
`define UC_SEG_IDTR       4'hC
`define UC_SEG_TR         4'hD
`define UC_SEG_HS_32      4'hE          // Forces the address size to 64 if EFER.LMA=1, otherwise forces the address
                                        // size to 32. After that, drops to the actual HS.
`define UC_SEG_NONE       4'hF

//************************************************************************
// ENCODINGS FOR THE OPERATION SIZE FIELD
`define  UC_OPSZ_1B             3'h0    // Basic sizes are encoded so that the encoding = length-1 (for limit checking),
`define  UC_OPSZ_2B             3'h1    // except for 16B which is overloaded into the internal-to-ME-only STSIZE encoding.
`define  UC_OPSZ_DSIZE          3'h2    // data sized (ME-only)
`define  UC_OPSZ_4B             3'h3
`define  UC_OPSZ_ASIZE          3'h4    // address sized (ME-only)
`define  UC_OPSZ_ZSIZE          3'h5    // data sized (saturates at 4B) (ME-only)
`define  UC_OPSZ_STSIZE         3'h6    // stack sized (ME-only)
`define  UC_OPSZ_8B             3'h7
`define  UC_OPSZ_16B            3'h6    // overload 16B into STSZIE (which should never be seen outside of ME)

`define UC_ADSZ_2B      2'b00
`define UC_ADSZ_4B      2'b01
`define UC_ADSZ_8B      2'b11

`define EX_ADSZ_2B      `UC_ADSZ_2B
`define EX_ADSZ_4B      `UC_ADSZ_4B
`define EX_ADSZ_8B      `UC_ADSZ_8B

//************************************************************************
// ENCODINGS FOR THE OPC FIELD
// (same as opA encodings)

// ENCODINGS FOR OPERAND B TYPE
`define UC_OPBTYP_IMM17         2'h0    // 17-bit micro-immediate, sign extended
`define UC_OPBTYP_IMM64         2'h1    // 64-bit micro-immediate (takes full diad)
`define UC_OPBTYP_REG_MCONST    2'h2    // opB is a register (or mconst if opB=30-37h)  and ucode Displacement is 7-bit mconst
`define UC_OPBTYP_REG_X86IMM    2'h3    // opB is a register (or x86immd if opB=30-37h) and ucode Displacement is 9-bit  zero extended mconst


//************************************************************************
// ENCODINGS FOR DISPLACEMENT CONTROL
`define UC_DISPCTL_MICRO         1'h0
`define UC_DISPCTL_MACRO         1'h1


//************************************************************************
// ENCODINGS FOR INTCHK


//************************************************************************
// <A NAME="uc_field_memacc"></A>
// ENCODINGS FOR MEM_ACCESS field

`define UC_MEMACC_NORMAL                 5'h00       // 
`define UC_MEMACC_PHYSICAL               5'h01       // 
`define UC_MEMACC_LOCK                   5'h02       // 
`define UC_MEMACC_SUPERVISOR             5'h03       // 
`define UC_MEMACC_IO                     5'h04       // 
`define UC_MEMACC_ACCESS_CK              5'h05       // 
`define UC_MEMACC_SEL_ERR_CODE           5'h06       // 
`define UC_MEMACC_FLUSH                  5'h07       // If issued with a load no copyback, if issued with a store cpbk
`define UC_MEMACC_CK_LMT                 5'h08       // 
`define UC_MEMACC_NO_ALIGN_CHECK         5'h09       // 
`define UC_MEMACC_SPECIAL                5'h0A       // 
`define UC_MEMACC_STORE_CK               5'h0B       // 
`define UC_MEMACC_STCHK_CONDLOCK         5'h0C       // 
`define UC_MEMACC_SPREG                  5'h0D       // Special Register access
`define UC_MEMACC_EMEM                   5'h0E       // Emulation Memory access
`define UC_MEMACC_FXSV_FXRSTR            5'h0F       // Fxsave/Fxrestore type
`define UC_MEMACC_STREAMST               5'h10       // (FP) Streaming store type
`define UC_MEMACC_CONDST                 5'h11       // Conditional streaming store, 1 byte
`define UC_MEMACC_CONDST32               5'h12       // Conditional streaming store, 4 bytes
`define UC_MEMACC_DBL                    5'h13       // Op is linked to the next op as two linked 128-bit ops
`define UC_MEMACC_DBL_EMEM               5'h14       // (MC) Emulation Memory access
`define UC_MEMACC_C6                     5'h15       // C6 memory - BU synthesizes upper nibble and is treated as WC store
`define UC_MEMACC_INVALIDATE_TLB         5'h16       // New for BT for INVLPG
`define UC_MEMACC_CLFLUSH                5'h17       // (FP) Invalidate cache line associated with given linear address from all caches
`define UC_MEMACC_128CHECK               5'h18       // Checks for 16-byte alignment conditionally.
`define UC_MEMACC_128CHECK_STRICT        5'h19       // Checks for 16-byte alignment unconditionally.
`define UC_MEMACC_128CHECK_STRICT_SS     5'h1A       // Checks for 16-byte alignment unconditionally on a streaming store.
`define UC_MEMACC_UNUSED                 5'h1B       // Actually used to cover a bobcat bug - bug 217525
`define UC_MEMACC_ADD16                  5'h1C       // hi double address needs to add 128 to lo double address
`define UC_MEMACC_DBL_256CHECK_STRICT    5'h1D       // fastpath double that will fault on 32B misalignment regardless of MXCSR.MM
`define UC_MEMACC_DBL_256CHECK_STRICT_SS 5'h1E       // (FP) Op is linked to the next op, needs to check for 32-byte alignment unconditionally, and is a streaming store
`define UC_MEMACC_UNUSED1                5'h1F

//************************************************************************
// ENCODINGS FOR CHKTYPE overloaded mem_access field (Looked at only when segldp is a 1)
// Some thought was put into these encodings to make it easier for the SRB and LS1,
// if they choose to take advantage of it. If we leave encoding 18, and 19 alone
// then the upper two bits can be used to designate override GP to TSS to both
// LS1 and SRB.  Also, the SRB can ignore the MSB for the actual checks involved
// for the DS,SS,CS,LLDT,LTR cases if they stay aliased.
`define CHKTYP  19:15

`define UC_CHKTYP_NO_CHK            5'h00       // New
`define UC_CHKTYP_JMP_CHK           5'h01       // Old
`define UC_CHKTYP_CLG_CHK           5'h02       // Old
`define UC_CHKTYP_TKG_CHK           5'h03       // Old
`define UC_CHKTYP_RET_CHK           5'h04       // Old
`define UC_CHKTYP_IRET_CHK          5'h05       // Old
`define UC_CHKTYP_INTCS_CHK         5'h06       // Old
`define UC_CHKTYP_SFWIDT_CHK        5'h07       // Old
`define UC_CHKTYP_DS_CHK            5'h0B       // New
`define UC_CHKTYP_SS_CHK            5'h0C       // New
`define UC_CHKTYP_CS_CHK            5'h0D       // New
`define UC_CHKTYP_LLDT_CHK          5'h0E       // New
`define UC_CHKTYP_LTR_CHK           5'h0F       // Old
`define UC_CHKTYP_LAR_CHK           5'h10       // New
`define UC_CHKTYP_LSL_CHK           5'h11       // New
`define UC_CHKTYP_VERR_CHK          5'h12       // New
`define UC_CHKTYP_VERW_CHK          5'h13       // New
`define UC_CHKTYP_IDT_CHK           5'h14       // New
`define UC_CHKTYP_IRETTSS_CHK       5'h1A       // Needs to convey old LS_TSS_FAULT to Load/Store
`define UC_CHKTYP_TSW_DS_CHK        5'h1B       // Needs to convey old LS_TSS_FAULT to Load/Store
`define UC_CHKTYP_TSW_SS_CHK        5'h1C       // Needs to convey old LS_TSS_FAULT to Load/Store
`define UC_CHKTYP_TSW_CS_CHK        5'h1D       // Needs to convey old LS_TSS_FAULT to Load/Store
`define UC_CHKTYP_TSW_LDT_CHK       5'h1E       // Needs to convey old LS_TSS_FAULT to Load/Store
`define UC_CHKTYP_TSW_LTR_CHK       5'h1F       // Needs to convey old LS_TSS_FAULT to Load/Store

//************************************************************************
// ENCODINGS FOR THE OPB FIELD
// (same as opA encodings)


//************************************************************************
// ENCODINGS FOR MC_TYPE field
`define UC_MCTYP_CONST            2'h0  // sign-extended 7-bit const
`define UC_MCTYP_ZSCALED_CONST    2'h1  // scaled, sign-extended 7-bit const clamped at 32-bit scaling
`define UC_MCTYP_SCALED_CONST     2'h2  // scaled, sign-extended 7-bit const
`define UC_MCTYP_MENG_CONST       2'h3  // Special MENG immediate encoded in const


// SPECIAL ENCODINGS FOR _MCONST
`define UC_MCONST_OPCD          7'h00   // opcode
`define UC_MCONST_MODRM         7'h01   // modrm
`define UC_MCONST_SIB           7'h02   // sib
`define UC_MCONST_PRFX          7'h03   // prefixes
`define UC_MCONST_ASIZE         7'h04   // address size
`define UC_MCONST_MODRM5TO3     7'h05   // modrm[5:3]
`define UC_MCONST_SEGBASE       7'h06   // Default segment, taking into account prefix overrides.
`define UC_MCONST_MMODREG       7'h07   // {rex[2],modrm[5:3]}


// ****************************************************************************
// Local special registers 
// ****************************************************************************

// local register address space assignment scheme

// 00-1F local control/config registers
// 20-4F 
// 40-5F
// 60-7F DSM (Debug State Machine)
// 80-9F segment limits
// A0-BF segment bases
// C0-EF segment attributes
// D0-FF segment selectors

// region defines
`define UC_SPREG_LCL          3'b000          // local addresses
`define UC_SPREG_LIMIT        4'b1000         // limit addresses
`define UC_SPREG_BASE         4'b1010         // base addresses
`define UC_SPREG_ATTR         3'b110          // attribute addresses
`define UC_SPREG_SEL          3'b111          // selector addresses

`define UC_SPREG_LIMIT_2BIT   2'b00           // limit addresses - shorthand implementation version
`define UC_SPREG_BASE_2BIT    2'b01           // base addresses - shorthand implementation version
`define UC_SPREG_ATTR_2BIT    2'b10           // attribute addresses - shorthand implementation version
`define UC_SPREG_SEL_2BIT     2'b11           // selector addresses - shorthand implementation version

// SR local registers
`define UC_SPREG_CR0            8'h00         // control register 0 *DON'T MOVE WITHOUT TELLING MCODE* 
`define UC_SPREG_CR4            8'h01         // control register 4 *DON'T MOVE WITHOUT TELLING MCODE* 
`define UC_SPREG_DR0            8'h02         // breakpoint 0 linear address *DON'T MOVE WITHOUT TELLING MCODE* 
`define UC_SPREG_DR1            8'h03         // breakpoint 1 linear address *DON'T MOVE WITHOUT TELLING MCODE* 
`define UC_SPREG_DR2            8'h04         // breakpoint 2 linear address *DON'T MOVE WITHOUT TELLING MCODE* 
`define UC_SPREG_DR3            8'h05         // breakpoint 3 linear address *DON'T MOVE WITHOUT TELLING MCODE* 
`define UC_SPREG_DR7            8'h06         // debug control register *DON'T MOVE WITHOUT TELLING MCODE*      
`define UC_SPREG_LS_CFG         8'h07         // LS local config register
`define UC_SPREG_VIRTCR         8'h08         // microarchitecture control oneshots
                                              // 8'h09 was FP_CFG
`define UC_SPREG_TSC            8'h0B         // timestamp counter
`define UC_SPREG_FP_COMB_SEL    8'h0E         // Combined fp dp and ip selectors - {fp_ip_sel[16:0], fp_dp_sel[160]}. Read Only
`define UC_SPREG_SVMKEY         8'h0F         // SVMLock Key register
`define UC_SPREG_SEGDISCHG_CPL  8'h10         // Bits 1:0 - effective CPL.
                                              // Bit 2    - set if the CS.L bit changes when Efer.Lma=1
                                              //            so actually reflects change between 64-bit mode and
                                              //            non 64-bit mode, which means the segmentation
                                              //            enabling/disabling info is changed.
`define UC_SPREG_LS_CTL         8'h11         // LS control register, contains NB LDT disable, disable 32-bit wrap, lock disable,
                                              // EFER.REX32, EFER.LMA, SSE disable
`define UC_SPREG_RET_INV_VEC    8'h14         // 4 bit vector - DS, ES, FS, GS
`define UC_SPREG_CPL            8'h15         // CPL (current privilege level)
`define UC_SPREG_EXCEPTION      8'h16         // Exception Vector (BOZO wgs)
`define UC_SPREG_IDREG          8'h17         // mask-programmable family/model/stepping reg 
`define UC_SPREG_TMPDESC_LO     8'h18         // temp descriptor lower half
`define UC_SPREG_TMPDESC_HI     8'h19         // temp descriptor upper half
`define UC_SPREG_FP_DP_SEL      8'h1A         // FP data pointer selector
`define UC_SPREG_FP_IP_SEL      8'h1B         // FP instruction pointer selector
`define UC_SPREG_PHYS_TYPE      8'h1C         // mtype(3 bits) + DRAM/IO(1 bit) + Quad(2 bits) + 4 don't care bits
                                              // this used to be call phys_addr in K7, the lower 4 bits were physical 
                                              // address bits 35:32.
`define UC_SPREG_MCG_CAP        8'h1D         // machine check global capability register (low 32 bits)
`define UC_SPREG_MCG_STAT       8'h1F         // machine check global status (low 32 bits)
`define UC_SPREG_MCG_CTL        8'h21         // machine check global control register (low 32 bits)
`define UC_SPREG_ZERO           8'h23         // zero-register, does not exist, but always returns 0
`define UC_SPREG_ZERO2          8'h24         // another zero-register, used for unimplemented MCi_STATUS MSRs
`define UC_SPREG_ZERO3          8'h25         // another zero-register, used for unimplemented MCi_ADDR MSRs
`define UC_SPREG_ZERO4          8'h26         // another zero-register, used for unimplemented MCi_MISC MSRs
// `define UC_SPREG_LS_MCA_CTL     8'h23         // ls machine check architecture control reg
// `define UC_SPREG_LS_MCA_STAT    8'h24         // ls machine check architecture status reg
// `define UC_SPREG_LS_MCA_ADDR    8'h25         // ls machine check architecture address reg 
// `define UC_SPREG_LS_MCA_MISC    8'h26         // ls machine check architectire misc reg (read as zero)
// `define UC_SPREG_LS_MCA_MASK    8'h27         // ls machine check architecture mask reg
`define UC_SPREG_DR4            8'h2B         // BOZO - old define to be deleted
`define UC_SPREG_DR5            8'h2C         // BOZO - old define to be deleted
`define UC_SPREG_DR0_DATA_MATCH 8'h2B         // data value for DR0 data write breakpoints
`define UC_SPREG_DR0_DATA_MASK  8'h2C         // data mask value for DR0 data write breakpoints
`define UC_SPREG_PERFMON0_MCTL  8'h30         // performance monitor 0 master control
`define UC_SPREG_PERFMON1_MCTL  8'h31         // performance monitor 1 master control
`define UC_SPREG_PERFMON2_MCTL  8'h32         // performance monitor 2 master control
`define UC_SPREG_PERFMON3_MCTL  8'h33         // performance monitor 3 master control
`define UC_SPREG_PERFMON0       8'h34         // performance monitor counter 0 
`define UC_SPREG_PERFMON1       8'h35         // performance monitor counter 1
`define UC_SPREG_PERFMON2       8'h36         // performance monitor counter 2
`define UC_SPREG_PERFMON3       8'h37         // performance monitor counter 3
`define UC_SPREG_DR0_ADDR_MASK  8'h3C         // breakpoint 0 address mask (bits 11:3)
`define UC_SPREG_SYS_LOAD_CS    8'h3D         // syscall/sysret loading of CS
`define UC_SPREG_SYS_LOAD_SS    8'h3E         // syscall/sysret loading of SS

`define UC_SPREG_PHYS_ADDR      8'h40         // physical address and type information.  Used for MONITOR/MWAIT
`define UC_SPREG_BIST_ADDR      8'h41         // Master BIST Controller CFG Addr Register
`define UC_SPREG_BIST_DATA      8'h42         // Master BIST Controller CFG Data Register

`define UC_SPREG_DSM_BASE       8'h60         // DSM registers go from 60-7B
`define UC_SPREG_DSM_CTL        8'h60         // DSM Control and Status Register
`define UC_SPREG_DSM_CLK_CNT    8'h61         // DSM Absolute Time Counter Register
`define UC_SPREG_DSM_CLK_MATCH  8'h62         // DSM Absolute Time Counter Match Register
`define UC_SPREG_DSM_GEN_CNT_0  8'h63         // DSM General Purpose Counter Register 0
`define UC_SPREG_DSM_GEN_CNT_1  8'h64         // DSM General Purpose Counter Register 1
`define UC_SPREG_DSM_GEN_CNT_2  8'h65         // DSM General Purpose Counter Register 2
`define UC_SPREG_DSM_GEN_CNT_3  8'h66         // DSM General Purpose Counter Register 3
`define UC_SPREG_DSM_RND_LFSR   8'h67         // DSM Random Event Generator LFSR Register
`define UC_SPREG_DSM_RND_POLY   8'h68         // Random Event Generator Feedback Polynomial Register
`define UC_SPREG_DSM_RND_MASK   8'h69         // DSM Random Event Generator Mask Register
`define UC_SPREG_DSM_RND_MATCH  8'h6A         // DSM Random Event Generator Match Register
//`define UC_SPREG_DSM_TRIG_DATA_0 8'h6B
`define UC_SPREG_DSM2MCODE      8'h6B         // DSM to Microcode Control
`define UC_SPREG_MCODE2DSM      8'h6C         // Microcode to DSM Control
`define UC_SPREG_DSM_RND_MASK1  8'h6D         // DSM Random Event Generator Mask Register 1
`define UC_SPREG_DSM_SM_VEC_0_0 8'h6E         // DSM state 0, vector 0
`define UC_SPREG_DSM_SM_VEC_0_1 8'h6F         // DSM state 0, vector 1
`define UC_SPREG_DSM_SM_VEC_0_2 8'h70         // DSM state 0, vector 2
`define UC_SPREG_DSM_SM_VEC_1_0 8'h71         // DSM state 1, vector 0
`define UC_SPREG_DSM_SM_VEC_1_1 8'h72         // DSM state 1, vector 1
`define UC_SPREG_DSM_SM_VEC_1_2 8'h73         // DSM state 1, vector 2
`define UC_SPREG_DSM_SM_VEC_2_0 8'h74         // DSM state 2, vector 0
`define UC_SPREG_DSM_SM_VEC_2_1 8'h75         // DSM state 2, vector 1
`define UC_SPREG_DSM_SM_VEC_2_2 8'h76         // DSM state 2, vector 2
`define UC_SPREG_DSM_SM_VEC_3_0 8'h77         // DSM state 3, vector 0
`define UC_SPREG_DSM_SM_VEC_3_1 8'h78         // DSM state 3, vector 1
`define UC_SPREG_DSM_SM_VEC_3_2 8'h79         // DSM state 3, vector 2
`define UC_SPREG_DSM_TRIG_PRE_SEL1 8'h7A      // DSM Preselected Trigger 1
`define UC_SPREG_DSM_TRIG_PRE_SEL2 8'h7B      // DSM Preselected Trigger 2
`define UC_SPREG_DSM_ACT_PRE_SEL01 8'h7C      // DSM Action Preselect 01
`define UC_SPREG_DSM_ACT_PRE_SEL23 8'h7D      // DSM Action Preselect 23
`define UC_SPREG_DSM_CTL2       8'h7E         // DSM Breakpoint Control Register
`define UC_SPREG_DSM_RND_MATCH1 8'h7F         // DSM Random Event Generator Match Register 1

// Don't change the order and encodings for the segment selectors below from UC_SPREG_ES_LIMIT
// to UC_SPREG_GS_SEL without informing microcoders, since reset microcode mc_reset.s counts on
// the following order and encodings to initialize segment selectors related informations.

`define UC_SPREG_ES_LIMIT     8'h80           // data segment limit
`define UC_SPREG_CS_LIMIT     8'h81           // code segment limit
`define UC_SPREG_SS_LIMIT     8'h82           // stack segment limit
`define UC_SPREG_DS_LIMIT     8'h83           // data segment limit
`define UC_SPREG_FS_LIMIT     8'h84           // data segment limit
`define UC_SPREG_GS_LIMIT     8'h85           // data segment limit
`define UC_SPREG_HS_LIMIT     8'h86           // data segment limit
`define UC_SPREG_GDTR_LIMIT   8'h8A           // global descriptor table limit
`define UC_SPREG_LDTR_LIMIT   8'h8B           // local descriptor table limit
`define UC_SPREG_IDTR_LIMIT   8'h8C           // interrupt descriptor table limit
`define UC_SPREG_TR_LIMIT     8'h8D           // task segment limit

`define UC_SPREG_DSM_TRIG_DATA_0   8'h90      // 
`define UC_SPREG_DSM_TRIG_DATA_1   8'h91      // 
`define UC_SPREG_DSM_TRIG_SEL      8'h92      // 
`define UC_SPREG_DSM_DBG_DELAY     8'h93      //
`define UC_SPREG_DSM_DBG_MASK      8'h94      //
`define UC_SPREG_DSM_DBUS_MISR     8'h95      //

`define UC_SPREG_ES_BASE      8'hA0           // data segment base
`define UC_SPREG_CS_BASE      8'hA1           // code segment base
`define UC_SPREG_SS_BASE      8'hA2           // stack segment base
`define UC_SPREG_DS_BASE      8'hA3           // data segment base
`define UC_SPREG_FS_BASE      8'hA4           // data segment base
`define UC_SPREG_GS_BASE      8'hA5           // data segment base
`define UC_SPREG_HS_BASE      8'hA6           // data segment base
`define UC_SPREG_GDTR_BASE    8'hAA           // global descriptor table base addr
`define UC_SPREG_LDTR_BASE    8'hAB           // local descriptor table base
`define UC_SPREG_IDTR_BASE    8'hAC           // interrupt descriptor table base addr
`define UC_SPREG_TR_BASE      8'hAD           // task segment base

`define UC_SPREG_DSM_PERF_CTL0     8'hB0      //
`define UC_SPREG_DSM_PERF_CTL1     8'hB1      //
`define UC_SPREG_DSM_PERF_CTL2     8'hB2      //
`define UC_SPREG_DSM_PERF_CTL3     8'hB3      //
`define UC_SPREG_EXCP_HIS          8'hB4      //
`define UC_SPREG_DSM_DBGBUS_CFG    8'hB5      //

`define UC_SPREG_ES_ATTR      8'hC0           // data segment attribute
`define UC_SPREG_CS_ATTR      8'hC1           // code segment attribute
`define UC_SPREG_SS_ATTR      8'hC2           // stack segment attribute
`define UC_SPREG_DS_ATTR      8'hC3           // data segment attribute
`define UC_SPREG_FS_ATTR      8'hC4           // data segment attribute
`define UC_SPREG_GS_ATTR      8'hC5           // data segment attribute
`define UC_SPREG_HS_ATTR      8'hC6           // data segment attribute
`define UC_SPREG_GDTR_ATTR    8'hCA           // global descriptor table attribute
`define UC_SPREG_LDTR_ATTR    8'hCB           // local descriptor table attribute
`define UC_SPREG_IDTR_ATTR    8'hCC           // interrupt descriptor table attribute
`define UC_SPREG_TR_ATTR      8'hCD           // task segment attribute

`define UC_SPREG_ES_SEL       8'hE0           // SR copy of selector
`define UC_SPREG_CS_SEL       8'hE1           // SR copy of selector
`define UC_SPREG_SS_SEL       8'hE2           // SR copy of selector
`define UC_SPREG_DS_SEL       8'hE3           // SR copy of selector
`define UC_SPREG_FS_SEL       8'hE4           // SR copy of selector
`define UC_SPREG_GS_SEL       8'hE5           // SR copy of selector
`define UC_SPREG_GS_SEL       8'hE5           // SR copy of selector
`define UC_SPREG_HS_SEL       8'hE6           // SR copy of selector
`define UC_SPREG_GDTR_SEL     8'hEA           // SR copy of selector
`define UC_SPREG_LDTR_SEL     8'hEB           // SR copy of selector
`define UC_SPREG_IDTR_SEL     8'hEC           // SR copy of selector
`define UC_SPREG_TR_SEL       8'hED           // SR copy of selector


//************************************************************************
// SVM VMCB Flush TLB control bits
`define VMCB_TLB_CTL_FLUSH          8'h1
`define VMCB_TLB_CTL_FLUSH_CURRASID 8'h2
`define VMCB_TLB_CTL_FLUSH_LOCAL    8'h4



//************************************************************************
// virtcr bits

// Bit Definitions for UC_SPREG_MISC_CTL1 (VIRTCR register)
`define UC_VIRTCR_INV_TLB     0
`define UC_VIRTCR_INV_TLBG    1
`define UC_VIRTCR_INV_DC      2
`define UC_VIRTCR_INV_IC      3
`define UC_VIRTCR_CLEAR_IC    4
`define UC_VIRTCR_FLUSH_WC    5
`define UC_VIRTCR_FLUSH_VB    6
`define UC_VIRTCR_FLUSH_PDC   7
`define UC_VIRTCR_INST_BRK    11:8
`define UC_VIRTCR_INTR_TKN    12
`define UC_VIRTCR_INV_IL2     13
`define UC_VIRTCR_CPUID       14
`define UC_VIRTCR_CLEAR_EMEM  15
`define UC_VIRTCR_FLUSH_GTLB  16
// LS_ClrSvmInfo  // 17: ???
`define UC_VIRTCR_WBINVD_IL2  18
`define UC_VIRTCR_FLUSH_TLB_CURRASID  19

// symbolic constants for one-shot microarchitecture control register 1 virtcr lower 16 - use with const 
`define VCR_FLUSH_TLBL      16'h0001     //  0: invalidate non-global L1 & L2 TLBs entries (filtered by Flush Filter if armed)
`define VCR_FLUSH_TLBG      16'h0002     //  1: invalidate all L1 & L2 TLBs entries, including both local (filtered by Flush Filter if armed) and global entries                          
`define VCR_FLUSH_DC        16'h0004     //  2: invalidate DC (flash clear, no writeback)
`define VCR_FLUSH_IC        16'h0008     //  3: invalidate IC (flash clear, no writeback)
`define VCR_CLEAR_IC        16'h0010     //  4: shutdown the prefetcher
`define VCR_FLUSH_WC        16'h0020     //  5: flush write combining buffer
`define VCR_FLUSH_VB        16'h0040     //  6: flush victim buffer
`define VCR_FLUSH_PDC       16'h0080     //  7: flush PDC, used by VMRUN.
`define VCR_INST_BRK        16'h0f00     // 11:8: Firob counts the breakpoints
`define VCR_BP0             16'h0100     //  8: breakpoint 0
`define VCR_BP1             16'h0200     //  9: breakpoint 1
`define VCR_INTR_TKN        16'h1000     // 12: CCU counts taken INTR
`define VCR_FLUSH_IL2       16'h2000     // 13: Invalidate IL2
`define VCR_CPUID           16'h4000     // 14: For CPUID counting
`define VCR_CLEAR_EMEM      16'h8000     // 15: clear EMEM with hardware state machine in reset
// virtcr (upper 16 bits)
`define VCR_U_FLUSH_GTLB    16'h0001     // 16: invalidate guest TLBs
// LS_ClrSvmInfo  // 17: ???
`define VCR_U_WBINVD_IL2    16'h0004     // 18: kick off WBINVD hardware in L2
`define VCR_U_FLUSH_TLB_CURRASID  16'h0008 // 19: Clears all PDC entries which match the current ASID

// Bit definitions for the LS physical address type register phys_type
`define UC_PHYSTYPE_QUAD     5:4
`define UC_PHYSTYPE_DRAM       6
`define UC_PHYSTYPE_MEMTYPE  9:7

// Bit definitions for the DC Scrubber Correction register
`define UC_DCSCRUB_VAL          0       // Valid bit
`define UC_DCSCRUB_WAY          1       // Way
`define UC_DCSCRUB_EMEM         2       // Emulation memory
`define UC_DCSCRUB_QWORD      5:3       // Quadword address
`define UC_DCSCRUB_IDX       14:6       // Index
`define UC_DCSCRUB_BIT      20:15       // Bit pointer when the error is in one of the data bits 0-63
`define UC_DCSCRUB_ECC         21       // Indicates the error is in one of the ecc bits



// ****************************************************************************
// Remote special registers
// ****************************************************************************

// move these to a new home (these registers are not in the bu, -Kurt)
//`define UC_SPREG_TLB_REP_TAG  8'h00   // TLB replaced tag     (in ic and dc?)
//`define UC_SPREG_TLB_REP_DATA 8'h00   // TLB replaced data    (in ic and dc?)
//`define UC_SPREG_TLB_REP_ENT  8'h00   // TLB replaced entry   (in ic and dc?)

// Registers shared between multiple TLMs

`define UC_SPREG_PERFMON0123_CTL 6'b111000 // performance monitor 0-3 base address
`define UC_SPREG_PERFMON0_CTL   8'hE0   // performance monitor 0 local TLM control
`define UC_SPREG_PERFMON1_CTL   8'hE1   // performance monitor 1 local TLM control
`define UC_SPREG_PERFMON2_CTL   8'hE2   // performance monitor 2 local TLM control
`define UC_SPREG_PERFMON3_CTL   8'hE3   // performance monitor 3 local TLM control

// BU (BU reserves 8'h00 to 8'h7F (128 entries))

`define UC_SPREG_FFPDC_ADDR_SR  8'h00   // Address Register to access Region Table (FF) or PDC
`define UC_SPREG_FFPDC_DATA1    8'h01   // Data Register (#1) to access Region Table (FF) or PDC
`define UC_SPREG_FFPDC_DATA2    8'h02   // Data Register (#2) to access Region Table (FF) or PDC
`define UC_SPREG_BU_HCR3        8'h03   // Host Control Register 3 

`define UC_SPREG_BU_PDP0        8'h04   // Register to access PDP0 (write only - used by microcode)
`define UC_SPREG_BU_PDP1        8'h05   // Register to access PDP1 (write only - used by microcode)
`define UC_SPREG_BU_PDP2        8'h06   // Register to access PDP2 (write only - used by microcode)
`define UC_SPREG_BU_PDP3        8'h07   // Register to access PDP3 (write only - used by microcode)

`define UC_SPREG_BU_PFLA        8'h08   // Page Fault Linear Address
`define UC_SPREG_BU_PFCODE      8'h09   // Page Fault Error Code
`define UC_SPREG_BU_CR3         8'h0a   // Control register 3 *DON'T MOVE WITHOUT TELLING MCODE* 
`define UC_SPREG_BU_CTL         8'h0b   // BU Control Register
`define UC_SPREG_BU_CURR_ASID   8'h0c   // SVM Current Address Space Identification
//`define UC_SPREG_L2_EXCFGBASE                   8'h0D           // PCIE Config Intercept Base Reg
`define UC_SPREG_BU_HCR0        8'h0d   // Host copies of CR0 bits for nested paging
`define UC_SPREG_BU_SMMKEY      8'h0e   // Key for Smm Lock bit
`define UC_SPREG_BU_MONITOR     8'h0f   // BU register that supports Monitor/MWait instructions

// BOZO remove UC_SPREG_BU_DEVBASE when it is removed fromother files
`define UC_SPREG_BU_DEVBASE     8'h0c   // DMA Exclusion Vector base page address

`define UC_SPREG_BU_CFG         8'h10   // BU Configuration Register
`define UC_SPREG_SYS_CFG        8'h11   // System Configuration Register
`define UC_SPREG_SYS_INITL      8'h12   // System interface state, assigned at reset (read-only), Low 32b
`define UC_SPREG_SYS_INITH      8'h13   // System interface state, assigned at reset (read-only), High 32b
`define UC_SPREG_BU_APICL       8'h14   // Apic Base Address
`define UC_SPREG_BU_PATL        8'h15   // Page Attribute Table
`define UC_SPREG_BU_SMMADDR     8'h16   // Smm Address Base
`define UC_SPREG_BU_SMMMASK     8'h17   // Smm Address Mask

`define UC_SPREG_BU_L2DATAL     8'h1c   // L2 Debug Read/Write Data Register, Low 32b
`define UC_SPREG_BU_L2DATAH     8'h1d   // L2 Debug Read/Write Data Register, High 32b
`define UC_SPREG_BU_L2ADDR      8'h1e   // L2 Debug Read/Write Address Register
`define UC_SPREG_BU_ECS_BASE    8'h1f   // BU Extended Config Space Base Register

//`define UC_SPREG_BU_IOVAR       6'b001000 // IO Variable Range (4 64b registers)

// Note: don't change relative order IOBASEs, IOMASks, TOMADDRs without changing ucode
`define UC_SPREG_BU_IOBASE0     8'h20   // IO Base 0
`define UC_SPREG_BU_IOMASK0     8'h21   // IO Mask 0
`define UC_SPREG_BU_IOBASE1     8'h22   // IO Base 1
`define UC_SPREG_BU_IOMASK1     8'h23   // IO Mask 1
`define UC_SPREG_BU_TOMADDR     8'h24   // Top of Memory
`define UC_SPREG_BU_MTRRCAP     8'h25   // MTRR Capability register
`define UC_SPREG_BU_MTRRDEF     8'h26   // MTRR Default Memory Type
`define UC_SPREG_BU_TOMADDR2    8'h27   // Top of Memory 2

`define UC_SPREG_BU_BUL2I       4'b0011 // The 16 register block that BUINT sends to BUL2I

`define UC_SPREG_BU_BISTADDR    8'h30   // BU BIST controller address
`define UC_SPREG_BU_BISTDATA    8'h31   // BU BIST controller data
`define UC_SPREG_L2_CFG2        8'h32   // L2 Data Configuration Register
`define UC_SPREG_L2_CFG3        8'h33   // L2 Tag Configuration Register
`define UC_SPREG_BU_ARRAYADDR   8'h34   // L2 Partial Tag array access address register.
`define UC_SPREG_BU_ARRAYDATA   8'h35   // L2 Partial Tag array access data register.
                                        // Note: mcode (MSR) depends on the ordering of the MCA regs!
//                              8'h36-37// reserved and unimplemented MCA reg, don't use
`define UC_SPREG_BU_MCA_CTL     8'h38   // BU MCA Control
`define UC_SPREG_BU_MCA_STAT    8'h39   // BU MCA Status
`define UC_SPREG_BU_MCA_ADDR    8'h3a   // BU MCA Address
`define UC_SPREG_BU_MCA_MISC    8'h3b   // BU MCA Misc, needs to return 0s
`define UC_SPREG_BU_MCA_MASK    8'h3c   // BU MCA Mask

`define UC_SPREG_BU_MTRRVAR     4'b0100 // MTRR Variable Range (32 32b registers) 8'h4x and 8'h5x
                                        // Note: The Bu makes us of this being 32 size aligned.

`define UC_SPREG_BU_MTRRBASE0   8'h40   // MTRR Variable Range Base 0 (start on 64B boundary)
`define UC_SPREG_BU_MTRRMASK0   8'h41   // MTRR Variable Range Mask 0
`define UC_SPREG_BU_MTRRBASE1   8'h42   // MTRR Variable Range Base 1
`define UC_SPREG_BU_MTRRMASK1   8'h43   // MTRR Variable Range Mask 1
`define UC_SPREG_BU_MTRRBASE2   8'h44   // MTRR Variable Range Base 2
`define UC_SPREG_BU_MTRRMASK2   8'h45   // MTRR Variable Range Mask 2
`define UC_SPREG_BU_MTRRBASE3   8'h46   // MTRR Variable Range Base 3
`define UC_SPREG_BU_MTRRMASK3   8'h47   // MTRR Variable Range Mask 3
`define UC_SPREG_BU_MTRRBASE4   8'h48   // MTRR Variable Range Base 4
`define UC_SPREG_BU_MTRRMASK4   8'h49   // MTRR Variable Range Mask 4
`define UC_SPREG_BU_MTRRBASE5   8'h4a   // MTRR Variable Range Base 5
`define UC_SPREG_BU_MTRRMASK5   8'h4b   // MTRR Variable Range Mask 5
`define UC_SPREG_BU_MTRRBASE6   8'h4c   // MTRR Variable Range Base 6
`define UC_SPREG_BU_MTRRMASK6   8'h4d   // MTRR Variable Range Mask 6
`define UC_SPREG_BU_MTRRBASE7   8'h4e   // MTRR Variable Range Base 7
`define UC_SPREG_BU_MTRRMASK7   8'h4f   // MTRR Variable Range Mask 7

`define UC_SPREG_BU_MTRR64K     8'h50   // MTRR Fixed Range 64K
`define UC_SPREG_BU_MTRR16K0    8'h51   // MTRR Fixed Range 16K 0
`define UC_SPREG_BU_MTRR16K1    8'h52   // MTRR Fixed Range 16K 1
`define UC_SPREG_BU_MTRR4K0     8'h58   // MTRR Fixed Range 4K 0
`define UC_SPREG_BU_MTRR4K1     8'h59   // MTRR Fixed Range 4K 1
`define UC_SPREG_BU_MTRR4K2     8'h5a   // MTRR Fixed Range 4K 2
`define UC_SPREG_BU_MTRR4K3     8'h5b   // MTRR Fixed Range 4K 3
`define UC_SPREG_BU_MTRR4K4     8'h5c   // MTRR Fixed Range 4K 4
`define UC_SPREG_BU_MTRR4K5     8'h5d   // MTRR Fixed Range 4K 5
`define UC_SPREG_BU_MTRR4K6     8'h5e   // MTRR Fixed Range 4K 6
`define UC_SPREG_BU_MTRR4K7     8'h5f   // MTRR Fixed Range 4K 7

`define UC_SPREG_FP_CFG         8'h60   // FP local config register 
`define  UC_SPREG_L2_ADDR_SR    8'h66   // L2 Array Access (Addr) in BU
`define  UC_SPREG_L2_DATA_ECC   8'h67   // L2 Array Access (Ecc/Lru) in BU
`define  UC_SPREG_L2_DATA_LO    8'h68   // L2 Array Access (Data) in BU
`define  UC_SPREG_BU_CFG2       8'h69
`define  UC_SPREG_L2_FATAL      8'h6a   // still in ucode tools (s/b removed) but unused by rtl
`define  UC_SPREG_L2_SIGN       8'h6b
`define  UC_SPREG_L2_SIGN1      8'h6c
`define  UC_SPREG_L2_SIGN2      8'h6d
`define  UC_SPREG_BU_ECS_ACC_ADDR 8'h6e  // Captured ECS access address.
`define  UC_SPREG_BU_ECS_ACC_DATA 8'h6f  // Captured ECS store data.


// L2 CACHE
`define UC_SPREG_BU_CFG3        8'h70 // L2 cache configuration
`define UC_SPREG_BU_SFTRPR_IDX  8'h71  // L2 soft repair index, command and data register
`define UC_SPREG_BU_SFTRPR_DATA 8'h72  // L2 soft repair data register  

// CCU (FR)
`define UC_SPREG_EIP               8'h80  // Retired Effective Instruction Pointer
`define UC_SPREG_FP_IP_OFF         8'h81  // FPU Instruction pointer (offset)
`define UC_SPREG_FP_OP             8'h83  // FPU Opcode
`define UC_SPREG_BR_FROM           8'h85  // LastBranchFrom register
`define UC_SPREG_BR_TO             8'h86  // LastBranchTo register
`define UC_SPREG_BITMAP            8'h87  // Trace BitMap register
`define UC_SPREG_DBG_CTL_MSR       8'h88  // Intel-compatible DbgCtl (minus trace)
`define UC_SPREG_DBG_CTL_MSR2      8'h89  // Amd proprietary DbgCtl
`define UC_SPREG_DR6_MSTR          8'h8A  // DR6 master register
`define UC_SPREG_DISP_FLT          8'h8B  // Dispatch fault reason vector
`define UC_SPREG_VINTR_CTL         8'h8C  // Virtual interrupt control register
`define UC_SPREG_INT_EDGE          8'h8D  // Edge bits for external interrupts (PREQ, FLUSH, SMI, INIT, NMI, INTR, STPCLK)
`define UC_SPREG_INT_LEVEL         8'h8E  // Level bits for external interrupts (PREQ, FLUSH, SMI, INIT, NMI, INTR, STPCLK)
`define UC_SPREG_INT_MASK          8'h8F  // Mask bits for external interrupts (PREQ, FLUSH, SMI, INIT, NMI, INTR, STPCLK) Don't change without telling Fritz - used with Genesys tests.
`define UC_SPREG_INT_PENDING       8'h90  // Pending external interrupt register (FLUSH, SMI, INIT, NMI, INTR, STPCLK...)
`define UC_SPREG_FR_DBG_CTL        8'h91  // Firob debug control register
`define UC_SPREG_SSE_IP_OFF        8'h93  // SSE Instruction pointer (offset)
`define UC_SPREG_RCV_ESPDELTA      8'h94  // Recovery EspDelta
`define UC_SPREG_CPU_WD_TMR_CFG    8'h95  // Firob cpu watchdog timer config register
`define UC_SPREG_FR_MCA_CTL        8'h96  // FR MCA Ctl
`define UC_SPREG_FR_MCA_STAT       8'h97  // FR MCA Status, Low 32b
`define UC_SPREG_FR_MCA_ADDR       8'h98  // FR MCA Address, Low 32b
`define UC_SPREG_FR_MCA_MISC       8'h99  // FR MCA Misc, Low 32b
`define UC_SPREG_FR_MCA_MASK       8'h9a  // FR MCA Mask, Low 32b
`define UC_SPREG_FR_IBS_CTL        8'h9b  // FR IBS control reg. Note: Located in ME SRB stop.
`define UC_SPREG_FR_IBS_IP_OFF     8'h9c  // FR IBS instruction pointer reg
`define UC_SPREG_FR_IBS_DATA       8'h9d  // FR IBS data reg
`define UC_SPREG_FR_IBS_BRN_TARGET 8'h9e  // FR IBS macro branch target reg
`define UC_SPREG_X87_REG_CACHE_STAT 8'h9f  // FR X87 register cache control/status reg

// DCACHE
`define UC_SPREG_DC_ADDR        8'hA0   // dcache address register for special array movement
`define UC_SPREG_DC_INVLPG      8'hA1   // writes to this register invalidate the page specified
`define UC_SPREG_DC_DATA_LO     8'hA2   // dcache data register for special array movement
`define UC_SPREG_DC_DATA_HI     8'hA3   // dcache data register for special array movement
`define UC_SPREG_DC_MCA_CTL     8'hA4   // dcache machine check architecture control reg
`define UC_SPREG_DC_MCA_STAT    8'hA5   // dcache machine check architecture status reg
`define UC_SPREG_DC_MCA_ADDR    8'hA6   // dcache machine check architecture address reg
`define UC_SPREG_DC_MCA_MISC    8'hA7   // dcache machine check architectire misc reg (read as zero)
`define UC_SPREG_DC_MCA_MASK    8'hA8   // dcache machine check architecture mask reg
// unused encoding 8'hA9
`define UC_SPREG_DC_ECC_CORR    8'hAA   // correction register for ecc load errors
`define UC_SPREG_DC_PHYS_ADDR   8'hAB   // physical address saved on access checks - used to support monitor/mwait
`define UC_SPREG_DC_CFG         8'hAC   // dcache config register
`define UC_SPREG_DC_BIST        8'hAD   // dcache BIST fatal error result register
`define UC_SPREG_DC_SCRUB_ADDR  8'hAE   // dcache scrubber address register
`define UC_SPREG_DC_SCRUB_CORR  8'hAF   // dcache scrubber correction register

// ICACHE
`define UC_SPREG_IC_DR0            8'hB0   // icache architectural copy of debug register 0 for instruction breakpointing
`define UC_SPREG_IC_DR1            8'hB1   // icache architectural copy of debug register 1 for instruction breakpointing
`define UC_SPREG_IC_DR2            8'hB2   // icache architectural copy of debug register 2 for instruction breakpointing
`define UC_SPREG_IC_DR3            8'hB3   // icache architectural copy of debug register 3 for instruction breakpointing
`define UC_SPREG_IC_CS_BASE        8'hB4   // icache architectural copy of code segment descriptor base.
`define UC_SPREG_IC_CS_LIMIT       8'hB5   // icache architectural copy of the code segment limit expressed in 32bit form
`define UC_SPREG_IC_CS_ATTR        8'hB6   // icache architectural copy of the code segment "D" bit
`define UC_SPREG_IC_MCA_CTL        8'hB7   // icache machine check architecture control reg
`define UC_SPREG_IC_MCA_STAT       8'hB8   // icache machine check architecture status reg
`define UC_SPREG_IC_MCA_ADDR       8'hB9   // icache machine check architecture address reg
`define UC_SPREG_IC_MCA_MISC       8'hBA   // no storage, just returns 0's, writes bit-bucket 
`define UC_SPREG_IC_MCA_MASK       8'hBB   // icache machine check architecture mask reg
                                           // BC is reserved and unimplemented MCA reg, don't use - why???

`define UC_SPREG_ID_SFTRPR_IDX     8'hBC   // ID soft repair index, command and status register
`define UC_SPREG_ID_SFTRPR_DATA    8'hBD   // ID soft repair data register
`define UC_SPREG_ID_ADDR           8'hBE   // pc address register for special array movement
`define UC_SPREG_ID_DATA_LO        8'hBF   // pc data register for special array movement


// ME
`define UC_SPREG_ME_CFG         8'hC0   // ME config register.
`define UC_SPREG_ME_PWORD0      8'hC1   // Patch RAM 64-bit COP0 data to write.               Write only.
`define UC_SPREG_ME_PWORD1      8'hC2   // Patch RAM 64-bit COP1 data to write.               Write only.
`define UC_SPREG_ME_PSEQCTL     8'hC3   // Patch RAM 19-bit Sequence Control Field to write.  Write only.
`define UC_SPREG_ME_PADDR       8'hC4   // Patch RAM address to update.                       Write only.
`define UC_SPREG_ME_PBKPT0      8'hC5   // Patch breakpoint register 0.                       Write only.
`define UC_SPREG_ME_PBKPT1      8'hC6   // patch breakpoint register 1.                       Write only.
`define UC_SPREG_ME_PBKPT2      8'hC7   // patch breakpoint register 2.                       Write only.
`define UC_SPREG_ME_PBKPT3      8'hC8   // patch breakpoint register 3.                       Write only.
`define UC_SPREG_ME_PATCH_CLR   8'hC9   // Initialize the patch registers to all ones, to guarantee no matches. Write only.

// DE
`define UC_SPREG_DE_XCR0        8'hCA   // XCR0 - XFEATURE_ENABLED_MASK register
`define UC_SPREG_DE_TRAPOP0     8'hCB   // Instruction match 0
`define UC_SPREG_DE_TRAPMSK0    8'hCC   // Instruction match mask 0
`define UC_SPREG_DE_TRAPOP1     8'hCD   // Instruction match 1     
`define UC_SPREG_DE_TRAPMSK1    8'hCE   // Instruction match mask 1
`define UC_SPREG_DE_CFG         8'hCF   // Decoder configuration register


// More IC
`define UC_SPREG_IC_DR0_ADDR_MASK  8'hD0   // breakpoint 0 address mask (bits 11:0)
`define UC_SPREG_ID_DATA_HI        8'hD1   // pc data register for special array movement
`define UC_SPREG_IC_DATA_LO        8'hD2   // icache data register for special array movement
`define UC_SPREG_IC_DATA_HI        8'hD3   // icache data register for special array movement
`define UC_SPREG_IC_ADDR           8'hD4   // icache address register for special array movement
                                           // D5, is reserved and unimplemented MCA reg, don't use
`define UC_SPREG_IC_CTL            8'hD6   // icache control register
`define UC_SPREG_IC_CFG            8'hD7   // icache configuration
`define UC_SPREG_IF_SFTRPR_IDX     8'hD8   // IF soft repair index, command and status register
`define UC_SPREG_IF_SFTRPR_DATA    8'hD9   // IF soft repair data register
`define UC_SPREG_HDTCMD            8'hDA   // HDT command register
`define UC_SPREG_HDTDATA           8'hDB   // HDT data register
`define UC_SPREG_IC_FATAL          8'hDC   // Bist fatal bit register.
// `define UC_SPREG_CPUID             8'hDD   // cpu id revision number.
// `define UC_SPREG_UTIL              8'hDF   // cpu product engineering utility bits.
// `define UC_SPREG_IC_FATAL2         8'hE0   // cpu product engineering utility bits. Read only.
// `define UC_SPREG_DC_FATAL2         8'hE1   // cpu product engineering utility bits. Read only.
// `define UC_SPREG_IC_BISTDATA       8'hE4   // BU BIST controller data
`define UC_SPREG_IC_IBS_CTL        8'hE6   // IBS control register
`define UC_SPREG_IC_IBS_LIN_AD     8'hE7   // IBS linear address register
`define UC_SPREG_IC_IBS_PHYS_AD    8'hE8   // IBS physical address register
`define UC_SPREG_IC_BISTADDR       8'hE9   // BU BIST controller address - moved here since it conflicted with UC_SPREG_PERFMON3_CTL (Bug GH8612)
                                           // BU BIST not used on BT, but is in utl_msr_access.sv so this can't be removed 
// `define UC_SPREG_HDT2CMD           8'hEA   // HDT2 command register (held in TL, interfaced with Sideband Interface (SBI)/ Direct Connect Technology (DCT))
// `define UC_SPREG_HDT2DATA          8'hEB   // HDT2 data register (held in TL, interfaced with Sideband Interface (SBI)/ Direct Connect Technology (DCT))
// `define UC_SPREG_FC_ADDR           8'hEC   // Fuse Controller broadcast address
`define UC_SPREG_DC_IBS_DATA       8'hED   // DC IBS data register
`define UC_SPREG_DC_IBS_LIN_AD     8'hEE   // DC IBS linear address register
`define UC_SPREG_DC_IBS_PHYS_AD    8'hEF   // DC IBS physical address register

// APM/Cac Monitor
`define UC_SPREG_DC_APMCTL         8'hF0  // APM control register
`define UC_SPREG_DC_APMDATA        8'hF1  // APM data register

// more BU
`define UC_SPREG_BU_PWR_CTRL    8'hF2   // Power Reduction Control Register, not used on BT, but is in utl_msr_access.sv so this can't be removed

// DC soft repair registers
`define UC_SPREG_DC_SFTRPR_IDX     8'hF3   // DC soft repair index, command and status register
`define UC_SPREG_DC_SFTRPR_DATA    8'hF4   // DC soft repair data register

// Applications Power Management (APM) Digital Power Monitor (DPM)
`define UC_SPREG_AD_DPM_BASE 6'h3F   // Base address of the DPM register range (i.e. the 6 MSBs of 8'hFC shifted right by 2)
`define UC_SPREG_AD_DPM_DBG  8'hFC   // DPM debug register
`define UC_SPREG_AD_DPM_LOG  8'hFD   // DPM log register
`define UC_SPREG_AD_DPM_WAC  8'hFE   // DPM weight array access
`define UC_SPREG_AD_DPM_CFG  8'hFF   // DPM configuration register

// Fuse Controller bits
`define UC_SPBIT_FC_CACHE       31:30
`define UC_SPBIT_FC_CACHE_L3    2'b00
`define UC_SPBIT_FC_CACHE_IC    2'b01
`define UC_SPBIT_FC_CACHE_DC    2'b10
`define UC_SPBIT_FC_CACHE_L2    2'b11
`define UC_SPBIT_FC_TAG         29
`define UC_SPBIT_FC_ECC         29
`define UC_SPBIT_FC_ROW         28
`define UC_SPBIT_FC_HVAL        27
`define UC_SPBIT_FC_SLICE       25:23
`define UC_SPBIT_FC_DONE        22
`define UC_SPBIT_FC_MACRO       20:16
`define UC_SPBIT_FC_REPAIR      8:0

//  ICACHE code segment attribute bits
`define UC_SPBIT_IC_CS_ATTR_D             10  // copy of code segment descriptor D bit
`define UC_SPBIT_IC_CS_ATTR_L             9   // copy of code segment descriptor L bit
`define UC_SPBIT_IC_CS_ATTR_R             1   // copy of code segment descriptor R bit
`define UC_SPBIT_IC_CS_ATTR_G             11  // copy of code segment descriptor G bit

//  ICACHE control bits.
`define UC_SPBIT_IC_CTL_DR0               0   // enable for debug register 0 for instruction breakpointing
`define UC_SPBIT_IC_CTL_DR1               1   // enable for debug register 1 for instruction breakpointing
`define UC_SPBIT_IC_CTL_DR2               2   // enable for debug register 2 for instruction breakpointing
`define UC_SPBIT_IC_CTL_DR3               3   // enable for debug register 3 for instruction breakpointing
`define UC_SPBIT_IC_CTL_LOCK_ERR          4   // lock mca error in logging registers

//  ICACHE configuration bits.
//  NOTE that you must keep this up to date with simenv/s_rndcfg.pl
`define UC_SPBIT_IC_CFG_DIS_BP              0  // disable branch predictor
`define UC_SPBIT_IC_CFG_DIS_LHIST           1  // disable local predictor (all branches defer to global predictor)
`define UC_SPBIT_IC_CFG_DIS_GHIST           2  // disable global predictor (all branches predict taken once taken)
`define UC_SPBIT_IC_CFG_DIS_BTAC            3  // disable branch target address calculator
`define UC_SPBIT_IC_CFG_DIS_TLB2            4  // disable level 2 tlb. (disable BTLB on BT)
`define UC_SPBIT_IC_CFG_DIS_PDA             5  // disable predecode cacheing
`define UC_SPBIT_IC_CFG_DIS_WAY0            6  // disable use of way 0
`define UC_SPBIT_IC_CFG_DIS_WAY1            7  // disable use of way 1
`define UC_SPBIT_IC_CFG_DIRECT_MAP          8  // disable associativity, (direct mapped)
`define UC_SPBIT_IC_CFG_DIS_SPEC_TLB_RLD    9  // disable speculative tlb reloads
`define UC_SPBIT_IC_CFG_DIS_SPLIT_DBL      10  // disable splitting the dispatch of double instructions into 2 lines.
`define UC_SPBIT_IC_CFG_DIS_SEQ_PREFETCH   11  // disable sequential prefetching
`define UC_SPBIT_IC_CFG_MCA_FAULT_ON_CORR_ERR   12  // Report MCA fault on correctable error.
`define UC_SPBIT_IC_CFG_DIS_PFC_WR_BYPASS  13  // Let a pfc write go through when BU_VbCdFlPendMb is asserted
`define UC_SPBIT_IC_CFG_DIS_IND            14  // disable indirect branch predictor
`define UC_SPBIT_IC_CFG_DIS_ONE_BEAT       15  // disable one beat feature, which allows the IC to forward a single beat of data to SA from L2/L3/NB without waiting for the second beat.
//`define UC_SPBIT_IC_CFG_DIS_RAS_24_BIT     16  // disable allowing call/ret pairs within 2^24 bytes from using only one 24bit RAS entry and force to use two for all calls and returns - MOVED to bit 30. Bit 16 is RESEVED.
`define UC_SPBIT_IC_CFG_DIS_IND_GHIST      17  // disable shifting bits from indirect targets into ghist. #IndGhist.
`define UC_SPBIT_IC_CFG_DIS_HASHED_PERC    18  // disable updates of the hashed-index weight tables and predict branches using only the bias weights
`define UC_SPBIT_IC_CFG_DIS_DENSE          19  // disable the dense predictor
`define UC_SPBIT_IC_CFG_DIS_ITLB_PWR_SAVE  20  // disable power saving feature of ITLB. Once disabled, ITLB will be fired in every clock cycle. 
`define UC_SPBIT_IC_CFG_DIS_SILO_RELOAD    21  // disable reloading the sparse from the L2 silo on a L1 IC reload. Once disabled we clear out the sparse info on a reload. 
`define UC_SPBIT_IC_CFG_DIS_OUTPAGE        22  // disable use of the outpage array contents. If true use the SkLinAd bits instead. 
//`define UC_SPBIT_IC_CFG_DIS_STLB_BTLB      23  // disable both STLB and BTLB. Translation will use only CPFR. RESERVED. (Bit-4 is used as disable BTLB on BT) 
`define UC_SPBIT_IC_CFG_DIS_IDATA_PWR_SAVE 24  // disable stall power mgmt feature for read accesses to I$ data arrays.
`define UC_SPBIT_IC_CFG_DIS_FTAG_PWR_SAVE  25  // disable same_line power mgmt feature for read accesses to I$ Fulltag array.
`define UC_SPBIT_IC_CFG_DIS_WIDEREAD_PWR_SAVE  26  // disable wide read power mgmt feature for read accesses to I$ data array.
`define UC_SPBIT_IC_CFG_GHIST_ZERO         27  // force global history to be zero at all times
`define UC_SPBIT_IC_CFG_DIS_SK_VER02_FETCH 28  // disable Shark ver0.2 fetch scheme in which the frontend can predict a branch in the second 32B as taken and turn around frontend
                                               // before we send the 2nd 32B containing the branch to the DE in _2. This allows us to eliminate predicted-taken bubbles in some cases.
//`define UC_SPBIT_IC_CFG_DIS_RAS_24_BIT     29  // disable allowing call/ret pairs within 2^24 bytes from using only one 24bit RAS entry and force to use two for all calls and returns - Removed
`define UC_SPBIT_IC_CFG_DIS_BP_PWR_SAVE    29  // disable power gating the sparse aray. This feature allows us to not power up the sparse as long as we are fetching within its 128B width

//  NOTE that you must keep this up to date with simenv/s_rndcfg.pl

//  ICACHE bist fatal error bits.
`define UC_SPBIT_IC_FATAL_FTAG            0  // fatal error bit for IC_FTAG macro
`define UC_SPBIT_IC_FATAL_STAG            1  // fatal error bit for IC_STAG macro
`define UC_SPBIT_IC_FATAL_L2TLB           2  // fatal error bit for IC_L2TLB macro
`define UC_SPBIT_IC_FATAL_TGT             3  // fatal error bit for PC_TGT macro
`define UC_SPBIT_IC_FATAL_BRN             4  // fatal error bit for PC_BRN macro
`define UC_SPBIT_IC_FATAL_STQUAD          5  // fatal error bit for IC_STQUAD macro
`define UC_SPBIT_IC_FATAL_PDA             6  // fatal error bit for SA_PDA macro
`define UC_SPBIT_IC_FATAL_BCT             7  // fatal error bit for SA_BCT macro
`define UC_SPBIT_IC_FATAL_L1TLB           8  // fatal error bit for L1TLB macro
`define UC_SPBIT_IC_FATAL_LRU             9  // fatal error bit for LRU ra cells
`define UC_SPBIT_IC_FATAL_BSR            10  // fatal error bit for BSR ra cells


// ME Configuration bits - for UC_SPREG_ME_CFG
`define UC_SPBIT_ME_CFG_DIS_STACK_ENGINE            0    // disable stack engine
`define UC_SPBIT_ME_CFG_LFENCE_SERIALIZE            1    // serialize LFENCE
`define UC_SPBIT_ME_CFG_CONVERT_PREFETCH_TO_NOP     7:2  // Convert PREFETCH instructions to NOPs
`define UC_SPBIT_ME_CFG_DIS_LARGE_FAST_STRINGS      8    // Disable large fast strings mechanism
`define UC_SPBIT_ME_CFG_PATCH_DIS                   9    // Disable microcode patch capability
`define UC_SPBIT_ME_CFG_SERIALIZE_TO_WFQ           10    // Convert .serialize into .wait_for_quiet
`define UC_SPBIT_ME_CFG_FORCE_AGU_INORDER          11    // Force all AGUs ops to be scheduled in-order
`define UC_SPBIT_ME_CFG_UCODE_PATCH_ENCRYPT        12    // State of UcodePatchEncrypt fuse (read-only)
`define UC_SPBIT_ME_CFG_MEMACC_NORMAL_TO_PHYSICAL  13    // Convert UC_MEMACC_NORMAL to UC_MEMACC_PHYSICAL
`define UC_SPBIT_ME_CFG_MOQ_TOKEN_SIZE             20:16 // Override the LS MOQ depth as used by the dispatch token control logic.


// DE Configuration bits - for UC_SPREG_DE_CFG
`define UC_SPBIT_DE_CFG_DisFastDispatch1        0    // 1 => Disable dispatch lane 1 - only dispatch from lane 0
`define UC_SPBIT_DE_CFG_DisSplitDoubles         1    // 1 => Don't allow split fastpath doubles, force them to dispatch the same clock
`define UC_SPBIT_DE_CFG_DisCoarseGtr            2    // 1 => Force RCLK_deCoarse_AR to be free-running
`define UC_SPBIT_DE_CFG_DisMeIntfGtr            3    // 1 => Force RCLK_MeIntf_AR to be free-running
`define UC_SPBIT_DE_CFG_ForceInstVal            5:4  // 1 => Force InstValidIn_2b[1:0] to assert - this is strictly for interactive debug w/clock control (Do Not
`define UC_SPBIT_DE_CFG_ForceResetPic           6    // 1 => Clear Out DE's Front End - this is strictly for interactive debug w/clock control (Do Not Randomize)


// x87 reg cache status bits
`define UC_SPBIT_X87_REG_CACHE_STAT_STATUS      0    // 1 => x87 regs are cached in EMEM


//************************************************************************
// ENCODINGS FOR SEQUENCE CONTROL FIELD
`define SCF 18:0

// Microcode Sequencer Control Fields
`define SERIALIZE  18:18
`define CONDBR     17:17
`define SEQBRN     16:16
`define SQEXIT     15:15
`define SQCTL      15:13
`define SQCND      16:13
`define SQINC      14:14
`define SQMISC     13:0   // see UC_SQM_* and UC_SQMBIT_*
`define SQOFFS     12:0


// ENCODINGS FOR SERIALIZE BIT

// ENCODINGS FOR CONDITIONAL/UNCONDITIONAL(NO) BRANCH

// ENCODINGS FOR CONDITIONAL SEQUENCE BRANCH    (18,16:13)
// we are overloading the serialize bit to give us more branch conditions
// microcode will guarantee that serialize and condbr never happen together.

`define UC_SQCND_RM             5'h00           // Real mode: ~CR0[PE]
`define UC_SQCND_PM             5'h01           // Protected mode: CR0[PE] & ~EFLAGS[VM]
`define UC_SQCND_VM             5'h02           // Virtual mode: EFLAGS[VM]
`define UC_SQCND_VME            5'h03           // (CURCPL=3 & CR4[1] & ~EFLAGS[VM]) | (EFLAGS[VM] & CR4[0])
`define UC_SQCND_LM             5'h04           // Long mode: EFER.LMA = 1
`define UC_SQCND_CK_IOMAP       5'h05           // (CPL > IOPL) | EFLAGS[VM] | (SME & ~TX)
`define UC_SQCND_BT_OR_LBR      5'h06           // Branch tracing is enabled or LBR enabled
`define UC_SQCND_DSIZE64        5'h07           // x86 operand size is 64-bits
`define UC_SQCND_NOT_CPL0       5'h08           // CURCPL != 0
`define UC_SQCND_RVM            5'h09           // Real or v8086 mode: ~CR0[PE] | EFLAGS[VM]
`define UC_SQCND_DSIZE8         5'h0A           // x86 operand size is 8-bits
`define UC_SQCND_CPL_GT_IOPL    5'h0B           // CPL > IOPL
`define UC_SQCND_DSIZE16        5'h0C           // x86 operand size is 16-bits
`define UC_SQCND_DSIZE32        5'h0D           // x86 operand size is 32-bits
`define UC_SQCND_SSE_ENBL       5'h0E           // SSE instructions are enabled (CR4[9]=1)
`define UC_SQCND_FERR           5'h0F           // Legacy FERR pin
`define UC_SQCND_MODE64         5'h10           // 64-bit mode: LMA & CS.L
`define UC_SQCND_MODE16         5'h11           // 16-bit mode: ~(LMA & CS.L) & ~CS.D
`define UC_SQCND_DSM_ENABLED    5'h12           // Debug State Machine is enabled
`define UC_SQCND_VINTR_MASKING  5'h13           // vintr.VINTR_MASKING from FR
`define UC_SQCND_SVM_DIS        5'h14           // SVM is disabled
`define UC_SQCND_CNT_ZERO       5'h15           // ME setcnt is zero
`define UC_SQCND_CNT_GT_ONE     5'h16           // ME setcnt is one
`define UC_SQCND_CNT_ONE        5'h17           // ME setcnt > 1
`define UC_SQCND_CNT_NOT_SEVEN     5'h18           // ME setcnt !=7 (and increment)
`define UC_SQCND_CNT_AOPNONZERO 5'h19           // setcnt AOp bits 2:0 were non-zero
`define UC_SQCND_NO_LARGE_FAST_STRINGS 5'h1A    // Large fast string copies/stores disabled
`define UC_SQCND_X87_REG_CACHE_ENABLED  5'h1B   // x87 register cache is enabled
`define UC_SQCND_X87_REGS_CACHED        5'h1C   // x87 registers are cached

// ENCODINGS FOR CONDITIONAL SEQUENCE OFFSET/TARGET - THIS IS A PURE IMMEDIATE VALUE


// ENCODINGS FOR CONDITIONAL SEQUENCE OFFSET/TARGET - THIS IS A PURE IMMEDIATE VALUE

// ENCODINGS FOR UNCONDITIONAL BRANCHES:

// ENCODINGS FOR SEQUENTIAL BRANCHES (15)

// ENCODINGS FOR SEQUENTIAL CONTROL ONLY USED WHEN CONDITIONAL BRANCH 0 AND SEQUENTIAL BRANCH 1
`define UC_SQCTL_SQJMP          3'h2
`define UC_SQCTL_CALL           3'h3
`define UC_SQCTL_MJMP           3'h4
`define UC_SQCTL_SQJMP_NULL     3'h5  // For nullifying Null Triads
`define UC_SQCTL_CALL_NULL      3'h6  // 

// ENCODINGS FOR SEQUENTIAL EXIT CONDBRN 0, SEQBRN 0

// ENCODINGS FOR SEQUENTIAL INCREMENT CONDBRN 0, SEQBRN 0

// ENCODINGS FOR MISC SEQUENTIAL FIELD
`define UC_SQM_NOP                14'h0000
//`define UC_SQM_UNUSED0          14'h0001
`define UC_SQM_WAIT_FOR_QUIET     14'h0002
`define UC_SQM_RETURN             14'h0004
`define UC_SQM_WAIT_FOR_COUNT     14'h0008
`define UC_SQM_FORCE_16           14'h0010
`define UC_SQM_FORCE_32           14'h0020
`define UC_SQM_RF_LOCK            14'h0040
`define UC_SQM_FORCE_ADDR_SIZE    14'h0080
`define UC_SQM_CLR_FP_TRAPS       14'h0100
`define UC_SQM_CLR_ALL_TRAPS      14'h0200
//`define UC_SQM_UNUSED10         14'h0400
`define UC_SQM_CLR_RESYNC         14'h0800
`define UC_SQM_FORCE_64           14'h1000
`define UC_SQM_FORCE_8            14'h2000

// Bit defines for the `defines above.  
// These are mostly mutually exclusive, except for FORCE_ADDR_SIZE.
`define UC_SQMBIT_EXIT            0  // sequential case only
`define UC_SQMBIT_WAIT_FOR_QUIET  1
`define UC_SQMBIT_RETURN          2
`define UC_SQMBIT_WAIT_FOR_COUNT  3
`define UC_SQMBIT_FORCE_16        4
`define UC_SQMBIT_FORCE_32        5
`define UC_SQMBIT_RF_LOCK         6
`define UC_SQMBIT_FORCE_ADDR_SIZE 7
`define UC_SQMBIT_CLR_FP_TRAPS    8
`define UC_SQMBIT_CLR_ALL_TRAPS   9
//`define UC_SQMBIT_UNUSED10      10
`define UC_SQMBIT_CLR_RESYNC      11
`define UC_SQMBIT_FORCE_64        12
`define UC_SQMBIT_FORCE_8         13


//************************************************************************
//
// EXCEPTIONS (& absolute addresses)
//
// *IMP* : values MUST be in multiples of 2, as they refer to srom offsets
//         into an exception entry table at srom start where each exception entry is
//         of size 2 LOMs.
//
//         Add new exceptions just before "END - SROM EXCEPTION TABLE" and if required
//         increment UC_VEC_TABLE_START.
//
//************************************************************************
//  Defines which result in Microcode Entries -- Informational Only.
// `define UC_EP_RESET                13'h0000      // Reset set to zero
// `define UC_EP_FP_MICRO_TRAP        13'h0002      // FP microcode trap
// `define UC_EP_FP_FERRSET_TRAP      13'h0004      // Trap to cause Ferr bus cycle
// `define UC_EP_BRANCH_TRACE         13'h0006      // Branch Trace Handler - requires 11 triads
// `define UC_EP_BRANCH_BITMAP_TRAP   13'h0008      // Branch Bitmap full - requires 6 triads
// `define UC_EP_DBG_TRAP             13'h000a      // TF, or Data Breakpoint 
// `define UC_EP_EXT_CFG_TRAP         13'h000c      // Extended Config Trap
// `define UC_EP_INTERRUPT            13'h0010
// `define UC_VEC_SET_ACC_BIT_SS 13'h0012        // accessed bit exception on SS
// `define UC_VEC_TASK_GATE      13'h0014        // Task Gate
// `define UC_VEC_SET_ACC_BIT    13'h0016        // accessed bit exception
// `define UC_VEC_SET_ACC_BIT_CS 13'h0018        // accessed bit exception on CS
// `define UC_VEC_TSS            13'h001a        // TSS either 16 or 32
// `define UC_VEC_CALL_GATE      13'h001c        // Call Gate either 16 or 32
// `define UC_VEC_IDT_NP         13'h0102        // IDTR fault but Not Present
// `define UC_VEC_TSS_SEL        13'h0104        // TSS fault with selector error code
// `define UC_VEC_SS_SEL         13'h0106        // SS fault, selector error code 
// `define UC_VEC_RST_ZF_NODBG   13'h0116        // Reset ZF but pre-access chk so don't redo debug chk.
// `define UC_VEC_PAGE_FAULT     13'h011C        // Page fault
// `define UC_VEC_IDT_FAULT      13'h011E        // IDTR fault
// `define UC_EP_LS_FAULT             13'h013A      // Normal Load/Store Fault
// `define UC_EP_DISPATCH_FAULT       13'h013E      // Sum up all the dispatch faults to one register
// `define UC_EP_ILLEGAL_OP           13'h014E      // Predecode detected illegal op int  - Shared with ILLEGAL_LOCK
// `define UC_EP_ILLEGAL_LOCK         13'h014E      // Instruction with illegal lock - Shared with ILLEGAL_OP
// `define UC_EP_ILLEGAL_FPOP         13'h0154      // Predecode detected illegal op fp
// `define UC_EP_INST_PF              13'h015C      // Instruction cache page fault 
// `define UC_EP_SSE_ARCH_EXC         13'h0160      // SSE architectural exception
// `define UC_EP_SSE_ARCH_EXC_UTRAP   13'h0164      // SSE architectural exception w/ microtrap
// `define UC_EP_FP_MICRO_FAULT       13'h0182      // FP restart instruction
// `define UC_EP_FP_MICRO_FAULT_KFSR  13'h0184      // SSE microfault: convert non-FP to FP single
// `define UC_EP_FP_MICRO_FAULT_KFDR  13'h0186      // SSE microfault: convert non-FP to FP double
// `define UC_EP_FP_MICRO_FAULT_KFPR  13'h0188      // SSE microfault: convert non-int to packed int
// `define UC_EP_FP_MICRO_FAULT_KFSAN 13'h018c      // SSE microfault: reclass bitstring to FP single
// `define UC_EP_3DX_ILLEGAL          13'h0194      // Invalid 3dX immediate byte, Int #6
// `define UC_EP_PDEC_MICRO_FAULT     13'h0196      // Pdec has screwed up, restart at current eip.
// `define UC_EP_FPU_ARCH_EXC         13'h0198      // 
// `define UC_EP_EMERGENCY_HDT        13'h019c      // Emergency Mode HDT
// `define UC_EP_RESYNC               13'h01A0      // SMC resync, Preld fault, Ferr resync.                
// `define UC_VEC_BBIT_CHG       13'h01d0        // The old B-bit does not match the new B-bit
// `define UC_VEC_RST_ZF         13'h01d4        // Reset ZF fault (really only needs one line)
// `define UC_VEC_SS_ZERO        13'h01d6        // SS fault, zero error code
// `define UC_VEC_GP_SEL         13'h01d8        // GP fault, selector error code
// `define UC_VEC_NP_SEG         13'h01da        // Not present segment
// `define UC_EP_BRN_LIMIT            13'h01f0      // Brn goes beyond limit - Shared with GP_ZERO, GT_15_BYTES
// `define UC_EP_GT_15_BYTES          13'h01f0      // Instruction gt 15 bytes long - Shared with  GP_ZERO, BRN_LIMIT 
// `define UC_VEC_GP_ZERO             13'h01f0      // GP fault, zero error code - Shared with BRN_LIMIT, GT_15_BYTES


`define UC_EP_RESET                13'h0000      // Reset set to zero

// resyncs
`define UC_EP_RESYNC               13'h01A0      // SMC resync, Preld fault, Ferr resync.                

// faults
`define UC_EP_DISPATCH_FAULT       13'h013E      // Sum up all the dispatch faults to one register
`define UC_EP_LS_FAULT             13'h013A      // Normal Load/Store Fault
`define UC_EP_3DX_ILLEGAL          13'h0194      // Invalid 3dX immediate byte, Int #6

`define UC_EP_FPU_ARCH_EXC         13'h0c88      // 
`define UC_EP_SSE_ARCH_EXC         13'h0160      // SSE architectural exception
`define UC_EP_SSE_ARCH_EXC_UTRAP   13'h0164      // SSE architectural exception w/ microtrap
`define UC_EP_EMERGENCY_HDT        13'h0c6c      // Emergency Mode HDT
`define UC_EP_ILLEGAL_OP           13'h014E      // Predecode detected illegal op int  - Shared with ILLEGAL_LOCK
`define UC_EP_ILLEGAL_LOCK         13'h014E      // Instruction with illegal lock - Shared with ILLEGAL_OP
`define UC_EP_ILLEGAL_FPOP         13'h0154      // Predecode detected illegal op fp
`define UC_EP_INST_PF              13'h015C      // Instruction cache page fault 
`define UC_EP_PDEC_MICRO_FAULT     13'h0196      // Pdec has screwed up, restart at current eip.
`define UC_EP_HW_DIVERROR          13'h12e3      // Hardware Divided error entrypoint.

// Note:  These share the same ucode, so the following 3 entry points must be the same
`define UC_EP_BRN_LIMIT            13'h033C      // Brn goes beyond limit - Shared with GP_ZERO, GT_15_BYTES
`define UC_EP_GT_15_BYTES          13'h033C      // Instruction gt 15 bytes long - Shared with  GP_ZERO, BRN_LIMIT 
`define UC_VEC_GP_ZERO             13'h033C      // GP fault, zero error code - Shared with BRN_LIMIT, GT_15_BYTES

// traps
`define UC_EP_FP_MICRO_TRAP        13'h0168      // FP microcode trap
`define UC_EP_FP_FERRSET_TRAP      13'h016C      // Trap to cause Ferr bus cycle
`define UC_EP_BRANCH_TRACE         13'h0BBB      // Branch Trace Handler - requires 11 triads
`define UC_EP_BRANCH_BITMAP_TRAP   13'h0AF0      // Branch Bitmap full - requires 6 triads
`define UC_EP_DBG_TRAP             13'h01AC      // TF, or Data Breakpoint 
`define UC_EP_EXT_CFG_TRAP         13'h0422      // Extended Config Trap
`define UC_EP_IBS_TRAP             13'h0426      // IBS Trap
`define UC_EP_INTERRUPT            13'h0BF4
`define UC_EP_BIST_SIG             (`MROMSIZE - 1)

// Upper 7 bits of entrypoints below.
`define UC_EP_FP_MICRO_FAULT_BASE  7'h63        
// To simplify implementation, the following 8 entries should be kept in order and be of the form:
// {`UC_EP_FP_MICRO_FAULT_BASE, 5'h0}, {`UC_EP_FP_MICRO_FAULT_BASE, 5'h4}, ...
`define UC_EP_FP_MICRO_FAULT            13'h0c60      // FP restart instruction
`define UC_EP_FP_MICRO_FAULT_3SRC_KFSR  13'h0c63      // SSE microfault: convert non-FP to FP double
`define UC_EP_FP_MICRO_FAULT_KFSR       13'h0c65      // SSE microfault: convert non-FP to FP single
`define UC_EP_FP_MICRO_FAULT_3SRC_KFDR  13'h0c67      // SSE microfault: convert non-FP to FP double
`define UC_EP_FP_MICRO_FAULT_KFDR       13'h0c69      // SSE microfault: convert non-FP to FP double
`define UC_EP_FP_MICRO_FAULT_3SRC_KFPR  13'h0c8a      // SSE microfault: convert non-int to packed int
`define UC_EP_FP_MICRO_FAULT_KFPR       13'h0c8c      // SSE microfault: convert non-int to packed int
`define UC_EP_FP_MICRO_FAULT_3SRC_KFSAN 13'h0c91      // SSE microfault: reclass bitstring to FP single
`define UC_EP_FP_MICRO_FAULT_KFSAN      13'h0c92      // SSE microfault: reclass bitstring to FP single
`define UC_EP_FP_MICRO_FAULT_3SRC_KFDAN 13'h0c77      // SSE microfault: reclass bitstring to FP double
`define UC_EP_FP_MICRO_FAULT_KFDAN      13'h0c78      // SSE microfault: reclass bitstring to FP double


// these are not real exceptions ! - sem & absolute addresses
`define UC_COMMON_INIT             13'h00c9
`define UC_SKINIT_CONT             13'h0fcc
`define UC_SKINIT_CONT1            13'h0fe0
`define UC_READ_HASH_DATA          13'h0be3
`define STOPCLK_SPIN               13'h02a6
`define UC_FP_XCP_FRZLOOP_INTCHK   13'h05b6
`define UC_NONPATCHABLE_START      13'h0df0      // non-patchable range is 0xdf0-0xdff
`define UC_MSR_TSC                 13'h0841
//`define UC_FULL_SERIAL_JMP         13'h0895

// Alternate fault handler EP's for XOS help
`define UC_EP_CMPS_FIX             13'h0144      // Fix up cmps x86 registers before going to the fault
`define UC_EP_MOVS_FIX             13'h0148      // Fix up movs x86 registers before going to the fault
`define UC_EP_STOS_FIX             13'h0536      // Fix up stos x86 registers before going to the fault
`define UC_EP_APICINT              13'h0744      // Apic interrupt
`define UC_EP_SSFIXTF              13'h0A5E      // Fix up TF on mov ss
`define UC_EP_FR_INTERRUPT         13'h0172      // Interrupt on mov ss, pop ss

// So tsim can find its way through the REP MOV/REP STOS ucode
`define UC_MOVS_UP_LOOP            13'h0E20
`define UC_MOVS_DOWN_LOOP          13'h0E26
`define UC_MOVS_UP_EXITS           13'h0E2A
`define UC_MOVS_DOWN_EXITS         13'h0E2F
`define UC_STOS_UP_LOOP            13'h0E34
`define UC_STOS_DOWN_LOOP          13'h0E3A
`define UC_STOS_EXITS              13'h0E3E

// Spin loops for bridge code to help find bad tests
`define UC_LS_REQ_DIS              13'h0800
`define UC_HLT_SPIN                13'h074C
`define UC_EP_HLTINT               13'h0E0D
`define UC_SHUTDOWN_SPIN           13'h0752
`define UC_EP_SHUTDOWNINT          13'h075A

// add new below - 0072...007E or use space 002A...002E
// and must be less than UC_VEC_TABLE_START

//DSM patch location
//Absoluted to help keep this constant so patch testing is easier
`define UC_EP_DSM_PATCH            13'h0DDD

//---------------------------
// END - SROM EXCEPTION TABLE
//---------------------------


//************************************************************************
// Vector Table for UC_EP_LS_FAULT.
//
// The vectors are internal to ucode and start in srom from offset UC_VEC_TABLE_START
//
// These are the offsets to a jump table maintained within srom by ucode and are read
// from register excep_addr[11:0]. Can remain to be 12-bits as ucode maintains a base address for
// table.
//
// *IMP*  -These must be in multiples of 2 as they hold 2 LOMs each.
//        -Add new vectors just before UC_VEC_LS_TABLE_END and if required increment it's value.

`define UC_VEC_IDT_FAULT      13'h011E        // IDTR fault
`define UC_VEC_IDT_NP         13'h0102        // IDTR fault but Not Present
`define UC_VEC_TSS_SEL        13'h0104        // TSS fault with selector error code
`define UC_VEC_SS_SEL         13'h0106        // SS fault, selector error code 
`define UC_VEC_SS_ZERO        13'h0380        // SS fault, zero error code
`define UC_VEC_GP_SEL         13'h0382        // GP fault, selector error code
`define UC_VEC_NP_SEG         13'h0384        // Not present segment
`define UC_VEC_ALIGN_FAULT    13'h019A        // Alignment fault
`define UC_VEC_BBIT_CHG       13'h0314        // The old B-bit does not match the new B-bit
`define UC_VEC_RST_ZF_NODBG   13'h0116        // Reset ZF but pre-access chk so don't redo debug chk.
`define UC_VEC_RST_ZF         13'h032A        // Reset ZF fault (really only needs one line)
`define UC_VEC_PAGE_FAULT     13'h011C        // Page fault
`define UC_VEC_MACHINE_CHK    13'h017C        // Machine check
`define UC_VEC_LD_ECC_ERROR   13'h0420        // Load ecc error

// 4 line
`define UC_VEC_SET_ACC_BIT_SS 13'h0180        // accessed bit exception on SS
`define UC_VEC_TASK_GATE      13'h0410        // Task Gate
`define UC_VEC_SET_ACC_BIT    13'h019C        // accessed bit exception
`define UC_VEC_SET_ACC_BIT_CS 13'h0414        // accessed bit exception on CS
`define UC_VEC_TSS            13'h0136        // TSS either 16 or 32
`define UC_VEC_CALL_GATE      13'h012c        // Call Gate either 16 or 32

// Start of relocatable srom ucode. Before this point are the fixed exception tables.
//`define SROM_BASE                       (`UC_VEC_TABLE_START + `UC_VEC_LS_TABLE_END)


// We will block all patch matches to addresses in the range of 0x0cf0-0x0cf7.
//   OF 01 /3 /reg r/m=6  -> 0x0cf0    SKINIT RAX [0F 01 DE]
   `define UC_NO_PATCH 10'b0_1100_1111_0


//************************************************************************
// FPU REGISTERS

`define UC_FPREG_ST0                    6'h00
`define UC_FPREG_ST1                    6'h01
`define UC_FPREG_ST2                    6'h02
`define UC_FPREG_ST3                    6'h03
`define UC_FPREG_ST4                    6'h04
`define UC_FPREG_ST5                    6'h05
`define UC_FPREG_ST6                    6'h06
`define UC_FPREG_ST7                    6'h07

`define UC_FPREG_FT0                    6'h30
`define UC_FPREG_FT1                    6'h31
`define UC_FPREG_FT2                    6'h32
`define UC_FPREG_FT3                    6'h33
`define UC_FPREG_FT4                    6'h34
`define UC_FPREG_FT5                    6'h35
`define UC_FPREG_FT6                    6'h36
`define UC_FPREG_FT7                    6'h37

`define UC_FPREG_FT0_IMM                6'h30
`define UC_FPREG_FT1_IMM                6'h31
`define UC_FPREG_FT2_IMM                6'h32
`define UC_FPREG_FT3_IMM                6'h33
`define UC_FPREG_FT4_IMM                6'h34
`define UC_FPREG_FT5_IMM                6'h35
`define UC_FPREG_FT6_IMM                6'h36
`define UC_FPREG_FT7_IMM                6'h37

`define UC_FPREG_INVSRC                 6'h10
`define UC_FPREG_SETCNT                 6'h11   // MENG will sub lower 5-bits of sequencer setcnt counter (BOp only).
`define UC_FPREG_SSE_FAULT0_LO          6'h12   // {2'b10, FR_SseFaultReg0_11[3:0]}
`define UC_FPREG_SSE_FAULT0_HI          6'h13   // {2'b11, FR_SseFaultReg0_11[3:0]}
`define UC_FPREG_SSE_FAULT1_LO          6'h14   // {2'b10, FR_SseFaultReg1_11[3:0]}
`define UC_FPREG_SSE_FAULT1_HI          6'h15   // {2'b11, FR_SseFaultReg1_11[3:0]}
`define UC_FPREG_INVDST                 6'h17

// Overload the UC_FPREG_STI  and UC_FPREG_STIREG 
`define UC_FPREG_SSE_FAULT2_LO          6'h38   // {2'b10, FR_SseFaultReg2_11[3:0]}
`define UC_FPREG_SSE_FAULT2_HI          6'h3c   // {2'b11, FR_SseFaultReg2_11[3:0]}

`define UC_FPREG_MM0                    6'h18
`define UC_FPREG_MM1                    6'h19
`define UC_FPREG_MM2                    6'h1A
`define UC_FPREG_MM3                    6'h1B
`define UC_FPREG_MM4                    6'h1C
`define UC_FPREG_MM5                    6'h1D
`define UC_FPREG_MM6                    6'h1E
`define UC_FPREG_MM7                    6'h1F

`define UC_FPREG_XMM0HI                 6'h00
`define UC_FPREG_XMM1HI                 6'h01
`define UC_FPREG_XMM2HI                 6'h02
`define UC_FPREG_XMM3HI                 6'h03
`define UC_FPREG_XMM4HI                 6'h04
`define UC_FPREG_XMM5HI                 6'h05
`define UC_FPREG_XMM6HI                 6'h06
`define UC_FPREG_XMM7HI                 6'h07
`define UC_FPREG_XMM8HI                 6'h08
`define UC_FPREG_XMM9HI                 6'h09
`define UC_FPREG_XMM10HI                6'h0A
`define UC_FPREG_XMM11HI                6'h0B
`define UC_FPREG_XMM12HI                6'h0C
`define UC_FPREG_XMM13HI                6'h0D
`define UC_FPREG_XMM14HI                6'h0E
`define UC_FPREG_XMM15HI                6'h0F
`define UC_FPREG_XMM0LO                 6'h20
`define UC_FPREG_XMM1LO                 6'h21
`define UC_FPREG_XMM2LO                 6'h22
`define UC_FPREG_XMM3LO                 6'h23
`define UC_FPREG_XMM4LO                 6'h24
`define UC_FPREG_XMM5LO                 6'h25
`define UC_FPREG_XMM6LO                 6'h26
`define UC_FPREG_XMM7LO                 6'h27
`define UC_FPREG_XMM8LO                 6'h28
`define UC_FPREG_XMM9LO                 6'h29
`define UC_FPREG_XMM10LO                6'h2A
`define UC_FPREG_XMM11LO                6'h2B
`define UC_FPREG_XMM12LO                6'h2C
`define UC_FPREG_XMM13LO                6'h2D
`define UC_FPREG_XMM14LO                6'h2E
`define UC_FPREG_XMM15LO                6'h2F

`define UC_FPREG_YMM0_HI                6'h30 
`define UC_FPREG_YMM1_HI                6'h31 
`define UC_FPREG_YMM2_HI                6'h32 
`define UC_FPREG_YMM3_HI                6'h33 
`define UC_FPREG_YMM4_HI                6'h34 
`define UC_FPREG_YMM5_HI                6'h35 
`define UC_FPREG_YMM6_HI                6'h36 
`define UC_FPREG_YMM7_HI                6'h37 
`define UC_FPREG_YMM8_HI                6'h38 
`define UC_FPREG_YMM9_HI                6'h39 
`define UC_FPREG_YMM10_HI               6'h3a 
`define UC_FPREG_YMM11_HI               6'h3b 
`define UC_FPREG_YMM12_HI               6'h3c 
`define UC_FPREG_YMM13_HI               6'h3d 
`define UC_FPREG_YMM14_HI               6'h3e 
`define UC_FPREG_YMM15_HI               6'h3f 

`define UC_FPREG_STI                    6'h38
`define UC_FPREG_MMREGM                 6'h39
`define UC_FPREG_XMMREGMLO              6'h3A
`define UC_FPREG_XMMREGMHI              6'h3B
`define UC_FPREG_STIREG                 6'h3C
`define UC_FPREG_MMREG                  6'h3D
`define UC_FPREG_XMMREGLO               6'h3E
`define UC_FPREG_XMMREGHI               6'h3F
`define UC_FPREG_VEXREGLO               6'h18
`define UC_FPREG_VEXREGHI               6'h19
`define UC_FPREG_VEXIMMLO               6'h1A
`define UC_FPREG_VEXIMMHI               6'h1B


//************************************************************************
// Emulation memory address for fp temp - this is also defined in mc_cpu.h
`define FP_MEM_TEMP         9'h100

//************************************************************************
// ENCODINGS FOR FPUCTRL

`define UC_FPC_OP_ERRSENSITIVE  2'b01
`define UC_FPC_UPDATE_POINTERS  2'b10


//************************************************************************
// ENCODINGS FOR THE FP 8-BIT COP OPCODE FIELD: cop[`FPUOP]

// GENERIC FPU OP CLASSES
`define UC_FPOP_NOSTKNOINT   8'b00??????     // 8'h00-8'h3f: no stack change, no integer interface
`define UC_FPOP_NOSTKINT     8'b0100????     // 8'h40-8'h4f: no stack change, integer interface
`define UC_FPOP_PUSHINT      8'b01010???     // 8'h50-8'h57: push, integer interface
`define UC_FPOP_POPINT       8'b01011???     // 8'h58-8'h5f: pop, integer interface
`define UC_FPOP_FMAKETAG     8'b01100???     // 8'h60-8'h67: FPMAKETAG ops
`define UC_FPOP_FLDCROMOP    8'b01101???     // 8'h68-8'h6f: FLDCROM ops
`define UC_FPOP_PUSHNOINT    8'b01110???     // 8'h70-8'h77: push, no integer interface
`define UC_FPOP_POP          8'b01111???     // 8'h78-8'h7f: pop, no integer interface
`define UC_FPOP_SSE          8'b1???????     // 8'h80-8'hff: sse ops


// SINGLE FPU OPS

`define UC_FPOP_FADD        8'h00
`define UC_FPOP_FMUL        8'h01
`define UC_FPOP_FSELECTB    8'h02
`define UC_FPOP_FCOM        8'h03
`define UC_FPOP_FSUB        8'h04
`define UC_FPOP_FLDMANT     8'h05
`define UC_FPOP_FDIV        8'h06
`define UC_FPOP_FSELECTNB   8'h07
`define UC_FPOP_FCPYSIGN    8'h08
`define UC_FPOP_FSELECTNE   8'h09
`define UC_FPOP_FREMCLRQ    8'h0A
`define UC_FPOP_FREMI68     8'h0B
// unused                   8'h0C
`define UC_FPOP_FIXUFLOW    8'h0D
`define UC_FPOP_FLDSWE      8'h0E
`define UC_FPOP_FSTi64      8'h0F
`define UC_FPOP_FSUBT64     8'h10
`define UC_FPOP_FADDT64     8'h11
`define UC_FPOP_FADDT68     8'h12
`define UC_FPOP_FUPDTFERR   8'h13
`define UC_FPOP_FABS        8'h14
`define UC_FPOP_FCOMBINE    8'h15
`define UC_FPOP_FSUBT68     8'h16
`define UC_FPOP_FCLEX       8'h17
`define UC_FPOP_FRECLASS    8'h18
`define UC_FPOP_FSELECTE    8'h19
`define UC_FPOP_FMULT68     8'h1A
`define UC_FPOP_FDIVT68     8'h1B
`define UC_FPOP_FNOP        8'h1C
`define UC_FPOP_FIXOFLOW    8'h1D
`define UC_FPOP_FLDTWE      8'h1E
`define UC_FPOP_FLDi16      8'h1F
`define UC_FPOP_FXTRMANT    8'h20
`define UC_FPOP_FXTREXPO    8'h21
`define UC_FPOP_FSTMANTE    8'h22
`define UC_FPOP_FCLRFERR    8'h23
`define UC_FPOP_FSTDENr32   8'h24
`define UC_FPOP_FSTMANT     8'h25
`define UC_FPOP_FSTDENr64   8'h26
`define UC_FPOP_FSTRSNCD    8'h27
`define UC_FPOP_FSTSWE      8'h28
// aliased to FSTSWF        8'h29
`define UC_FPOP_FMULT64     8'h2A
`define UC_FPOP_FDIVT64     8'h2B
`define UC_FPOP_FPMLDQ      8'h2C
`define UC_FPOP_FRNDDENPC   8'h2D
`define UC_FPOP_FLDCWE      8'h2E
`define UC_FPOP_FLDi32      8'h2F
`define UC_FPOP_FMOV        8'h30
`define UC_FPOP_FXAM        8'h31
`define UC_FPOP_FIRND_NX    8'h32
`define UC_FPOP_FIRNDSTP    8'h33
`define UC_FPOP_FSELECTNU   8'h34
`define UC_FPOP_FSTEXPO     8'h35
`define UC_FPOP_FSELECTU    8'h36
`define UC_FPOP_FNORM       8'h37
`define UC_FPOP_FSCALSTP    8'h38
`define UC_FPOP_FSELECTNBE  8'h39
`define UC_FPOP_FMULSCAL    8'h3A
`define UC_FPOP_FSELECTBE   8'h3B
`define UC_FPOP_DSFP        8'h3C  // pseudo-op for TSIM fastpath ucode 
`define UC_FPOP_FRNDDEN     8'h3D
`define UC_FPOP_FFLG2CL     8'h3E
`define UC_FPOP_FIRNDNORM   8'h3F
`define UC_FPOP_FMOVCHK     8'h40
// unused                   8'h41
`define UC_FPOP_FREMFLG     8'h42
`define UC_FPOP_FIRNDCHK    8'h43
`define UC_FPOP_F2XM1CHK    8'h44
`define UC_FPOP_FSINCHK     8'h45
// unused                   8'h46
// unused                   8'h47
`define UC_FPOP_FCOMIX86    8'h48
`define UC_FPOP_FUCOMIX86   8'h49
`define UC_FPOP_FCOMI       8'h4A
`define UC_FPOP_FUCOMI      8'h4B
`define UC_FPOP_FSTPCHK     8'h4C
`define UC_FPOP_FCOSCHK     8'h4D
`define UC_FPOP_FSCALCHK    8'h4E
// unused                   8'h4F
`define UC_FPOP_FXTRCHK     8'h50
// unused                   8'h51
`define UC_FPOP_FTANCHK     8'h52
`define UC_FPOP_FSNCSCHK    8'h53
// unused                   8'h54
// unused                   8'h55
// unused                   8'h56
// unused                   8'h57
`define UC_FPOP_FCOMIPX86   8'h58
`define UC_FPOP_FUCOMIPX86  8'h59
`define UC_FPOP_FATANCHK    8'h5A
`define UC_FPOP_FL2XCHK     8'h5B
`define UC_FPOP_FLXP1CHK    8'h5C
`define UC_FPOP_FBSTPCHK    8'h5D
// unused                   8'h5E
// unused                   8'h5F
`define UC_FPOP_FMAKETAG0   8'h60
`define UC_FPOP_FMAKETAG1   8'h61
`define UC_FPOP_FMAKETAG2   8'h62
`define UC_FPOP_FMAKETAG3   8'h63
`define UC_FPOP_FMAKETAG4   8'h64
`define UC_FPOP_FMAKETAG5   8'h65
`define UC_FPOP_FMAKETAG6   8'h66
`define UC_FPOP_FMAKETAG7   8'h67
`define UC_FPOP_FLDCROM     8'h68
// unused                   8'h69
`define UC_FPOP_FLDTWCE     8'h6A
`define UC_FPOP_FPMOVMSKB   8'h6B
`define UC_FPOP_FPMSTQ      8'h6C
`define UC_FPOP_FPOR        8'h6D
// unused                   8'h6E
`define UC_FPOP_FPSTTW      8'h6F
// unused                   8'h70
`define UC_FPOP_FLDi64      8'h71
`define UC_FPOP_FLDr32      8'h72
// unused                   8'h73
// unused                   8'h74
`define UC_FPOP_FNORMLD     8'h75
// unused                   8'h76
// unused                   8'h77
`define UC_FPOP_FSTP1       8'h78
// unused                   8'h79
// unused                   8'h7A
`define UC_FPOP_FCOMP       8'h7B
// unused                   8'h7C
`define UC_FPOP_FSTPEXPO    8'h7D
// unused                   8'h7E
// unused                   8'h7F


// ******************** begin SSE ops

// -------------------- 8'b1000_xxxx
`define UC_FPOP_FPKDPMULPDIMM   8'b1000_0000
`define UC_FPOP_FPKDPMULPD      8'b1000_0001
`define UC_FPOP_FPKDPADDPDIMM   8'b1000_0010
`define UC_FPOP_FPKDPADDPD      8'b1000_0011
`define UC_FPOP_FPKDPSHUFPD     8'b1000_0100
`define UC_FPOP_FPKANDPD        8'b1000_0101
`define UC_FPOP_FPKORPS         8'b1000_0110
`define UC_FPOP_SUDS            8'b1000_0111 // Suds: was unused, maps to hex187 in TSIM
`define UC_FPOP_FPKORPD         8'b1000_1000
`define UC_FPOP_FRECLAIM        8'b1000_1001
`define UC_FPOP_FPKDPMULPSIMM   8'b1000_1010
`define UC_FPOP_FPKDPMULPS      8'b1000_1011
`define UC_FPOP_FPKDPSHUFLPS    8'b1000_1100
`define UC_FPOP_FPKRBITSTRPS    8'b1000_1101
`define UC_FPOP_FPKSTU64        8'b1000_1110
`define UC_FPOP_FPKDPSHUFHPS    8'b1000_1111
// -------------------- 8'b1001_xxxx
`define UC_FPOP_FPKDPADDPSIMM   8'b1001_0000
`define UC_FPOP_FPKMOVD         8'b1001_0001
`define UC_FPOP_FPKDPADDFPS     8'b1001_0010
`define UC_FPOP_FPKDPADDSPS     8'b1001_0011
`define UC_FPOP_FPKANDPS        8'b1001_0100
`define UC_FPOP_FPKDPANDPD      8'b1001_0101
`define UC_FPOP_FPKDPANDPS      8'b1001_0110
`define UC_FPOP_FPKSHUFD        8'b1001_0111
`define UC_FPOP_FPKMGHD         8'b1001_1000
// unused                       8'b1001_1001
// unused                       8'b1001_1010
// unused                       8'b1001_1011
// unused                       8'b1001_1100
`define UC_FPOP_FPKRBITSTRD     8'b1001_1101
// unused                       8'b1001_1110
// unused                       8'b1001_1111
// -------------------- 8'b1010_xxxx
// unused                       8'b1010_0000
`define UC_FPOP_FPKMOV32        8'b1010_0001
// unused                       8'b1010_0010
// unused                       8'b1010_0011
`define UC_FPOP_FPKMGSS         8'b1010_0100
// unused                       8'b1010_0101
`define UC_FPOP_FPKPZERONE      8'b1010_0110
// unused                       8'b1010_0111
`define UC_FPOP_FPKBLENDVPD1    8'b1010_1000
`define UC_FPOP_FPKBLENDVPD2    8'b1010_1001
`define UC_FPOP_FPKBLENDVPS1    8'b1010_1010
`define UC_FPOP_FPKBLENDVPS2    8'b1010_1011
`define UC_FPOP_FPKPBLENDVB1    8'b1010_1100
`define UC_FPOP_FPKPBLENDVB2    8'b1010_1101
`define UC_FPOP_FPKROUNDSS      8'b1010_1110
`define UC_FPOP_FPKROUNDSD      8'b1010_1111
// -------------------- 8'b1011_xxxx
// unused                       8'b1011_0000
// unused                       8'b1011_0001
// unused                       8'b1011_0010
// unused                       8'b1011_0011
`define UC_FPOP_FPKCVTD2SSL     8'b1011_0100
// unused                       8'b1011_0101
`define UC_FPOP_FPKCVTSS2DL     8'b1011_0110
// unused                       8'b1011_0111
// unused                       8'b1011_1000
// unused                       8'b1011_1001
// unused                       8'b1011_1010
// unused                       8'b1011_1011
`define UC_FPOP_FPKCVTSI2SS     8'b1011_1100
// unused                       8'b1011_1101
`define UC_FPOP_FPKCVTDQ2DL     8'b1011_1110
// unused                       8'b1011_1111
// -------------------- 8'b1100_xxxx
`define UC_FPOP_FPKLDMXCSR      8'b1100_0000
`define UC_FPOP_FPKSTMT         8'b1100_0001
`define UC_FPOP_FPKSTLMT        8'b1100_0010
`define UC_FPOP_FPKSTHMT        8'b1100_0011
// unused                       8'b1100_0100
// unused                       8'b1100_0101
`define UC_FPOP_FPKSTMXCSR      8'b1100_0110
`define UC_FPOP_FPKREINT_2PI    8'b1100_0111
`define UC_FPOP_FPKREINT_SNG2PI 8'b1100_1000
`define UC_FPOP_FPKREINT_DBL2PI 8'b1100_1001
`define UC_FPOP_FPKREINT_PI2SNG 8'b1100_1010
`define UC_FPOP_FPKREINT_PI2DBL 8'b1100_1011
// unused                       8'b1100_1100
// unused                       8'b1100_1101
// unused                       8'b1100_1110
// unused                       8'b1100_1111
// -------------------- 8'b1101_xxxx
// unused    			8'b1101_0000
`define UC_FPOP_FPKMOVREG       8'b1101_0001
`define UC_FPOP_FPKSTRRESI      8'b1101_0010
`define UC_FPOP_FPKMOVD64       8'b1101_0011
`define UC_FPOP_FPKSHUFBL       8'b1101_0100
`define UC_FPOP_FPKSHUFBH       8'b1101_0101
`define UC_FPOP_FPKRNDDENSD     8'b1101_0110
`define UC_FPOP_FPKNORMSD       8'b1101_0111
`define UC_FPOP_FPKRNDDENPS     8'b1101_1000
`define UC_FPOP_FPKNORMPS       8'b1101_1001
`define UC_FPOP_FPKRNDDENSS     8'b1101_1010
`define UC_FPOP_FPKNORMSS       8'b1101_1011
`define UC_FPOP_FPKRNDDEND      8'b1101_1100
`define UC_FPOP_FPKNORMD        8'b1101_1101
`define UC_FPOP_FPKSTRLENE      8'b1101_1110
`define UC_FPOP_FPKSTRRESM      8'b1101_1111

// -------------------- 8'b1110_xxxx
`define UC_FPOP_FPKPOR          8'b1110_0000
// unused                       8'b1110_0001
// unused                       8'b1110_0010
// unused                       8'b1110_0011
// unused                       8'b1110_0100
`define UC_FPOP_FPKDPMOVFLGPS   8'b1110_0101
`define UC_FPOP_FPKPMOVMSKB     8'b1110_0110
`define UC_FPOP_FPKDPMOVFLGPD   8'b1110_0111
`define UC_FPOP_FPKPINSRQ       8'b1110_1000
`define UC_FPOP_FPKPCLRQ        8'b1110_1001
`define UC_FPOP_FPKPMULLD	8'b1110_1010
`define UC_FPOP_FPKPMULHD	8'b1110_1011
`define UC_FPOP_FPKPINSRQIMM    8'b1110_1100
`define UC_FPOP_FPKPCLRQIMM     8'b1110_1101
`define UC_FPOP_FPKSTRCMP1E     8'b1110_1110
`define UC_FPOP_FPKSTRCMP1I     8'b1110_1111


// -------------------- 8'b1111_xxxx
`define UC_FPOP_FPKLDPI         8'b1111_0000
`define UC_FPOP_FPKMOVPI        8'b1111_0001
`define UC_FPOP_FPKLDPD         8'b1111_0010
`define UC_FPOP_FPKLDPS         8'b1111_0011
// unused                       8'b1111_0100
// unused                       8'b1111_0101
// unused                       8'b1111_0110
`define UC_FPOP_FPKLDPI128      8'b1111_0111 // not used except by whacker - obsolete

`define UC_FPOP_FPKMPSADSRCSHUF	 8'b1111_1000
`define UC_FPOP_FPKMPSADDESTSHUF 8'b1111_1001
`define UC_FPOP_FPKMPSADBW	 8'b1111_1010

`define UC_FPOP_FPKSTRCMP2E     8'b1111_1011

// unused                       8'b1111_1101
`define UC_FPOP_FPKSTPIU        8'b1111_1110
`define UC_FPOP_FPKSTRCMP2I     8'b1111_1111


// ******************** end SSE ops

//************************************************************************
// These defines used to be used in RTL but are still required for the tsim
// effort. Adding an additional bit to distinguish them from real fpu ops

// `define UC_FPOP_FPMLDD          9'h10C
// `define UC_FPOP_FSTSWEF         9'h129
// `define UC_FPOP_FPUNPKHDQ       9'h129  
// `define UC_FPOP_FPZEROCHK       9'h14F
// `define UC_FPOP_FPUNPKLDQ       9'h169
// `define UC_FPOP_FPMSTD          9'h16E
// `define UC_FPOP_FPKLD64         9'b1_1000_0000
// `define UC_FPOP_FPKMOV64        9'b1_1000_0001
// `define UC_FPOP_FPKMOVMSKPS     9'b1_1000_0010
// `define UC_FPOP_FPKSHUFPS       9'b1_1000_0011
// `define UC_FPOP_FPKHADDPS       9'b1_1000_0100
// `define UC_FPOP_FPKHSUBPS       9'b1_1000_0101
// `define UC_FPOP_FPKSTD64        9'b1_1000_1001
// `define UC_FPOP_FPKLDD          9'b1_1001_0000
// `define UC_FPOP_FPKMOVMSKD      9'b1_1001_0010
// `define UC_FPOP_FPKSHUFD        9'b1_1001_0011
// `define UC_FPOP_FPKADDD         9'b1_1001_0100
// `define UC_FPOP_FPKSUBD         9'b1_1001_0101
// `define UC_FPOP_FPKUCOMID       9'b1_1001_0110
// `define UC_FPOP_FPKCOMID        9'b1_1001_0111
// `define UC_FPOP_FPKSTDD         9'b1_1001_1001
// `define UC_FPOP_FPALIGNR        9'b1_1001_1010
// `define UC_FPOP_FPKSTDU         9'b1_1001_1110
// `define UC_FPOP_FPKLD32         9'b1_1010_0000
// `define UC_FPOP_FPKSTD32        9'b1_1010_0101
// `define UC_FPOP_FPKCVTTD2DQL    9'b1_1011_0000
// `define UC_FPOP_FPKCVTTD2DQH    9'b1_1011_0001
// `define UC_FPOP_FPKCVTD2DQL     9'b1_1011_0010
// `define UC_FPOP_FPKCVTD2DQH     9'b1_1011_0011
// `define UC_FPOP_FPKCVTD2SSH     9'b1_1011_0101
// `define UC_FPOP_FPKCVTTD2PIL    9'b1_1011_1000
// `define UC_FPOP_FPKCVTTD2PIH    9'b1_1011_1001
// `define UC_FPOP_FPKCVTD2PIL     9'b1_1011_1010
// `define UC_FPOP_FPKCVTD2PIH     9'b1_1011_1011
// `define UC_FPOP_FPKSTMTYPE      9'b1_1100_0100
// `define UC_FPOP_FPKLDCROMS      9'b1_1100_1100
// `define UC_FPOP_FPKLDCROMPI     9'b1_1100_1110
// `define UC_FPOP_FPKPACKSSWB     9'b1_1110_0001
// `define UC_FPOP_FPKPACKSSDW     9'b1_1110_0010
// `define UC_FPOP_FPKPACKUSWB     9'b1_1110_0011
// `define UC_FPOP_FPKPINSRWL      9'b1_1110_0100
// `define UC_FPOP_FPKPINSRWH      9'b1_1110_0101
// `define UC_FPOP_FPWKPMOVMSKB    9'b1_1110_0111
// `define UC_FPOP_FPWKPINSRQ      9'b1_1110_1010
// `define UC_FPOP_FPWKPCLRQ       9'b1_1110_1011
// `define UC_FPOP_FPKPSHUFD       9'b1_1111_0010
// `define UC_FPOP_FPKHADDW        9'b1_1111_0100
// `define UC_FPOP_FPKHADDD        9'b1_1111_0101
// `define UC_FPOP_FPKHADDSW       9'b1_1111_0110
// `define UC_FPOP_FPKHSUBW        9'b1_1111_1000
// `define UC_FPOP_FPKHSUBD        9'b1_1111_1001
// `define UC_FPOP_FPKHSUBSW       9'b1_1111_1010
// `define UC_FPOP_FPKSTLPI        9'b1_1111_1101
// `define UC_FPOP_FPKLDPIDW       9'b1_1111_0011
// `define UC_FPOP_FPKSTHPI        9'b1_1111_1100

//************************************************************************
// /* ******************** start tsim-specific opcodes */
// /* To add a new opcode:
//   1. create a UC_TSIMOP_myop define here in uc_field.d
//   2. add the opcode to uc.l (like t_fld)
//   3. add the token translation to the function tsim_tokenToFpOpcode in uc_actions.cc
//   4. add the token to uc.y (like TSIM_FLD)

//   5. Regenerate k8_opcode_table.h to contain the new opcodes.
// */

`define UC_TSIMOP_FADD   12'hc00
`define UC_TSIMOP_FSUB   12'hc01
`define UC_TSIMOP_FSUBR  12'hc02
`define UC_TSIMOP_FMUL   12'hc03
`define UC_TSIMOP_FDIV   12'hc04
`define UC_TSIMOP_FDIVR  12'hc05

`define UC_TSIMOP_FLD    12'hc06
`define UC_TSIMOP_FCHS   12'hc07
`define UC_TSIMOP_FPREM  12'hc08
`define UC_TSIMOP_FPREM1 12'hc09
`define UC_TSIMOP_FSQRT  12'hc0a
`define UC_TSIMOP_FTST   12'hc0b
`define UC_TSIMOP_FCOM   12'hc0c
`define UC_TSIMOP_FUCOM  12'hc0d

`define UC_TSIMOP_FFREE  12'hc0e
`define UC_TSIMOP_FXCH   12'hc0f

`define UC_TSIMOP_FST    12'hc10
`define UC_TSIMOP_FIST   12'hc11

// /* POP-flavors of opcodes - use same bit patterns as regular fp opcodes*/
// /* FP opcodes with pop are in the c30-c3f range: */
`define UC_TSIMOP_FADDP  12'hc30
`define UC_TSIMOP_FSUBP  12'hc31
`define UC_TSIMOP_FSUBRP 12'hc32
`define UC_TSIMOP_FMULP  12'hc33
`define UC_TSIMOP_FDIVP  12'hc34
`define UC_TSIMOP_FDIVRP 12'hc35
`define UC_TSIMOP_FSTP   12'hc36
`define UC_TSIMOP_FCOMP  12'hc37
`define UC_TSIMOP_FUCOMP 12'hc38

`define UC_TSIMOP_FISTP  12'hc3a

`define UC_TSIMOP_FDEC   12'hc3b
`define UC_TSIMOP_FMOVP  12'hc3c


// /* These opcodes in the 0xc40-0xc47 range pop the stack twice */
`define UC_TSIMOP_FCOMPP  12'hc40
`define UC_TSIMOP_FUCOMPP 12'hc41

`define UC_TSIMOP_FINCSTP 12'hc48
`define UC_TSIMOP_FPUSH   12'hc49  // reg-reg fp loads, also a stack push.


// /* ******************** end tsim-specific opcodes */



//************************************************************************
// MAXIMUM FPU CONSTANT ROM ADDRESS

`define UC_FPU_CROM_MAX     7'h7F

//************************************************************************
// C6 Save memory region

`define C6_SAVE_BASE        16'hFDF7

//************************************************************************
// L2I configuration register base

`define L2I_REG_BASE        16'hFDF5

// L2I addresses are bits [10:3] of the config address: - { `L2I_REG_BASE, 13'b0, `L2I_REG_CTL1, 3'b0 }
`define L2I_REG_CFG         8'h0A
`define L2I_REG_CTL1        8'h0C
`define L2I_REG_CTL2        8'h0E


//************************************************************************

`endif   //`ifndef _UC_FIELD_D_

//</PRE></BODY></HTML>

