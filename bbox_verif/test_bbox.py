#See LICENSE.iitm for license details
'''

Author   : Santhosh Pavan
Email id : santhosha@mindgrovetech.in
Details  : This file consists cocotb testbench for bbox dut

--------------------------------------------------------------------------------------------------
'''
'''
TODO:
Task Description: Add list of instructions in Testfactory block. So that testbench generates tests for listed instructions. One instruction is implemented as an example. 
		  For multiple instructions, provided as comment (see after TestFactory(TB)). Please the use the same format.
                  Note - Comments are provided for TestFactory.
		  Note - The value of instr (ANDN) is a temp value, it needed to be changed according to spec.

Note - Here testbench assumes below verilog port names are generated by bluespec compiler. Please implement the bluespec design with below port names.

 DUT Ports:
 Name                         I/O  size 
 bbox_out                       O    65/33
 CLK                            I     1 
 RST_N                          I     1 
 instr                          I    32
 rs1                            I    64/32
 rs2                            I    64/32
   (instr, rs1, rs2) -> bbox_out
'''


import string
import random
import cocotb
import logging as _log
from cocotb.decorators import coroutine
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.binary import BinaryValue
from cocotb.clock import Clock
from cocotb.regression import TestFactory

from bbox_ref_model import bbox_rm



def btd(s):
    
    ans = 0
    n = len(s)
    for i in range(n):
        if(s[i]=='1'):
            ans += pow(2,n-1-i)

    return ans



def instr_gen(instr_name):
    if instr_name=='andn':
        return btd('0100000' + '00000' + '00000' + '111' + '00000' + '0110011')

    if instr_name=='bclr':
        return btd('0100100' + '00000' + '00000' + '001' + '00000' + '0110011')


    if instr_name=='bclri':
        

        if(base == 'RV32'):
            num = random.randint(0,31)
            shamt = bin(num)
            shamt = shamt[2:]

            shamt = (5-len(shamt))*'0' + shamt

            return btd('0100100' + shamt + '00000' + '001' + '00000' + '0010011')
        else:
            num = random.randint(0,63)
            shamt = bin(num)
            shamt = shamt[2:]

            shamt = (6-len(shamt))*'0' + shamt

            return btd('010010' + shamt + '00000' + '001' + '00000' + '0010011')

    if instr_name=='bext':
        return btd('0100100' + '00000' + '00000' + '101' + '00000' + '0110011')


    if instr_name=='bexti':
        

        if(base == 'RV32'):
            num = random.randint(0,31)
            shamt = bin(num)
            shamt = shamt[2:]

            shamt = (5-len(shamt))*'0' + shamt

            return btd('0100100' + shamt + '00000' + '101' + '00000' + '0010011')
        else:
            num = random.randint(0,63)
            shamt = bin(num)
            shamt = shamt[2:]

            shamt = (6-len(shamt))*'0' + shamt

            return btd('010010' + shamt + '00000' + '101' + '00000' + '0010011')

    if instr_name=='binv':
        return btd('0110100' + '00000' + '00000' + '001' + '00000' + '0110011')


    if instr_name=='binvi':
        

        if(base == 'RV32'):
            num = random.randint(0,31)
            shamt = bin(num)
            shamt = shamt[2:]

            shamt = (5-len(shamt))*'0' + shamt

            return btd('0110100' + shamt + '00000' + '001' + '00000' + '0010011')
        else:
            num = random.randint(0,63)
            shamt = bin(num)
            shamt = shamt[2:]

            shamt = (6-len(shamt))*'0' + shamt

            return btd('011010' + shamt + '00000' + '001' + '00000' + '0010011')

    if instr_name=='bset':
        return btd('0010100' + '00000' + '00000' + '001' + '00000' + '0110011')


    if instr_name=='bseti':
        

        if(base == 'RV32'):
            num = random.randint(0,31)
            shamt = bin(num)
            shamt = shamt[2:]

            shamt = (5-len(shamt))*'0' + shamt

            return btd('0010100' + shamt + '00000' + '001' + '00000' + '0010011')
        else:
            num = random.randint(0,63)
            shamt = bin(num)
            shamt = shamt[2:]

            shamt = (6-len(shamt))*'0' + shamt

            return btd('001010' + shamt + '00000' + '001' + '00000' + '0010011')
    


#generates clock and reset
async def initial_setup(dut):
	cocotb.start_soon(Clock(dut.CLK, 1, units='ns').start())
        
	dut.RST_N.value = 0
	await RisingEdge(dut.CLK)
	dut.RST_N.value = 1


