# BitManip Extension

# CS6320 - CAD for VLSI - Course Project

## Introduction:

The bit-manipulation (bitmanip) extension collection is comprised of several component extensions to the base
RISC-V architecture that are intended to provide some combination of code size reduction, performance
improvement, and energy reduction. While the instructions are intended to have general use, some instructions
are more useful in some domains than others. Hence, several smaller bitmanip extensions are provided, rather
than one large extension. Each of these smaller extensions is grouped by common function and use case, and
each has its own Zb*-extension name.

Each bitmanip extension includes a group of several bitmanip instructions that have similar purposes and that
can often share the same logic. Some instructions are available in only one extension while others are available in
several. The instructions have mnemonics and encodings that are independent of the extensions in which they
appear. Thus, when implementing extensions with overlapping instructions, there is no redundancy in logic or
encoding.

## Procedure:

The bitmanip extensions are defined for RV32 and RV64. However certain instructions are present only in RV64. The image below shows a table containing all the 43 bit manipulation instructions in RISC-V:

![image](https://user-images.githubusercontent.com/60357885/201973070-7c5e3ff2-69a2-436c-8925-976666c53b3c.png)
![image](https://user-images.githubusercontent.com/60357885/201974070-6026de7f-854c-47b6-85f8-c3b048909b49.png)

All the above instructions were implemented in bluespec and tested using both - random testvector generation, and custom corner case testvectors.

## Results:

### Randomly generated test vectors:

#### RV64:
The image below shows the prefect working of all the 43 instructions of RV64 Bit Manip, iterated over randomly generated source register values (and randomly generated immediate values wherever used). Each instruction was tested across 10 randomly generated vectors. The results were verfied using a Testbench made using cocotb. 

![image](https://user-images.githubusercontent.com/60357885/201975410-d9762577-8fac-41e4-9520-a4d41b2ea7c4.png)

#### RV32:
The image below shows the prefect working of all the 32 instructions of RV32 Bit Manip, iterated over randomly generated source register values (and randomly generated immediate values wherever used). Each instruction was tested across 10 randomly generated vectors. The results were verfied using a Testbench made using cocotb. 

![image](https://user-images.githubusercontent.com/60357885/201976699-80e12043-b7b2-4e99-b7e4-9909ca3a8ebd.png)


### Custom generated corner case testing:

#### RV64:
The image below shows the prefect working of all the 43 instructions of RV64 Bit Manip, iterated over a set of custom corner case test input register values. Each instruction was tested against 4 custom generated edge case test vectors. The results were verfied using a Testbench made using cocotb. 

![image](https://user-images.githubusercontent.com/60357885/201980566-373c3c60-9e36-4318-a2ac-4743e118508b.png)

#### RV32:
The image below shows the prefect working of all the 32 instructions of RV32 Bit Manip, iterated over a set of custom corner case test input register values. Each instruction was tested against 4 custom generated edge case test vectors. The results were verfied using a Testbench made using cocotb. 

![image](https://user-images.githubusercontent.com/60357885/201981166-91431665-dfa7-409f-b99c-9856fa3dc427.png)


## Instructions for Testing:

### To Run:

We modified the 'makefile' to include clean build everytime we simulate. This will ensure that the while changing the MACROS, the changes get aptly reflected during testing.

- For testing, use the following command:
```bash
$ make simulate
```


### Changing from RV64 to RV32 and viceversa:

By default, RV64 instructions are used for testing. 

If we want to test for `RV32`:

1. Change the variable `base = 'RV64'` to `base = 'RV32' in `\bbox_verif\test_bbox.py`
2. Change the macro `BSCDEFINES = RV64` to `BSCDEFINES = RV32` in `\Makefile`


If we want to test again for `RV64`, revert back the above done changes.


### Changing from "Random Input Vector Testing" to "Custom Corner Case Input Tetsing":

- Change the variable `custom_testing = False` to `custom_testing = True` in `\src\test_bbox.py` to do Corner Case Testing.
- To do Random Input Vector Testing, use `custom_testing = False` again.


## Changes made:

- `\bbox_verif\test_bbox.py` was changed to accomdate for Random Test vector generation testing as well as custom corner case testing.
- `\bbox_verif\bbox_ref_model.py` was changed to include the python test functions for all the 43 instructions.
- `Zba.bsv`, `Zbb.bsv`, `Zbc.bsv`, and `Zbs.bsv` files which contain Bluespec functions were created in `\src\`
- `\src\bbox.defines` has all the instructions and their corresponding general instruction format, to be used for case statements in `compute.bsv`
- `\src\compute.bsv` all the implememted instructions are called/instantiated in this module depending on the instruction being used.


## Contribution by Members:

### 1. Antonson (EE19B025):

- Implemented all the Zbc instructions, and most of Zbb instrutions.
	- 21 bit manipulation instruction were implemented.
- Added extenstive comments.
- Finished the Readme.md


### 2. Likith Sai (EE19B080):

- Implemented all the Zba instructions, Zbs instrutions and some of Zbb instructions.
	- 21 bit manipulation instruction were implemented.
- Implemented Custom Corner Case Testing Testbench.
- Optimised the hardware bluespec implementation.




## Other Details:

Bit Manipulation Spec by RISC-V was implemented in **Bluespec** and verified it using **cocotb**. 

The spec pdf referred is `docs/bitmanip-1.0.0-38-g865e7a7.pdf`. "Bluespec reference guide" was used to aid and optimise the design process. 


### The repo structure is as follows:
- bbox.bsv - The top module of the design. Has the interface definition and module definition which calls the BitManip calculation.
- Makefile - Has make commands to generate_verilog and simulate.
- src/ - The directory where the files which the student should edit are present here. The files present are
	- compute.bsv - The top function which selects between the functions implemented for the spec depending on the instruction.
	- bbox.defines - The function which has the macro definition used to select between the instructions.
	- bbox_types.bsv - The structures, enum, bsc macors are defined here.
	- Zbb.bsv - A sample implementation of ANDN instruction is present. It is needed to be completed with all the other required instructions.
- bbox_verif/ - The directory where the scripts required for running the cocotb tests are present. The files present are:
	- test_bbox.py - This file consists cocotb testbench for bbox dut. For more info, check Task description provided in this file.
	- bbox_ref_model.py - This file consists reference model which used in verifying the design (DUT). For more info, check Task description provided 				in this file.
- docs/ - The directory where the bitmanip spec pdf, instructions for Tool Setup and some FAQs are present. 


### More info for Verification

```bash
1. To run - $ make simulate
```
```bash
2. To check waveforms, - Once simulation completes, dump.vcd is created in bbox/
    $ gtkwave dump.vcd
```    
```bash    
3. GTKWave installation - 
	$ sudo apt update
	$ sudo apt install gtkwave
```    
