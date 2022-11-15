/* ZBB INSTRUCTIONS */

// ANDN = AND with inverted operand
/* This instruction performs the bitwise logical AND operation 
between rs1 and the bitwise inversion of rs2 */
function Bit#(XLEN) fn_andn(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs1 & ~rs2;
endfunction

/////////////////////////////////////////////////////////////

// ORN = OR with inverted operand
/* This instruction performs the bitwise logical AND operation
 between rs1 and the bitwise inversion of rs2 */
function Bit#(XLEN) fn_orn(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs1 | ~rs2;
endfunction


// XNOR = Exclusive NOR
/* This instruction performs the bit-wise exclusive-NOR operation 
on rs1 and rs2 */
function Bit#(XLEN) fn_xnor(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return ~(rs1^rs2);
endfunction


// CLZ = Count leading zero bits
/* This instruction counts the number of 0’s before the first 1, starting
 at the most-significant bit (i.e., XLEN-1) and progressing to bit 0. 
 Accordingly, if the input is 0, the output is XLEN, and if the most-significant bit of
the input is a 1, the output is 0 */
function Bit#(XLEN) fn_clz(Bit#(XLEN) rs);
  Bit#(XLEN) result=0;
  if(valueof(XLEN)==32) result= zeroExtend(pack(countZerosMSB(rs[31:0])));
  else result= zeroExtend(pack(countZerosMSB(rs)));
  
  case(valueof(XLEN)) matches
    64: return result;
    32: return signExtend(result[31:0]);
  endcase
endfunction


// CLZW = Count leading zero bits in word
/* This instruction counts the number of 0’s before the 
first 1 starting at bit 31 and progressing to bit 0.
Accordingly, if the least-significant word is 0, the output is 32,
 and if the most-significant bit of the word (i.e., bit 31) is a 1,
  the output is 0 */
function Bit#(XLEN) fn_clzw(Bit#(XLEN) rs);
  Bit#(32) result=0;
  result= zeroExtend(pack(countZerosMSB(rs[31:0])));
  return signExtend(result[31:0]);
endfunction


// CTZ = Count trailing zeros
/* This instruction counts the number of 0’s before the first 1,
starting at the least-significant bit (i.e., 0) and progressing to
 the most-significant bit (i.e., XLEN-1). 
 Accordingly, if the input is 0, the output is XLEN, and
if the least-significant bit of the input is a 1, the output is 0 */
function Bit#(XLEN) fn_ctz(Bit#(XLEN) rs);
  Bit#(XLEN) result=0;
  if(valueof(XLEN)==32) result= zeroExtend(pack(countZerosLSB(rs[31:0])));
  else result= zeroExtend(pack(countZerosLSB(rs)));

  case(valueof(XLEN)) matches
    64: return result;
    32: return signExtend(result[31:0]);
  endcase
endfunction


// CTZW = Count trailing zero bits in word
/* This instruction counts the number of 0’s before the first 1,
 starting at the least-significant bit (i.e., 0) and
progressing to the most-significant bit of the least-significant word (i.e., 31).
 Accordingly, if the leastsignificant word is 0, the output is 32, 
 and if the least-significant bit of the input is a 1, the output is 0. */
function Bit#(XLEN) fn_ctzw(Bit#(XLEN) rs);
  Bit#(32) result=0;
  result= zeroExtend(pack(countZerosLSB(rs[31:0])));
  return signExtend(result[31:0]);
endfunction


// CPOP = Count set bits
/* This instructions counts the number of 1’s (i.e., set bits) in the source register */
function Bit#(XLEN) fn_cpop(Bit#(XLEN) rs) ;
  Bit#(XLEN) result=0;
  if(valueof(XLEN)==32) result= zeroExtend(pack(countOnes(rs[31:0])));
  else result= zeroExtend(pack(countOnes(rs)));

  case(valueof(XLEN)) matches
    64: return result;
    32: return signExtend(result[31:0]);
  endcase
endfunction


// CPOPW = Count set bits in word
/* This instructions counts the number of 1’s (i.e., set bits) in the
 least-significant word of the source register */
