create table euro2024_poi_all_smallestpolygon_cities as (

	with smallest_polygon as (
		select
			  poi.tile_id, poi.amenity, poi.service, poi.shop, poi.tourism, poi.osm_id_point, poi.way_point
			, first_value(poi.osm_id_polygon) over (partition by poi.osm_id_point order by osm.way_area asc) as osm_id_polygon
		from euro2024_poi_all as poi
		join tuberlin_euro2024_osm as osm on osm.osm_id = poi.osm_id_polygon -- planet_osm_polygon
	)
	select distinct on (poi.osm_id_point) sp.*, poi.way_polygon
	from smallest_polygon as sp
	join euro2024_poi_all as poi on poi.osm_id_polygon = sp.osm_id_polygon

);