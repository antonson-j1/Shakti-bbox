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

// `ifdef RV64

function Bit#(XLEN) fn_ctzw(Bit#(XLEN) rs);
  Bit#(32) result=0;
  result= zeroExtend(pack(countZerosLSB(rs[31:0])));
  return signExtend(result[31:0]);
endfunction

// `endif

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
  Int#(XLEN) shamt = unpack(x);
  Bit#(XLEN) src1 = zeroExtend(rs1[31:0]);
  return signExtend((src1 << shamt) | (src1 >> (32 - shamt)));
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


//RORI
function Bit#(XLEN) fn_rori(Bit#(XLEN) rs1, Bit#(32) instr);
  UInt#(XLEN) shamt = 0;
  case(valueof(XLEN)) matches
      64: shamt = unpack(zeroExtend(instr[25:20]));
      32: shamt = unpack(zeroExtend(instr[24:20]));
  endcase
  return zeroExtend(rs1 >> shamt) | zeroExtend( rs1 << (fromInteger(valueOf(XLEN)) - shamt ) ) ;
endfunction


//RORIW
function Bit#(XLEN) fn_roriw(Bit#(XLEN) rs1, Bit#(32) instr);
  UInt#(XLEN) shamt = unpack(zeroExtend(instr[24:20]));
  Bit#(XLEN) rs1_data = zeroExtend(rs1[31:0]);
  Bit#(XLEN) result = (rs1_data >> shamt) | ( rs1_data << (fromInteger(valueOf(XLEN)) - shamt ) ) ;
  return signExtend(result[31:0]);
endfunction


//RORW
function Bit#(XLEN) fn_rorw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) num1 = zeroExtend(rs1[31:0]);
  Bit#(XLEN) x = zeroExtend(rs2[4:0]);
  Int#(XLEN) shamt = unpack(x);
  return signExtend((num1 >> shamt) | (num1 << (32 - shamt)));
endfunction


//ORC.B
function Bit#(XLEN) fn_orc_b(Bit#(XLEN) rs1); 
  Bit#(XLEN) inp = rs1;
  Bit#(XLEN) out = 0;
  Bit#(8) zeroes = 8'b00000000;
  Bit#(8) ones = 8'b11111111;
  for(Integer i=0; i <= (valueof(XLEN)-8); i=i+8)
  begin
    if(inp[i+7:i] == zeroes) out[i+7:i] = zeroes;
    else out[i+7:i] = ones;
  end
  return out;
endfunction


//REV8
function Bit#(XLEN) fn_rev8(Bit#(XLEN) rs1);
  Bit#(XLEN) inp = rs1;
  Bit#(XLEN) out = 0;
  Integer j = valueof(XLEN) - 1;
  Bit#(8) temp = 0;
  for(Integer i=0; i <= (valueof(XLEN)-8); i=i+8)
  begin
    temp = inp[j:j-7];
    out[i+7:i] = temp;
    j = j-8;
  end
  return out;
endfunction

