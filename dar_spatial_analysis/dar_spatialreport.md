---
layout: page
title: Spatial Urban Resilience Analysis in Dar es Salaam
---

**Spatial Urban Resilience Analysis in Dar es Salaam**

Produced by Nick Nonnenmacher

Created - `03/31/2021`
Revised - `04/13/2021`

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

The first step to this analysis was obtaining data from the Resilience Academy and OSM. Joe Holler, the professor of this class, had already obtained and downloaded Dar es Salaam ward and building data, which I accessed in PostGIS using the DB Manager tool in QGIS.

Next, I created new tables in my personal schema containing building and greenspace information. Since the only population data available at a reasonable scale was very dated, I used residential buildings as a proxy for population. To filter these buildings, I created a new table called darbuildings from the building field of the plant_osm_polygon layer taken from OSM, which contained over 1.3 million features. Isolating greenspace was a bit more difficult, because various attributes that couldhave been considered greenspace were scattered throughout multiple different fields in plant_osm_polygon. I ended up selecting specific attributes 'greenfield', 'park', 'grass', 'recreation ground', 'garden', 'wood', 'tree', 'beach', 'tree_row', and 'grassland' from three different fields: 'landuse', 'leisure', and 'natural'. Once I had isolated these attributes within their individual fields, I was able to combine the three subsequent tables into one 'greenspace' table containing points of each attribute. This table contained 356 rows.

```
Create new tables in personal schema

CREATE TABLE darbuildings AS
SELECT osm_id, st_transform(way,32737)::geometry(polygon,32737) as geom, name
FROM planet_osm_polygon
WHERE building ILIKE 'residential' OR 'yes';

/* this first table contains all the building attributes labeled "residential" or "YES" */

CREATE TABLE landusespace2 AS
SELECT osm_id, landuse, st_transform(way,32737)::geometry(polygon,32737) as geom, name
FROM planet_osm_polygon
WHERE landuse = 'greenfield' OR landuse = 'park' OR landuse = 'grass' OR landuse = 'recreation ground';

CREATE TABLE leisurespace AS
SELECT osm_id, leisure, st_transform(way,32737)::geometry(polygon,32737) as geom, name
FROM planet_osm_polygon
WHERE leisure = 'garden' OR leisure = 'park';

CREATE TABLE naturalspace AS
SELECT osm_id, "natural", st_transform(way,32737)::geometry(polygon,32737) as geom, name
FROM planet_osm_polygon
WHERE "natural" = 'wood' OR "natural" = 'tree' OR "natural" = 'beach' OR "natural" = 'tree_row' OR "natural" = 'grassland' OR "natural" = 'grass';
```

I used this query to search within the three fields that would contribute to the 'greenspace' table ('landuse', 'leisure', and 'natural'). The term *field1* represents the specific field I was searching in. This query helped me determine which attributes I should include in the three pull queries above. Unfortunately, I had to leave many attributes out of this analysis, and did not have an objective selection technique. Nearly 60 such attributes were therefore not included as greenspace in Dar es Salaam, and included such features as reefs, cemeteries, reservoirs, and farmland.

```
SELECT field1, count(osm_id) as n
FROM planet_osm_polygon
GROUP BY field1
ORDER BY n DESC;
```

Once the residential buildings and appropriate greenspace features had been isolated, I created the buffer zones around each greenspace point in the city. I chose the arbitrary distance of 500m to create these buffers. By dissolving overlapping buffers, I would later be able to calculate area and population density. This process resulted in 42 buffer features, from the 356 unique greenspace points.

```
CREATE TABLE greenspacecentroids AS
SELECT osm_id, st_centroid(geom)::geometry(point,32737) as geom from greenspace;

/* create centroids in each polygon attribute */

CREATE TABLE greenspacebuffer AS
SELECT osm_id, st_buffer(geom, 500)::geometry(polygon,32737) as geom from greenspacecentroids
UNION
SELECT osm_id, st_buffer(geom, 500)::geometry(polygon,32737) as geom from greenspace;

/* create buffers */

CREATE TABLE greenspacebufferdissolve AS
SELECT st_union(geom)::geometry(multipolygon,32737) AS geom
FROM greenspacebuffer;

/* dissolve into one layer */

CREATE TABLE greenspacebuffers AS
SELECT (st_dump(geom)).geom::geometry(polygon,32737)
FROM greenspacebufferdissolve;

/* multipart to single parts */

/* greenspacebuffers = 42 features */

ALTER TABLE greenspacebuffers ADD COLUMN id SERIAL PRIMARY KEY;

/* give each buffer a nuique id based off column number */
```

