# CH

for d in `seq 100000000001 1000000 100005000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, ch_test_code, ch_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.ch_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.ch_answers, r.test_position, 1);"
done

for d in `seq 130005702868 1000000 130013000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, ch_test_code, ch_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.ch_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.ch_answers, r.test_position, 1);"
done

for d in `seq 140000000001 1000000 140009000000`; do
  u=$((d+1000000))
  echo $d, $u
time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, ch_test_code, ch_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.ch_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.ch_answers, r.test_position, 1);"
done

for d in `seq 150000000002 1000000 150008000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, ch_test_code, ch_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.ch_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.ch_answers, r.test_position, 1);"
done

for d in `seq 160000000000 1000000 160009000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, ch_test_code, ch_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.ch_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.ch_answers, r.test_position, 1);"
done

for d in `seq 200000000001 1000000 200005000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, ch_test_code, ch_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.ch_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.ch_answers, r.test_position, 1);"
done

for d in `seq 300000000001 1000000 300006000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, ch_test_code, ch_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.ch_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.ch_answers, r.test_position, 1);"
done

for d in `seq 400000000001 1000000 400006000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, ch_test_code, ch_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.ch_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.ch_answers, r.test_position, 1);"
done

# CN

for d in `seq 100000000001 1000000 100005000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, cn_test_code, cn_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.cn_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.cn_answers, r.test_position, 1);"
done

for d in `seq 130005702868 1000000 130013000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, cn_test_code, cn_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.cn_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.cn_answers, r.test_position, 1);"
done

for d in `seq 140000000001 1000000 140009000000`; do
  u=$((d+1000000))
  echo $d, $u
time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, cn_test_code, cn_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.cn_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.cn_answers, r.test_position, 1);"
done

for d in `seq 150000000002 1000000 150008000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, cn_test_code, cn_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.cn_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.cn_answers, r.test_position, 1);"
done

for d in `seq 160000000000 1000000 160009000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, cn_test_code, cn_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.cn_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.cn_answers, r.test_position, 1);"
done

for d in `seq 200000000001 1000000 200005000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, cn_test_code, cn_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.cn_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.cn_answers, r.test_position, 1);"
done

for d in `seq 300000000001 1000000 300006000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, cn_test_code, cn_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.cn_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.cn_answers, r.test_position, 1);"
done

for d in `seq 400000000001 1000000 400006000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, cn_test_code, cn_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.cn_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.cn_answers, r.test_position, 1);"
done

# LC

