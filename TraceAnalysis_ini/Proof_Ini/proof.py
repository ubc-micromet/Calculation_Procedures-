import re
from os import walk
import pandas as pd
import numpy as np
Year = 2021
Site = 'BB'

Wdir = 'C:\\Users\\User\\PostDoc_Work\\database\\'

data_Path = str(Year)+'\\'+Site+'\\'

data_Folders = ['Met','Flux']

ini_File = 'Calculation_Procedures\\TraceAnalysis_ini\\BB\\BB_firststage.ini'
ini = open(Wdir+ini_File, 'r')
Lines = ini.readlines()
count = 0

Contains = []

for line in Lines:
    count += 1
    if 'inputFileName' in line and '{' in line:
        result = re.search('{\'(.*)\'}', line)
        Contains.append(result.group(1))

Raw_Files = []
Missing_Files = {}
Excludes = ['clean','Clean','SecondStage','ThirdStage']
Path = (Wdir + data_Path)
proceed = 1
for (dirpath, dirnames, filenames) in walk(Path):
    rel_dir = dirpath.replace(Path,'')
    for ex in Excludes:
        if ex in rel_dir:
            proceed = 0
    if proceed == 1:

        if dirpath != Path:
            for file in filenames:
                if file not in Contains:
                    Missing_Files[file] = rel_dir
                else:
                    Raw_Files.append(file)
    proceed = 1
print(Missing_Files)
# print(Contains)
# Missing = pd.DataFrame(index = np.arange(len(Missing_Files)) , data=Missing_Files)
# print(Missing)