Next, I distinguished which buildings were inside and outside the buffer zones. It is immediately evident that many more buildings sit outside the buffer zones than inside.

```
ALTER TABLE darbuildings
ADD COLUMN greenbuffer

UPDATE darbuildings
SET greenbuffer = 1
FROM greenspacebuffers
WHERE st_intersects(darbuildings.geom, greenspacebuffers.geom);

SELECT greenbuffer, count(osm_id) as n
FROM darbuildings
GROUP BY greenbuffer
ORDER BY n DESC;

/*
now we explicitly know which buildings are within the buffer zones and which aren't
total features in darbuilings = 1,358,546
features within buffer zones = 266,142
features outside buffer zones = 1,092,527
*/
```

Then, I calculated the total city area inside each of the 42 buffer zones, and the total city area of each of the 95 individual city wards.

```
ALTER TABLE darbuildings
ADD COLUMN greenbuffer

UPDATE darbuildings
SET greenbuffer = 1
FROM greenspacebuffers
WHERE st_intersects(darbuildings.geom, greenspacebuffers.geom);

SELECT greenbuffer, count(osm_id) as n
FROM darbuildings
GROUP BY greenbuffer
ORDER BY n DESC;

/*
now we explicitly know which buildings are within the buffer zones and which aren't
total features in darbuilings = 1,358,546
features within buffer zones = 266,142
features outside buffer zones = 1,092,527
*/
```

Then, I calculated the area of the buffer zones and the city wards.

```
ALTER TABLE greenspacebuffers
ADD COLUMN area_km2_buffers real;

UPDATE greenspacebuffers
SET area_km2_buffers = st_area(geom) / 1000;

/* this will give us the area of each of the 42 buffer zones */

ALTER TABLE wards2
ADD COLUMN area_km2 real;

UPDATE wards2
SET area_km2 = st_area(utmgeom)/1000;

/* this will give us the area of each of the 95 city wards  */
```

The next step was the join the building points and buffer polygons. This was done with an intersect.

```
CREATE TABLE pop_density_green AS
SELECT
greenspacebuffers.id as id, greenspacebuffers.geom as geom1,
COUNT(darbuildings.greenbuffer) as total_ct
FROM greenspacebuffers
JOIN darbuildings
ON st_intersects(darbuildings.geom, greenspacebuffers.geom)
GROUP BY greenspacebuffers.id;
```

Now, I know the area in square kilometers and the number of buildings within the 42 buffer zones, contained in the 'pop_density_green' table, and the area in square kilometers and the number of buildings within the 95 city wards, contained in the 'wards2' table. It only takes a simple calculation from here to create a new population density column!

```
ALTER TABLE pop_density_green
ADD COLUMN density_inside real;

UPDATE pop_density_green
SET density_inside = pop_density_green.total_ct / pop_density_green.area_km2_inside;

ALTER TABLE wards2
ADD COLUMN percent_flooded real;

UPDATE ward_flood2
SET pop_density = wards2.totalpop / wards2.area_km2;
```

From here, I added the 'wards2' and 'pop_density_green' layers into a QGIS file and created a chloropleth map from the population density data (Figures 1 and 3). I also added the greenspace centroid points before buffers were added, to visualize where the urban green space actually is in the city in a separate map (Figure 2). An OSM Standard basemap was added to all three figures for easier viewing. Additionally, a Leaflet interactive map was created to better understand how population density changes in relation to ward and the presence of urban green spaces.

The .sql document containing all of my queries may be found [here](/dar_spatial_analysis/darspatialanalysisqueries.sql).
The initial SQL exercise studying Dar es Salaam flood risk conducted by Joe Holler and the Middlebury College spring 2021 GEOG 323 class may be found [here](/dar_spatial_analysis/osm_sql.sql).


