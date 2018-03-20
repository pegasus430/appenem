for d in `seq 1700 100 88000`; do
  u=$((d+100))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO frequencies (school_id, exam_id, question_id, alternative_id, frequency) SELECT 	s.id AS school_id,     c.exam_id AS exam_id,     a.question_id AS question_id,     a.id AS alternative_id,     COUNT(a.id) AS frequency FROM schools AS s INNER JOIN candidates AS c ON c.school_id = s.id INNER JOIN answers AS an ON an.candidate_id = c.id INNER JOIN alternatives AS a ON a.id = an.alternative_id WHERE s.id BETWEEN $d AND $u GROUP BY s.id, c.exam_id, a.question_id, a.id;"
done
