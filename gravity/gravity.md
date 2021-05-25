---
layout: page
title: Gravity Model Spatial Interaction
---

Updated 03/08/2021 9:00pm

### Background and Introduction

For this assignment, I created a [Gravity Model of Spatial Interaction](https://transportgeography.org/contents/methods/spatial-interactions-gravity-model/) to illustrate the potential interactions between two places.

In this lab, I'm using a model to determine the service area "catchment" areas for hospitals in the Northeast US. The model uses three variables to calculate potential interaction: the "weight" of the input, the "weight" of the target, and the distance between the input and the target. The potential for interaction is based on values of the weights multiplied together and the divided by the distance, to produce the equation

**((InputWeight)^λ * (TargetWeight)^α) / (Distance)^β**

All three exponent parameters, λ, α, and β, are modifiable by the user of the model. The β parameter is set to a default value of 2, due to the more significant influence distance has on the interaction of two points in space, while parameters λ and α are set to a default value of 1.

### Methods and Results

In this exercise, I analyzed the interactions of towns and hospital clusters in the Northeast US and then compared those catchment areas to the those of the Dartmouth Health Atlas. The aggregated results may be found in [this](file:///Users/nicholasnonnenmacher/Desktop/Nicholas'%20Documents/Middlebury%2020-21%20/Spring%202021/OpenSource%20GIS/nicknonnen.github.io/gravity/assets/qgis2web_2021_05_25-14_16_08_019603/index.html#6/42.585/-74.861) interactive Leaflet map.

Here is the preprocessing model used to clean hospital data. This model is available for download [here](hospital_preProcessing.model3).
![preprocessing_model](/assets/preprocessing_model.png)
Figure 1. To clean and prepare hospital data, all private and specialized hospitals were removed from the data pool.

Here is the completed gravity model used to create HSAs. The file is available for download [here](/assets/gravityModel.model3).

![gravitymodel](/assets/gravitymodel.png)
Figure 2. The Gravity Model.

This model accepts an input layer, target destinations, and a distance value. It returns a polygon that represents the area which a hospital has the potential to serve. When combined with 

### Unexpected Challenges

However, I have encountered many challenges in connecting the output of the distance matrix algorithm to the aggregate function outputting the product of the input and target weights, as well as experiencing some smaller technical issues in QGIS setting automatic "maximum" default values for λ, α, and β parameters. I know much of my model is unfinished, and as I work to fill in the gaps in the near future, I am certain I will encounter even more challenges I do not even know about yet.

![Model Diagram](/assets/model_diagram1.png)
*Model Diagram - to be updated*

This model was then used to combine a linear distance matrix and population data to determine hospital service areas, or HSAs, for the states of New England (this study also includes New York, Pennsylvania, and New Jersey). The final product may be found [here](file:///Users/nicholasnonnenmacher/Desktop/Nicholas'%20Documents/Middlebury%2020-21%20/Spring%202021/OpenSource%20GIS/nicknonnen.github.io/gravity/assets/qgis2web_2021_05_25-14_16_08_019603/index.html#6/42.585/-74.861), where these HSA catchment areas are then compared to those used by the [Dartmouth Health Atlas](https://data.dartmouthatlas.org/supplemental/#boundaries).


![HSA_comparisons](/assets/HSA_comparisons.png)
As seen more clearly in the Leaflet map


Thank you to Professor Joe Holler and my class peers in Spring 2021 GEOG 323 for assistance, conversations, and thoughts while deliberating this assignment.

Data Sources:
- Population data [by Joe Holler](/assets/netown.gpkg)
- Hospital Data: [Homeland Security](https://hifld-geoplatform.opendata.arcgis.com/datasets/6ac5e325468c4cb9b905f1728d6fbf0f_0)
- Dartmouth Atlas of Health Care [boundary files](https://atlasdata.dartmouth.edu/downloads/supplemental#boundaries)
