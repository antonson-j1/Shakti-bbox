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


function Bit#(XLEN) fn_clz(Bit#(XLEN) src1);
  Bit#(XLEN) result =0;

  Bit#(1)  op3 = 0;
  if(valueof(XLEN)==32)
    op3=1;

  if(op3==1) result= zeroExtend(pack(countZerosMSB(src1[31:0])));
  else  result= zeroExtend(pack(countZerosMSB(src1)));
  case(op3) matches
    0: return result;
    1:return signExtend(result[31:0]);
  endcase
endfunction


// function Bit#(XLEN) fn_clz1(Bit#(XLEN) rs1);
//   Bit#(XLEN) temp = highestSetBit(rs1);
//   return valueOf(XLEN)-1-temp;
// endfunction


// //////////////

// function Bit#(XLEN) highestSetBit(Bit#(XLEN) rs1);
//   Bit#(XLEN) x = -1;
//   for(Bit#(XLEN) i = 0; i<valueOf(XLEN); i=i+1)
//     if( (rs1>>i)&(1) == 1)
//       x = i;
//   return x;
// endfunction


/////////////////////////////////////////////////////////////