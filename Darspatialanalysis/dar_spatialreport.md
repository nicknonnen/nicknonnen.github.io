---
layout: page
title: Spatial Urban Resilience Analysis in Dar es Salaam
---

**Spatial Urban Resilience Analysis in Dar es Salaam**

Produced by Nick Nonnenmacher

Created - `03/31/2021`
Revised - `04/12/2021`

```
Lab report should include:
1 - question
2 - data, data citations, data descriptions (ethnography)
3 - methods (verbal description of analysis with SQL code blocks, with sufficient explanation and detail to be reproduced)
4 - Results (interpretation, with link to Leaflet map and any static maps)
```

## Background Question

Understanding and improving urban resilience around the world is paramount in preparing human population hubs for changing climates in the near future. In this analysis, I implemented SQL queries in PostGIS to analyze and better understand certain aspects of urban resilience in the eastern African city of Dar es Salaam, Tanzania. I was interested in how urban green space affected population spatial distribution, so my guiding question was, "is population density greater in areas closer to urban green space compared to farther away?"


## Data

The data for this exercise was obtained from [Open Street Map (OSM)](https://www.openstreetmap.org/#map=15/44.0703/-73.1703) and the [Resilience Academy](https://resilienceacademy.ac.tz).

OSM is an open source public mapping effort aimed at creating accessible and accurate mapping data all over the world. Data is contributed by local parties and may be of any type. OSM data is tagged with a timestamp and username, and so it appears much of the data used in this analysis was contributed by members of [Ramani Huria](https://ramanihuria.org/en/), a local Dar es Salaam mapping effort focused on collecting flood data and improving the city's flood resilience.

[Ramani Huria](https://ramanihuria.org/en/) itself is just one initiative of the larger organization the [Resilience Academy](https://resilienceacademy.ac.tz), a program bringing together five academic institutions in Tanzania and Finland in order to improve social capacity to tackle changing climate and urban challenges. Resilience Academy is providing inclusive and comprehensive mapping and digital knowledge, skills, and tools to students and partners, with the aim of improving urban planning and design, climate response models and practices, and infrastructure for developing cities in Tanzania and beyond.

Specific data used in this analysis includes:
- [wards](https://geonode.resilienceacademy.ac.tz/layers/geonode_data:geonode:dar_es_salaam_administrative_wards): adminstrative wards in Dar es Salaam, 2018
- [landuse](https://geonode.resilienceacademy.ac.tz/layers/geonode_data:geonode:dar_es_salaam_open_areas0): land use in Dar es Salaam, 2019
- [buildings](https://geonode.resilienceacademy.ac.tz/layers/geonode_data:geonode:building_thumnails_2): buildings in Dar es Salaam, 2019


## Methods

This exercise was as much an exercise in SQL literacy and open-source science as an analysis in urban resilience. Therefore, extra effort has been allocated into developing an accessible and reproducible workflow that can be replicated in PostGIS - using the [OSM2PGSQL tool](https://ramanihuria.org/en/) - and used as an effective SQL teaching mechanism.

The first step to this analysis was obtaining data from the Resilience Academy ...

Next, I created new tables in my personal schema containing building and greenspace information. talk about what I considered greenspace

Then, I created the buffer zones around each greenspace point in the city. I chose the arbitrary distance of 500m to create these buffers.

Next, I distinguished which buildings were inside and outside the buffer zones.

Then, I calculated the total city area inside each of the 42 buffer zones.

Next, I joined the building points and polygons, 

## Results

Here is a map [summarizing population density distribution in relation to green space in Dar es Salaam.](/Darspatialanalysis/assets/)

These results show that there is a general positive correlation between high-density wards and high-density buffer zones - implying urban green space does not significantly influence proximate population density. As seen in Figures 1 and 2, the highest-density wards are situated in the center of the city along the coastline, and overlap with the major cluster of urban green points. This is further supported in Figure 3, where the darkest-blue buffer zones are most represented in the same city center region.

There are a few notable exceptions to this pattern. A range of third-quintile buffer zones are found just to the northeast of the city center clusters, representing a noticeable beachfront community. More examples may be seen in the western-most wards of the city, where a few fourth- and third-quintile buffer zones linger even as the overall ward density drops to second- and first-quintiles.

In conclusion, the results of this analysis simply suggest that urban green space has been incorporated in regions of the city where population density is already high. ***add bit about why urban green space is beneficial here to polish off this section***

![Figure 1. wards density](/Darspatialanalysis/assets/warddensitymap2.png)
Figure 1. Population density by city ward in Dar es Salaam in 2018. Data obtained from Resilience Academy and OSM (Basemap: OSM).

![Figure 2. green space points](/Darspatialanalysis/assets/greenspacepointsmap1.png)
Figure 2. Green space in Dar es Salaam in 2019, represented as points. Data obtained from Resilience Academy and OSM (Basemap: OSM).

![Figure 3. pop density in buffer zones](/Darspatialanalysis/assets/bufferdensitymap1.png)
Figure 3. Population density by green space buffer zone in Dar es Salaam in 2019. Data obtained from Resilience Academy and OSM (Basemap: OSM).

## References

Schuurman, N. 2008. Database Ethnographies Using Social Science Methodologies to Enhance Data Analysis and Interpretation. Geography Compass 2 (5):1529–1548. [https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1749-8198.2008.00150.x](https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1749-8198.2008.00150.x)

ABSTRACT

Placement of solid waste sites near water transmission features (“waterways”) such as rivers, streams, canals, drains, and ditches can lead to flooding during rain events if these waste collections block water transmission and egress. Not only can this result in flooding, but it can also lead to increased contact between humans and pathogens, toxins, and other environmental hazards. In this analysis we identify waste collection sites within 50 meters of water transmission features as potentially dangerous waste sites and calculate the density of dangerous waste sites for each ward in Dar es Salaam to identify spatial distribution of environmental vulnerability.
