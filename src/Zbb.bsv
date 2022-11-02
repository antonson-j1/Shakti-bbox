function Bit#(XLEN) fn_andn(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) res = truncate(rs1 & ~rs2);
  return res;
endfunction

/////////////////////////////////////////////////////////////

function Bit#(XLEN) fn_orn(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs1 | ~rs2;
endfunction

function Bit#(XLEN) fn_xnor(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return ~(rs1^rs2);
endfunction


function Bit#(XLEN) fn_clz(Bit#(XLEN) src1);

  Bit#(XLEN) result =0;

  if(valueof(XLEN)==32) 
    result= zeroExtend(pack(countZerosMSB(src1[31:0])));
  else  
    result= zeroExtend(pack(countZerosMSB(src1)));
  
  case(valueof(XLEN)) matches
    64: return result;
    32: return signExtend(result[31:0]);
  endcase
endfunction


function Bit#(XLEN) fn_clzw(Bit#(XLEN) src1);

  Bit#(32) result =0;
  result= zeroExtend(pack(countZerosMSB(src1[31:0])));
  return signExtend(result[31:0]);

endfunction