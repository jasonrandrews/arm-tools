# Version: 0.10.0
# Date: 2020-09-30
# This file maps the CMSIS project options to toolchain settings.
#
#   - Applies to toolchain: ARMCC 6.14.0

############### EDIT BELOW ###############
# Set base directory of toolchain
TOOLCHAIN_ROOT:= /home/ubuntu/AC6/bin

############ DO NOT EDIT BELOW ###########

AS:=$(TOOLCHAIN_ROOT)/armasm
CC:=$(TOOLCHAIN_ROOT)/armclang
CXX:=$(TOOLCHAIN_ROOT)/armclang
LD:=$(TOOLCHAIN_ROOT)/armlink
AR:=$(TOOLCHAIN_ROOT)/armar
OC:=$(TOOLCHAIN_ROOT)/fromelf

# Escape whitespace in toolchain root
TOOLCHAIN_ROOT_WS:=$(subst $() ,\ ,$(TOOLCHAIN_ROOT))

# Assembler

ifeq ($(CPU),Cortex-M0)
  ARMASM_CPU:=--cpu=$(CPU)
else ifeq ($(CPU),Cortex-M0+)
  ARMASM_CPU:=--cpu=cortex-m0plus
else ifeq ($(CPU),Cortex-M1)
  ARMASM_CPU:=--cpu=$(CPU)
else ifeq ($(CPU),Cortex-M3)
  ARMASM_CPU:=--cpu=$(CPU)
else ifeq ($(CPU),Cortex-M4)
  ifeq ($(FPU),NO_FPU)
    ARMASM_CPU:=--cpu=$(CPU).no_fp
  else
    ARMASM_CPU:=--cpu=$(CPU)
  endif
else ifeq ($(CPU),Cortex-M7)
  ifeq ($(FPU),NO_FPU)
    ARMASM_CPU:=--cpu=$(CPU).no_fp
  else ifeq ($(FPU),SP_FPU)
    ARMASM_CPU:=--cpu=$(CPU).fp.sp
  else
    ARMASM_CPU:=--cpu=$(CPU)
  endif
else ifeq ($(CPU),Cortex-M23)
  ARMASM_CPU:=--cpu=$(CPU)
else ifeq ($(CPU),Cortex-M33)
  ifeq ($(FPU),NO_FPU)
    ifeq ($(DSP),NO_DSP)
      ARMASM_CPU:=--cpu=$(CPU).no_dsp.no_fp
    else
      ARMASM_CPU:=--cpu=$(CPU).no_fp
    endif
  else
    ifeq ($(DSP),NO_DSP)
      ARMASM_CPU:=--cpu=$(CPU).no_dsp
    else
      ARMASM_CPU:=--cpu=$(CPU)
    endif
  endif
else ifeq ($(CPU),Cortex-M35P)
  ifeq ($(FPU),NO_FPU)
    ifeq ($(DSP),NO_DSP)
      ARMASM_CPU:=--cpu=$(CPU).no_dsp.no_fp
    else
      ARMASM_CPU:=--cpu=$(CPU).no_fp
    endif
  else
    ifeq ($(DSP),NO_DSP)
      ARMASM_CPU:=--cpu=$(CPU).no_dsp
    else
      ARMASM_CPU:=--cpu=$(CPU)
    endif
  endif
else ifeq ($(CPU),Cortex-M55)
  ifeq ($(FPU),NO_FPU)
    ifeq ($(MVE),NO_MVE)
      ARMASM_CPU:=--cpu=$(CPU).no_mve.no_fp
    else
      ARMASM_CPU:=--cpu=$(CPU).no_fp
    endif
  else
    ifeq ($(MVE),NO_MVE)
      ARMASM_CPU:=--cpu=$(CPU).no_mve
    else ifeq ($(MVE),MVE)
      ARMASM_CPU:=--cpu=$(CPU).no_mvefp
    else
      ARMASM_CPU:=--cpu=$(CPU)
    endif
  endif
