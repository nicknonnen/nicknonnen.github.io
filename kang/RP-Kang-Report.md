---
layout: page
title: RP - Kang et al. reproduction
---

**Report outline**

Introduction explaining the interest and purpose in reproducing the Kang et al (2020) study, and very briefly introducing what the study was about.

### Introduction

As the COVID-19 pandemic spread across the world, the first step to containing it was understanding where it was and how it spread. An efficient and effective way to accomplish this is through big datasets manipulated and analyzed by modern coding languages such as Python, and using open source data platforms such as OSM. In 2020, Kang et al. conducted a study to measure and visualize the spatial accessibility of COVID-19 healthcare resources, with a focus on Chicago, Illinois.

Beyond the study's timeliness with regards to the pandemic it studied, Kang et al. (2020) was groundbreaking in another sense as well: much of the code used to collect and analyze this data was published in an accessible Jupyter notebook, allowing our class to closely study the methods and results in the context of learning how to conduct open source geospatial science. In this reproduction, I closely examined the code used by Kang et al. (2020) in an effort to validate and improve the methods and conclusions.


### Materials and Methods

Materials and Methods briefly explaining and citing what data sources and computational resources were used for the study. Explain any changes you made to the original python notebook / repository.

Data for this study was collected from three unique sources.
- Network data was collected from [OpenStreetMap](https://www.openstreetmap.org/#map=4/38.01/-95.84)
  - this was then analyzed through the Python library [OSMNX](https://osmnx.readthedocs.io/en/stable/)
- Population data was collected from the [American Community Survey (ACS)](https://www.census.gov/programs-surveys/acs)
- Hospital data was collected from [Homeland Infrastructure Foundation-Level Data (HIFLD)](https://hifld-geoplatform.opendata.arcgis.com)

The study then proceeded to 

- sources: OSM network data (OpenStreetMap Python Library OSMNX), population data (ACS), and hospital data (HomelandInfrastructure Foundation-Level Data) **include links here**
- changes made: fixing the network spatial extent to overcome the flaw introduced by snapping hospitals to nearest node in grid
  - this involved adding a buffer area when grabbing street network data
  - also added time stamps to each function, so efficiency is more easily determined and slower functions can be pinpointed to improve the speed of the study overall

### Results and Discussion

Results and Discussion include images of findings (maps, graphs) and link to your final repository for the reproduction. Discuss what you learned from the reproduction attempt, especially any knowledge, insight, or uncertainty that was encoded in the repository or discovered in the reproduction but not explained in the published paper.
- figures: example of the two-step floating catchment area (Fig 3 in report), final figure showing accessibility areas (/assets/ChicagoResult2.png)
- link to [nicknonnen/RP-Kang](https://github.com/nicknonnen/RP-Kang)
- lessons learned from reproduction attempt:
  - how to use a jupyter notebook
  - spatial analysis in Python (using libraries, how to import / clean data, intersections and some more complex data analysis methods)
  - technical lesson: how to conduct an enhanced two-step floating catchment area analysis
- insights
  - revisions are always necessary, especially if scales change - even in how data was Collected
  - must constantly edit and update code as new library / software updates come out
  - the more people working on code, the better the code will be - the original study used a lot of less efficient workflows for certain functions / steps of the study, and was ony improved when bringing in a community of people used to thinking more geospatially

### Conclusions

Conclusions with emphasis on the significance of the reproduction study you just completed. Was the study reproducible, and has the reproduction study increased, decreased, or otherwise refined your belief in the validity of the original study? Conclude with any insights, priorities, or questions for future research.
- there is variation in the accessibility to COVID-19 relief resources in and around Chicago
- study is reproducible and replicable, but scale must be kept in mind when pulling data for a RE/RP study
- format of jupyter notbeook is highly effective in increasing transparency and reproducibility - this format should be used as an example for any future geospatial analysis involving heavy coding (do these notebooks only work for Python?)

Note on Style: Remember that the primary motivation for reproduction and replication studies is not punitive. Frame your discussions in this report and previous reports in the constructive motivation for improving scientific knowledge through peer review. Project like CyberGISX generally, and the Kang et al 2020 publication specifically, are very new in geography, and our engagement with them should be both encouraging and constructive while emphasizing the value of open science.

Fixing the one major problem in the code:
- look at how they got the network data in the first place using the osmnx library and look at the documentation they used

minor contributions: outline why each package is used and where
- **import pandas as pd**: any and all geospatial data analysis
- **import numpy as np**: numerical computing within Python
- **import geopandas as gpd**:
- **import networkx as nx**:
- **import osmnx as ox**:
- **from shapely.geometry import Point, LineString, Polygon**:
- **import matplotlib.pyplot as plt**:
- **from tqdm import tqdm**:
- **import multiprocessing as mp**:
- **import folium, itertools, os, time, warnings**:
- **from IPython.display import display, clear_output**:
