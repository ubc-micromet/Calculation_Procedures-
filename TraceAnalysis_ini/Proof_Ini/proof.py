import re
import sys
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
        Contains.append(result.group(1).split('/')[-1])

Raw_Files = []
Missing_Files = {'Name':[],
                'Path':[]}
Exclude_keys = ['clean','Clean','SecondStage','ThirdStage','5min']
Exclude_paths = ['Met\ECCC']
Path = (Wdir + data_Path)
proceed = 1
for (dirpath, dirnames, filenames) in walk(Path):
    rel_dir = dirpath.replace(Path,'')
    for ex in Exclude_keys:
        if ex in rel_dir or rel_dir in Exclude_paths:
            proceed = 0
    if proceed == 1:

        if dirpath != Path:
            for file in filenames:
                if file not in Contains:
                    Missing_Files['Path'].append(rel_dir)
                    Missing_Files['Name'].append(file)
                else:
                    Raw_Files.append(file)
    proceed = 1
# print(Missing_Files.keys())
# print(Contains)
Missing = pd.DataFrame(data=Missing_Files)
print(Missing.groupby('Path').count())


