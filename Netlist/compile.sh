#!/bin/bash
mkdir -p syn
if [ $1 == "1" ]; then
	design_vision -no_gui -f intersections_syn.dcsh
fi
if [ $2 == "1" ]; then
	design_vision -no_gui -f inside_syn.dcsh
fi 