import sys

rawFrames={}
finalFrames={}
file=open(sys.argv[1],"r")
output=open('HAPOD.out', "w")
lines=file.readlines()

for line in lines[1:]:
    frame=int(line.split()[0])
    RMSD=float(line.split()[1])
    rawFrames[frame]=RMSD

#print(rawFrames)

MoveAvgFrames={}
a=int(list(rawFrames)[-1])
print("A total of ",a, "frames read.", file=output)
print("A total of ",a, "frames read.")
for i in range(10,a+1):
    newFrame=0
    for k in range(0,10):
        
        one=(rawFrames[i-k])
        newFrame=one+newFrame
#        print(newFrame)
    outFrame=round(newFrame/10,4)
#    print(outFrame)
    finalFrames[i-9]=outFrame
#print(finalFrames)
##Because the first 16 frames are part of the equilibrum only not yet started any heating, but the moving average of 10 still counts them.
rawOccupany=-7
for i in range(1,a-8):
    if finalFrames[i]<4:
        rawOccupany=rawOccupany+1
occupancy=rawOccupany/5
print("Occupancy Score: ", occupancy, file=output)
print("Occupancy Score: ", occupancy)

dissociation={}
counter=0
dis=0
k=0
print("Dissociation frames:", file=output)
print("Dissociation frames:")
for i in range(1,a-8):
    if finalFrames[i]>4.5 and dis==0:
        k=i+k
        print(i, file=output)
        print(i)
        dis=1
        counter=counter+1
    elif finalFrames[i]<3.5 and dis==1:
        dis=0
    if i==a-9 and finalFrames[a-9] <4.5 and dis==0:
        k=k+562
        print(562, file=output)
        print(562)
        counter=counter+1

dissocation=round((k/counter-12)/5+310,1)
print("Temperature Score: ",dissocation, file=output)
print("Temperature Score: ",dissocation)






#    MoveAvgFrames[i-9]=int(rawFrames[1])+int(rawFrames[2])
#    print(MoveAvgFrames[1])
