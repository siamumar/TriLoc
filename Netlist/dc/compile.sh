#!/bin/bash
mkdir -p syn
if [ $1 == "1" ]; then
	design_vision -no_gui -f intersections_seq_TG_syn.dcsh
fi 
if [ $2 == "1" ]; then
	design_vision -no_gui -f intersections_comb_TG_syn.dcsh
fi 
if [ $3 == "1" ]; then
	design_vision -no_gui -f inside_TG_syn.dcsh
fi
if [ $4 == "1" ]; then
	design_vision -no_gui -f one_vertex_syn.dcshh
fi
if [ $5 == "1" ]; then
	design_vision -no_gui -f median_x_3_syn.dcsh
fi
if [ $6 == "1" ]; then
	design_vision -no_gui -f TriLoc_BMR_syn.dcsh
fi
rm *.pvl *.syn *.mr *.log *.svf