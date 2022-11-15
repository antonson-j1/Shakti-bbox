//See LICENSE.iitm for license details
/*

Author : Mouna Krishna
Email id : mounakrishna@mindgrovetech.in
Details: The top function which calls the required function depending 
         on the instruction.

--------------------------------------------------------------------------------------------------
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
  //Bit#(32) res;
  Bool valid;
  case(inp.instr) matches
    `ANDN: begin
      result = truncate(fn_andn(inp.rs1, inp.rs2));
      valid = True;
    end

    `ORN: begin
      result = fn_orn(inp.rs1, inp.rs2);
      valid = True;
    end

    `XNOR: begin
      result = fn_xnor(inp.rs1, inp.rs2);
      valid = True;
    end

    `CLZ: begin
      result = fn_clz(inp.rs1);
      valid = True;
    end

    `CLZW: begin
      result = fn_clzw(inp.rs1);
      valid = True;
    end


    `CTZ: begin
      result = fn_ctz(inp.rs1);
      valid = True;
    end

    `CTZW: begin
      result = fn_ctzw(inp.rs1);
      valid = True;
    end

    `CPOP: begin
      result = fn_cpop(inp.rs1);
      valid = True;
    end

    `ifdef RV64

    `CPOPW: begin
      result = fn_cpopw(inp.rs1);
      valid = True;
    end

    `endif 

    `MAX: begin
      result = fn_max(inp.rs1, inp.rs2);
      valid = True;
    end

    `MAXU: begin
      result = fn_maxu(inp.rs1, inp.rs2);
      valid = True;
    end

    `MIN: begin
      result = fn_min(inp.rs1, inp.rs2);
      valid = True;
    end

    `MINU: begin
      result = fn_minu(inp.rs1, inp.rs2);
      valid = True;
    end

    `SEXT_B: begin
      result = fn_sext_b(inp.rs1);
      valid = True;
    end

    `SEXT_H: begin
      result = fn_sext_h(inp.rs1);
      valid = True;
    end

    `ZEXT_H: begin
      result = fn_zext_h(inp.rs1);
      valid = True;
    end

    `ROL: begin
      result = fn_rol(inp.rs1, inp.rs2);
      valid = True;
    end

    `ROLW: begin
      result = fn_rolw(inp.rs1, inp.rs2);
      valid = True;
    end

    `ROR: begin
      result = fn_ror(inp.rs1, inp.rs2);
      valid = True;
    end



    // ZBC instructions

    `CLMUL: begin
      result = fn_clmul(inp.rs1, inp.rs2);
      valid = True;
    end

    `CLMULH: begin
      result = fn_clmulh(inp.rs1, inp.rs2);
      valid = True;
    end

    `CLMULR: begin
      result = fn_clmulr(inp.rs1, inp.rs2);
      valid = True;
    end




    `ADD_UW: begin
      result = fn_and_uw(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH1ADD: begin
      result = fn_sh1add(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH1ADD_UW: begin
      result = fn_sh1add_uw(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH2ADD: begin
      result = fn_sh2add(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH2ADD_UW: begin
      result = fn_sh2add_uw(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH3ADD: begin
      result = fn_sh3add(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH3ADD_UW: begin
      result = fn_sh3add_uw(inp.rs1, inp.rs2);
      valid = True;
    end

    `SLLI_UW: begin
      result = fn_slli_uw(inp.rs1, inp.instr);
      valid = True;
    end




    `BCLR: begin
      result = fn_bclr(inp.rs1, inp.rs2);
      valid = True;
    end

    `BCLRI: begin
      result = fn_bclri(inp.rs1, inp.instr);
      valid = True;
    end

    `BEXT: begin
      result = fn_bext(inp.rs1, inp.rs2);
      valid = True;
    end

    `BEXTI: begin
      result = fn_bexti(inp.rs1, inp.instr);
      valid = True;
    end

    `BINV: begin
      result = fn_binv(inp.rs1, inp.rs2);
      valid = True;
    end

    `BINVI: begin
      result = fn_binvi(inp.rs1, inp.instr);
      valid = True;
    end

    `BSET: begin
      result = fn_bset(inp.rs1, inp.rs2);
      valid = True;
    end

    `BSETI: begin
      result = fn_bseti(inp.rs1, inp.instr);
      valid = True;
    end


    default: begin
      result = 0;
      valid = False;
    end
  endcase
  return BBoxOutput{valid: valid, data: result};
endfunction
