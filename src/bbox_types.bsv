//See LICENSE.iitm for license details
/*

Author : Mouna Krishna
Email id : mounakrishna@mindgrovetech.in
Details: The file contains the structures, macors etc.
         Any new structures, enum, union tagged are expected to be written 
         and used everywhere

--------------------------------------------------------------------------------------------------
*/

package bbox_types;

`ifdef RV32
   typedef 32 XLEN;
`else
   typedef 64 XLEN;
`endif

typedef struct {
  Bit#(32) instr;   // 32-bit Instruction
  Bit#(XLEN) rs1;   // Data of register addressed by rs1
  Bit#(XLEN) rs2;   // Data of register addressed by rs2
} BBoxInput deriving (Bits, Eq, FShow);

typedef struct {
  Bool valid;       // A bool indicating that the data is valid.
  Bit#(XLEN) data;  // The computed data
} BBoxOutput deriving (Bits, Eq, FShow);

endpackage: bbox_types
