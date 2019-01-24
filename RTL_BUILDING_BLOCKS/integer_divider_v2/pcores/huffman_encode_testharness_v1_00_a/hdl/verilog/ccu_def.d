//=======================================================================
//                     Jaguar RTL design file
//=======================================================================
//                  AMD PROPRIETARY AND CONFIDENTIAL
//           (c) Copyright 2006-2010 Advanced Micro Devices, Inc.
//=======================================================================
// File Id and RCS Info:
// $Id: ccu_def.d,v 1.1 2010/12/08 22:14:14 vsananda Exp $
// $Change: 43720 $
//=======================================================================
// Module Description:
// defines for CCU 
//=======================================================================

`ifndef _CCU_DEF_D_
`define _CCU_DEF_D_

// ROB 
`define ROB_SIZE    56
`define ROB_TOP     55

// Motley Queue Defines
`define MOTQ_SIZE 12               // size of the Motley Queue in FR
`define MOTQ_TOP  `MOTQ_SIZE-1

// Dispatch/Retire Map State 
`define MS_SIZE   30               // number of renamed registers
`define MS_TOP    `MS_SIZE-1

// PRF Free List
// PRFFL depth needs to be PRF_SIZE - MS_SIZE + 1
// (+1 is because sometimes ESP and RCVESP have the same mapped PRN)
`define PRFFL_SIZE 35
`define PRFFL_TOP  34

// PRF Defines
`define PRF_SIZE    64             // number of physical registers
`define PRF_TOP     63

// AGU Scheduling Queue (AG SQ) size and ranges
`define AG_SIZEP1   9
`define AG_SIZE     8              // total number of entries in AGU SQ
`define AG_TOP      7              // max entry in AGU SQ
`define AG_ALL      7:0            // indexes into all the AGU Reservation Stations
// vpp work-arounds for a conv bug when LHS of gate has `AG_TOP+1 in it.
`define AG_DP1      9
`define AG_DP0      8
`define AG_TOP_M1   6
`define AG_TOP_M2   5

// ALU Scheduling Queue (AL SQ) size and ranges
`define AL_SIZEP1   17 
`define AL_SIZE     16             // total number of entries in ALU SQ
`define AL_TOP      15             // max entry in ALU SQ
`define AL_ALL      15:0           // indexes into all the ALU Reservation Stations
// vpp work-arounds for a conv bug when LHS of gate has `AL_TOP+1 in it.
`define AL_DP1      17
`define AL_DP0      16
`define AL_TOP_M1   14
`define AL_TOP_M2   13

// ALU Arithmetic/Logical Function Select encoding
`define ALU_FUNCSEL_OTHER   4'b0000
`define ALU_FUNCSEL_ADD     4'b0001
`define ALU_FUNCSEL_SUB     4'b0010
`define ALU_FUNCSEL_SUBR    4'b0011
`define ALU_FUNCSEL_DIVSTEP 4'b0100
`define ALU_FUNCSEL_ANDN    4'b1000
`define ALU_FUNCSEL_ANDNR   4'b1001
`define ALU_FUNCSEL_AND     4'b1010
`define ALU_FUNCSEL_NAND    4'b1011
`define ALU_FUNCSEL_XOR     4'b1100
`define ALU_FUNCSEL_A       4'b1101
`define ALU_FUNCSEL_B       4'b1110
`define ALU_FUNCSEL_OR      4'b1111


// Overloaded firob control bits stashed in FpOpcode field
//`define SSE_OP   0
//`define LO_DBL   1
//`define TOS_CLR  2

// Positions of status flag bits on flag result bus
`define FLAG_C       0
`define FLAG_P       1
`define FLAG_A       2
`define FLAG_Z       3
`define FLAG_S       4
`define FLAG_O       5
`define FLAG_SZAP    4:1
`define FLAG_OSZAPC  5:0

// positions of used EFLAGS bits
`define EFLAGS_VIP   20
`define EFLAGS_VIF   19
`define EFLAGS_AC    18
`define EFLAGS_VM    17
`define EFLAGS_RF    16
`define EFLAGS_IOPL  13:12
`define EFLAGS_IF    9
`define EFLAGS_TF    8

