inputs = ['linvilla_fall.txt', 'linvilla_frost.txt', 'linvilla_spring.txt']
outputs = ['linvillafalloutput.txt', 'linvillafrostoutput.txt', 'linvillaspringoutput.txt']

import matplotlib.pyplot as plt
import numpy as np

allFiles = []
for iputs in inputs:
    with open(iputs, 'r') as fp:
        lines = fp.readlines()
        stripped = []
        for line in lines:
            stripped.append(line.strip().split('\t'))
        allFiles.append(stripped)
        
everything = []
for i in range(len(outputs)):
    newf = open(outputs[i], "w+")
    data1 = []
    names = []
    vals = []
    for line in allFiles[i]:
        if line[0].count('|') == 6:
            lookingFor = "s__"
            posG = line[0].find(lookingFor) +len(lookingFor)
            data1.append([line[0][posG:], line[-1]])
            names.append(line[0][posG:])
            vals.append(float(line[-1]))
            newf.write(str(line[0][posG:]) + "\t" + str(line[-1]) + "\n")
    everything.append([names, vals])
    newf.close()
    
betterData = []

for i in range(len(everything)):
    currTotal = 0
    betterDataTemp = []
    totalTemp = []
    for j in range(len(everything[i][0])):
        if not (everything[i][0][j].count('Wolbachia') >= 1):
            betterDataTemp.append(everything[i][0][j])
            totalTemp.append(everything[i][1][j])
            currTotal += float(everything[i][1][j])
    betterData.append([betterDataTemp, totalTemp, currTotal])

allBacteria = {}
colorNum = 0
colors = ['#377eb8', '#ff7f00', '#4daf4a', '#f781bf', '#a65628', '#984ea3', '#999999', '#e41a1c', '#dede00']
for i in range(3):
    for j in range(len(betterData[i][0])):
        if betterData[i][0][j] not in allBacteria:
            allBacteria[(betterData[i][0][j])] = 'col'

myKeys = list(allBacteria.keys())
myKeys.sort()
allBacteria = {i: allBacteria[i] for i in myKeys}
for bac in allBacteria:
    allBacteria[bac] = colors[colorNum]
    colorNum+=1

seasons = ['Fall', 'Frost', 'Spring']
for i in range(len(seasons)):
    prevVal = 0
    for j in range(len(betterData[i][0])):
        plt.bar(seasons[i], (float(betterData[i][1][j])/betterData[i][2])*100, bottom = prevVal, color = allBacteria[betterData[i][0][j]])
        prevVal += (float(betterData[i][1][j])/betterData[i][2])*100
    plt.title("Microbiome Diversity in Linvilla")
    plt.xlabel("Season")
    plt.ylabel("% Abundance")
plt.show()

listBacteria = []
for bacteria in allBacteria:
    listBacteria.append(bacteria.replace('_', ' '))

f = lambda m,c: plt.plot([],[],marker=m, color=c, ls="none")[0]
handles = [f("s", colors[i]) for i in range(8)]
labels = listBacteria
legend = plt.legend(handles, labels, loc=2, framealpha=1, frameon=True)
plt.gca().set_axis_off()
plt.show()
