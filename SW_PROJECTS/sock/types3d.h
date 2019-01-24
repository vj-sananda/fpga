/****************************************************************************\
|*                                                                           *|
|*       Copyright (c) 1995-1996 by NVIDIA Corp.  All rights reserved.       *|
|*                                                                           *|
|*     This material  constitutes  the trade  secrets  and confidential,     *|
|*     proprietary information of NVIDIA, Corp.  This material is not to     *|
|*     be  disclosed,  reproduced,  copied,  or used  in any manner  not     *|
|*     permitted  under license from NVIDIA, Corp.                           *|
|*                                                                           *|
 \***************************************************************************/

#ifndef _types_h
#define _types_h

#include "nvos.h"

#ifndef FALSE
#define FALSE 0
#endif
#ifndef TRUE
#define TRUE 1
#endif
#ifndef NULL
#define NULL 0
#endif


typedef unsigned char U008;
typedef unsigned char V008;
typedef unsigned short U016;
typedef unsigned short V016;

typedef NVR_S32 S032;
typedef NVR_U32 U032;
typedef NVR_U32 V032;

typedef signed char S008, S007, S006, S005, S004, S003, S002, S001;
typedef signed short S016, S015, S014, S013, S012, S011, S010, S009;
typedef NVR_S32 S031, S030, S029, S028, S027, S026, S025;
typedef NVR_S32 S024, S023, S022, S021, S020, S019, S018, S017;
typedef NVR_S64 S064;

typedef unsigned char U007, U006, U005, U004, U003, U002, U001;
typedef unsigned short U015, U014, U013, U012, U011, U010, U009;
typedef NVR_U32 U031, U030, U029, U028, U027, U026, U025;
typedef NVR_U32 U024, U023, U022, U021, U020, U019, U018, U017;
typedef NVR_U64 U033, U064;

typedef unsigned char V007, V006, V005, V004, V003, V002, V001;
typedef unsigned short  V015, V014, V013, V012, V011, V010, V009;
typedef NVR_U32 V031, V030, V029, V028, V027, V026, V025;
typedef NVR_U32 V024, V023, V022, V021, V020, V019, V018, V017;
typedef NVR_U64 V064;

typedef float F032;
typedef double F064;

#endif /*!_types_h*/