function Bit#(XLEN) fn_cpopw(Bit#(XLEN) rs);
  Bit#(32) result=0;
  result= zeroExtend(pack(countOnes(rs[31:0])));
  return signExtend(result[31:0]);
endfunction


// MAX = Maximum
/* This instruction returns the larger of two signed integers */
function Bit#(XLEN) fn_max(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Int#(XLEN) src1 = unpack(rs1);
  Int#(XLEN) src2 = unpack(rs2);
  return (src1 > src2) ? rs1 : rs2 ;
endfunction


// MAXU = Unsigned maximum
/* This instruction returns the larger of two unsigned integers.*/
function Bit#(XLEN) fn_maxu(Bit#(XLEN) rs1, Bit#(XLEN) rs2);  
  UInt#(XLEN) src1 = unpack(rs1);
  UInt#(XLEN) src2 = unpack(rs2);
  return (src1 > src2) ? rs1 : rs2 ;
endfunction


// MIN = Minimum
/* This instruction returns the smaller of two signed integers */
function Bit#(XLEN) fn_min(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Int#(XLEN) src1 = unpack(rs1);
  Int#(XLEN) src2 = unpack(rs2);
  return (src1 < src2) ? rs1 : rs2 ;
endfunction


// MINU = Unsigned minimum
/* This instruction returns the smaller of two unsigned integers */
function Bit#(XLEN) fn_minu(Bit#(XLEN) rs1, Bit#(XLEN) rs2);  
  UInt#(XLEN) src1 = unpack(rs1);
  UInt#(XLEN) src2 = unpack(rs2);
  return (src1 < src2) ? rs1 : rs2 ;
endfunction


// SEXT.B = Sign-extend byte
/* This instruction sign-extends the least-significant byte in the source to XLEN by copying the most-significant
bit in the byte (i.e., bit 7) to all of the more-significant bits */
function Bit#(XLEN) fn_sext_b(Bit#(XLEN) rs1);
  return signExtend(rs1[7:0]);
endfunction


// SEXT.H = Sign-extend halfword
/* This instruction sign-extends the least-significant halfword in rs to XLEN by copying the most-significant bit
in the halfword (i.e., bit 15) to all of the more-significant bits.*/
function Bit#(XLEN) fn_sext_h(Bit#(XLEN) rs1);
  return signExtend(rs1[15:0]);
endfunction


// ZEXT.H = Zero-extend halfword
/* This instruction zero-extends the least-significant halfword 
of the source to XLEN by inserting 0’s into all of the bits more significant than 15. */
function Bit#(XLEN) fn_zext_h(Bit#(XLEN) rs1);
  return zeroExtend(rs1[15:0]);
endfunction


// ROL = Rotate Left (Register)
/* This instruction performs a rotate left of rs1 by the amount in least-significant log2(XLEN) bits of rs2.*/
function Bit#(XLEN) fn_rol(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  UInt#(XLEN) x = 0;
  case(valueof(XLEN)) matches
    64: x = unpack(zeroExtend(rs2[5:0]));
    32: x = unpack(zeroExtend(rs2[4:0]));
  endcase
  return zeroExtend(rs1 << x) | zeroExtend( rs1 >> (fromInteger(valueOf(XLEN)) - x ) ) ;
endfunction


// ROLW = Rotate Left Word (Register)
/* This instruction performs a rotate left on the least-significant word of rs1 by the amount in least-significant 5
bits of rs2. The resulting word value is sign-extended by copying bit 31 to all of the more-significant bits.*/
function Bit#(XLEN) fn_rolw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) x = zeroExtend(rs2[4:0]);
  Int#(XLEN) shamt = unpack(x);
  Bit#(XLEN) src1 = zeroExtend(rs1[31:0]);
  return signExtend((src1 << shamt) | (src1 >> (32 - shamt)));
endfunction


// ROR = Rotate Right
/* This instruction performs a rotate right of rs1 by the amount in least-significant log2(XLEN) bits of rs2 */
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


// REV8 = Byte-reverse register
/* This instruction reverses the order of the bytes in rs */
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

