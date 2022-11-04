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

`ifdef RV64

function Bit#(XLEN) fn_ctzw(Bit#(XLEN) rs);
  Bit#(32) result=0;
  result= zeroExtend(pack(countZerosLSB(rs[31:0])));
  return signExtend(result[31:0]);
endfunction

`endif

function Bit#(XLEN) fn_cpop(Bit#(XLEN) rs) ;
  Bit#(XLEN) result=0;
  if(valueof(XLEN)==32) result= zeroExtend(pack(countOnes(rs[31:0])));
  else result= zeroExtend(pack(countOnes(rs)));

  case(valueof(XLEN)) matches
    64: return result;
    32: return signExtend(result[31:0]);
  endcase
endfunction

function Bit#(XLEN) fn_cpopw(Bit#(XLEN) rs);
  Bit#(32) result=0;
  result= zeroExtend(pack(countOnes(rs[31:0])));
  return signExtend(result[31:0]);
endfunction

// MAX
function Bit#(XLEN) fn_max(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Int#(XLEN) src1 = unpack(rs1);
  Int#(XLEN) src2 = unpack(rs2);
  return (src1 > src2) ? rs1 : rs2 ;
endfunction

// MAX UNSIGNED
function Bit#(XLEN) fn_maxu(Bit#(XLEN) rs1, Bit#(XLEN) rs2);  
  UInt#(XLEN) src1 = unpack(rs1);
  UInt#(XLEN) src2 = unpack(rs2);
  return (src1 > src2) ? rs1 : rs2 ;
endfunction

// MIN
function Bit#(XLEN) fn_min(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Int#(XLEN) src1 = unpack(rs1);
  Int#(XLEN) src2 = unpack(rs2);
  return (src1 < src2) ? rs1 : rs2 ;
endfunction

// MIN UNSIGNED
function Bit#(XLEN) fn_minu(Bit#(XLEN) rs1, Bit#(XLEN) rs2);  
  UInt#(XLEN) src1 = unpack(rs1);
  UInt#(XLEN) src2 = unpack(rs2);
  return (src1 < src2) ? rs1 : rs2 ;
endfunction

// SEXT.B
function Bit#(XLEN) fn_sext_b(Bit#(XLEN) rs1);
  return signExtend(rs1[7:0]);
endfunction

//SEXT.H
function Bit#(XLEN) fn_sext_h(Bit#(XLEN) rs1);
  return signExtend(rs1[15:0]);
endfunction

//ZEXT.H
function Bit#(XLEN) fn_zext_h(Bit#(XLEN) rs1);
  return zeroExtend(rs1[15:0]);
endfunction

//ROL
function Bit#(XLEN) fn_rol(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  UInt#(XLEN) x = 0;
  case(valueof(XLEN)) matches
    64: x = unpack(zeroExtend(rs2[5:0]));
    32: x = unpack(zeroExtend(rs2[4:0]));
  endcase
  return zeroExtend(rs1 << x) | zeroExtend( rs1 >> (fromInteger(valueOf(XLEN)) - x ) ) ;
endfunction

//ROLW
function Bit#(XLEN) fn_rolw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) x = zeroExtend(rs2[4:0]);
  Bit#(XLEN) src1 = zeroExtend(rs1[31:0]);
  return signExtend((src1 << x) | (src1 >> (32 - x)));
endfunction

//ROR
function Bit#(XLEN) fn_ror(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  UInt#(XLEN) x = 0;
  case(valueof(XLEN)) matches
    64: x = unpack(zeroExtend(rs2[5:0]));
    32: x = unpack(zeroExtend(rs2[4:0]));
  endcase
  return zeroExtend(rs1 >> x) | zeroExtend( rs1 << (fromInteger(valueOf(XLEN)) - x ) ) ;
endfunction