// positions of used FIROBCTL bits
`define FIROBCTL_INT_SHADOW 4 // read/write
`define FIROBCTL_GIF        3 // read/write
`define FIROBCTL_SSELASTRF  2 // read only
`define FIROBCTL_FERRMASK   1 // read/write
`define FIROBCTL_RF         0 // read/write

// Firob Debug Control (FrDbgCtl) bit positions
`define APSTARTFETCHINTEN 8    // Enable AP Start Fetch interrupts
`define TRACE_FARBR_ONLY  7    // Generate branch trace traps on just jfar/jfarman instead of on all non-jresync macro branches.
`define TRACE_BITMAP_ALL  6    // Enable unconditional branch recording in the branch bitmap.
`define TRACE_FULL_ALL    5    // Enable full trace recording for all branches.
`define TRACE_ENABLE      4    // enable branch tracing
`define DR3210_ENABLE     3:0  // enable DR[3:0] in CCU
`define DR3_ENABLE        3    // enable DR3 in CCU
`define DR2_ENABLE        2    // enable DR2 in CCU
`define DR1_ENABLE        1    // enable DR1 in CCU
`define DR0_ENABLE        0    // enable DR0 in CCU

// DbgCtlMsr bit fields
`define BPMUXSEL      5:2     // breakpoint pin control
`define BRANCH_TF     1       // BTF, branch single-step:
                              // 0: eflags_TF controls instr single-stepping
                              // 1: eflags_TF controls single-stepping on 
                              //    control transfers
`define LAST_BRANCH   0       // LBR: last branch record

// DbgCtlMsr2 bit fields
`define MNI_DISABLE   8    // Disable MNI (SSSE3) instructions. R/W in FR as required by ARB. Shadowed in DE to mark instructions as illegal.
`define EMERGENCY_HDT 7    // Enable emergency HDT mode
`define SIGNATURE_BP  6    // Software signature output control bit
`define EMULATE_SSE   5    // Generate DNA faults on SSE/SSE2/SSE3 ops.
`define EMULATE_FPU   4    // Generate DNA faults on x87 floating point ops.
`define EMULATE_MMX   3    // Generate DNA faults on MMX ops.
`define STDATBRKMODE  1:0  // Store data breakpoint mode for LS:
                           // 00: normal oper, address match breakpointing only
                           // 01: data match only (no address match)
                           // 10: address and data match
                           // 11: address match and data mismatch

// CpuWdTmrCfg bit fields
`define CPUWDTMR_CNT_SEL      6:3  // WDT timeout value. The time period is this value times
                                   // the time base specified in the time base field.
                                   // 0000: 4095
                                   // 0001: 2047
                                   // 0010: 1023
                                   // 0011: 511
                                   // 0100: 255
                                   // 0101: 127
                                   // 0110: 63
                                   // 0111: 31
                                   // 1000: 8191
                                   // 1001: 16383
                                   // 1010 - 1111: <reserved>
`define CPUWDTMR_TIMEBASE_SEL 2:1  // time base for CPU Watchdog Timer tick:
                                   // 00: 1.28 ms
                                   // 01: 1.28 us
                                   // 10: 5 ns
                                   // 11: <reserved>
`define CPUWDTMR_EN             0  // Enable CPU WDT (disabled by default)

// x87 reg-cache control/stat register bit fields
`define X87_REG_CACHE_STATUS_BIT 0  // 0: x87 regs are not cached in EMEM
                                    // 1: x87 regs are     cached in EMEM
`define X87_REG_CACHE_STATUS 0x1

// SpecialBr branch types
`define SPECBR_BIT_STALLXFER 2     // StallXfer is jfar, jfarman, or jresync
`define SPECBR_NONE         3'b000
`define SPECBR_CONDITIONAL  3'b001
`define SPECBR_CALL         3'b010
`define SPECBR_RETURN       3'b011
`define SPECBR_JFAR         3'b100
`define SPECBR_JFARMAN      3'b101
`define SPECBR_JRESYNC      3'b110


// Stack engine defines
`define ESP_ADJ_NONE    2'b00
`define ESP_ADJ_INC     2'b01
`define ESP_ADJ_DEC     2'b10
`define ESP_ADJ_CLR     2'b11


