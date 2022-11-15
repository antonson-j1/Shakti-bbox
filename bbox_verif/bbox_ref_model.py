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
    
    # This instruction performs the bitwise logical AND operation between rs1 and the bitwise inversion of rs2.
    if instr_name == 'andn':
        res = rs1 & ~rs2
        valid = '1'

    # This instruction performs the bitwise logical AND operation between rs1 and the bitwise inversion of rs2.
    elif instr_name == 'orn':
        res = rs1 | ~rs2
        if res < 0:
            res = res + 2**XLEN
        valid = '1'

    # This instruction performs the bit-wise exclusive-NOR operation on rs1 and rs2.
    elif instr_name == 'xnor' :
        res = ~(rs1 ^ rs2)
        if res < 0:
            res = res + 2**XLEN
        valid = '1'

    # This instruction counts the number of 0’s before the first 1, starting at the most-significant bit (i.e., XLEN-1)
    # and progressing to bit 0. Accordingly, if the input is 0, the output is XLEN, and if the most-significant bit of
    # the input is a 1, the output is 0. 
    elif instr_name == 'clz' :
        
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


    # This instruction counts the number of 0’s before the first 1 starting at bit 31 and progressing to bit 0.
    # Accordingly, if the least-significant word is 0, the output is 32, and if the most-significant bit of the word
    # (i.e., bit 31) is a 1, the output is 0.
    elif instr_name == 'clzw' :
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


    # This instruction counts the number of 0’s before the first 1, starting at the least-significant bit (i.e., 0) and
    # progressing to the most-significant bit (i.e., XLEN-1). Accordingly, if the input is 0, the output is XLEN, and
    # if the least-significant bit of the input is a 1, the output is 0.
    elif instr_name == 'ctz' :
        count = 0        
        for i in range(XLEN):
            last_bit = rs1 % 2
            if(last_bit == 1):
                break
            count += 1
            rs1 >>= 1
        res = count
        valid = '1'


    # This instruction counts the number of 0’s before the first 1, starting at the least-significant bit (i.e., 0) and
    # progressing to the most-significant bit of the least-significant word (i.e., 31). Accordingly, if the least-
    # significant word is 0, the output is 32, and if the least-significant bit of the input is a 1, the output is 0.
    elif instr_name == 'ctzw' :
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

    # This instructions counts the number of 1’s (i.e., set bits) in the source register.
    elif instr_name == 'cpop' :    # CPOP
        res = CountSetBits(rs1, XLEN)
        valid = '1'

    # This instructions counts the number of 1’s (i.e., set bits) in the least-significant word of the source registers
    elif instr_name == 'cpopw' :    # CPOPW
        res = CountSetBits(rs1, 32)
        valid = '1'
    
    # This instruction returns the larger of two signed integers.
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

    # This instruction returns the larger of two unsigned integers.
    elif instr_name == 'maxu' :   # MAX UNSIGNED
        if rs1 > rs2:
            res = rs1
        else:
            res = rs2
        valid = '1'

    # This instruction returns the smaller of two signed integers.
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

    # This instruction returns the smaller of two unsigned integers.
    elif instr_name == 'minu':   # MIN UNSIGNED
        if rs1 < rs2:
            res = rs1
        else:
            res = rs2
        valid = '1'

    # This instruction sign-extends the least-significant byte in the source to XLEN by copying the most-significant
    # bit in the byte (i.e., bit 7) to all of the more-significant bits.
    elif instr_name == 'sext_b':   # SEXT B
        if rs1>>7 & 1 == 0b1:
            if XLEN == 32:
                res = int("0xFFFFFF00",16) + (rs1 & 0xFF)
            else:
                res = int("0xFFFFFFFFFFFFFF00",16) + (rs1 & 0xFF)
        else:
            res = rs1 & 0xFF
        valid = '1'

    # This instruction sign-extends the least-significant halfword in rs to XLEN by copying the most-significant bit
    # in the halfword (i.e., bit 15) to all of the more-significant bits.
    elif instr_name == 'sext_h':   # SEXT H
        if rs1>>15 & 1 == 0b1:
            if XLEN == 32:
                res = int("0xFFFF0000",16) + (rs1 & 0xFFFF)
            else:
                res = int("0xFFFFFFFFFFFF0000",16) + (rs1 & 0xFFFF)
        else:
            res = rs1 & 0xFFFF
        valid = '1'

    # This instruction zero-extends the least-significant halfword of the source to XLEN by inserting 0’s into all of
    # the bits more significant than 15.
    elif instr_name == 'zext_h':   # ZEXT H
        res = rs1 & 0xFFFF
        valid = '1'

    # This instruction performs a rotate left of rs1 by the amount in least-significant log2(XLEN) bits of rs2.
    elif instr_name == 'rol':   # ROL
        if XLEN == 32:
            res = ((rs1 << (rs2 & 0x1F)) | (rs1 >> (XLEN - (rs2 & 0x1F)))) & (2**(XLEN)-1)
        else:
            res = ((rs1 << (rs2 & 0x3F)) | (rs1 >> (XLEN - (rs2 & 0x3F)))) & (2**(XLEN)-1)
        valid = '1'

    # This instruction performs a rotate left on the least-significant word of rs1 by the amount in least-significant 5
    # bits of rs2. The resulting word value is sign-extended by copying bit 31 to all of the more-significant bits
    elif instr_name == 'rolw':   # ROLW
       
        rs1 = rs1 & 0xFFFFFFFF
        shamt = rs2 & 0x1F
        res = ((rs1 << shamt) | (rs1 >> (32-shamt))) & (2**(XLEN)-1)

        valid = '1' 

    # This instruction performs a rotate right of rs1 by the amount in least-significant log2(XLEN) bits of rs2.
    elif instr_name == 'ror':   # ROR
        if XLEN == 32:
            res = ((rs1 >> (rs2 & 0x1F)) | (rs1 << (XLEN - (rs2 & 0x1F)))) & (2**(XLEN)-1)
        else:
            res = ((rs1 >> (rs2 & 0x3F)) | (rs1 << (XLEN - (rs2 & 0x3F)))) & (2**(XLEN)-1)
        valid = '1'

    # This instruction performs a rotate right of rs1 by the amount in the least-significant log2(XLEN) bits of
    # shamt. For RV32, the encodings corresponding to shamt[5]=1 are reserved.
    elif instr_name == 'rori':   # RORI

        temp = instr >> 20

        if XLEN == 32:
            shamt = temp & 0x1F
        else:
            shamt = temp & 0x3F

        res = ((rs1 >> shamt) | (rs1 << (XLEN - shamt))) & (2**(XLEN)-1)
        valid = '1'

    # This instruction performs a rotate right on the least-significant word of rs1 by the amount in the least-
    # significant log2(XLEN) bits of shamt. The resulting word value is sign-extended by copying bit 31 to all of
    # the more-significant bits.
    elif instr_name == 'roriw':   # RORIW

        shamt = (instr >> 20) & 0x1F
        rs1_data = rs1 & 0xFFFFFFFF
        
        res = ((rs1_data >> shamt) | (rs1_data << (XLEN - shamt))) & (0xFFFFFFFF)
        
        if res>>31 & 1 == 0b1:
            res |= 0xFFFFFFFF00000000
        
        res &= (2**(XLEN)-1)
        
        valid = '1'

    # This instruction performs a rotate right on the least-significant word of rs1 by the amount in the least-
    # significant log2(XLEN) bits of shamt. The resulting word value is sign-extended by copying bit 31 to all of
    # the more-significant bits.
    elif instr_name == 'rorw':   # RORW
       
        rs1 = rs1 & 0xFFFFFFFF
        shamt = rs2 & 0x1F
        res = ((rs1 >> shamt) | (rs1 << (32-shamt))) & (2**(XLEN)-1)

        valid = '1' 

    # Combines the bits within each byte using bitwise logical OR. This sets the bits of each byte in the result rd
    # to all zeros if no bit within the respective byte of rs is set, or to all ones if any bit within the respective byte
    # of rs is set.
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

    # This instruction reverses the order of the bytes in rs.
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

    # clmul produces the lower half of the 2·XLEN carry-less product.
    elif instr_name == 'clmul':   # CLMUL
        res = 0
        for i in range(0, XLEN):
            if (rs2>>i) & 1 == 1:
                res = res ^ (rs1 << i)

        res = res & (2**(XLEN)-1)
        valid = '1'

    # clmulh produces the upper half of the 2·XLEN carry-less product.
    elif instr_name == 'clmulh':   # CLMULH
        res = 0
        for i in range(0, XLEN):
            if (rs2>>i) & 1 == 1:
                res = res ^ (rs1 >> (XLEN-i))

        res = res & (2**(XLEN)-1)
        valid = '1'

    # clmulr produces bits 2·XLEN−2:XLEN-1 of the 2·XLEN carry-less product.
    elif instr_name == 'clmulr':   # CLMULR
        res = 0
        for i in range(0, XLEN):
            if (rs2>>i) & 1 == 1:
                res = res ^ (rs1 >> (XLEN-i-1))

        res = res & (2**(XLEN)-1)
        valid = '1'


    # Zba 

    # This instruction performs an XLEN-wide addition between rs2 and the zero-extended least-significant word of rs1
    elif instr_name == 'add_uw':   # ADD_UW
        index = rs1 & 0xFFFFFFFF
        res = (rs2 + index) & (2**(XLEN)-1)

        valid = '1'

    # This instruction shifts rs1 to the left by 1 bit and adds it to rs2.
    elif instr_name == 'sh1add':   # SH1ADD
        num1 = rs1 << 1
        res = (num1 + rs2) & (2**(XLEN)-1)

        valid = '1'

    # This instruction performs an XLEN-wide addition of two addends. The first addend is rs2. The second
    # addend is the unsigned value formed by extracting the least-significant word of rs1 and shifting it left by 1
    # place
    elif instr_name == 'sh1add_uw':   # SH1ADD_UW
        num1 = (rs1 & 0xFFFFFFFF) << 1
        res = (num1 + rs2) & (2**(XLEN)-1)

        valid = '1'
    
    # This instruction shifts rs1 to the left by 2 places and adds it to rs2.
    elif instr_name == 'sh2add':   # SH2ADD
        num1 = rs1 << 2
        #num1 = (rs1 << 2) & (2**(XLEN)-1)
        res = (num1 + rs2) & (2**(XLEN)-1)

        valid = '1'

    # This instruction performs an XLEN-wide addition of two addends. The first addend is rs2. The second
    # addend is the unsigned value formed by extracting the least-significant word of rs1 and shifting it left by 2
    # places.
    elif instr_name == 'sh2add_uw':   # SH2ADD_UW
        num1 = (rs1 & 0xFFFFFFFF) << 2
        res = (num1 + rs2) & (2**(XLEN)-1)

        valid = '1'
    
    # This instruction shifts rs1 to the left by 3 places and adds it to rs2.
    elif instr_name == 'sh3add':   # SH3ADD
        num1 = rs1 << 3
        #num1 = (rs1 << 2) & (2**(XLEN)-1)
        res = (num1 + rs2) & (2**(XLEN)-1)

        valid = '1'

    # This instruction performs an XLEN-wide addition of two addends. The first addend is rs2. The second
    # addend is the unsigned value formed by extracting the least-significant word of rs1 and shifting it left by 3
    # places.
    elif instr_name == 'sh3add_uw':   # SH3ADD_UW
        num1 = (rs1 & 0xFFFFFFFF) << 3
        res = (num1 + rs2) & (2**(XLEN)-1)

        valid = '1'

    # This instruction takes the least-significant word of rs1, zero-extends it, and shifts it left by the immediate
    elif instr_name == 'slli_uw':   # SLLI_UW

        shamt = (instr >> 20) & 0x3F
        res = ((rs1 & 0xFFFFFFFF) << shamt) & (2**(XLEN)-1)
       
        valid = '1'
    

    #Zbs

    # This instruction returns rs1 with a single bit cleared at the index specified in rs2. The index is read from the
    # lower log2(XLEN) bits of rs2.
    elif instr_name == 'bclr':   # BCLR
        index = rs2 & (XLEN - 1)
        res = rs1 & ~( 1 << index )

        valid = '1'
        
    # This instruction returns rs1 with a single bit cleared at the index specified in shamt. The index is read from
    # the lower log2(XLEN) bits of shamt. For RV32, the encodings corresponding to shamt[5]=1 are reserved.
    elif instr_name == 'bclri':   # BCLRI

        temp = instr >> 20

        if XLEN == 32:
            shamt = temp & 0x1F
        else:
            shamt = temp & 0x3F

        index = shamt & (XLEN - 1)
        res = rs1 & ~( 1 << index )

        valid = '1'

    # This instruction returns a single bit extracted from rs1 at the index specified in rs2. The index is read from
    # the lower log2(XLEN) bits of rs2.
    elif instr_name == 'bext':   # BEXT
        index = rs2 & (XLEN - 1)
        res = (rs1 >> index) & 1

        valid = '1'

    # This instruction returns a single bit extracted from rs1 at the index specified in rs2. The index is read from
    # the lower log2(XLEN) bits of shamt. For RV32, the encodings corresponding to shamt[5]=1 are reserved
    elif instr_name == 'bexti':   # BEXTI
        temp = instr >> 20
        if XLEN == 32:
            shamt = temp & 0x1F
        else:
            shamt = temp & 0x3F

        index = shamt & (XLEN - 1)
        res = (rs1 >> index) & 1
        valid = '1'
        
    # This instruction returns rs1 with a single bit inverted at the index specified in rs2. The index is read from the
    # lower log2(XLEN) bits of rs2.
    elif instr_name == 'binv':   # BINV
        index = rs2 & (XLEN - 1)
        res = rs1 ^ ( 1 << index )

        valid = '1'

    # This instruction returns rs1 with a single bit inverted at the index specified in shamt. The index is read from
    # the lower log2(XLEN) bits of shamt. For RV32, the encodings corresponding to shamt[5]=1 are reserved
    elif instr_name == 'binvi':   # BINVI
        temp = instr >> 20
        if XLEN == 32:
            shamt = temp & 0x1F
        else:
            shamt = temp & 0x3F
        index = shamt & (XLEN - 1)
        res = rs1 ^ ( 1 << index )

        valid = '1'
        
    # This instruction returns rs1 with a single bit set at the index specified in rs2. The index is read from the
    # lower log2(XLEN) bits of rs2.
    elif instr_name == 'bset':   # BSET
        index = rs2 & (XLEN - 1)
        res = rs1 | ( 1 << index )

        valid = '1'

    # This instruction returns rs1 with a single bit set at the index specified in shamt. The index is read from the
    # lower log2(XLEN) bits of shamt. For RV32, the encodings corresponding to shamt[5]=1 are reserved.
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

    # If FAILED:
    else:
        res = 0
        valid = '0'

    # Return Results
    if XLEN == 32:
        result = '{:032b}'.format(res)
    elif XLEN == 64:
        result = '{:064b}'.format(res)

    return valid+result

