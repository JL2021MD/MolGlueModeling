for output in Occupancy.out Temperature.out; do
if [ -e $output ]; then
rm $output
fi
done
for i in PMEMD* ; do

printf "$i, " >> Occupancy.out
printf "$i, " >> Temperature.out

awk '/Occupancy/ { print $3 }'  $i/HAPOD.out >> Occupancy.out
awk '/Temperature/ { print $3 }' $i/HAPOD.out >> Temperature.out

done



