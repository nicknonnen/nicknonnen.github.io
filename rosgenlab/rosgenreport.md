---
layout: page
title: RE- Replication of Rosgen Stream Classification
---


**Replication of**
# A classification of natural rivers

Original study *by* Rosgen, D. L.
*in* *CATENA* 22 (3):169–199. https://linkinghub.elsevier.com/retrieve/pii/0341816294900019.

and Replication by: Kasprak, A., N. Hough-Snee, T. Beechie, N. Bouwes, G. Brierley, R. Camp, K. Fryirs, H. Imaki, M. Jensen, G. O’Brien, D. Rosgen, and J. Wheaton. 2016. The Blurred Line between Form and Process: A Comparison of Stream Channel Classification Frameworks ed. J. A. Jones. *PLOS ONE* 11 (3):e0150293. https://dx.plos.org/10.1371/journal.pone.0150293.

Replication Authors:
Nick Nonnenmacher, Zach Hilgendorf, Joseph Holler, and Peter Kedron.

Replication Materials Available at: [github repository name](github repository link)

Created: `21 March 2021`
Revised: `25 March 2021`

## Introduction and Motivation

Briefly describe the original analysis – type of study, research design, analytical approach, and results; motivation of the replication; and outline of the replication study

Understanding river dynamics and morphology is crucial to further understanding how a system influences and interacts with surrounding environments. Through a classification system such as the Rosgen Classification of Natural Rivers, these dynamics can be better studied and researchers can more accurately and effectively predict, manage, and conserve environments within and adjacent to river systems.

This report stems from the original 1994 study ***A classification of natural rivers*** by Rosgen, which established a classification hierarchy with 7 major categories from A to G. Rosgen's motivation for this system was to aid river restoration, engineering, and conservation, as well as help predict oft-erratic future behavior with higher accuracy. That study was then replicated by Kasprack et al in 2016, in the report ***The blurred line between form and process: A comparison of stream channel classification frameworks***. In this replication, Kasprack aimed to identify weaknesses in four different river classification models (Rosgen, the River Styles Framework, the Natural Channels Classification, and Channel-form Based Statistical Classifications) in the same place - the John Day Watershed in eastern Oregon. Kasprack concluded the four schemes were largely consistent.

This study is a replication of Kasprack's analysis, with the goal of reproducing results using Rosgen's classification scheme, open-source GIS software, and the same data sets, to test to what extent such a river classification study is possible without any field aspect, and without oversimplifying our conclusions.


## Procedure and Data

Describe how the replication study will be implemented and identify any materials and procedures used to complete the replication.
1.	For computational studies include information about the hardware and software environments of both the original study and the replication attempt.

Protocol: Explain how the analysis of the replication will proceed and identify if the analysis plan will match the original study. For many replications this section may be quite short if the procedures used in the original analyses are followed closely. In those cases, this section can simply explain how key elements will be followed.

Differences from the Original Study: Identify any ways in which the replication is planned to depart from the original study -- a) location, b) sampling, c) data, d) measures/variable construction, d) analytical techniques.
1.	Provide the motivation for each change that is made to the original study.
2.	State how the differences identified above may influence the expected size/direction of the effect of the original study
3.	List any testable hypotheses associated with each change. If a hypothesis is directional, state the direction
4.	Outline any initial analyses that were taken to assess whether the differences identified above will influence the outcome of the replication attempt.

Assessment Criteria: Identify the criteria that will define whether the replication attempt was successful (e.g., matched statistical significance, direction of effect, similar magnitude of effect)
- Reproducible documentation of methods, where documentation includes:
- Annotated flowchart of final parameter values (use last page of RSC_EPA_2005 PDF)

#### Data
>> CHamPS (Columbia Habitat Monitoring Program) [data]()
>> John Day Watershed Digital Elevation Model [data]()

#### Procedure
The purpose of this study was to replicate Kasprak's analysis to determine if the methodology was reproducible and viable. Therefore, the procedure for this project follows exactly or very closely that of Kasprak's, and focuses on study sites within the John Day Watershed. This replication effort was distributed across all students in Joe Holler's spring 2021 GEOG 323 Open Source GIScience, and the analysis in this document focuses specifically on study site 25 (loc_id = 25).

