// AND.UW
function Bit#(XLEN) fn_and_uw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Int#(XLEN) base = unpack(rs2);
  Int#(XLEN) index = unpack(zeroExtend(rs1[31:0]));

  Int#(XLEN) result = base + index;
  return pack(result);
endfunction

// SH1ADD
function Bit#(XLEN) fn_sh1add(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Int#(XLEN) num1 = unpack(rs1 << 1);
  Int#(XLEN) num2 = unpack(rs2);

  Int#(XLEN) result = num1 + num2;
  return pack(result);
endfunction

// SH1ADD.UW
function Bit#(XLEN) fn_sh1add_uw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) index = zeroExtend(rs1[31:0]);
  Int#(XLEN) num = unpack(index << 1);
  Int#(XLEN) base = unpack(rs2);
  
  Int#(XLEN) result = num + base;
  return pack(result);
  
endfunction

// SH2ADD
function Bit#(XLEN) fn_sh2add(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Int#(XLEN) num1 = unpack(rs1 << 2);
  Int#(XLEN) num2 = unpack(rs2);

  Int#(XLEN) result = num1 + num2;
  return pack(result);
endfunction

// SH2ADD.UW
function Bit#(XLEN) fn_sh2add_uw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) index = zeroExtend(rs1[31:0]);
  Int#(XLEN) num = unpack(index << 2);
  Int#(XLEN) base = unpack(rs2);
  
  Int#(XLEN) result = num + base;
  return pack(result);
  
endfunction

// SH3ADD
function Bit#(XLEN) fn_sh3add(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Int#(XLEN) num1 = unpack(rs1 << 3);
  Int#(XLEN) num2 = unpack(rs2);

  Int#(XLEN) result = num1 + num2;
  return pack(result);
endfunction

// SH2ADD.UW
function Bit#(XLEN) fn_sh3add_uw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) index = zeroExtend(rs1[31:0]);
  Int#(XLEN) num = unpack(index << 3);
  Int#(XLEN) base = unpack(rs2);
  
  Int#(XLEN) result = num + base;
  return pack(result);
  
endfunction