// Flag read/write bit positions.
`define ME_FLG_CF    0
`define ME_FLG_SZAP  1
`define ME_FLG_OF    2

// Displacement pointer bit positions.
`define ME_DI_SIZE 2:1    // Bits 2:1 give the size.
`define ME_DI_NONE 2'b00 // No displacement/immediate field.
`define ME_DI_1B   2'b01 //  8 bit displacement/immediate.
`define ME_DI_2B   2'b10 // 16 bit displacement/immediate.
`define ME_DI_4B   2'b11 // 32 bit displacement/immediate.

`define ME_DI_PTR  0      // Bit 0.
`define ME_DI_MROM 1'b1   // Use Mrom displacement field.
// else  - Use x86 displacement/immediate field within a 24 byte block.

`define ME_IM_SIGN 3      // Sign of immediate
`define ME_IM_SIZE 2:0    // Bits 2:0 give the size.

`define ME_IM_NONE 3'b000 // No displacement/immediate field.
`define ME_IM_1B   3'b001 //  8 bit displacement/immediate.
`define ME_IM_2B   3'b010 // 16 bit displacement/immediate.
`define ME_IM_4B   3'b011 // 32 bit displacement/immediate.
`define ME_IM_8B   3'b100 // 64 bit displacement/immediate.



// Encoded Prefix Bytes
`define ME_REPE_MSK    10'b10_0000_0000     // REP/REPE/REPZ prefix mask
`define ME_ANYREP_MSK  10'b01_0000_0000     // REPNE/REPNZ prefix mask
`define ME_2BOPC_MSK   10'b00_1000_0000     // two-byte opcode mask
`define ME_OPSZ_MSK    10'b00_0100_0000     // operand-size prefix mask
`define ME_ADSZ_MSK    10'b00_0010_0000     // address-size prefix mask
`define ME_LOCK_MSK    10'b00_0001_0000     // LOCK prefix mask
// NOTE:  I need to make these match the uc_field.d definitions.
`define ME_ES_MSK      10'b00_0000_1000     // ES prefix mask
`define ME_CS_MSK      10'b00_0000_1001     // CS prefix mask
`define ME_SS_MSK      10'b00_0000_1010     // SS prefix mask
`define ME_DS_MSK      10'b00_0000_1011     // DS prefix mask
`define ME_FS_MSK      10'b00_0000_1100     // FS prefix mask
`define ME_GS_MSK      10'b00_0000_1101     // GS prefix mask 

// bit defines for DE_MromPrefix_4 encoded prefixes.
`define ME_PFX_ANYREX 16    // REX prefix present
`define ME_PFX_REX3   15    // REX.W: bit 3 from REX byte
`define ME_PFX_REX2   14    // REX.R: bit 2 from REX byte
`define ME_PFX_REX1   13    // REX.X: bit 1 from REX byte
`define ME_PFX_REX0   12    // REX.B: bit 0 from REX byte
`define ME_PFX_MNI3A  11    // MNI (SSSE3) 0x3A 3-byte opcode [0F 3A xx]
`define ME_PFX_MNI38  10    // MNI (SSSE3) 0x38 3-byte opcode [0F 38 xx]
`define ME_PFX_SSEPFX  8:9  // bits 8:9:  (note reverse bit ordering from DE_Prefix!)
                            // 00 none
                            // 01 opsize override (66)
                            // 10 REPNE (F2)
                            // 11 REPE (F3)
`define ME_PFX_REPE    9
`define ME_PFX_ANYREP  8
`define ME_PFX_2BOPC   7    // 0F two-byte opcode escape
`define ME_PFX_OPSZ    6    // 66 operand size override prefix
`define ME_PFX_ADSZ    5    // 67 address size override prefix
`define ME_PFX_LOCK    4    // F0 lock prefix
`define ME_PFX_SEG     3    // any segment override prefix (2E,36,3E,26,64,65)
// NOTE:  I need to make these match the uc_field.d definitions.
// These are a subset of the `ME_PFX_SEG.
`define ME_PFX_ES     3'h0
`define ME_PFX_CS     3'h1
`define ME_PFX_SS     3'h2
`define ME_PFX_DS     3'h3
`define ME_PFX_FS     3'h4
`define ME_PFX_GS     3'h5

// bit defines for 5-bit REX prefix field from SA (lower four bits are from the REX prefix byte)
`define REX_PRESENT   4
`define REX_W         3
`define REX_R         2
`define REX_X         1
`define REX_B         0

`endif   // `ifndef _CCU_DEF_D_
