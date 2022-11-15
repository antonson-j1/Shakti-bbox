/* ZBS INSTRUCTIONS */

// BCLR = Single-Bit Clear (Register)
/* This instruction returns rs1 with a single bit cleared 
at the index specified in rs2. The index is read from the
lower log2(XLEN) bits of rs2 */
function Bit#(XLEN) fn_bclr(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) ind =  rs2 &  ( fromInteger(valueOf(XLEN)) - 1);
    Int#(XLEN) index = unpack(ind);
  return rs1 & ~( 1 << index);
endfunction


// BCLRI = Single-Bit Clear (Immediate) 
/* This instruction returns rs1 with a single bit cleared
at the index specified in shamt. The index is read from
the lower log2(XLEN) bits of shamt */
function Bit#(XLEN) fn_bclri(Bit#(XLEN) rs1, Bit#(32) instr);
    Bit#(XLEN) shamt = 0;
    case(valueof(XLEN)) matches
      64: shamt = zeroExtend(instr[25:20]);
      32: shamt = zeroExtend(instr[24:20]);
    endcase  
    Bit#(XLEN) ind = shamt &  ( fromInteger(valueOf(XLEN)) - 1) ;
    Int#(XLEN) index = unpack(ind);   
  return rs1 & ~( 1 << index);
endfunction


// BEXT = Single-Bit Extract (Register)
/* This instruction returns a single bit extracted from rs1 
at the index specified in rs2. The index is read from the 
lower log2(XLEN) bits of rs2 */
function Bit#(XLEN) fn_bext(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) ind = rs2 &  ( fromInteger(valueOf(XLEN)) - 1) ;
    Int#(XLEN) index = unpack(ind);
  return (rs1 >> index) & 1;
endfunction


// BEXTI = Single-Bit Extract (Immediate)
/* This instruction returns a single bit extracted from rs1 
at the index specified in rs2. The index is read from the 
lower log2(XLEN) bits of shamt */
function Bit#(XLEN) fn_bexti(Bit#(XLEN) rs1, Bit#(32) instr);
    Bit#(XLEN) shamt = 0;
    case(valueof(XLEN)) matches
      64: shamt = zeroExtend(instr[25:20]);
      32: shamt = zeroExtend(instr[24:20]);
    endcase
    Bit#(XLEN) ind = shamt &  ( fromInteger(valueOf(XLEN)) - 1) ;
    Int#(XLEN) index = unpack(ind);  
  return (rs1 >> index) & 1;
endfunction


// BINV = Single-Bit Invert (Register)
/* This instruction returns rs1 with a single bit inverted 
at the index specified in rs2. The index is read from the
lower log2(XLEN) bits of rs2 */
function Bit#(XLEN) fn_binv(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) ind = 0;
    ind = rs2 &  ( fromInteger(valueOf(XLEN)) - 1);
    Int#(XLEN) index = unpack(ind);
  return rs1 ^ (1 << index);
endfunction


// BINVI = Single-Bit Invert (Immediate)
/* This instruction returns rs1 with a single bit inverted 
at the index specified in shamt. The index is read from
the lower log2(XLEN) bits of shamt */
function Bit#(XLEN) fn_binvi(Bit#(XLEN) rs1, Bit#(32) instr);
    Bit#(XLEN) shamt = 0;
    case(valueof(XLEN)) matches
      64: shamt = zeroExtend(instr[25:20]);
      32: shamt = zeroExtend(instr[24:20]);
    endcase
    Bit#(XLEN) ind = shamt &  ( fromInteger(valueOf(XLEN)) - 1) ;
    Int#(XLEN) index = unpack(ind);
  return rs1 ^ (1 << index);
endfunction


// BSET = Single-Bit Set (Register)
/* This instruction returns rs1 with a single bit set at the
 index specified in rs2. The index is read from the
lower log2(XLEN) bits of rs2 */
function Bit#(XLEN) fn_bset(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) ind = rs2 &  ( fromInteger(valueOf(XLEN)) - 1) ;
    Int#(XLEN) index = unpack(ind);
  return rs1 | (1 << index);
endfunction


// BSETI = Single-Bit Set (Immediate)
/* This instruction returns rs1 with a single bit set at the 
index specified in shamt. The index is read from the
lower log2(XLEN) bits of shamt */
function Bit#(XLEN) fn_bseti(Bit#(XLEN) rs1, Bit#(32) instr);
    Bit#(XLEN) shamt = 0;
    case(valueof(XLEN)) matches
      64: shamt = zeroExtend(instr[25:20]);
      32: shamt = zeroExtend(instr[24:20]);
    endcase
    Bit#(XLEN) ind = shamt &  ( fromInteger(valueOf(XLEN)) - 1) ;
    Int#(XLEN) index = unpack(ind);
  return rs1 | (1 << index);
endfunction
