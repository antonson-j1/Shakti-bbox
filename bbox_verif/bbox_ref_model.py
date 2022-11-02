#See LICENSE.iitm for license details
'''

Author   : Santhosh Pavan
Email id : santhosh@mindgrovetech.in
Details  : This file consists reference model which is used in verifying the bbox design (DUT).

--------------------------------------------------------------------------------------------------
'''
'''
TODO:
Task Description: Add logic for all instructions. One instruction is implemented as an example. 
                  Note - The value of instr (ANDN) is a temp value, it needed to be changed according to spec.

Note - if instr has single operand, take rs1 as an operand
'''

#Functions to be used for instructions
def HighestSetBit(rs, XLEN):
    for i in range((XLEN-1), -1, -1):
        if (rs>>i)&(1) == 0b1:
            return i
    return XLEN

def LowestSetBit(rs, XLEN):
    for i in range(0, (XLEN), 1):
        if (rs>>i)&(1) == 0b1:
            return i
    return -1

def CountSetBits(rs, XLEN):
    count = 0
    for i in range(0, (XLEN), 1):
        if (rs>>i)&(1) == 0b1:
            count = count+1
    return count




#Reference model
def bbox_rm(instr, rs1, rs2, XLEN):
    
    if instr == 1:
        res = rs1 & ~rs2
        valid = '1'
    ## logic for all other instr starts 

    ##elif instr == 2:
    elif instr == 2:
        res = rs1 | ~rs2
        if res < 0:
            res = res + 2**XLEN
        valid = '1'

    elif instr == 3:
        res = ~(rs1 ^ rs2)
        if res < 0:
            res = res + 2**XLEN
        valid = '1'

    elif instr == 4:
        HighestOne = HighestSetBit(rs1, XLEN)
        res = (XLEN-1) - HighestOne
        valid = '1'

    elif instr == 5:
        HighestOne = HighestSetBit(rs1, 32)
        res = 31 - HighestOne
        valid = '1'

    elif instr == 6:
        res = LowestSetBit(rs1, XLEN)
        valid = '1'

    elif instr == 7:
        res = LowestSetBit(rs1, 32)
        valid = '1'

    elif instr == 8:    # CPOP
        res = CountSetBits(rs1, XLEN)
        valid = '1'

    elif instr == 9:    # CPOPW
        res = CountSetBits(rs1, 32)
        valid = '1'
    
    
    elif instr == 10:   # MAX
        print(rs1, type(rs1))
        if rs1>>(XLEN-1) & 1 == 0b1:
            rs1 = rs1 - 2**(XLEN)
        if rs2>>(XLEN-1) & 1 == 0b1:
            rs2 = rs2 - 2**(XLEN)

        if rs1 > rs2:
            res = rs1
        else:
            res = rs2

        if res < 0:
            res = res + 2**XLEN
        valid = '1'


    elif instr == 11:   # MAX UNSIGNED
        if rs1 > rs2:
            res = rs1
        else:
            res = rs2
        valid = '1'


    

    ## logic for all other instr ends
    else:
        res = 0
        valid = '0'

    if XLEN == 32:
        result = '{:032b}'.format(res)
    elif XLEN == 64:
        result = '{:064b}'.format(res)

    return valid+result

