current=`pwd`
mkdir $current/Tleap
cd  $current/Tleap

cat > tleap.build.in <<EOF
#### tleap -f tleap.build.in


source leaprc.protein.ff19SB
source leaprc.gaff2

source leaprc.water.opc
#loadamberparams frcmod.ionsjc_tip3p
loadamberparams frcmod.ions1lm_126_iod_opc

set default PBradii mbondi2

rec=loadpdb ../rep.c0.pdb

###Load Ligand frcmod/prep

#loadamberparams ../ligand.frcmod
#lig=loadmol2 ../ligand_gaff2.mol2

gascomplex=  rec 

savepdb gascomplex complex.gas.pdb
saveamberparm gascomplex complex.gas.prmtop complex.gas.rst7
#saveamberparm rec receptor.gas.prmtop receptor.gas.rst7
#saveamberparm lig ligand.gas.prmtop ligand.gas.rst7

solvcomplex=  rec  
solvateoct solvcomplex OPCBOX 10.0

###Neutralize system (it will add either Na or Cl depending on net charge)
addions solvcomplex Cl- 0
addions solvcomplex Na+ 0

###Write solvated pdb file
savepdb solvcomplex complex.opc.pdb
###Check the system
charge solvcomplex
#check gascomplex
###Write Solvated topology and coord file
saveamberparm solvcomplex complex.opc.prmtop complex.opc.rst7

quit

EOF

cat > parmed1.in<<EOF
HMassRepartition
outparm complex.HMR.opc.prmtop
EOF
cat > parmed2.in<<EOF
HMassRepartition
outparm complex.HMR.gas.prmtop
EOF
tleap -f tleap.build.in
parmed -p complex.opc.prmtop -i parmed1.in
parmed -p complex.gas.prmtop -i parmed2.in

cat > stripPrmtop.temp <<EOF

parm complex.gas.prmtop [1]
parm complex.gas.prmtop [2]


parmstrip :383 parm [1]
parmwrite out CRBN.prmtop parm [1]

parmstrip :1-382 parm [2]
parmwrite out ligand.prmtop parm [2]

EOF
#cpptraj -i stripPrmtop.temp
cat > zinc.in <<EOF
parm complex.gas.prmtop
reference complex.gas.rst7
rst :594@ZN :542@SG reference offset 0.0 rk2 10.0 rk3 10.0 out zinc.rst
rst :594@ZN :545@SG reference offset 0.0 rk2 10.0 rk3 10.0 out zinc.rst
rst :594@ZN :474@SG reference offset 0.0 rk2 10.0 rk3 10.0 out zinc.rst
rst :594@ZN :477@SG reference offset 0.0 rk2 10.0 rk3 10.0 out zinc.rst
EOF
cpptraj zinc.in

rm parmed*.in 
#stripPrmtop.temp