#drives input data to dut
async def input_driver(dut, instr, rs1, rs2, single_opd):
    await RisingEdge(dut.CLK)
    dut.instr.value = instr
    dut.rs1.value = rs1
    dut._log.info("---------------- DUT Input Info -----------------------")
    if single_opd == 1:
        await RisingEdge(dut.CLK)
        dut._log.info("instr = %s  rs1 = %s ",hex(dut.instr.value), hex(dut.rs1.value))

    else :
        dut.rs2.value = rs2
        await RisingEdge(dut.CLK)
        dut._log.info("instr = %s  rs1 = %s rs2 = %s",hex(dut.instr.value), hex(dut.rs1.value), hex(dut.rs2.value))
    dut._log.info("-------------------------------------------------------")

#monitors dut output
async def output_monitor(dut):
    while True:
        await RisingEdge(dut.CLK)
        if(dut.bbox_out.value[0]): break

    dut_result = dut.bbox_out.value
    return dut_result

#compares output of dut and rm
async def scoreboard(dut, dut_result, rm_result):
    dut._log.info("------------ Compare DUT o/p & Ref Model o/p ----------")
    dut._log.info("Expected output  = %s", rm_result)
    dut._log.info("DUT output       = %s", dut_result)
    assert rm_result == str(dut_result),"Failed"
    dut._log.info("-------------------------------------------------------")

#Testbench
async def TB(dut, XLEN, instr, instr_name, single_opd, num_of_tests):
    await initial_setup(dut)
    dut._log.info("*******************************************************")
    dut._log.info("------------- Test %r of RV%d starts --------------" %(instr_name,XLEN))
    dut._log.info("*******************************************************")
    for i in range (num_of_tests):
        rs1 = random.randint(0,(2**XLEN)-1) 
        rs2 = random.randint(0,(2**XLEN)-1)
        rm_result = bbox_rm(instr, instr_name, rs1, rs2, XLEN)
    
        await input_driver(dut, instr, rs1, rs2, single_opd)
        dut_result = await output_monitor(dut)
    
        await scoreboard(dut, dut_result, rm_result)	
    dut._log.info("*******************************************************")
    dut._log.info("------------- Test %r of RV%d ends ----------------" %(instr_name,XLEN))
    dut._log.info("*******************************************************")


# generates sets of tests based on the different permutations of the possible arguments to the test function
tf = TestFactory(TB)

base = 'RV64'
#To run tests for RV32, change base = 'RV32'

#generates tests for instructions of RV32
if base == 'RV32':
    tf.add_option('XLEN', [32])
    #tf.add_option(('instr','instr_name','single_opd'), [(1, 'addn', 0), (2,'orn',0), (3,'xnor',0), (4,'clz',1), (5,'clzw',1), (6,'ctz',1), (7,'ctzw',1), (8,'cpop',1)])
    #if instruction has single operand, provide single_opd = 1 (please see below line).
    ##To run multiple instr - tf.add_option(((('instr','instr_name','single_opd'), [(1, 'addn', 0),(2,'clz',1),(...)])

#generates tests for instructions of RV64
elif base == 'RV64':
    tf.add_option('XLEN', [64])
    
    
tf.add_option(('instr','instr_name','single_opd'), \
    [(instr_gen('andn'), 'andn', 0), 
    (instr_gen('bclr'), 'bclr', 0), (instr_gen('bclri'), 'bclri', 1), (instr_gen('bext'), 'bext', 0), (instr_gen('bexti'), 'bexti', 1), \
        (instr_gen('binv'), 'binv', 0), (instr_gen('binvi'), 'binvi', 1), (instr_gen('bset'), 'bset', 0), (instr_gen('bseti'), 'bseti', 1),
    ])
#  (2,'orn',0), (3,'xnor',0), \
#     (4,'clz',1), (5,'clzw',1), (6,'ctz',1), (7,'ctzw',1), (8,'cpop',1), (9,'cpopw',1), \
#         (10,'max',0), (11,'maxu',0), (12,'min',0), (13,'minu',0), (14,'sext_b',1), (15,'sext_h',1), \
#             (16,'zext_h',1), (17,'rol',0), (18,'rolw',0), (19,'ror',0), (24,'clmul',0), (25,'clmulh',0), (26,'clmulr',0), \
#                 (27,'add_uw',0), (28,'sh1add',0), (29,'sh1add_uw',0), (30,'sh2add',0), (31,'sh2add_uw',0), (32,'sh3add',0), (33,'sh3add_uw',0), \
#                     (34,'bclr',0), (36,'bext',0), (38,'binv',0), (40,'bset',0) ])
    #if instruction has single operand, provide single_opd = 1 (please see below line).
    ##To run multiple instr - tf.add_option(((('instr','instr_name','single_opd'), [(1, 'addn', 0),(2,'clz',1),(...)])

#for each instruction below line generates 10 test vectors, can change to different no.
tf.add_option('num_of_tests',[10])
tf.generate_tests()