else ifeq ($(CPU),SC000)
  ARMASM_CPU:=--cpu=$(CPU)
else ifeq ($(CPU),SC300)
  ARMASM_CPU:=--cpu=$(CPU)
else ifeq ($(CPU),ARMV8MBL)
  ARMASM_CPU:=--cpu=8-M.Base
else ifeq ($(CPU),ARMV8MML)
  ifeq ($(FPU),NO_FPU)
    ifeq ($(DSP),NO_DSP)
      ARMASM_CPU:=--cpu=8-M.Main --fpu=softvfp
    else
      ARMASM_CPU:=--cpu=8-M.Main.dsp --fpu=softvfp
    endif
  else ifeq ($(FPU),SP_FPU)
    ifeq ($(DSP),NO_DSP)
      ARMASM_CPU:=--cpu=8-M.Main --fpu=fpv5-sp
    else
      ARMASM_CPU:=--cpu=8-M.Main.dsp --fpu=fpv5-sp
    endif
  else ifeq ($(FPU),DP_FPU)
    ifeq ($(DSP),NO_DSP)
      ARMASM_CPU:=--cpu=8-M.Main --fpu=fpv5_d16
    else
      ARMASM_CPU:=--cpu=8-M.Main.dsp --fpu=fpv5_d16
    endif
  endif
else ifeq ($(CPU),ARMV81MML)
  ifeq ($(FPU),NO_FPU)
    ifeq ($(MVE),NO_MVE)
      ifeq ($(DSP),NO_DSP)
        ARMASM_CPU:=--cpu=8.1-M.Main --fpu=SoftVFP
      else
        ARMASM_CPU:=--cpu=8.1-M.Main.dsp --fpu=SoftVFP
      endif
    else ifeq ($(MVE),MVE)
      ARMASM_CPU:=--cpu=8.1-M.Main.mve --fpu=SoftVFP
    endif
  else ifeq ($(FPU),SP_FPU)
    ifeq ($(MVE),NO_MVE)
      ifeq ($(DSP),NO_DSP)
        ARMASM_CPU:=--cpu=8.1-M.Main --fpu=FPv5-SP
      else
        ARMASM_CPU:=--cpu=8.1-M.Main.dsp --fpu=FPv5-SP
      endif
    else ifeq ($(MVE),MVE)
      ARMASM_CPU:=--cpu=8.1-M.Main.mve --fpu=FPv5-SP
    else
      ARMASM_CPU:=--cpu=8.1-M.Main.mve.fp --fpu=FPv5-SP
    endif
  else ifeq ($(FPU),DP_FPU)
    ifeq ($(MVE),NO_MVE)
      ifeq ($(DSP),NO_DSP)
        ARMASM_CPU:=--cpu=8.1-M.Main --fpu=FPv5_D16
      else
        ARMASM_CPU:=--cpu=8.1-M.Main.dsp --fpu=FPv5_D16
      endif
    else ifeq ($(MVE),MVE)
      ARMASM_CPU:=--cpu=8.1-M.Main.mve --fpu=FPv5_D16
    else
      ARMASM_CPU:=--cpu=8.1-M.Main.mve.fp --fpu=FPv5_D16
    endif
  endif
endif
ifndef ARMASM_CPU
$(error Error: CPU is not supported!)
endif

ifeq ($(CPU),Cortex-M0)
  ARMCLANG_CPU:=-mcpu=$(CPU) -mfpu=none
else ifeq ($(CPU),Cortex-M0+)
  ARMCLANG_CPU:=-mcpu=cortex-m0plus -mfpu=none
else ifeq ($(CPU),Cortex-M1)
  ARMCLANG_CPU:=-mcpu=$(CPU) -mfpu=none
else ifeq ($(CPU),Cortex-M3)
  ARMCLANG_CPU:=-mcpu=$(CPU) -mfpu=none
