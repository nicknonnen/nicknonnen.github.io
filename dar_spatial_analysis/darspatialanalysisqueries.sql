**Queries for Spatial Urban Resilience Analysis in Dar es Salaam**

Nick Nonnenmacher
Created 03/31/2021
Revised 04/__/2021



ABSTRACT

Placement of solid waste sites near water transmission features (“waterways”) such as rivers, streams, canals, drains, and ditches can lead to flooding during rain events if these waste collections block water transmission and egress. Not only can this result in flooding, but it can also lead to increased contact between humans and pathogens, toxins, and other environmental hazards. In this analysis we identify waste collection sites within 50 meters of water transmission features as potentially dangerous waste sites and calculate the density of dangerous waste sites for each ward in Dar es Salaam to identify spatial distribution of environmental vulnerability.

Goal: Compare population density (using buildings as a proxy) inside and outside buffer zones surrounding urban green space within Dar es Salaam

Data:
- obtained from the Resilience Academy
- include more fleshed out data ethnography There

Procedure:

Create new tables in 'nick' schema

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

/* these three tables contain all the attributes from various fields that count as green space, according purely to my interpretation */

/*

include query here to see all of the attributes in these fields, to document which ones I did not included:

SELECT field1, count(osm_id) as n
FROM planet_osm_poly
GROUP BY field1
ORDER BY n DESC;

*/

CREATE TABLE greenspace AS
SELECT osm_id, geom, name FROM landusespace2
UNION
SELECT osm_id, geom, name FROM leisurespace
UNION
SELECT osm_id, geom, name FROM naturalspace;

/* this query joins the three green space tables into one */

2. Create a buffer around each attribute in greenspace

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

3. UPDATE darbuildings table to define those points within buffer zones

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

4. Calculate area inside and outside buffer zones

ALTER TABLE greenspacebuffers
ADD COLUMN area_km2_buffers real;

UPDATE greenspacebuffers
SET area_km2_buffers = st_area(geom) / 1000;

/* one more query / set of queries to get area outside the buffer zones */

5. Join the building points and area polygons

/*
first step: spatial join btw points and polygons
- points are in c.greenbuffer FROM t.darbuildings WHERE greenbuffer = 1.0
- polygons are in t.greenspacebuffers, c.area_km2_buffers (42 features)
second step: group the results of the spatial join by the polygons while counting

1) spatially joining the polygon name / ID to the points

2) grouping the points by that polygon name/ID while counting

3) joining the count back onto the polygons

# Count how many residential buildings are in each subward

CREATE TABLE subwards_join AS
SELECT
ds_subwards.fid as fid, ds_subwards.ward_name as ward_name, ds_subwards.geom as geom1,
COUNT(osm_id) as total_ct
FROM ds_subwards
JOIN res_union
ON ST_Intersects(ds_subwards.geom, res_union.geom)
GROUP BY ds_subwards.fid, ds_subwards.ward_name

# Populate geometry column, Add primary key, Create spatial index
SELECT populate_geometry_columns('public.subwards_join'::regclass);
ALTER TABLE subwards_join ADD PRIMARY KEY (fid)
*/

CREATE TABLE pop_density_green AS
SELECT
greenspacebuffers.id as id, greenspacebuffers.geom as geom1,
COUNT(darbuildings.greenbuffer) as total_ct
FROM greenspacebuffers
JOIN darbuildings
ON st_intersects(darbuildings.geom, greenspacebuffers.geom)
GROUP BY greenspacebuffers.id;


6. Update tables to contain pop density calculations

/* now, join in buffer area measurements */

ALTER TABLE pop_density_green
ADD COLUMN area_km2_inside real;

UPDATE pop_density_green
SET area_km2_inside = greenspacebuffers.area_km2_buffers
FROM greenspacebuffers
WHERE pop_density_green.id = greenspacebuffers.id;

/* now we have are area of each buffer zone AND the number of buildings within each buffer zone in the same table */

ALTER TABLE pop_density_green
ADD COLUMN density_inside real;

UPDATE pop_density_green
SET density_inside = pop_density_green.total_ct / pop_density_green.area_km2_inside;

/* this column gives us the population desnity within each buffer zone */


7. Find pop density by ward

/* won't get pop and area outside buffer zones, just pop and area of whole ward zones */

ALTER TABLE wards2
ADD COLUMN percent_flooded real;

UPDATE ward_flood2
SET pop_density = wards2.totalpop / wards2.area_km2;

/* end goal: visualize pop density inside buffer zones by zone as one color gradient, and outside buffer zones by ward as another color gradient */

8. Ratio of houses near green space vs far away by ward

/* find ratio of buildings close to green space vs distant from green space */

/* two parts to this info: greenbuffer (1 if its close to green space) AND which ward the building is in -- sum greenbuffer by ward */

/*
CREATE TABLE popo_density_green AS
SELECT
greenspacebuffers.id as id, greenspacebuffers.geom as geom1,
COUNT(darbuildings.greenbuffer) as total_ct
FROM greenspacebuffers
JOIN darbuildings
ON st_intersects(darbuildings.geom, greenspacebuffers.geom)
GROUP BY greenspacebuffers.id;
*/

ALTER TABLE wards2
ADD COLUMN buffer_buildings real;

UPDATE wards2
SET buffer_buildings = darbuildings.greenbuffer
FROM darbuildings
WHERE wards2.utmgeom = darbuildings.geom;


/* now calculate ratio */

ALTER TABLE wards2
ADD COLUMN ward_ratio real;

UPDATE wards2
SET ward_ratio = wards2.buffer_buildings / wards2.totalpop;
