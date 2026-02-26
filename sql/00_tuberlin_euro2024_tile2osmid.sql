drop table if exists tuberlin_euro2024_tile2osmid;

create table tuberlin_euro2024_tile2osmid (
	tile_id int4,
	tile int8,
	osm_ids _int8
);

with level1_unnest as (
	select distinct tileid.tile_id, osm.osm_id, tile_geom, osm.way
	from tuberlin_euro2024_osm as osm
	join tuberlin_euro2024_tileid as tileid on tileid.tile_id = osm.tile_id
	--where tileid.tile_id in (28718,28719)
),
level1 as (
	select *, st_intersects(way, st_transform(tile_geom, 3857)) as intersects, st_contains(way, st_transform(tile_geom, 3857)) as "contains"
	from level1_unnest
	--where tile_id = 177243
),

level2_unnest as (
	select tile_id, (tile_id::text || unnest(array[0,1,2,3])::text)::int8 tile2, osm_id, unnest(tilen2tilenplus1(tile_geom)) tile_geom, way
	from level1
	where intersects and not "contains"
),
level2 as (
	select *, st_intersects(way, st_transform(tile_geom, 3857)) as intersects, st_contains(way, st_transform(tile_geom, 3857)) as "contains"
	from level2_unnest
),

level3_unnest as (
	select tile_id, (tile2::text || unnest(array[0,1,2,3])::text)::int8 tile3, osm_id, unnest(tilen2tilenplus1(tile_geom)) tile_geom, way
	from level2
	where intersects and not "contains"
),
level3 as (
	select *, st_intersects(way, st_transform(tile_geom, 3857)) as intersects, st_contains(way, st_transform(tile_geom, 3857)) as "contains"
	from level3_unnest
),

level4_unnest as (
	select tile_id, (tile3::text || unnest(array[0,1,2,3])::text)::int8 tile4, osm_id, unnest(tilen2tilenplus1(tile_geom)) tile_geom, way
	from level3
	where intersects and not "contains"
),
level4 as (
	select *, st_intersects(way, st_transform(tile_geom, 3857)) as intersects, st_contains(way, st_transform(tile_geom, 3857)) as "contains"
	from level4_unnest
),

level5_unnest as (
	select tile_id, (tile4::text || unnest(array[0,1,2,3])::text)::int8 tile5, osm_id, unnest(tilen2tilenplus1(tile_geom)) tile_geom, way
	from level4
	where intersects and not "contains"
),
level5 as (
	select *, st_intersects(way, st_transform(tile_geom, 3857)) as intersects, st_contains(way, st_transform(tile_geom, 3857)) as "contains"
	from level5_unnest
),

level6_unnest as (
	select tile_id, (tile5::text || unnest(array[0,1,2,3])::text)::int8 tile6, osm_id, unnest(tilen2tilenplus1(tile_geom)) tile_geom, way
	from level5
	where intersects and not "contains"
),
level6 as (
	select *, st_intersects(way, st_transform(tile_geom, 3857)) as intersects, st_contains(way, st_transform(tile_geom, 3857)) as "contains"
	from level6_unnest
),

level7_unnest as (
	select tile_id, (tile6::text || unnest(array[0,1,2,3])::text)::int8 tile7, osm_id, unnest(tilen2tilenplus1(tile_geom)) tile_geom, way
	from level6
	where intersects and not "contains"
),
level7 as (
	select *, st_intersects(way, st_transform(tile_geom, 3857)) as intersects, st_contains(way, st_transform(tile_geom, 3857)) as "contains"
	from level7_unnest
),

level8_unnest as (
	select tile_id, (tile7::text || unnest(array[0,1,2,3])::text)::int8 tile8, osm_id, unnest(tilen2tilenplus1(tile_geom)) tile_geom, way
	from level7
	where intersects and not "contains"
),
level8 as (
	select *, st_intersects(way, st_transform(tile_geom, 3857)) as intersects, st_contains(way, st_transform(tile_geom, 3857)) as "contains"
	from level8_unnest
)

insert into tuberlin_euro2024_tile2osmid (tile_id, tile, osm_ids)

select tile_id, tile8 as tile, array_agg(osm_id) osm_ids
from level8
where intersects
group by 1,2
union all
select tile_id, tile7 as tile, array_agg(osm_id) osm_ids
from level7
where intersects and "contains"
group by 1,2
union all
select tile_id, tile6 as tile, array_agg(osm_id) osm_ids
from level6
where intersects and "contains"
group by 1,2
union all
select tile_id, tile5 as tile, array_agg(osm_id) osm_ids
from level5
where intersects and "contains"
group by 1,2
union all
select tile_id, tile4 as tile, array_agg(osm_id) osm_ids
from level4
where intersects and "contains"
group by 1,2
union all
select tile_id, tile3 as tile, array_agg(osm_id) osm_ids
from level3
where intersects and "contains"
group by 1,2
union all
select tile_id, tile2 as tile, array_agg(osm_id) osm_ids
from level2
where intersects and "contains"
group by 1,2
union all
select tile_id, tile_id as tile, array_agg(osm_id) osm_ids
from level1
where intersects and "contains"
group by 1,2;