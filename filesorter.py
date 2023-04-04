#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr  4 20:47:16 2023

@author: cocolee
"""

import os, shutil

path = r"/Users/cocolee/Documents/DataAnalytics/Python/"
# reading as raw string = r"" 



#displaying the files
filename = os.listdir(path)

folder_names = ['csv files','image files','html files']


##  ------ creating a folder ---------

# does this path already exist? = os.path.exists
# make directory = os.makedirs

for loop in range(0,3):
    if not os.path.exists(path + folder_names[loop]):
        print(path + folder_names[loop])
        os.makedirs(path + folder_names[loop])

## check if it is in the file -> move to correct file

for file in filename:
    if ".jpg" in file and not os.path.exists(path + "image files/" + file) :
        shutil.move(path + file, path + "image files/" + file )
    elif ".html" in file and not os.path.exists(path + "html files/" + file) :
        shutil.move(path + file, path + "html files/" + file )
    elif ".xlsx" in file and not os.path.exists(path + "csv files/" + file) :
        shutil.move(path + file, path + "csv files/" + file )
    

