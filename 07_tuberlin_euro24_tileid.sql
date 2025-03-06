-- create table containing all tile IDs located in region of interest
drop table if exists tuberlin_euro24_tileid;
 
create table tuberlin_euro24_tileid as (
 
	select tp.*
	from tile2plz as tp, tuberlin_euro24_contour as p
	where st_intersects(st_transform(tp.tile_geom, 3857), p.way)
 
);
