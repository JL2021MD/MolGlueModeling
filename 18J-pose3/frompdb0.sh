#!/bin/bash

antechamber -i $1 -fi pdb -o ${1%.pdb}_gaff2.mol2 -fo mol2 -c bcc -nc $2 -at gaff2
rm *.AC *.INF *.AC0 sqm.pdb sqm.in sqm.out
parmchk2 -i ${1%.pdb}_gaff2.mol2 -f mol2 -s 2 -o ligand.frcmod

