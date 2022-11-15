# BitManip Extension project

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

The image below 



Students are required to read through the Bit Manipulation Spec by RISC-V and implement it in **Bluespec** and verify it using **cocotb**. The spec pdf is present in docs/bitmanip-1.0.0-38-g865e7a7.pdf .

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

### Steps to run:
Make sure you have installed all the required tools as mentioned in docs/Tool_setup.pdf and the python environment is activated.

1. To just generate the verilog
```bash
$ make generate_verilog
```
2. To simulate. NOTE: Does both generate_verilog and simulate.
```bash
$ make simulate
```
3. To clean the build.
```bash
$ make clean_build
```

**_NOTE:_** Change BSCDEFINES macro in Makefile to RV64/RV32 according to use. 

### More info for Verification

```bash
1. First-time run - $ make simulate
   Subsequent runs - $ make clean_build
   		     $ make simulate
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

### Evaluation Criteria:
- Design code (bsv) has to be documented with proper comments and design intent
- Every team member should check-in their code contribution using their own GitLab id for individual evaluation
- Verification code (python) has to be documented with proper comments providing the test case explanation
- A final Report.md should be updated providing the steps to run the tests and the instructions implemented along with test run report.
