#!/bin/bash
mkdir -p syn
if [ $1 == "1" ]; then
	design_vision -no_gui -f intersections_seq_syn.dcsh
fi 
if [ $2 == "1" ]; then
	design_vision -no_gui -f intersections_comb_syn.dcsh
fi 
if [ $3 == "1" ]; then
	design_vision -no_gui -f inside_syn.dcsh
fi
#rm *.pvl *.syn *.mr *.log *.svf