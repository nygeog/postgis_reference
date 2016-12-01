SELECT
  group_id,
  ST_MakeLine(geom ORDER BY gps_time ASC) AS geom
FROM table_name
GROUP BY group_id