else ifeq ($(CPU),Cortex-M4)
  ifeq ($(FPU),SP_FPU)
    ARMCLANG_CPU:=-mcpu=$(CPU) -mfpu=fpv4-sp-d16 -mfloat-abi=hard
  else
    ARMCLANG_CPU:=-mcpu=$(CPU) -mfpu=none
  endif
else ifeq ($(CPU),Cortex-M7)
  ifeq ($(FPU),DP_FPU)
    ARMCLANG_CPU:=-mcpu=$(CPU) -mfpu=fpv5-d16 -mfloat-abi=hard
  else ifeq ($(FPU),SP_FPU)
    ARMCLANG_CPU:=-mcpu=$(CPU) -mfpu=fpv5-sp-d16 -mfloat-abi=hard
  else
    ARMCLANG_CPU:=-mcpu=$(CPU) -mfpu=none
  endif
else ifeq ($(CPU),Cortex-M23)
  ARMCLANG_CPU:=-mcpu=$(CPU) -mfpu=none
else ifeq ($(CPU),Cortex-M33)
  ifeq ($(FPU),SP_FPU)
    ARMCLANG_CPU:=-mcpu=$(CPU) -mfpu=fpv5-sp-d16 -mfloat-abi=hard
  else ifeq ($(DSP),DSP)
    ARMCLANG_CPU:=-mcpu=$(CPU) -mfpu=none
  else
    ARMCLANG_CPU:=-mcpu=$(CPU)+nodsp -mfpu=none
  endif
else ifeq ($(CPU),Cortex-M35P)
  ifeq ($(FPU),SP_FPU)
    ifeq ($(DSP),DSP)
      ARMCLANG_CPU:=-mcpu=$(CPU) -mfpu=fpv5-sp-d16 -mfloat-abi=hard
    else
      ARMCLANG_CPU:=-mcpu=$(CPU)+nodsp -mfpu=fpv5-sp-d16 -mfloat-abi=hard
    endif
  else
    ifeq ($(DSP),DSP)
      ARMCLANG_CPU:=-mcpu=$(CPU) -mfpu=none
    else
      ARMCLANG_CPU:=-mcpu=$(CPU)+nodsp -mfpu=none
    endif
  endif
else ifeq ($(CPU),Cortex-M55)
  ifeq ($(FPU),NO_FPU)
    ifeq ($(MVE),NO_MVE)
      ARMCLANG_CPU:=-mcpu=$(CPU)+nofp+nomve
    else
      ARMCLANG_CPU:=-mcpu=$(CPU)+nofp
    endif
  else
    ifeq ($(MVE),NO_MVE)
      ARMCLANG_CPU:=-mcpu=$(CPU)+nomve -mfloat-abi=hard
    else ifeq ($(MVE),MVE)
      ARMCLANG_CPU:=-mcpu=$(CPU)+nomve.fp -mfloat-abi=hard
    else
      ARMCLANG_CPU:=-mcpu=$(CPU) -mfloat-abi=hard
    endif
  endif
else ifeq ($(CPU),SC000)
  ARMCLANG_CPU:=-mcpu=$(CPU) -mfpu=none
else ifeq ($(CPU),SC300)
  ARMCLANG_CPU:=-mcpu=$(CPU) -mfpu=none
else ifeq ($(CPU),ARMV8MBL)
  ARMCLANG_CPU:=-march=armv8-m.base
else ifeq ($(CPU),ARMV8MML)
  ifeq ($(FPU),NO_FPU)
    ifeq ($(DSP),NO_DSP)
      ARMCLANG_CPU:=-march=armv8-m.main -mfpu=none -mfloat-abi=soft
    else
      ARMCLANG_CPU:=-march=armv8-m.main+dsp -mfpu=none -mfloat-abi=soft
    endif
  else ifeq ($(FPU),SP_FPU)
    ifeq ($(DSP),NO_DSP)
      ARMCLANG_CPU:=-march=armv8-m.main -mfpu=fpv5-sp-d16 -mfloat-abi=hard
    else
      ARMCLANG_CPU:=-march=armv8-m.main+dsp -mfpu=fpv5-sp-d16 -mfloat-abi=hard
    endif
  else ifeq ($(FPU),DP_FPU)
    ifeq ($(DSP),NO_DSP)
      ARMCLANG_CPU:=-march=armv8-m.main -mfpu=fpv5-d16 -mfloat-abi=hard
    else
      ARMCLANG_CPU:=-march=armv8-m.main+dsp -mfpu=fpv5-d16 -mfloat-abi=hard
    endif
  endif
