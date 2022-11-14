function Bit#(XLEN) fn_bclr(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) ind = 0;
    ind = rs2 &  ( fromInteger(valueOf(XLEN)) - 1) ;

    Int#(XLEN) index = unpack(ind);
    
  return rs1 & ~( 1 << index);

endfunction

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


function Bit#(XLEN) fn_bext(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) ind = 0;
    ind = rs2 &  ( fromInteger(valueOf(XLEN)) - 1) ;

    Int#(XLEN) index = unpack(ind);
    
  return (rs1 >> index) & 1;

endfunction

function Bit#(XLEN) fn_binv(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) ind = 0;
    ind = rs2 &  ( fromInteger(valueOf(XLEN)) - 1) ;

    Int#(XLEN) index = unpack(ind);
    
  return rs1 ^ (1 << index);

endfunction

function Bit#(XLEN) fn_bset(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) ind = 0;
    ind = rs2 &  ( fromInteger(valueOf(XLEN)) - 1) ;

    Int#(XLEN) index = unpack(ind);
    
  return rs1 | (1 << index);

endfunction
