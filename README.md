Privacy Preserving Localization
=======
This project is a simulation of the privacy preserving localization protocol for smart cars presented in [1]. It uses the TinyGarble framework [2] for privacy preserving computation using Yao's Garbled Circuits (GC). 

## C++ Source Code
First install the dependencies required by TinyGarble (described in the README file of the TinyGarble repository).

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

## MATLAB Simulation
This is a MATALB implementation of the triangle localization method in non-privacy preserving setting. It also include code for analysing the error associated with the localization method (note that the privacy preserving computation does not introduce any additional error).

## Generating Netlist
The Netlist folder includes the Verilog implementation of the two functions, one to compute the pair of intersections of two circles and one to check which one of them is inside a third circle, required for Yao's GC protocol. The intersection function has two implementations- with sequential and combinational implementations of the square root function. 

To compile the Verilog files to netlists with Synopsys DC, call
```
	./compile.sh $1 $2 $3 
```
$1, $2, and $3 are flags for <i>intersections_seq.v</i>, <i>intersections_comb.v</i>, <i>inside.v</i> respectively. Set them to 1 to compile the corresponding Verilog files, otherwise set them to 0. 

To generate the SCD file required by TinyGarble call `V2SCD_Main` as described in the README file of TinyGarble. 

The bit length can be changed by changing the parameter `N`. Also set the macros accordingly in `CPP_src\tri_loc.h`. Netlists and SCD files with bit length 8 is already provided inside the `Netlist\syn` directory.

## References
[1] Siam U. Hussain, and Farinaz Koushanfar, ["Privacy Preserving Localization for Smart Automotive Systems."](http://aceslab.org/sites/default/files/Localization.pdf) <i>Design Automation Conference, 2016</i>, June, 2016.

[2] Ebrahim M. Songhori, Siam U. Hussain, Ahmad-Reza Sadeghi, Thomas Schneider
and Farinaz Koushanfar, ["TinyGarble: Highly Compressed and Scalable Sequential
Garbled Circuits."](http://aceslab.org/sites/default/files/TinyGarble.pdf) <i>Security
and Privacy, 2015 IEEE Symposium on</i>,  May, 2015.
