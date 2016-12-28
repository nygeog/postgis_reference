SELECT ST_Y(CDB_LatLng(42.374444, -71.116944)) as Y, ST_X(CDB_LatLng(42.374444, -71.116944)) as X

SELECT ((floor(normal_rand(1,0,1)*250 + 125)::int % 250) + 250) % 250 as v;

SELECT ((floor(normal_rand(CDB_LatLng(42.374444, -71.116944),0,1)*250 + 125)::int % 250) + 250) % 250 as v;

SELECT Y, X from normal_rand(1, ST_Y(CDB_LatLng(42.374444, -71.116944))::int, 0.01) as Y, normal_rand(1, ST_X(CDB_LatLng(42.374444, -71.116944))::int, 0.01) as X

SELECT Y, X from normal_rand(1, ST_Y(CDB_LatLng(42.374444, -71.116944))::int, 0.001) as Y, normal_rand(1, ST_X(CDB_LatLng(42.374444, -71.116944))::int, 0.001) as X

SELECT Y, X from normal_rand(1, ST_Y(CDB_LatLng(42.374444, -71.116944))::int, 0.001) as Y, normal_rand(1, ST_X(CDB_LatLng(42.374444, -71.116944))::int, 0.001) as X

SELECT Y, X from normal_rand(1, ST_Y(CDB_LatLng(42.374444, -71.116944)), 0.001) as Y, normal_rand(1, ST_X(CDB_LatLng(42.374444, -71.116944)), 0.001) as X
SELECT normal_rand(1, (select st_y(the_geom)), 0.001) as Y FROM test_points

SELECT normal_rand(1, (select st_y(the_geom)), 0.001) as Y FROM test_points

SELECT normal_rand(1, (select st_y(the_geom)), 0.001) as Y, normal_rand(1, (select st_x(the_geom)), 0.001) as X FROM test_points

UPDATE test_points SET geom = ST_MakePoint(X, Y), 4326) SELECT normal_rand(1, (select st_y(the_geom)), 0.001) as Y, normal_rand(1, (select st_x(the_geom)), 0.001) as X FROM test_points


ALTER TABLE test_points ADD COLUMN X double precision;
ALTER TABLE test_points ADD COLUMN Y double precision;
UPDATE test_points SET X = normal_rand(1, (select st_y(the_geom)), 0.001) as Y FROM test_points



ALTER TABLE test_points ADD COLUMN Y double precision;
ALTER TABLE test_points ADD COLUMN X double precision;
UPDATE test_points SET Y = normal_rand(1, (select st_y(the_geom)), 0.001) 
UPDATE test_points SET X = normal_rand(1, (select st_x(the_geom)), 0.001) 

ALTER TABLE test_points ADD COLUMN Y double precision;
ALTER TABLE test_points ADD COLUMN X double precision;
UPDATE test_points SET Y = normal_rand(1, (select st_y(the_geom)), 0.001);
UPDATE test_points SET X = normal_rand(1, (select st_x(the_geom)), 0.001);
UPDATE test_points SET the_geom = ST_SetSRID(ST_MakePoint(X,Y),4326);
