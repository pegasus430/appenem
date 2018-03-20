/*
-- Query: SELECT DISTINCT
  g.id AS id,
  g.name AS name,
  g.short_name AS short_name
FROM groups AS g
INNER JOIN subgroups AS s ON s.group_id = g.id
INNER JOIN questions AS q ON q.subgroup_id = s.id
INNER JOIN relations AS r ON r.id = q.id
-- Date: 2017-06-05 14:41
*/
INSERT INTO `areas` (`id`,`name`,`short_name`) VALUES (5,'Ciências Humanas e suas Tecnologias','Ciências Humanas');
INSERT INTO `areas` (`id`,`name`,`short_name`) VALUES (6,'Ciências da Natureza e suas Tecnologias','Ciências da Natureza');
INSERT INTO `areas` (`id`,`name`,`short_name`) VALUES (7,'Linguagens, Códigos e suas Tecnologias','Linguagens');
INSERT INTO `areas` (`id`,`name`,`short_name`) VALUES (8,'Matemática e suas Tecnologias','Matemática');
