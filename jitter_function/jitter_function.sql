ALTER FUNCTION [dbo].[JitterPoints]
	(@Bandwith float(10))
	returns float(10), float(10)
	AS
	BEGIN
		declare @Return float(10), float(10)
		select @return = case @Bandwith

		
		ALTER TABLE table_name ADD COLUMN Y double precision;
		ALTER TABLE table_name ADD COLUMN X double precision;
		ALTER TABLE table_name ADD COLUMN Y_old double precision;
		ALTER TABLE table_name ADD COLUMN X_old double precision;
		UPDATE table_name SET Y_old = Y;
		UPDATE table_name SET X_old = X;
		UPDATE table_name SET Y = normal_rand(1, (select st_y(the_geom)), 0.001);
		UPDATE table_name SET X = normal_rand(1, (select st_x(the_geom)), 0.001);
		UPDATE table_name SET the_geom = ST_SetSRID(ST_MakePoint(X,Y),4326);
		else 'Unknown'
		end

	return @return
	end