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
def bbox_rm(instr, instr_name, rs1, rs2, XLEN):
    
    if instr_name == 'andn':
        res = rs1 & ~rs2
        valid = '1'
    ## logic for all other instr starts 

    elif instr_name == 'orn':
        res = rs1 | ~rs2
        if res < 0:
            res = res + 2**XLEN
        valid = '1'

    elif instr_name == 'xnor' :
        res = ~(rs1 ^ rs2)
        if res < 0:
            res = res + 2**XLEN
        valid = '1'

    elif instr_name == 'clz' :
        # HighestOne = HighestSetBit(rs1, XLEN)
        # res = (XLEN-1) - HighestOne
        # if res < 0:
        #     res = res + 2**XLEN
        # valid = '1'
        
        bits = [ 0 for i in range(XLEN)]
        for i in range(XLEN):
            last_bit = rs1 % 2
            bits[XLEN-1-i] = last_bit
            rs1 >>= 1

        count = 0        
        for i in range(XLEN):
            if(bits[i]==1):
                break
            count += 1
        res = count
        valid = '1'

    elif instr_name == 'clzw' :
        # HighestOne = HighestSetBit(rs1, 32)
        # res = 31 - HighestOne
        # if res < 0:
        #     res = res + 2**XLEN
        # valid = '1'
        rs1 &= 0xFFFFFFFF
        bits = [ 0 for i in range(32)]
        for i in range(32):
            last_bit = rs1 % 2
            bits[31-i] = last_bit
            rs1 >>= 1
        
        count = 0
        for i in range(32):
            if(bits[i]==1):
                break
            count += 1
        res = count
        valid = '1'


    elif instr_name == 'ctz' :
        # res = LowestSetBit(rs1, XLEN)
        # if res < 0:
        #     res = res + 2**XLEN
        # valid = '1'

        count = 0        
        for i in range(XLEN):
            last_bit = rs1 % 2
            if(last_bit == 1):
                break
            count += 1
            rs1 >>= 1
        res = count
        valid = '1'


    elif instr_name == 'ctzw' :
        # res = LowestSetBit(rs1, 32)
        # if res < 0:
        #     res = res + 2**XLEN
        # valid = '1'

        rs1 &= 0xFFFFFFFF
        count = 0        
        for i in range(32):
            last_bit = rs1 % 2
            if(last_bit == 1):
                break
            count += 1
            rs1 >>= 1
        res = count
        valid = '1'


    elif instr_name == 'cpop' :    # CPOP
        res = CountSetBits(rs1, XLEN)
        valid = '1'

    elif instr_name == 'cpopw' :    # CPOPW
        res = CountSetBits(rs1, 32)
        valid = '1'
    

    elif instr_name == 'max' :   # MAX
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


    elif instr_name == 'maxu' :   # MAX UNSIGNED
        if rs1 > rs2:
            res = rs1
        else:
            res = rs2
        valid = '1'

    elif instr_name == 'min' :   # MIN
        if rs1>>(XLEN-1) & 1 == 0b1:
            rs1 = rs1 - 2**(XLEN)
        if rs2>>(XLEN-1) & 1 == 0b1:
            rs2 = rs2 - 2**(XLEN)

        if rs1 < rs2:
            res = rs1
        else:
            res = rs2

        if res < 0:
            res = res + 2**XLEN
        valid = '1'

    elif instr_name == 'minu':   # MIN UNSIGNED
        if rs1 < rs2:
            res = rs1
        else:
            res = rs2
        valid = '1'

    elif instr_name == 'sext_b':   # SEXT B
        if rs1>>7 & 1 == 0b1:
            if XLEN == 32:
                res = int("0xFFFFFF00",16) + (rs1 & 0xFF)
            else:
                res = int("0xFFFFFFFFFFFFFF00",16) + (rs1 & 0xFF)
        else:
            res = rs1 & 0xFF
        valid = '1'

    elif instr_name == 'sext_h':   # SEXT H
        if rs1>>15 & 1 == 0b1:
            if XLEN == 32:
                res = int("0xFFFF0000",16) + (rs1 & 0xFFFF)
            else:
                res = int("0xFFFFFFFFFFFF0000",16) + (rs1 & 0xFFFF)
        else:
            res = rs1 & 0xFFFF
        valid = '1'

    elif instr_name == 'zext_h':   # ZEXT H
        res = rs1 & 0xFFFF
        valid = '1'


    elif instr_name == 'rol':   # ROL
        if XLEN == 32:
            res = ((rs1 << (rs2 & 0x1F)) | (rs1 >> (XLEN - (rs2 & 0x1F)))) & (2**(XLEN)-1)
        else:
            res = ((rs1 << (rs2 & 0x3F)) | (rs1 >> (XLEN - (rs2 & 0x3F)))) & (2**(XLEN)-1)
        valid = '1'

    elif instr_name == 'rolw':   # ROLW
       
        rs1 = rs1 & 0xFFFFFFFF
        shamt = rs2 & 0x1F
        res = ((rs1 << shamt) | (rs1 >> (32-shamt))) & (2**(XLEN)-1)

        valid = '1' 

    elif instr_name == 'ror':   # ROR
        if XLEN == 32:
            res = ((rs1 >> (rs2 & 0x1F)) | (rs1 << (XLEN - (rs2 & 0x1F)))) & (2**(XLEN)-1)
        else:
            res = ((rs1 >> (rs2 & 0x3F)) | (rs1 << (XLEN - (rs2 & 0x3F)))) & (2**(XLEN)-1)
        valid = '1'

    elif instr_name == 'rori':   # RORI

        temp = instr >> 20

        if XLEN == 32:
            shamt = temp & 0x1F
        else:
            shamt = temp & 0x3F

        res = ((rs1 >> shamt) | (rs1 << (XLEN - shamt))) & (2**(XLEN)-1)
        valid = '1'

    elif instr_name == 'roriw':   # RORIW

        shamt = (instr >> 20) & 0x1F
        rs1_data = rs1 & 0xFFFFFFFF
        
        res = ((rs1_data >> shamt) | (rs1_data << (XLEN - shamt))) & (0xFFFFFFFF)
        
        if res>>31 & 1 == 0b1:
            res |= 0xFFFFFFFF00000000
        
        res &= (2**(XLEN)-1)
        
        valid = '1'


    elif instr_name == 'rorw':   # RORW
       
        rs1 = rs1 & 0xFFFFFFFF
        shamt = rs2 & 0x1F
        res = ((rs1 >> shamt) | (rs1 << (32-shamt))) & (2**(XLEN)-1)

        valid = '1' 

    elif instr_name == 'orc_b':   # ORC_B
        out = 0
        inp = rs1

        for i in range(0, int((XLEN-8)/8)+1):
            if ( (inp >> (8*i)) & 0xFF == 0x00):
                out |= 0x00 << (8*i)
            else:
                out |= 0xFF << (8*i)

        res = out

        valid = '1' 

    elif instr_name == 'rev8':   # REV8
        out = 0
        inp = rs1
        j = XLEN-1

        for i in range(0, int((XLEN-8)/8)+1):
            out = out << 8
            out |= ((inp >> 8*i) & 0xFF)  
            
        res = out
        res &= (2**(XLEN)-1)
        

        valid = '1' 


    
    # Zbc 
    elif instr_name == 'clmul':   # CLMUL
        res = 0
        for i in range(0, XLEN):
            if (rs2>>i) & 1 == 1:
                res = res ^ (rs1 << i)

        res = res & (2**(XLEN)-1)
        valid = '1'

    elif instr_name == 'clmulh':   # CLMULH
        res = 0
        for i in range(0, XLEN):
            if (rs2>>i) & 1 == 1:
                res = res ^ (rs1 >> (XLEN-i))

        res = res & (2**(XLEN)-1)
        valid = '1'

    elif instr_name == 'clmulr':   # CLMULR
        res = 0
        for i in range(0, XLEN):
            if (rs2>>i) & 1 == 1:
                res = res ^ (rs1 >> (XLEN-i-1))

        res = res & (2**(XLEN)-1)
        valid = '1'


    # Zba 
    elif instr_name == 'add_uw':   # ADD_UW
        index = rs1 & 0xFFFFFFFF
        res = (rs2 + index) & (2**(XLEN)-1)

        valid = '1'

    elif instr_name == 'sh1add':   # SH1ADD
        num1 = rs1 << 1
        res = (num1 + rs2) & (2**(XLEN)-1)

        valid = '1'

    elif instr_name == 'sh1add_uw':   # SH1ADD_UW
        num1 = (rs1 & 0xFFFFFFFF) << 1
        res = (num1 + rs2) & (2**(XLEN)-1)

        valid = '1'
    
    elif instr_name == 'sh2add':   # SH2ADD
        num1 = rs1 << 2
        #num1 = (rs1 << 2) & (2**(XLEN)-1)
        res = (num1 + rs2) & (2**(XLEN)-1)

        valid = '1'

    elif instr_name == 'sh2add_uw':   # SH2ADD_UW
        num1 = (rs1 & 0xFFFFFFFF) << 2
        res = (num1 + rs2) & (2**(XLEN)-1)

        valid = '1'
    
    elif instr_name == 'sh3add':   # SH3ADD
        num1 = rs1 << 3
        #num1 = (rs1 << 2) & (2**(XLEN)-1)
        res = (num1 + rs2) & (2**(XLEN)-1)

        valid = '1'

    elif instr_name == 'sh3add_uw':   # SH3ADD_UW
        num1 = (rs1 & 0xFFFFFFFF) << 3
        res = (num1 + rs2) & (2**(XLEN)-1)

        valid = '1'

    elif instr_name == 'slli_uw':   # SLLI_UW

        shamt = (instr >> 20) & 0x3F
        res = ((rs1 & 0xFFFFFFFF) << shamt) & (2**(XLEN)-1)
       
        valid = '1'

    

    #Zbs
    elif instr_name == 'bclr':   # BCLR
        index = rs2 & (XLEN - 1)
        res = rs1 & ~( 1 << index )

        valid = '1'
    
    elif instr_name == 'bclri':   # BCLRI

        temp = instr >> 20

        if XLEN == 32:
            shamt = temp & 0x1F
        else:
            shamt = temp & 0x3F

        index = shamt & (XLEN - 1)
        res = rs1 & ~( 1 << index )

        valid = '1'
    

    elif instr_name == 'bext':   # BEXT
        index = rs2 & (XLEN - 1)
        res = (rs1 >> index) & 1

        valid = '1'

    elif instr_name == 'bexti':   # BEXTI
        temp = instr >> 20

        if XLEN == 32:
            shamt = temp & 0x1F
        else:
            shamt = temp & 0x3F

        index = shamt & (XLEN - 1)
        res = (rs1 >> index) & 1

        valid = '1'
    
    
    elif instr_name == 'binv':   # BINV
        index = rs2 & (XLEN - 1)
        res = rs1 ^ ( 1 << index )

        valid = '1'

    elif instr_name == 'binvi':   # BINVI

        temp = instr >> 20

        if XLEN == 32:
            shamt = temp & 0x1F
        else:
            shamt = temp & 0x3F


        index = shamt & (XLEN - 1)
        res = rs1 ^ ( 1 << index )

        valid = '1'
    
    
    elif instr_name == 'bset':   # BSET
        index = rs2 & (XLEN - 1)
        res = rs1 | ( 1 << index )

        valid = '1'

    elif instr_name == 'bseti':   # BSETI
        temp = instr >> 20

        if XLEN == 32:
            shamt = temp & 0x1F
        else:
            shamt = temp & 0x3F

        index = shamt & (XLEN - 1)
        res = rs1 | ( 1 << index )

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

