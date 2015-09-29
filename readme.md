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

#CartoDB
###Download CSV of data table

	<a href=
	    "http://username.cartodb.com/api/v2/sql?q=SELECT%20*%20FROM%20table_name&format=CSV&filename=export.csv">
	    Download CSV
	</a>
	
	

	
	