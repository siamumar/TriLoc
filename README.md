Privacy Preserving Localization
=======
This project is a simulation of the privacy preserving localization protocol for smart cars presented in [1]. For privacy preserving computation it employs
- TinyGarble framework [2] for privacy preserving computation using Yao's Garbled Circuits (GC). 
- Semi-Honest-BMR framework [3] for privacy preserving computation using BMR.

## C++ Source Code
First, install the dependencies required by TinyGarble (described in the README file of the TinyGarble repository).

Then compile by first configuring CMake and then calling `make` inside the `bin` directory. 
```
  $ ./configure
  $ cd bin
  $ make
```
Usage for the generated binary file `bin\CPP_src\TriLoc` is as follows
```
  -h [ --help ]                           produce help message
  -l [ --lost ]                           the lost car
  -a [ --assisting ]                      an assisting car
  -p [ --ports ] arg (=1111, 2222, 3333)  socket ports
  -s [ --server_ip ] arg (=127.0.0.1)     server ip of lost car
  -d [ --data_file ] arg (=../../CPP_src/location_data.txt)
                                          file containing <x,y> coordinates of the assisting cars and their respective distances from the lost car
```
We assume that all the assisting cars know their locations and respective distances from the lost car and read them from the location data file. 

## Simulation
### MATLAB Simulation
The MATALB implementation of the triangle localization method in non-privacy preserving setting is included in the MAT_SIM directory. It also include code for analysing the error associated with the localization method (note that the privacy preserving computation does not introduce any additional error).
### Verilog Simulation
To simulate with Xilinx Vivado create the Vivado project with TriLoc_Vivado.tcl in the Netlist directory. To create the project, in Vivado tcl console run
```
source TriLoc_Vivado.tcl
```
To update the project
```
cd [get_property DIRECTORY [current_project]]
write_project_tcl -force -target_proj_dir TriLoc_Vivado TriLoc_Vivado.tcl
```

## Generating Netlist
Netlist generation requires the [TinyGarbleCircuitSynthesis](https://github.com/siamumar/TinyGarbleCircuitSynthesis.git) library.

The Netlist directory includes the Verilog implementation of the functions required by the Yao's GC protocol:
- Intersection: to compute the pair of intersections of two circles. It has two implementations- with sequential and combinational implementations of the square root function.
- Inside: to check which one of the intersections is inside a third circle
- One_vertex: combination of Intersection and Inside to compute one vertex of the triangle
- Median: to compute the median of the triangle
- TriLoc: combination of One_vertex and Median to compute the final location

Intersection and Inside netlists are used in the GC based protocol and the TriLoc netlist is used in the BMR based protocol. 


To compile the Verilog files to netlists with Synopsys DC, run inside Netlist/dc/
```
	./compile.sh $1 $2 $3 $4 $5 $6
```
$1, $2,$3, $4, $5, $6 are flags for <i>intersections_seq.v</i>, <i>intersections_comb.v</i>, <i>inside.v</i>, <i>one_vertex.v</i>, <i>median_x_3.v</i>, <i>TriLoc_BMR.v</i> respectively. Set them to 1 to compile the corresponding Verilog files, otherwise set them to 0. 

To compile the TriLoc code to netlists with Yosys, run inside Netlist/dc/
```
yosys -s TriLoc_BMR_syn.yos
```

To generate the SCD files required by TinyGarble call `V2SCD_Main` as described in [TinyGarbleCircuitSynthesis](https://github.com/siamumar/TinyGarbleCircuitSynthesis.git)/Verilog2SCD. 
To generate the circuit file required by BMR call `V2BMR_Main` as described in [TinyGarbleCircuitSynthesis](https://github.com/siamumar/TinyGarbleCircuitSynthesis.git)/Verilog2BMR. 

The bit length can be changed by changing the parameter `N`. Also set the macros accordingly in `CPP_src\tri_loc.h`. Netlists and SCD files with bit length 8 is already provided inside the `Netlist\syn` directory.

## References
[1] Siam U. Hussain, and Farinaz Koushanfar, ["Privacy Preserving Localization for Smart Automotive Systems."](http://aceslab.org/sites/default/files/Localization.pdf) <i>Design Automation Conference, 2016</i>, June, 2016.

[2] Ebrahim M. Songhori, Siam U. Hussain, Ahmad-Reza Sadeghi, Thomas Schneider
and Farinaz Koushanfar, ["TinyGarble: Highly Compressed and Scalable Sequential
Garbled Circuits."](http://aceslab.org/sites/default/files/TinyGarble.pdf) <i>Security
and Privacy, 2015 IEEE Symposium on</i>,  May, 2015.

[3] Aner Ben-Efraim, Yehuda Lindell, and Eran Omri, ["Optimizing Semi-Honest Secure Multiparty Computation for the Internet"](https://eprint.iacr.org/2016/1066.pdf), <i>ACM SIGSAC Conference on Computer and Communications Security</i>, Oct, 2016. 
