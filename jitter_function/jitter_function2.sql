ALTER TABLE hubspot_crm_view_contacts_ip_known_2016_contacts_2016_12_01 ADD COLUMN Y double precision;
ALTER TABLE hubspot_crm_view_contacts_ip_known_2016_contacts_2016_12_01 ADD COLUMN X double precision;
ALTER TABLE hubspot_crm_view_contacts_ip_known_2016_contacts_2016_12_01 ADD COLUMN Y_old double precision;
ALTER TABLE hubspot_crm_view_contacts_ip_known_2016_contacts_2016_12_01 ADD COLUMN X_old double precision;
UPDATE hubspot_crm_view_contacts_ip_known_2016_contacts_2016_12_01 SET Y_old = Y;
UPDATE hubspot_crm_view_contacts_ip_known_2016_contacts_2016_12_01 SET X_old = X;
UPDATE hubspot_crm_view_contacts_ip_known_2016_contacts_2016_12_01 SET Y = normal_rand(1, (select st_y(the_geom)), 0.001);
UPDATE hubspot_crm_view_contacts_ip_known_2016_contacts_2016_12_01 SET X = normal_rand(1, (select st_x(the_geom)), 0.001);
UPDATE hubspot_crm_view_contacts_ip_known_2016_contacts_2016_12_01 SET the_geom = ST_SetSRID(ST_MakePoint(X,Y),4326);


