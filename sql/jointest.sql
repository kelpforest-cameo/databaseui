-- SELECT authors.last_name from author_cite
-- INNER JOIN authors ON authors.id =author_cite.author_id  
-- INNER JOIN node_max_age ON node_max_age.cite_id=author_cite.cite_id  
-- WHERE node_max_age.node_id=3 
-- ;

-- SELECT authors.last_name, citations.year, citations.id as cite_id from author_cite 
-- INNER JOIN authors ON authors.id =author_cite.author_id
-- INNER JOIN citations on citations.id = author_cite.cite_id
-- WHERE author_cite.cite_id=1
-- ;

-- SELECT node_range.cite_id, node_range.value,  node_range.north_south, node_range.lat_long, citations.year FROM node_range 
-- INNER JOIN citations ON citations.id=node_range.cite_id 
-- WHERE node_id=3  
-- ORDER BY node_range.cite_id, north_south, lat_long
-- ;

-- SELECT authors.last_name, citations.year, citations.title, citations.id as cite_id from author_cite 
-- INNER JOIN authors ON authors.id =author_cite.author_id
-- INNER JOIN citations on citations.id = author_cite.cite_id
-- ;

-- select * from trophic_interactions LEFT JOIN (stages,nodes) ON (stages.id=stage_2_id AND nodes.id=stages.node_id) WHERE stage_1_id=4;

select trophic_interactions.id, trophic_interactions.stage_1_id, trophic_interactions.stage_2_id, stages.name as stage_name, nodes.working_name  as node_working_name from trophic_interactions LEFT JOIN (stages,nodes) ON (stages.id=trophic_interactions.stage_2_id AND nodes.id=stages.node_id) WHERE stage_1_id=4;






