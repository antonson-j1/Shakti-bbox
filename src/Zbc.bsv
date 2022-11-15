/* ZBC INSTRUCTIONS */

// CLMUL = Carry-less multiply (low-part)
/* clmul produces the lower half of the 2·XLEN carry-less product */
function Bit#(XLEN) fn_clmul(Bit#(XLEN) rs1,Bit#(XLEN) rs2); 
  Bit#(XLEN) x = 0;
  for(Integer i=0; i < valueof(XLEN); i=i+1)
  begin
    if(((rs2 >> i) & 1) == 1) x = x ^ (rs1 << i);
  end
  return signExtend(pack(x));
endfunction


// CLMULH = Carry-less multiply (high-part)
/* clmulh produces the upper half of the 2·XLEN carry-less product */
function Bit#(XLEN) fn_clmulh(Bit#(XLEN) rs1,Bit#(XLEN) rs2); 
  Bit#(XLEN) x = 0;
  for(Integer i=0; i< valueof(XLEN); i=i+1)
  begin
    if(((rs2 >> i) & 1) == 1 ) x = x ^ (rs1 >> valueof(XLEN)-i);	
  end
  return signExtend(pack(x));
endfunction


// CLMULR = Carry-less multiply (reversed)
/* clmulr produces bits 2·XLEN−2:XLEN-1 of the 2·XLEN carry-less product */
function Bit#(XLEN) fn_clmulr(Bit#(XLEN) rs1,Bit#(XLEN) rs2); 
  Bit#(XLEN) x = 0;
  for(Integer i=0; i< valueof(XLEN); i=i+1)
  begin
    if(((rs2 >> i) & 1) == 1 ) x = x ^ (rs1 >> valueof(XLEN)-i-1);	
  end
  return signExtend(pack(x));
endfunction

