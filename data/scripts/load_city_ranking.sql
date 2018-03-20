SELECT @ranking := 0;
SELECT @last_entity := 0;
SELECT @last_exam := 0;
SELECT @last_score := 9999.0;

CREATE TEMPORARY TABLE city_ranking
SELECT
  @ranking := IF(
    r.city_id <> @last_entity OR r.exam_id <> @last_exam,
    1,
    IF(
      @last_score > r.general_score,
      @ranking + 1,
      @ranking
    )) AS ranking,
  r.*,
  @last_entity := r.city_id,
  @last_exam := r.exam_id,
  @last_score := r.general_score
FROM (
  SELECT
    c.id AS city_id,
    s.school_id,
    s.exam_id,
    s.general_score
  FROM summaries AS s
  INNER JOIN schools AS sc
    ON sc.id = s.school_id
  INNER JOIN cities AS c
    ON c.id = sc.city_id
  ORDER BY exam_id ASC, c.id ASC, general_score DESC
) AS r;

UPDATE summaries AS ss
INNER JOIN city_ranking AS cr ON cr.school_id = ss.school_id AND cr.exam_id = ss.exam_id
SET ss.city_ranking = cr.ranking;