All procedures, code, and material for this study can be found [here](https://github.com/nicknonnen/RE-rosgen), in my individual RE-Rosgen repository.

Detailed procedures for the GRASS analysis may be found [here](https://github.com/nicknonnen/RE-rosgen/blob/main/docs/instruction/instructor_materials/1-Research_Protocol_GRASS.docx).
The code for R Studio analysis may be found [here]().

First, a GIS analysis of the data was conducted in GRASS. Models were used for [visualizing data](https://github.com/emmab725/RE-rosgen/blob/main/procedure/code/visualize.gxm) in GRASS and [calculating centerlines](https://github.com/emmab725/RE-rosgen/blob/main/procedure/code/center_line_length_no_clip.gxm) of rivers at each study site, eliminating [steps]() in section 1.3 and 2.2 respectively.

Next, a cross-sectional graph, longitudinal profile, and flood-prone width profile were constructed in R Studio, following [this R markdown document](https://github.com/nicknonnen/RE-rosgen/blob/main/docs/instruction/instructor_materials/1-Research_Protocol_GRASS.docx). From these results, Tables 1, 2, and 3 were populated, and Rosgen Level I and Level II classifications were determined (see Tables in the Results and Discussion section).

Some deviations from Kasprak's methodology were observed during this study. Beyond using the models noted above to replace sections of workflow, slope as seen in Table 3 was recalculated. While the R Markdown file code calculated slope between every 1-meter point and then averaged that value, this study defined slope as the difference in elevation over the length of the river segment contained within the location buffer.

This assessment will be deemed successful if, based on the analysis conducted and measurement calculated, the same Rosgen classification code is applied to this river system segment as in Kasprak's study.

![Rosgen Classification Guide](/assets/RosgenScreenshot.png)


## Replication Results

For each hypothesis examined, present separately the results of the replication attempt.
1.	Briefly describe how the replication protocol outlined above was implemented reporting key information (e.g., sample size).
2.	State whether the original hypothesis was or was not supported by the replication
   - Provide key statistics produced by the replication.
   - Provide key measures (e.g., matching effect direction/size, significance) used to make the decision.
   - Highlight any contradictory results with a brief explanation
3.	State whether any hypothesis linked to a planned deviation from the original study was supported. Provide key statistics and related reasoning.

Figures to Include:
- map of the study site shaded elevation
- map of the study site slope
- Map of the study site stream/river centerlines and final mean centerline
- Map of the study site valley centerlines and final mean centerline
- Longitudinal profile graph with elevation and slope
- Cross-sectional profile graph

Tables to Include:

Table 1. Site Measurements
| Variable | Value | Source |
| :-: | :-: | :-: |
| Bankfull Avg Width | 4.637 | CHaMP Data |
| Bankfull Avg Depth | 0.238 | CHaMP Data |
| Bankfull Max Depth | 0.627 | CHaMP Data |
| Valley Width | 85 | Terrain Cross-Section in R |
| Valley Depth | 3 | Terrain Cross-Section |
| Stream/River Length | 208.993 | CHaMP Data |
| Valley Length | 197.033 | CHaMP Data |
| Median Channel Material Particle Diameter | 59 | CHaMP Data |

Table 2. Rosgen Level I Classification
| Criteria | Value |
| :-: | :-: |
| Entrenchment Ratio | 18.331 |
| Width / Depth Ratio | 19.483 |
| Sinuosity | 1.061 |
| Level I Stream Type | C |

Table 3. Rosgen Level II Classification
| Criteria | Value |
| :-: | :-: |
| Slope | 0.0167 |
| Channel Material | Gravel |
| Level II Stream Type | C4 |


## Unplanned Deviations from the Protocol

In order to initially install the required add-ons in GRASS on MacOS, XCode Command Line Tools had to be installed from the Apple Developers Library. More information on this issue and how to overcome may be found [here](https://github.com/GIS4DEV/RE-rosgen/issues/2). In addition, in order to open certain data it was necessary to install [The Unarchiver application](https://theunarchiver.com). Finally, as mentioned in the **Procedure and Data** section above, slope was recalculated as the difference in elevation over length of the river contained in the loc_id = 25 study site.

## Discussion

Provide a summary and interpretation of the key findings of the replication *vis-a-vis* the original study results. If the attempt was a failure, discuss possible causes of the failure. These may include:
- Practical Causes – related to lack of data, code, details in the original analysis
- Informative Causes – related to absence of effect, change in population, or location.

Discuss an interpretation of your results.
- Were the Level I and Level II results internally and logically consistent? That is, did all the parameters for the identified stream type conform to expectations outlined in Rosgen?
- Were your results consistent with previous evaluations of the same stream reach reported by Kasperak et al?

Discuss a response to the following prompt: Quantifying uncertainty in geomorphic systems and in GIScience is of paramount importance, not only for creating error bars on a graph, but for realistically communicating the reliability and legitimacy of an output dataset. Error bars do not (necessarily) reflect on the researcher. They stem from collection constraints, processing constraints, subjective decision making, and many, many more sources. Given what you have learned in this module, discuss at least three sources of error and uncertainty and how they could impact the classification of your stream. Where does uncertainty stem from? Why is uncertainty a problem? What could be done (or has been done) to fix or reduce uncertainty? In a perfect world, how could this uncertainty be removed?

## Conclusion

Restate the key findings and discuss their broader societal implications or contributions to theory.
Do the research findings suggest a need for any future research?

## References

Kasprak, A., N. Hough-Snee, T. Beechie, N. Bouwes, G. Brierley, R. Camp, K. Fryirs, H. Imaki, M. Jensen, G. O’Brien, D. Rosgen, and J. Wheaton. 2016. The blurred line between form and process: A comparison of stream channel classification frameworks ed. J. A. Jones. PLOS ONE 11 (3):e0150293. [https://dx.plos.org/10.1371/journal.pone.0150293](https://dx.plos.org/10.1371/journal.pone.0150293).

Rosgen, D. L. 1994. A classification of natural rivers. CATENA 22 (3):169–199. [https://linkinghub.elsevier.com/retrieve/pii/0341816294900019](https://linkinghub.elsevier.com/retrieve/pii/0341816294900019).

####  Report Template References & License

This template was developed by Peter Kedron and Joseph Holler with funding support from HEGS-2049837. This template is an adaptation of the ReScience Article Template Developed by N.P Rougier, released under a GPL version 3 license and available here: https://github.com/ReScience/template. Copyright © Nicolas Rougier and coauthors. It also draws inspiration from the pre-registration protocol of the Open Science Framework and the replication studies of Camerer et al. (2016, 2018). See https://osf.io/pfdyw/ and https://osf.io/bzm54/

Camerer, C. F., A. Dreber, E. Forsell, T.-H. Ho, J. Huber, M. Johannesson, M. Kirchler, J. Almenberg, A. Altmejd, T. Chan, E. Heikensten, F. Holzmeister, T. Imai, S. Isaksson, G. Nave, T. Pfeiffer, M. Razen, and H. Wu. 2016. Evaluating replicability of laboratory experiments in economics. Science 351 (6280):1433–1436. https://www.sciencemag.org/lookup/doi/10.1126/science.aaf0918.

Camerer, C. F., A. Dreber, F. Holzmeister, T.-H. Ho, J. Huber, M. Johannesson, M. Kirchler, G. Nave, B. A. Nosek, T. Pfeiffer, A. Altmejd, N. Buttrick, T. Chan, Y. Chen, E. Forsell, A. Gampa, E. Heikensten, L. Hummer, T. Imai, S. Isaksson, D. Manfredi, J. Rose, E.-J. Wagenmakers, and H. Wu. 2018. Evaluating the replicability of social science experiments in Nature and Science between 2010 and 2015. Nature Human Behaviour 2 (9):637–644. http://www.nature.com/articles/s41562-018-0399-z.