else ifeq ($(CPU),ARMV81MML)
  ifeq ($(FPU),NO_FPU)
    ifeq ($(DSP),NO_DSP)
      ifeq ($(MVE),NO_MVE)
        ARMCLANG_CPU:=-march=armv8.1-m.main+nofp -mfloat-abi=soft
      else ifeq ($(MVE),MVE)
        ARMCLANG_CPU:=-march=armv8.1-m.main+mve+nofp -mfloat-abi=soft
      endif
    else
      ifeq ($(MVE),NO_MVE)
        ARMCLANG_CPU:=-march=armv8.1-m.main+dsp+nofp -mfloat-abi=soft
      else ifeq ($(MVE),MVE)
        ARMCLANG_CPU:=-march=armv8.1-m.main+dsp+mve+nofp -mfloat-abi=soft
      endif
    endif
  else ifeq ($(FPU),SP_FPU)
    ifeq ($(DSP),NO_DSP)
      ifeq ($(MVE),NO_MVE)
        ARMCLANG_CPU:=-march=armv8.1-m.main+fp -mfloat-abi=hard
      else ifeq ($(MVE),MVE)
        ARMCLANG_CPU:=-march=armv8.1-m.main+mve+fp -mfloat-abi=hard
      else
        ARMCLANG_CPU:=-march=armv8.1-m.main+mve.fp+fp -mfloat-abi=hard
      endif
    else
      ifeq ($(MVE),NO_MVE)
        ARMCLANG_CPU:=-march=armv8.1-m.main+dsp+fp -mfloat-abi=hard
      else ifeq ($(MVE),MVE)
        ARMCLANG_CPU:=-march=armv8.1-m.main+dsp+mve+fp -mfloat-abi=hard
      else
        ARMCLANG_CPU:=-march=armv8.1-m.main+dsp+mve.fp+fp -mfloat-abi=hard
      endif
    endif
  else ifeq ($(FPU),DP_FPU)
    ifeq ($(DSP),NO_DSP)
      ifeq ($(MVE),NO_MVE)
        ARMCLANG_CPU:=-march=armv8.1-m.main+fp.dp -mfloat-abi=hard
      else ifeq ($(MVE),MVE)
        ARMCLANG_CPU:=-march=armv8.1-m.main+mve+fp.dp -mfloat-abi=hard
      else
        ARMCLANG_CPU:=-march=armv8.1-m.main+mve.fp+fp.dp -mfloat-abi=hard
      endif
    else
      ifeq ($(MVE),NO_MVE)
        ARMCLANG_CPU:=-march=armv8.1-m.main+dsp+fp.dp -mfloat-abi=hard
      else ifeq ($(MVE),MVE)
        ARMCLANG_CPU:=-march=armv8.1-m.main+dsp+mve+fp.dp -mfloat-abi=hard
      else
        ARMCLANG_CPU:=-march=armv8.1-m.main+dsp+mve.fp+fp.dp -mfloat-abi=hard
      endif
    endif
  endif
endif
ifndef ARMCLANG_CPU
$(error Error: CPU is not supported!)
endif

# Supported Assembly Variants:
#   AS_AA: armasm + Arm syntax
#   AS_CA: armclang + Arm syntax
#   AS_CG: armclang + GNU syntax
#   AS: armclang + pre-processing

AS_AA:=$(AS)
AS_CA:=$(CC)
AS_CG:=$(CC)
AS:=$(CC)

