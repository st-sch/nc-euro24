-- create table containing region of interest
drop table if exists tuberlin_euro24_contour;
 
create table tuberlin_euro24_contour as (
 
	select *
	from planet_osm_polygon
	where osm_id in (-62428,-62422,-62649,-62400,-1829065,-2793104,-62578,-62539,-62782,-62522) and way_area >= 100000
 
);