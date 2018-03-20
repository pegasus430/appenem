/*
-- Query: SELECT DISTINCT
  s.id AS id,
  s.group_id AS area_id,
  s.name AS name
FROM subgroups AS s
INNER JOIN questions AS q ON q.subgroup_id = s.id
INNER JOIN relations AS r ON r.id = q.id
-- Date: 2017-06-05 14:42
*/
INSERT INTO `disciplines` (`id`,`area_id`,`name`) VALUES (20,6,'Biologia');
INSERT INTO `disciplines` (`id`,`area_id`,`name`) VALUES (21,6,'Física');
INSERT INTO `disciplines` (`id`,`area_id`,`name`) VALUES (22,6,'Química');
INSERT INTO `disciplines` (`id`,`area_id`,`name`) VALUES (17,5,'História');
INSERT INTO `disciplines` (`id`,`area_id`,`name`) VALUES (16,5,'Geografia');
INSERT INTO `disciplines` (`id`,`area_id`,`name`) VALUES (19,5,'Filosofia');
INSERT INTO `disciplines` (`id`,`area_id`,`name`) VALUES (23,7,'Língua Portuguesa');
INSERT INTO `disciplines` (`id`,`area_id`,`name`) VALUES (27,7,'Arte');
INSERT INTO `disciplines` (`id`,`area_id`,`name`) VALUES (24,7,'Literatura');
INSERT INTO `disciplines` (`id`,`area_id`,`name`) VALUES (28,7,'Educação Física');
INSERT INTO `disciplines` (`id`,`area_id`,`name`) VALUES (29,7,'Tecnologias da Informação e Comunicação');
INSERT INTO `disciplines` (`id`,`area_id`,`name`) VALUES (30,8,'Matemática');
INSERT INTO `disciplines` (`id`,`area_id`,`name`) VALUES (18,5,'Sociologia');
INSERT INTO `disciplines` (`id`,`area_id`,`name`) VALUES (25,7,'Língua Estrangeira (Inglês)');
INSERT INTO `disciplines` (`id`,`area_id`,`name`) VALUES (26,7,'Língua Estrangeira (Espanhol)');
