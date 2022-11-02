function Bit#(XLEN) fn_andn(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs1 & ~rs2;
endfunction

/////////////////////////////////////////////////////////////

function Bit#(XLEN) fn_orn(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs1 | ~rs2;
endfunction


function Bit#(XLEN) fn_xnor(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return ~(rs1^rs2);
endfunction


function Bit#(XLEN) fn_clz(Bit#(XLEN) rs);
  Bit#(XLEN) result=0;
  if(valueof(XLEN)==32) result= zeroExtend(pack(countZerosMSB(rs[31:0])));
  else result= zeroExtend(pack(countZerosMSB(rs)));
  
  case(valueof(XLEN)) matches
    64: return result;
    32: return signExtend(result[31:0]);
  endcase
endfunction


function Bit#(XLEN) fn_clzw(Bit#(XLEN) rs);
  Bit#(32) result=0;
  result= zeroExtend(pack(countZerosMSB(rs[31:0])));
  return signExtend(result[31:0]);
endfunction


function Bit#(XLEN) fn_ctz(Bit#(XLEN) rs);
  Bit#(XLEN) result=0;
  if(valueof(XLEN)==32) result= zeroExtend(pack(countZerosLSB(rs[31:0])));
  else result= zeroExtend(pack(countZerosLSB(rs)));

  case(valueof(XLEN)) matches
    64: return result;
    32: return signExtend(result[31:0]);
  endcase
endfunction


function Bit#(XLEN) fn_ctzw(Bit#(XLEN) rs);
  Bit#(32) result=0;
  result= zeroExtend(pack(countZerosLSB(rs[31:0])));
  return signExtend(result[31:0]);
endfunction