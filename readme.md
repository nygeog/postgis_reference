#PostGIS/CartoDB reference

###List all tables in CartoDB acccount
From [StackExchange](http://gis.stackexchange.com/questions/94066/get-list-of-all-tables-in-cartodb-account-with-sql-statement)

	SELECT * FROM CDB_UserTables()
	
	
###Drop tables
[SQL Drop Table](http://www.1keydata.com/sql/sqldrop.html)
	
The syntax for DROP TABLE is,

	DROP TABLE "table_name";

Drop Multiple Tables At The Same Time

It is possible to drop more than one table at a time. To do that, list the names of all the tables we wish to drop separated by comma after DROP TABLE. For example, if we want to drop the User_Details table and the Job_List table together, we can issue the following SQL statement:

	DROP TABLE User_Details, Job_List;


###Spatially Enable Database

	CREATE EXTENSION postgis;	

From [Spatially enabled Postgres database](http://gis.stackexchange.com/questions/29759/spatially-enabled-postgres-database)

##Merge Multiple Tables

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

#CartoDB
###Download CSV of data table

	<a href=
	    "http://username.cartodb.com/api/v2/sql?q=SELECT%20*%20FROM%20table_name&format=CSV&filename=export.csv">
	    Download CSV
	</a>
	
	

	
	