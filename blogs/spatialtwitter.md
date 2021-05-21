---
layout: page
title: Spatial Data Analysis with Twitter
---

In “Spatial, temporal, and content analysis of Twitter for wildfire hazards” (Wang et al. 2016), social media data scraped from Twitter was analyzed to determine if such real-time, on-the-ground, user-input data sources could accurately characterize natural disasters such as wildfires. A Twitter API was used to scrape, which the team conducted in two phases: the first focused on the keywords “fire” and “wildfire” while the second focused on specific wildfires and added keywords “San Marcos” and “Bernardo” - two words selected randomly from a list. This two-phase approach allowed the researchers to first collect information about general wildfires, and then about specific disaster events; this in turn allowed the researchers to analyze multiple dimensions *and* investigate the impact of geography on the spatial distribution of people’s responses. Once this data was collected, the team used a kernel-density estimation to analyze the spatial pattern of tweets, text mining to identify conversational topics, and social network analysis to detect major sources of news and opinions during disaster events (Wang et al. 2016).

The paper contains relatively-accessible figures, which display the information collected in a decent way but not particularly elegantly. I particularly think Figures 3 and 6 could be improved with more accurate spatial location data, to represent where people lived within town boundaries instead of representing total population aggregated around the centroid. It is also important to note that this was how population was further *analyzed* - this suggests some errors could exist in the overall report. Figure 10 is particularly engaging, and its accessibility is greatly improved by the short paragraph of text at the end of Section 4.

Based on how data was collected, and the relative clarity of Wang et al.’s methodology, I would consider this paper to be replicable, according to the definition set forth by the National Academies of Sciences, Engineering and Medicine. The keywords used, the temporal range investigated, and the software applied are all available in the paper, and with a certain degree of skill, a geospatial researcher could very feasibly find a similar disaster event, set a similar timeframe, and produce similar results. Furthermore, I think this replicability lends strong support to the author's overarching motive for conducting their study: to test if big data sets collected from social media sites such as Twitter can be effectively used for scientific research. I hesitate to call this paper totally reproducible because of the time-sensitive nature of scraping Twitter data from free API sources.

References:

National Academies of Sciences, Engineering, and Medicine. 2019. Reproducibility and Replicability in Science. Washington, D.C.: National Academies Press. [DOI: 10.17226/25303](https://www.nap.edu/catalog/25303/reproducibility-and-replicability-in-science)

Wang, Z., X. Ye, and M. H. Tsou. 2016. Spatial, temporal, and content analysis of Twitter for wildfire hazards. [Natural Hazards 83 (1):523–540.](https://github.com/GIS4DEV/literature/blob/master/Spatial%20%2C%20temporal%20%2C%20and%20content%20analysis%20of%20Twitter.pdf)

Submitted May 03, 2021
