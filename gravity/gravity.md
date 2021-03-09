---
layout: page
title: Gravity Model Spatial Interaction
---

Updated 03/08/2021 9:00pm

For this assignment, I created a [Gravity Model of Spatial Interaction](https://transportgeography.org/contents/methods/spatial-interactions-gravity-model/) to illustrate the potential interactions between two places.

In this lab, I'm using this model to determine the service area "catchment" areas for hospitals in the Northeast US. The model uses three variables to calculate potential interaction: the "weight" of the input, the "weight" of the target, and the distance between the input and the target. The potential for interaction is based on values of the weights multiplied together and the divided by the distance, to produce the equation

**((InputWeight)^λ * (TargetWeight)^α) / (Distance)^β**

All three exponent parameters, λ, α, and β, are modifiable by the user of the model. The β parameter is set to a default value of 2, due to the more significant influence distance has on the interaction of two points in space, while parameters λ and α are set to a default value of 1.

In this exercise, I analyzed the interactions of towns and hospital clusters in the Northeast US and then compared those catchment areas to the those of the Dartmouth Health Atlas.

![Gravity Spatial Model Workflow 1](/assets/workflow1.3.png)
![Gravity Spatial Model Workflow 2](/assets/workflow1.4.png)
*Gravity Model Spatial Interaction Workflow - to be updated*

So far, my model may accept an input layer, target destinations, and a distance value. However, I have encountered many challenges in connecting the output of the distance matrix algorithm to the aggregate function outputting the product of the input and target weights, as well as experiencing some smaller technical issues in QGIS setting automatic "maximum" default values for λ, α, and β parameters. I know much of my model is unfinished, and as I work to fill in the gaps in the near future, I am certain I will encounter even more challenges I do not even know about yet.

![Model Diagram](/assets/model_diagram1.png)

Check back in shortly to view my completed Gravity Model and Spatial Analysis of hospital catchments in the Northeast US. The next steps of this assignment involve creating a model to preprocess hospital data (sourced from the Department of Homeland Security), grouping the remaining hospitals by town (sourced from the American Community Survey 2018 5-year, provided by Joe Holler), and running the spatial interaction model. This spatial interaction will then be displayed in a map format and compared to a hospital service area visualization by the the Dartmouth Health Atlas.

Thank you to Professor Joe Holler and my class peers in Spring 2021 GEOG 323 for assistance, conversations, and thoughts while deliberating this assignment.

Data Sources:
- Hospital Data: [Homeland Security](https://hifld-geoplatform.opendata.arcgis.com/datasets/6ac5e325468c4cb9b905f1728d6fbf0f_0)
- Dartmouth Atlas of Health Care [boundary files](https://atlasdata.dartmouth.edu/downloads/supplemental#boundaries)
