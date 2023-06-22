cat >cpptraj.genGaffLig.in<<EOF
parm ../Tleap/complex.gas.prmtop
trajin rep.c0.pdb
strip :1-594
trajout ligand_gaff2.mol2
EOF
cpptraj cpptraj.genGaffLig.in

cat >cpptraj.2proteins.in<<EOF
parm ../Tleap/complex.gas.prmtop
trajin rep.c0.pdb
strip :595
trajout 2proteins.pdb
EOF
cpptraj cpptraj.2proteins.in

rm cpptraj*
ln -s ../ligand.frcmod .
ln -s ../tleap_HMR.sh .
