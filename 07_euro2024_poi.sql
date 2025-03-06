drop table if exists euro2024_poi;
create table euro2024_poi as (
	with points as (
		select *
		from planet_osm_point
		where amenity in ('bar','restaurant','biergarten','pub','cafe') or shop in ('kiosk','supermarket','beverages')
		--limit 10
	)
	, polygons as (
		select *
		from planet_osm_polygon
		where building is not null or way_area < 100000
	)
	, mapped as (
		select points.amenity, points.shop, points.osm_id as osm_id_point, polygons.osm_id as osm_id_polygon, points.way as way_point, polygons.way as way_polygon
		from points, polygons
		where st_contains(polygons.way, points.way)
	)
	select tx.tile_id, mapped.*
	from mapped
	join txc_dt_grid_1000m as tx
	on st_contains(st_transform(tx.geom, 3857), mapped.way_point)
);