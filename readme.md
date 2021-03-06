# PostGIS/CartoDB reference

### PostGIS Reference

[http://postgis.net/docs/reference.html](http://postgis.net/docs/reference.html)

### SQL Reference

[http://www.w3schools.com/sql/default.asp](http://www.w3schools.com/sql/default.asp)


### List all tables in CartoDB acccount
From [StackExchange](http://gis.stackexchange.com/questions/94066/get-list-of-all-tables-in-cartodb-account-with-sql-statement)

	SELECT * FROM CDB_UserTables()
	
	
### Time add time to cols

https://www.postgresql.org/docs/8.0/static/functions-datetime.html
	
### Drop tables
[SQL Drop Table](http://www.1keydata.com/sql/sqldrop.html)
	
The syntax for DROP TABLE is,

	DROP TABLE "table_name";

Drop Multiple Tables At The Same Time

It is possible to drop more than one table at a time. To do that, list the names of all the tables we wish to drop separated by comma after DROP TABLE. For example, if we want to drop the User_Details table and the Job_List table together, we can issue the following SQL statement:

	DROP TABLE User_Details, Job_List;


### Spatially Enable Database

	CREATE EXTENSION postgis;	

From [Spatially enabled Postgres database](http://gis.stackexchange.com/questions/29759/spatially-enabled-postgres-database)

## Drop Multiple Columns
http://www.w3schools.com/sql/sql_alter.asp
http://stackoverflow.com/questions/6346120/how-do-i-drop-multiple-columns-with-a-single-alter-table-statement

	ALTER TABLE table_name DROP COLUMN column_name1, DROP COLUMN column_name2;

### Add column, Sum column

	ALTER TABLE chicago_census_tracts_2010_vars ADD COLUMN pop_children_0_18 FLOAT

	UPDATE chicago_census_tracts_2010_vars SET pop_children_0_18 = (b01001_003 + b01001_004 + b01001_005 + b01001_006 + b01001_007  + b01001_027  + b01001_028  + b01001_029  + b01001_030  + b01001_031)

## Merge Multiple Tables

[Merge Multiple Tables StackExchange](http://gis.stackexchange.com/questions/27402/merge-multiple-tables-into-a-new-table-in-postgis)

(Pre-flight-check: are attributes identical in all original tables? Is the geometry type exactly the same in all tables?)

You can either

create the (empty) table first, then use INSERT INTO...SELECT... FROM to get all the data from each of the original tables into the merged one.
Create the new table from one big UNION statement.

For 1 it might go:

	CREATE TABLE merged (id serial primary key, attrib1 integer, attrib2 varchar(15),....);
	SELECT AddGeometryColumn('merged','geom',<SRID>,'<FEATURE_TYPE>,'XY');
	INSERT INTO merged (attrib1, attrib2, ...., geom) SELECT attribA, attribB,...,geom FROM table_1;
	INSERT INTO merged (attrib1, attrib2, ...., geom) SELECT attribA, attribB,...,geom FROM table_2;

and so on...

For option 2:

	CREATE TABLE merged AS( 
	SELECT attribA, attribB,...,geom FROM table_1
	UNION 
	SELECT attribA, attribB,...,geom FROM table_2
	UNION
	.... 
	);
	SELECT Populate_Geometry_Columns('merged'::regclass);
	
	ALTER TABLE {new_tablename} DROP COLUMN cartodb_id

	SELECT cdb_cartodbfytable(‘{username}’, ‘{new_tablename}’);

### Select by Date Time Range
[Specific Time Range Query in SQL Server](http://stackoverflow.com/questions/885188/specific-time-range-query-in-sql-server)

	SELECT * FROM MyTable WHERE datecolumn > '3/1/2009' AND datecolumn <= '3/31/2009'

### Making Lines from Points
[http://blog.cleverelephant.ca/2015/03/making-lines-from-points.html](http://blog.cleverelephant.ca/2015/03/making-lines-from-points.html)

Suppose you have a GPS location table:

* gps_id: integer
* geom: geometry
* gps_time: timestamp
* gps_track_id: integer

You can get a correct set of lines from this collection of points with just this SQL:

	SELECT
	  gps_track_id,
	  ST_MakeLine(geom ORDER BY gps_time ASC) AS geom
	FROM gps_poinst
	GROUP BY gps_track_id

### Making Points from Lines

#### Split at pre-determined distance
[Create a point on a line after a specific distance from startpoint](http://gis.stackexchange.com/questions/122373/create-a-point-on-a-line-after-a-specific-distance-from-startpoint)

Your friend here is ST_LineInterpolatePoint. Look here for more information: http://postgis.net/docs/ST_Line_Interpolate_Point.html.

You have to compute the right fraction to get your 10 metres. So this is done with this little calculcation:

	10 metres = ST_Length(the_line) * fraction 
	fraction = 10 metres / ST_Length(the_line)
So the result is (like the other posts described):

	ST_LineInterpolatePoint(the_geom, 10 / ST_Length(the_line))
Watch out the coordinate system you use so the 10 is 10 metres indeed.

IMPORT/EXPORT GEODATA BETWEEN SPATIALITE (SQLITE), POSTGIS, SHAPEFILE,…
http://isticktoit.net/?p=740

#### Number of records in a table:

	SELECT COUNT(*) FROM table_name;

#### Sort Datetime to get 100 most recent

	SELECT * FROM table ORDER BY datetime DESC LIMIT 100

#CartoDB
### Download CSV of data table

	<a href=
	    "http://username.cartodb.com/api/v2/sql?q=SELECT%20*%20FROM%20table_name&format=CSV&filename=export.csv">
	    Download CSV
	</a>
	
### Get column names

	http://sheehan-carto.cartodb.com/api/v2/sql?q=SELECT column_name FROM information_schema.columns WHERE table_name ='<TABLE_NAME>'; &api_key=API_KEY	

### Get table column names as list

	
	from cartodb import CartoDBAPIKey, CartoDBException, FileImport
	
	def getCartoTableColsList(tablename,cartodb_domain,API_KEY):
		url = "http://"+cartodb_domain+".cartodb.com/api/v2/sql?q=SELECT%20column_name%20FROM%20information_schema.columns%20WHERE%20table_name%20='"+tablename+"';%20&format=json&api_key="+API_KEY
		req = urllib2.Request(url)
		response = urllib2.urlopen(req)
		cols_data = json.loads(str(response.read()))
		colsList = []
		for i in cols_data['rows']:
			colsList.append(i['column_name'])
	
		return colsList
	
	col_List = getCartoTableColsList('users',cartodb_domain,API_KEY)
	
### Get list of public tables

	https://andye.carto.com/api/v2/sql?q=SELECT * FROM CDB_UserTables()
	
### Get data as a csv

	https://ashleysimcox.carto.com/api/v2/sql?q=SELECT count(*) FROM ny_boroughs

	https://ashleysimcox.carto.com/api/v2/sql?q=SELECT * FROM ny_boroughs

### Cartodbfy for team

	SELECT cdb_cartodbfytable('your-account-name', 'your-table-name');


### Data Observatory

	CREATE TABLE ny_state_geom AS SELECT ST_Transform(OBS_GetBoundaryById('36', 'us.census.tiger.state_clipped'), 3857) As the_geom_webmercator
	
	SELECT cdb_cartodbfytable('sheehan-carto','ny_state_geom')


Get all Tracts

	CREATE TABLE us_census_tracts As
	SELECT the_geom, geoid
	FROM OBS_GetBoundariesByGeometry(
	   		ST_Buffer(CDB_LatLng(40.7, -73.9), 180), 'us.census.tiger.census_tract_clipped') As m(the_geom, geoid)
	
	SELECT cdb_cartodbfytable('sheehan-carto','us_census_tracts')

Get all States

	CREATE TABLE us_states As
	SELECT the_geom, geoid
	FROM OBS_GetBoundariesByGeometry(
	   		ST_Buffer(CDB_LatLng(40.7, -73.9), 180), 'us.census.tiger.state_clipped') As m(the_geom, geoid)
	
	SELECT cdb_cartodbfytable('sheehan-carto','us_states')


### Dissolve

	select  value_shared, st_union(the_geom_webmercator) as the_geom_webmercator from distribution_center_copy group by distribution_center_copy.value_shared
	

### Add thousands Seperator, comma

	ALTER TABLE table_250k_export_2_redbrick_1 ADD COLUMN total_available_space_sf_thousandssep TEXT

	UPDATE table_250k_export_2_redbrick_1 SET total_available_space_sf_thousandssep = to_char(total_available_space_sf, '9,999,999')



Other stuff: https://github.com/clhenrick/cartodb-tutorial/blob/master/sql/other-useful-queries.sql

http://cartodb.github.io/bigmetadata/tags.global/tags.boundary.html#countries

http://cartodb.github.io/bigmetadata/tags.global/tags.boundary.html#countries



https://github.com/CartoDB/cdb-manager
 
https://www.postgresql.org/docs/9.5/static/plpgsql.html

https://www.postgresql.org/docs/9.5/static/plpython.html


### Name Maps as XYZ

	http://nygeog.carto.com/api/v1/map/named/tpl_b6c8b9be_8fe5_11e6_8a5c_0e05a8b3e3d7/all/{z}/{x}/{y}.png

	http://nygeog.carto.com/api/v1/map/named/tpl_b6c8b9be_8fe5_11e6_8a5c_0e05a8b3e3d7/all/1/1/1.png
	
	
### Static Maps API

Carto Docs [https://carto.com/docs/carto-engine/maps-api/static-maps-api](https://carto.com/docs/carto-engine/maps-api/static-maps-api)

username: nygeog

named: tpl_2034a658_8fe9_11e6_9bbb_0e233c30368f
^ which is id, w/ tpl_ and dashes (-) as underscores

[http://staticmapmaker.com/cartodb/](http://staticmapmaker.com/cartodb/)

<img width="600" src="https://cartocdn-ashbu.global.ssl.fastly.net/nygeog/api/v1/map/static/named/tpl_2034a658_8fe9_11e6_9bbb_0e233c30368f/600/300.png" alt="CartoDB Map of 42.6564,-74.7638">

[https://cartocdn-ashbu.global.ssl.fastly.net/nygeog/api/v1/map/static/named/tpl_2034a658_8fe9_11e6_9bbb_0e233c30368f/600/300.png](https://cartocdn-ashbu.global.ssl.fastly.net/nygeog/api/v1/map/static/named/tpl_2034a658_8fe9_11e6_9bbb_0e233c30368f/600/300.png)

### Maps API
* Create a named map with a base map - without Javascript or browser
	* http://gis.stackexchange.com/questions/186029/create-a-named-map-with-a-base-map-without-javascript-or-browser
	
	


### HTTPS Stuff 

	https://cartodb-libs.global.ssl.fastly.net/cartodb.js/v3/3.15/themes/css/cartodb.css
	
	https://cartodb.com/assets/favicon.ico
	
	https://cartodb-libs.global.ssl.fastly.net/cartodb.js/v3/3.15/cartodb.js
	
### Import API
[https://github.com/nyctreescountdatajam/nyctreescountdatajam_code/blob/master/02-import-to-cartodb.py](https://github.com/nyctreescountdatajam/nyctreescountdatajam_code/blob/master/02-import-to-cartodb.py)
	
	
## Geocoding	
	
### Report Mapzen Geocoding Issues

[https://github.com/pelias/pelias/issues/new](https://github.com/pelias/pelias/issues/new)	


## Routing

Routing params [https://carto.com/docs/carto-engine/dataservices-api/routing-functions/#arguments-1](https://carto.com/docs/carto-engine/dataservices-api/routing-functions/#arguments-1)



## Basemaps

	https://cartodb-basemaps-a.global.ssl.fastly.net/dark_all/0/0/0.png
	
	
## CartoCSS

[https://tilemill-project.github.io/tilemill/docs/guides/styling-polygons/](https://tilemill-project.github.io/tilemill/docs/guides/styling-polygons/)


## Get Geocoding, Isolines Quota

	select * from cdb_dataservices_client.cdb_service_quota_info()


## Connector Call

here you have an example of a call with the CARTO connector to a Postgres database @dbryson  

	```curl -v -k -H "Content-Type: application/json"     -d '{"connector":{"provider":"postgres","connection":{"server":"46.101.239.37","username":"fdw_test","database":"fdw_tests"},"schema": "fdw_tests","table":"clients"}}'     "https://carto.lan/user/carto/api/v1/imports/?api_key=API_KEY"


## Torque Classify

	ALTER TABLE table_name ADD COLUMN torque_class INTEGER;
	UPDATE table_name SET torque_class = ROUND(((input_col - (SELECT MIN(input_col) FROM table_name)) / (( (SELECT MAX(input_col) FROM table_name) - (SELECT MIN(input_col) FROM table_name))) * 255))
	
## Table Metadata	
	
	Schema changes don't invalidate cached results. I cannot find the issue associated with this problem, but this is a known issue.

The current workaround is to select cartodb.cdb_tablemetadatatouch('user_name.table_name'); after you have changed the schema.

BTW, it should work OK if you delete the column through the UI.

## Clear an Analysis Cache

	select CDB_TableMetadataTouch('tablename'::regclass)
	
	
## Here 

HERE uses realtime traffic information. 
[https://carto.com/docs/carto-engine/dataservices-api/isoline-functions](https://carto.com/docs/carto-engine/dataservices-api/isoline-functions)

Here Geocoding coverage:
[https://developer.here.com/rest-apis/documentation/geocoder/topics/coverage-geocoder.html](https://developer.here.com/rest-apis/documentation/geocoder/topics/coverage-geocoder.html)
	
## Rotating a Map
Specific for NYC

	SELECT 
	the_geom,cartodb_id, 
	st_rotate(the_geom_webmercator,0.50459214, st_transform(cdb_latlng(40.658439, -73.963394),3857)) the_geom_webmercator
	FROM ny_nj 


## Update all rows

	UPDATE nyctsubwayroutes_20170119_2nd_ave_q
	SET secondave = '0'


## TurboCarto

* Set style ranges
	
		polygon-fill: ramp([pct_dem],(#9CC0E3 ,#6193C7 ,#006AAB ),(0.5,0.6,0.8),"<");
		
## Flip Coordinates (http://postgis.net/2013/08/18/tip_lon_lat/)

	ALTER TABLE sometable 
	  ALTER COLUMN geom TYPE geometry(LineString,4326) 
	  USING 
	    ST_FlipCoordinates(
		geom)::geometry(LineString,4326);

### Calculate PostGIS Distance

	ALTER TABLE line_table ADD COLUMN dist_meters double precision;
	UPDATE line_table SET dist_meters = st_length(the_geom::geography)

### Carto as WMS (Web Mapping Service)
Proxy: http://sharegis-admin.carto.com/api/v2/wms/demo/#


### Jitter
Python: https://github.com/nygeog/questions/blob/master/jitter/gaussian.ipynb
SQL: https://github.com/nygeog/postgis_reference/blob/master/jitter_function/jitter_function2.sql


### Find user defined functions in PostGIS

	SELECT prosrc FROM pg_proc WHERE proname = 'pluto_reverse_geocode'


### [Overviews](https://github.com/CartoDB/cartodb-postgresql/blob/master/doc/CDB_Overviews.md)

Check if overviews made: 

	SELECT CDB_Overviews(CDB_QueryTablesText('SELECT * FROM tmobile'))

### ST_MAKELINE for origin/destination pairs

	UPDATE ralphs_visits_by_home_location_carto SET the_geom = ST_MAKELINE(CDB_LatLng(homelat,homelon),CDB_LatLng(storelat,storelon))



### List of XYZ map services:

https://worldtiles1.waze.com/tiles/{z}/{x}/{y}.png  
https://livemap-tiles2.waze.com/tiles/{z}/{x}/{y}.png


### Altyrex Connector

![alteryx_workflow](img/alteryx_workflow.png)

![alteryx_workflow_configuration](img/alteryx_workflow_configuration.png)


### Population Density SQL

	SELECT *, totpop/ST_AREA(the_geom::geography)/1000000 AS popdens FROM "sheehan-carto".gct_000b11a_e

### Create Month Column

	UPDATE ggla_wc_activememmbers_dates_latlong SET month = EXTRACT(MONTH FROM join_date)

	SELECT EXTRACT(MONTH FROM join_date);

### State Plane Projected data to Web Mercator

	UPDATE compass_brownsville SET the_geom = ST_Transform(ST_SetSRID(ST_MakePoint(xcoordinate, ycoordinate), 2263), 4326);


### ST Distance

	SELECT ST_Distance(starbucks_manhattan.the_geom, nyc_subway_stations_2017.the_geom), nyc_subway_stations_2017.station, nyc_subway_stations_2017.the_geom as subway_geom, starbucks_manhattan.name, starbucks_manhattan.the_geom as starbucks_geom FROM starbucks_manhattan, nyc_subway_stations_2017

