-- create table containing region of interest
drop table if exists tuberlin_euro2024_contour;

create table tuberlin_euro2024_contour as (

	with contours as (
		select *
		from planet_osm_polygon
		where osm_id in (-62428,-62422,-62649,-62400,-1829065,-2793104,-62578,-62539,-62782,-62522)
		and way_area >= 100000
	)
	, biggest_surface as (
		select osm_id, max(way_area) as way_area
		from contours
		group by 1
	)
	select c.*
	from contours as c
	join biggest_surface as bs on bs.way_area = c.way_area

);