AS_AA_CPU:=$(ARMASM_CPU)
AS_CA_CPU:=$(ARMCLANG_CPU)
AS_CG_CPU:=$(ARMCLANG_CPU)
AS_CPU:=$(ARMCLANG_CPU)

COMMA:=,
AS_AA_DEFINES:=$(call ews_patsubst,%,--pd "% SETA 1",$(DEFINES))
AS_CA_DEFINES:=$(call patsubst,%,-Wa$(COMMA)armasm$(COMMA)--pd$(COMMA)"% SETA 1",$(DEFINES))
AS_CG_DEFINES:=$(call patsubst,%,-Wa$(COMMA)-defsym$(COMMA)"%=1",$(DEFINES))
AS_DEFINES:=$(call patsubst,%,-D%,$(DEFINES))

ifeq ($(BYTE_ORDER),Little-endian)
  AS_AA_BYTE_ORDER:=--littleend
  AS_BYTE_ORDER:=-mlittle-endian
else ifeq ($(BYTE_ORDER),Big-endian)
  AS_AA_BYTE_ORDER:=--bigend
  AS_BYTE_ORDER:=-mbig-endian
endif
AS_CA_BYTE_ORDER:=$(AS_BYTE_ORDER)
AS_CG_BYTE_ORDER:=$(AS_BYTE_ORDER)

AS_AA_FILE:=--via=
AS_CA_FILE:=@
AS_CG_FILE:=@
AS_FILE:=@

AS_AA_FLAGS=--depend "$(call ws_patsubst,%.o,%.d,$@)"
AS_CA_FLAGS:=--target=arm-arm-none-eabi -c
AS_CG_FLAGS:=--target=arm-arm-none-eabi -c
AS_FLAGS:=--target=arm-arm-none-eabi -c -MD

# C Compiler

CC_CPU:=$(AS_CPU)

CC_DEFINES:=$(AS_DEFINES)
_I:=-I
_PI:=-include 
_ISYS:=-isystem

CC_BYTE_ORDER:=$(AS_BYTE_ORDER)

ifeq ($(SECURE),Secure)
  CC_SECURE:=-mcmse
else
  CC_SECURE:=
endif

CC_FILE:=$(AS_FILE)

CC_FLAGS:=$(AS_FLAGS)

CC_SYS_INC_PATH:=\
$(TOOLCHAIN_ROOT_WS)/../include

# C++ Compiler

CXX_CPU:=$(CC_CPU)
CXX_DEFINES:=$(CC_DEFINES)
CXX_BYTE_ORDER:=$(CC_BYTE_ORDER)
CXX_SECURE:=$(CC_SECURE)
CXX_FILE:=$(CC_FILE)
CXX_FLAGS:=$(CC_FLAGS)

CXX_SYS_INC_PATH:=\
$(TOOLCHAIN_ROOT_WS)/../include/libcxx\
$(CC_SYS_INC_PATH)

# Linker

LD_CPU:=$(ARMASM_CPU)

ifdef LD_SCRIPT
  LD_SCRIPT:=--scatter="$(LD_SCRIPT)"
endif

LD_FILE:=--via=

LD_FLAGS=\
--list "$(subst \,,$(OUT_DIR)/$(TARGET)).map"

# Archiver

AR_FILE:=--via=

AR_FLAGS=\
--create

# Target output

TARGET_LIB:=$(OUT_DIR)/$(TARGET).lib
TARGET_ELF:=$(OUT_DIR)/$(TARGET).axf

# ELF to HEX conversion
ELF2HEX:=\
--i32combined --output "$(subst \,,$(TARGET_ELF:.axf=.hex))" "$(subst \,,$(TARGET_ELF))"

# ELF to BIN conversion
ELF2BIN:=\
--bin --output "$(subst \,,$(TARGET_ELF:.axf=.bin))" "$(subst \,,$(TARGET_ELF))"
