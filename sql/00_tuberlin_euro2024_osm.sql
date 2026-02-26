-- create table containing all OSM polygon entries in region of interest
drop table if exists tuberlin_euro2024_osm;

create table tuberlin_euro2024_osm as (

	with t_polygon as (
		select osm.*
	    from tuberlin_euro2024_contour as contour, planet_osm_polygon as osm
		where st_contains(contour.way, osm.way) and osm.way_area < 10000000
	)
	, t_line as (
		select osm.*
	    from tuberlin_euro2024_contour as contour, planet_osm_line as osm
		where st_contains(contour.way, osm.way) and st_length(osm.way) < 10000
	)
	, u_polygon as (
		select tileid.tile_id, tileid.plz, t.*
		from t_polygon as t, tuberlin_euro2024_tileid as tileid
		where st_intersects(st_transform(tileid.tile_geom, 3857), t.way)
	)
	, u_line as (
		select tileid.tile_id, tileid.plz, t.*
		from t_line as t, tuberlin_euro2024_tileid as tileid
		where st_intersects(st_transform(tileid.tile_geom, 3857), t.way)
	)
	select *
	from u_polygon
	union all
	select *
	from u_line
	
);

delete from tuberlin_euro2024_osm
where boundary = 'postal_code' or boundary = 'administrative'