## Results

Here is a map [summarizing population density distribution in relation to green space in Dar es Salaam.](/dar_spatial_analysis/assets/)

These results show that there is a general positive correlation between high-density wards and high-density buffer zones - implying urban green space does not significantly influence proximate population density. As seen in Figures 1 and 2, the highest-density wards are situated in the center of the city along the coastline, and overlap with the major cluster of urban green points. This is further supported in Figure 3, where the darkest-blue buffer zones are most represented in the same city center region.

There are a few notable exceptions to this pattern. A range of third-quintile buffer zones are found just to the northeast of the city center clusters, representing a noticeable beachfront community. More examples may be seen in the western-most wards of the city, where a few fourth- and third-quintile buffer zones linger even as the overall ward density drops to second- and first-quintiles.

![Figure 1. wards density](/dar_spatial_analysis/assets/warddensitymap2.png)
Figure 1. Population density by city ward in Dar es Salaam in 2018. Data obtained from Resilience Academy and OSM (Basemap: OSM).

![Figure 2. green space points](/dar_spatial_analysis/assets/greenspacepointsmap1.png)
Figure 2. Green space in Dar es Salaam in 2019, represented as points. Data obtained from Resilience Academy and OSM (Basemap: OSM).

![Figure 3. pop density in buffer zones](/dar_spatial_analysis/assets/bufferdensitymap1.png)
Figure 3. Population density by green space buffer zone in Dar es Salaam in 2019. Data obtained from Resilience Academy and OSM (Basemap: OSM).

In conclusion, the results of this analysis simply suggest that urban green space has been incorporated in regions of the city where population density is already high. Past studies have demonstrated there may be direct and indirect human health benefits to increasing the abundance of nature and natural places in modern urban space (van Leeuwen, Nijkamp, and de Norohna Vaz 2011, Lee and Maheswaran 2011, De Ridder et al 2004), and this may prove even more significant in rapidly-developing cities such as Dar es Salaam. Green spaces have been shown to provide cooling effects in dense urban centers, enhance local air quality, and even improve the use of nearby farmland (van Leeuwen, Nijkamp, and de Norohna Vaz 2011). As Dar es Salaam continues to grow in size and population over the next decade, pointed effort must be devoted to the city's infrastrcture and use of natural resources in order to provide a safe and healthy economic and cultural hub for Tanzania and east Africa.

## Acknowledgements

Thank you to Professor Joe Holler of Middlebury College for organizing this exercise and providing easily-accessible data and SQL exercises to aid myself and my GEOG 323 classmates in completing our analyses. Thank you also to my classmates for their help during this analysis. In addition, map data featured in this analysis is provided by OSM and the many users who contribute to it.

## References

De Ridder, K., Adamec, V., Bañuleos, A., Bruse, M., Bürger, M., Damsgaard, O., Dufek, J., Hirsch, J., Lefebre, F., Pérez-Larcorzana, J.M., Thierry, A., and C. Weber. 2004. An integreated methodology to assess the benefits of urban green space. Science of the Total Environment 334-335:489-497. [https://doi.org/10.1016/j.scitotenv.2004.04.054](https://doi.org/10.1016/j.scitotenv.2004.04.054)

Lee, A.C.K. and R. Maheswaran. 2011. The health benefits of urban green spaces: a review of the evidence. Journal of Public Health 33(5):212-222. [https://doi.org/10.1093/pubmed/fdq068](https://doi.org/10.1093/pubmed/fdq068)

Schuurman, N. 2008. Database Ethnographies Using Social Science Methodologies to Enhance Data Analysis and Interpretation. Geography Compass 2 (5):1529–1548. [https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1749-8198.2008.00150.x](https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1749-8198.2008.00150.x)

van Leeuwen, E., Nijkamp, P., and T. de Norohna Vaz. 2011. The multifunctional use of urban green space. International Journal of Agricultural Sustainability 8(1-2):20-25. [https://doi.org/10.3763/ijas.2009.0466](https://doi.org/10.3763/ijas.2009.0466)
