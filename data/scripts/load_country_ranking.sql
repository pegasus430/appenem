SELECT @ranking := 0;
SELECT @current_entity := 0;
SELECT @last_entity := 0;
SELECT @last_exam := 0;
SELECT @last_score := 9999.0;

CREATE TEMPORARY TABLE meta_ranking
SELECT
  @current_entity := 0,
  @ranking := IF(
    @current_entity <> @last_entity OR s.exam_id <> @last_exam,
    1,
    IF(
      @last_score > s.general_score,
      @ranking + 1,
      @ranking
    )) AS ranking,
  @last_exam := s.exam_id,
  @last_score := s.general_score,
  @last_entity := @current_entity,
  s.school_id,
  s.exam_id,
  s.general_score
FROM summaries AS s
ORDER BY exam_id ASC, general_score DESC;

UPDATE summaries AS ss
INNER JOIN meta_ranking AS mr ON mr.school_id = ss.school_id AND mr.exam_id = ss.exam_id
SET ss.country_ranking = mr.ranking;
