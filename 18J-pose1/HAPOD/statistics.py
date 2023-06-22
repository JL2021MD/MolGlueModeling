import sys
input=open(sys.argv[1], "r")
lines=input.readlines()
scores=[]
for index,line in enumerate(lines):
    value=float(line.split()[1])
    scores.append(value)

l=len(scores)
average=sum(scores)/l
print("Average",sys.argv[1].rsplit(".")[0],"score of", l, "runs is", round(average,1))
var=sum([(value-average)**2 for value in scores]) /l

dev=var**0.5
print("Standard deviation: ", round(dev,1))

err=dev/l**0.5
print("Standard error: ", round(err,1))

