//See LICENSE.iitm for license details

/*
This compute.bsv module is used as top level module for 
calling the functions from Zba.bsv, Zbb.bsv, Zbc.bsv or 
Zbs.bsv based on the instructions being used/tested.
*/

/****** Imports *******/
`include "bbox.defines"
import bbox_types :: *;
`include "Zbc.bsv"
`include "Zbb.bsv"

`include "Zba.bsv"
`include "Zbs.bsv"
/*********************/


/*doc: function: The top function where depending on the instruction the 
  required function is called, get the result and return it.
  The input argument and return type should not be changed. 
  Other than this, all the other code can be changed as per needs.

  As an example the instruction ANDN of the Zbb group has been implemented.
  NOTE: The value of ANDN in bbox.defines is a temp value, it needed to be 
  changed according to spec.
  The complete Zbb group and all the other groups is expected to be implemented 
  and verified.
*/

function BBoxOutput fn_compute(BBoxInput inp);

  Bit#(XLEN) result;

  Bool valid;
  case(inp.instr) matches

/*****************************************************************/
    // ZBB INSTRUCTIONS

    `ANDN: begin      // AND with inverted operand
      result = truncate(fn_andn(inp.rs1, inp.rs2));
      valid = True;
    end

    `ORN: begin       // OR with inverted operand
      result = fn_orn(inp.rs1, inp.rs2);
      valid = True;
    end

    `XNOR: begin      // Exclusive NOR
      result = fn_xnor(inp.rs1, inp.rs2);
      valid = True;
    end

    `CLZ: begin       // Count leading zero bits
      result = fn_clz(inp.rs1);
      valid = True;
    end

    `CLZW: begin      // Count leading zero bits in word
      result = fn_clzw(inp.rs1);
      valid = True;
    end

    `CTZ: begin       // Count trailing zeros
      result = fn_ctz(inp.rs1);
      valid = True;
    end

    `CTZW: begin      // Count trailing zero bits in word
      result = fn_ctzw(inp.rs1);
      valid = True;
    end

    `CPOP: begin      // Count set bits
      result = fn_cpop(inp.rs1);
      valid = True;
    end

    `CPOPW: begin     // Count set bits in word
      result = fn_cpopw(inp.rs1);
      valid = True;
    end

    `MAX: begin       // Maximum
      result = fn_max(inp.rs1, inp.rs2);
      valid = True;
    end

    `MAXU: begin      // Unsigned maximum
      result = fn_maxu(inp.rs1, inp.rs2);
      valid = True;
    end

    `MIN: begin       // Minimum
      result = fn_min(inp.rs1, inp.rs2);
      valid = True;
    end

    `MINU: begin      // Unsigned minimum
      result = fn_minu(inp.rs1, inp.rs2);
      valid = True;
    end

    `SEXT_B: begin    // Sign-extend byte
      result = fn_sext_b(inp.rs1);
      valid = True;
    end

    `SEXT_H: begin    // Sign-extend halfword
      result = fn_sext_h(inp.rs1);
      valid = True;
    end

    `ZEXT_H: begin    // Zero-extend halfword
      result = fn_zext_h(inp.rs1);
      valid = True;
    end

    `ROL: begin       // Rotate Left (Register)
      result = fn_rol(inp.rs1, inp.rs2);
      valid = True;
    end

    `ROLW: begin      // Rotate Left Word (Register)
      result = fn_rolw(inp.rs1, inp.rs2);
      valid = True;
    end

    `ROR: begin       // Rotate Right
      result = fn_ror(inp.rs1, inp.rs2);
      valid = True;
    end

    `RORI: begin      // Rotate Right (Immediate)
      result = fn_rori(inp.rs1, inp.instr);
      valid = True;
    end

    `RORIW: begin     // Rotate Right Word by Immediate
      result = fn_roriw(inp.rs1, inp.instr);
      valid = True;
    end

    `RORW: begin      // Rotate Right Word (Register)
      result = fn_rorw(inp.rs1, inp.rs2);
      valid = True;
    end

    `ORC_B: begin     // Bitwise OR-Combine, byte granule
      result = fn_orc_b(inp.rs1);
      valid = True;
    end

    `REV8: begin      // Byte-reverse register
      result = fn_rev8(inp.rs1);
      valid = True;
    end



/*****************************************************************/
    // ZBC INSTRUCTIONS

    `CLMUL: begin     // Carry-less multiply (low-part)
      result = fn_clmul(inp.rs1, inp.rs2);
      valid = True;
    end

    `CLMULH: begin    // Carry-less multiply (high-part)
      result = fn_clmulh(inp.rs1, inp.rs2);
      valid = True;
    end

    `CLMULR: begin    // Carry-less multiply (reversed)
      result = fn_clmulr(inp.rs1, inp.rs2);
      valid = True;
    end


/*****************************************************************/
    // ZBA INSTRUCTIONS

    `ADD_UW: begin    // Add unsigned word
      result = fn_and_uw(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH1ADD: begin    // Shift left by 1 and add
      result = fn_sh1add(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH1ADD_UW: begin // Shift unsigned word left by 1 and add
      result = fn_sh1add_uw(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH2ADD: begin    // Shift left by 2 and add
      result = fn_sh2add(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH2ADD_UW: begin // Shift unsigned word left by 2 and add
      result = fn_sh2add_uw(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH3ADD: begin    // Shift left by 3 and add
      result = fn_sh3add(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH3ADD_UW: begin // Shift unsigned word left by 3 and add
      result = fn_sh3add_uw(inp.rs1, inp.rs2);
      valid = True;
    end

    `SLLI_UW: begin   // Shift-left unsigned word (Immediate)
      result = fn_slli_uw(inp.rs1, inp.instr);
      valid = True;
    end


/*****************************************************************/
    // ZBS INSTRUCTIONS

    `BCLR: begin      // Single-Bit Clear (Register)
      result = fn_bclr(inp.rs1, inp.rs2);
      valid = True;
    end

    `BCLRI: begin     // Single-Bit Clear (Immediate)
      result = fn_bclri(inp.rs1, inp.instr);
      valid = True;
    end

    `BEXT: begin      // Single-Bit Extract (Register)
      result = fn_bext(inp.rs1, inp.rs2);
      valid = True;
    end

    `BEXTI: begin     // Single-Bit Extract (Immediate)
      result = fn_bexti(inp.rs1, inp.instr);
      valid = True;
    end

    `BINV: begin      // Single-Bit Invert (Register)
      result = fn_binv(inp.rs1, inp.rs2);
      valid = True;
    end

    `BINVI: begin     // Single-Bit Invert (Immediate)
      result = fn_binvi(inp.rs1, inp.instr);
      valid = True;
    end

    `BSET: begin      // Single-Bit Set (Register)
      result = fn_bset(inp.rs1, inp.rs2);
      valid = True;
    end

    `BSETI: begin     // Single-Bit Set (Immediate)
      result = fn_bseti(inp.rs1, inp.instr);
      valid = True;
    end

/*****************************************************************/
    default: begin
      result = 0;
      valid = False;
    end
  endcase

  return BBoxOutput{valid: valid, data: result};

endfunction
