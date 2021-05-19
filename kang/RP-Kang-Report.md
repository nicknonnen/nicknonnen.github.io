---
layout: page
title: RP - Kang et al. reproduction
---

**Report outline**

Introduction explaining the interest and purpose in reproducing the Kang et al (2020) study, and very briefly introducing what the study was about.

Materials and Methods briefly explaining and citing what data sources and computational resources were used for the study. Explain any changes you made to the original python notebook / repository.

Results and Discussion include images of findings (maps, graphs) and link to your final repository for the reproduction. Discuss what you learned from the reproduction attempt, especially any knowledge, insight, or uncertainty that was encoded in the repository or discovered in the reproduction but not explained in the published paper.

Conclusions with emphasis on the significance of the reproduction study you just completed. Was the study reproducible, and has the reproduction study increased, decreased, or otherwise refined your belief in the validity of the original study? Conclude with any insights, priorities, or questions for future research.

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