for d in `seq 100000000001 1000000 100005000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT a.id AS alternative_id, c.id AS candidate_id FROM ( SELECT registration, lc_test_code, lc_type, lc_answers FROM rawdata WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r ON rd.lc_test_code = r.test_id AND r.test_type <> IF(rd.lc_type = 'english', 2, 1) INNER JOIN candidates AS c ON rd.registration = c.registration INNER JOIN alternatives AS a ON a.question_id = r.question_id AND a.label = SUBSTR(rd.lc_answers, r.test_position, 1);"
done

for d in `seq 130005702868 1000000 130013000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT a.id AS alternative_id, c.id AS candidate_id FROM ( SELECT registration, lc_test_code, lc_type, lc_answers FROM rawdata WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r ON rd.lc_test_code = r.test_id AND r.test_type <> IF(rd.lc_type = 'english', 2, 1) INNER JOIN candidates AS c ON rd.registration = c.registration INNER JOIN alternatives AS a ON a.question_id = r.question_id AND a.label = SUBSTR(rd.lc_answers, r.test_position, 1);"
done

for d in `seq 140000000001 1000000 140009000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT a.id AS alternative_id, c.id AS candidate_id FROM ( SELECT registration, lc_test_code, lc_type, lc_answers FROM rawdata WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r ON rd.lc_test_code = r.test_id AND r.test_type <> IF(rd.lc_type = 'english', 2, 1) INNER JOIN candidates AS c ON rd.registration = c.registration INNER JOIN alternatives AS a ON a.question_id = r.question_id AND a.label = SUBSTR(rd.lc_answers, r.test_position, 1);"
done

for d in `seq 150000000002 1000000 150008000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT a.id AS alternative_id, c.id AS candidate_id FROM ( SELECT registration, lc_test_code, lc_type, lc_answers FROM rawdata WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r ON rd.lc_test_code = r.test_id AND r.test_type <> IF(rd.lc_type = 'english', 2, 1) INNER JOIN candidates AS c ON rd.registration = c.registration INNER JOIN alternatives AS a ON a.question_id = r.question_id AND a.label = SUBSTR(rd.lc_answers, r.test_position, 1);"
done

for d in `seq 160000000000 1000000 160009000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT a.id AS alternative_id, c.id AS candidate_id FROM ( SELECT registration, lc_test_code, lc_type, lc_answers FROM rawdata WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r ON rd.lc_test_code = r.test_id AND r.test_type <> IF(rd.lc_type = 'english', 2, 1) INNER JOIN candidates AS c ON rd.registration = c.registration INNER JOIN alternatives AS a ON a.question_id = r.question_id AND a.label = SUBSTR(rd.lc_answers, r.test_position, 1);"
done

for d in `seq 200000000001 1000000 200005000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT a.id AS alternative_id, c.id AS candidate_id FROM ( SELECT registration, lc_test_code, lc_type, lc_answers FROM rawdata WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r ON rd.lc_test_code = r.test_id AND r.test_type <> IF(rd.lc_type = 'english', 2, 1) INNER JOIN candidates AS c ON rd.registration = c.registration INNER JOIN alternatives AS a ON a.question_id = r.question_id AND a.label = SUBSTR(rd.lc_answers, r.test_position, 1);"
done

for d in `seq 300000000001 1000000 300006000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT a.id AS alternative_id, c.id AS candidate_id FROM ( SELECT registration, lc_test_code, lc_type, lc_answers FROM rawdata WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r ON rd.lc_test_code = r.test_id AND r.test_type <> IF(rd.lc_type = 'english', 2, 1) INNER JOIN candidates AS c ON rd.registration = c.registration INNER JOIN alternatives AS a ON a.question_id = r.question_id AND a.label = SUBSTR(rd.lc_answers, r.test_position, 1);"
done

for d in `seq 400000000001 1000000 400006000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT a.id AS alternative_id, c.id AS candidate_id FROM ( SELECT registration, lc_test_code, lc_type, lc_answers FROM rawdata WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r ON rd.lc_test_code = r.test_id AND r.test_type <> IF(rd.lc_type = 'english', 2, 1) INNER JOIN candidates AS c ON rd.registration = c.registration INNER JOIN alternatives AS a ON a.question_id = r.question_id AND a.label = SUBSTR(rd.lc_answers, r.test_position, 1);"
done

#MT

for d in `seq 100000000001 1000000 100005000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, mt_test_code, mt_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.mt_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.mt_answers, r.test_position, 1);"
done

for d in `seq 130005702868 1000000 130013000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, mt_test_code, mt_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.mt_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.mt_answers, r.test_position, 1);"
done

for d in `seq 140000000001 1000000 140009000000`; do
  u=$((d+1000000))
  echo $d, $u
time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, mt_test_code, mt_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.mt_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.mt_answers, r.test_position, 1);"
done

for d in `seq 150000000002 1000000 150008000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, mt_test_code, mt_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.mt_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.mt_answers, r.test_position, 1);"
done

for d in `seq 160000000000 1000000 160009000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, mt_test_code, mt_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.mt_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.mt_answers, r.test_position, 1);"
done

for d in `seq 200000000001 1000000 200005000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, mt_test_code, mt_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.mt_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.mt_answers, r.test_position, 1);"
done

for d in `seq 300000000001 1000000 300006000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, mt_test_code, mt_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.mt_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.mt_answers, r.test_position, 1);"
done

for d in `seq 400000000001 1000000 400006000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "SET foreign_key_checks=0; SET unique_checks=0;  INSERT IGNORE INTO answers SELECT   a.id AS alternative_id,   c.id AS candidate_id FROM ( SELECT registration, mt_test_code, mt_answers FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN relations AS r   ON rd.mt_test_code = r.test_id INNER JOIN candidates AS c   ON rd.registration = c.registration INNER JOIN alternatives AS a   ON a.question_id = r.question_id AND a.label = SUBSTR(rd.mt_answers, r.test_position, 1);"
done
