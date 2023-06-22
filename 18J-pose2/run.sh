for i in Refine1 Refine2 Refine3 Refine4 Refine5 ; do
	cd $i
	cpptraj cpptraj.align.in
	cpptraj RMSD.in
	cd ..
done
