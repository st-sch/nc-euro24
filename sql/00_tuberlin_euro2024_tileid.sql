-- create table containing all tile IDs located in region of interest
drop table if exists tuberlin_euro2024_tileid;

create table tuberlin_euro2024_tileid as (

	select tp.*
	from tile2plz as tp, tuberlin_euro2024_contour as p
	where st_intersects(st_transform(tp.tile_geom, 3857), p.way)

);



select name, count(tile_id)
from tuberlin_euro2024_tileid
group by 1
order by 1