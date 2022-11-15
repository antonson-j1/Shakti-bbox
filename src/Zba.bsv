/* ZBA INSTRUCTIONS */


// AND.UW = Add unsigned word
/* This instruction performs an XLEN-wide addition between rs2 
and the zero-extended least-significant word of rs1. */
function Bit#(XLEN) fn_and_uw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) result = rs2 + zeroExtend(rs1[31:0]);
  return result;
endfunction

// SH1ADD = Shift left by 1 and add
/* This instruction shifts rs1 to the left by 1 bit and adds 
it to rs2. */
function Bit#(XLEN) fn_sh1add(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) result = (rs1 << 1) + rs2;
  return result;
endfunction

// SH1ADD.UW = Shift unsigned word left by 1 and add
/* This instruction performs an XLEN-wide addition of two 
addends. The first addend is rs2. The second addend is the 
unsigned value formed by extracting the least-significant 
word of rs1 and shifting it left by 1 place.*/
function Bit#(XLEN) fn_sh1add_uw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) index = zeroExtend(rs1[31:0]);
  Bit#(XLEN) result = (index << 1) + rs2;
  return result;
endfunction

// SH2ADD = Shift left by 2 and add
/* This instruction shifts rs1 to the left by 2 places 
and adds it to rs2. */
function Bit#(XLEN) fn_sh2add(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) result = (rs1 << 2) + rs2;
  return result;
endfunction

// SH2ADD.UW = Shift unsigned word left by 2 and add
/* This instruction performs an XLEN-wide addition of 
two addends. The first addend is rs2. The second
addend is the unsigned value formed by extracting the 
least-significant word of rs1 and shifting it left by 2
places. */
function Bit#(XLEN) fn_sh2add_uw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) index = zeroExtend(rs1[31:0]);
  Bit#(XLEN) result = (index << 2) + rs2;
  return result;
endfunction

// SH3ADD = Shift left by 3 and add
/* This instruction shifts rs1 to the left by 3 
places and adds it to rs2. */
function Bit#(XLEN) fn_sh3add(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) result = (rs1 << 3) + rs2;
  return result;
endfunction

// SH3ADD.UW = Shift unsigned word left by 3 and add
/* This instruction performs an XLEN-wide addition 
of two addends. The first addend is rs2. The second
addend is the unsigned value formed by extracting the 
least-significant word of rs1 and shifting it left 
by 3 places. */
function Bit#(XLEN) fn_sh3add_uw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) index = zeroExtend(rs1[31:0]);
  Bit#(XLEN) result = (index << 3) + rs2;
  return result;
endfunction


// SLLI.UW = Shift-left unsigned word (Immediate)
/* This instruction takes the least-significant word 
of rs1, zero-extends it, and shifts it left by the immediate. */
function Bit#(XLEN) fn_slli_uw(Bit#(XLEN) rs1, Bit#(32) instr);
  Bit#(XLEN) ind = zeroExtend(instr[25:20]);
  Bit#(XLEN) num = zeroExtend(rs1[31:0]);
  Int#(XLEN) shamt = unpack(ind);
  return (num << shamt) ;
endfunction