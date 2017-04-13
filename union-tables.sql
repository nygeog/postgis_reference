CREATE TABLE {new_tablename} AS( 
SELECT * FROM {tablename}_0
UNION ALL
SELECT * FROM {tablename}_1
UNION ALL
SELECT * FROM {tablename}_2);

SELECT Populate_Geometry_Columns('{new_tablename}'::regclass);

ALTER TABLE {new_tablename} DROP COLUMN cartodb_id

SELECT cdb_cartodbfytable(‘{username}’, ‘{new_tablename}’);
