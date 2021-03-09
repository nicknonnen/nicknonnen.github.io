---
layout: page
title: Gravity Model Spatial Interaction
---

Updated 03/08/2021 9:00pm

For this assignment, I created a [Gravity Model of Spatial Interaction](https://transportgeography.org/contents/methods/spatial-interactions-gravity-model/) to illustrate the potential interactions between two places.

In this lab, I'm using this model to determine the service area "catchment" areas for hospitals in the Northeast US. The model uses three variables to calculate potential interaction: the "weight" of the input, the "weight" of the target, and the distance between the input and the target. The potential for interaction is based on values of the weights multiplied together and the divided by the distance, to produce the equation

((InputWeight)^λ * (TargetWeight)^α) / (Distance)^β

All three exponent parameters, λ, α, and β, are modifiable by the user of the model. The β parameter is set to a default value of 2, due to the more significant influence distance has on the interaction of two points in space, while parameters λ and α are set to a default value of 1.

In this exercise, I analyzed the interactions of towns and hospital clusters in the Northeast US and then compared those catchment areas to the those of the Dartmouth Health Atlas.

![Gravity Spatial Model Workflow 1](/assets/workflow1.3)
*Gravity Model Spatial Interaction Workflow - to be updated*

Model so far

Challenges:
- max values appearing for alpha, beta, lamda
- unable to calculate "sum(attribute(@InputWeight), @TargetID)" in aggregate function
- overall, model not functioning with current workflow


Check back soon for a completed model, data sources, and accompanying map of hospital catchment areas.

Data:
- add data here
