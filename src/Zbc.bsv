function Bit#(XLEN) fn_clmul(Bit#(XLEN) rs1,Bit#(XLEN) rs2); 
  Bit#(XLEN) x = 0;
  for(Integer i=0; i < valueof(XLEN); i=i+1)
  begin
    if(((rs2 >> i) & 1) == 1) x = x ^ (rs1 << i);
  end
  return signExtend(pack(x));
endfunction

function Bit#(XLEN) fn_clmulr(Bit#(XLEN) rs1,Bit#(XLEN) rs2); 
  Bit#(XLEN) x = 0;
  for(Integer i=0; i< valueof(XLEN); i=i+1)
  begin
    if(((rs2 >> i) & 1) == 1 ) x = x ^ (rs1 >> valueof(XLEN)-i-1);	
  end
  return signExtend(pack(x));
endfunction
