# Take template .gitignore file and cast to all sites
# Written by June Skeeter

import os
import shutil
from pathlib import Path
root = Path(__file__).parents[2]

subfolder = 'Derived_Variables'

Template = f'{root}/_Example_ini_files/{subfolder}/.gitignore'


for d in os.listdir(root):
    if d.startswith('_')==False:
        shutil.copyfile(Template, f'{root}/{d}/{subfolder}/.gitignore')
