GDB Remote Connection Plugin
----------------------------

GDB Remote Connection Plugin allows the model to be debugged using GDB.  It can be found in the TPIP package.


Features
--------

This supports the following operations:
- Connection to models containing a single core cluster.
- Read and write of core registers
- Read and write of memory
- Run, stop, single step
- Breakpoints
- Connection to AArch32 and AArch64 models.


Operation
---------

This can be loaded into a model using the --plugin option and the command line option
-D or --allow-debug-plugin. For example...

    FVP_VE_Cortex-A15x1 --allow-debug-plugin --plugin GDBRemoteConnection.so

This adds two parameters to the model when loaded:

REMOTE_CONNECTION.GDBRemoteConnection.listen_address="0.0.0.0"  # (string, init-time) default = '0.0.0.0' : Network address the server should listen on ("0.0.0.0" by default)
REMOTE_CONNECTION.GDBRemoteConnection.port=0x7B8B     # (int   , init-time) default = '0x7B8B' : TCP port the server should listen on (31627 by default) : [0x1..0xFFFF]

A suitable GDB can be connected using the target command within GDB.


GDB examples
------------

The following shows some examples of GDB commands and response.  The lines starting (gdb) are the commands followed by the response


Connecting to target
(gdb) target remote 127.0.0.1:31627
Remote debugging using 127.0.0.1:31627
0x0000000080001098 in ?? ()

Display registers
(gdb) info registers
x0             0x0	0
x1             0x0	0
x2             0x0	0
x3             0x0	0
x4             0x0	0
x5             0x0	0
x6             0x0	0
x7             0x0	0
x8             0x0	0
x9             0x0	0
x10            0x0	0
x11            0x0	0
x12            0x0	0
x13            0x0	0
x14            0x0	0
x15            0x0	0
x16            0x0	0
x17            0x0	0
x18            0x0	0
x19            0x0	0
x20            0x0	0
x21            0x0	0
x22            0x0	0
x23            0x0	0
x24            0x0	0
x25            0x0	0
x26            0x0	0
x27            0x0	0
x28            0x0	0
x29            0x0	0
x30            0x0	0
sp             0x0	0x0
pc             0x80001098	0x80001098
cpsr           0x3cd	973
fpsr           0x0	0
fpcr           0x0	0

Display memory at location 0x0000000080001098
(gdb) x/10 0x0000000080001098 
0x80001098:	0xd51e115f	0xd53800a0	0x92401c00	0xf100001f
0x800010a8:	0x54ff7ac0	0xd503205f	0x17ffffff	0xd10083ff
0x800010b8:	0xf9000bfe	0xa90077f3


Disassemble from current PC to PC+30
(gdb) disassemble $pc,$pc+30
Dump of assembler code from 0x80001098 to 0x800010b6:
=> 0x0000000080001098:	msr	cptr_el3, xzr
   0x000000008000109c:	mrs	x0, mpidr_el1
   0x00000000800010a0:	and	x0, x0, #0xff
   0x00000000800010a4:	cmp	x0, #0x0
   0x00000000800010a8:	b.eq	0x80000000
   0x00000000800010ac:	wfe
   0x00000000800010b0:	b	0x800010ac
   0x00000000800010b4:	sub	sp, sp, #0x20
End of assembler dump.

Set a breakpoint at location *0x00000000800010a0 in the current memory space
(gdb) break  *0x00000000800010a0
Breakpoint 1 at 0x800010a0

Show breakpoints
(gdb) info break
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x00000000800010a0 

disable breakpoints
(gdb) disable 1



Limitations
-----------

- Connection only allowed to a single core simulation. No multicore or multicluster
- No tracepoints supported
- No parameters support
- Memory view will only show current memoryspace
- Disassembly will only disassemble using the current instruction set
- Breakpoints can only be set on the current memoryspace





