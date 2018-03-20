# for d in `seq 100000000000 1000000 100005000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	5 AS area_id,     c.id AS candidate_id,     rd.ch_presence AS presence,     rd.ch_score AS score FROM ( 	SELECT 		registration,         ch_presence,         ch_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 130000000000 1000000 130013000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	5 AS area_id,     c.id AS candidate_id,     rd.ch_presence AS presence,     rd.ch_score AS score FROM ( 	SELECT 		registration,         ch_presence,         ch_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 140000000000 1000000 140009000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	5 AS area_id,     c.id AS candidate_id,     rd.ch_presence AS presence,     rd.ch_score AS score FROM ( 	SELECT 		registration,         ch_presence,         ch_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 150000000000 1000000 150008000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	5 AS area_id,     c.id AS candidate_id,     rd.ch_presence AS presence,     rd.ch_score AS score FROM ( 	SELECT 		registration,         ch_presence,         ch_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done

for d in `seq 160000000000 1000000 160009000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -psomosedu appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	5 AS area_id,     c.id AS candidate_id,     rd.ch_presence AS presence,     rd.ch_score AS score FROM ( 	SELECT 		registration,         ch_presence,         ch_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
done

# for d in `seq 200000000000 1000000 200005000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	5 AS area_id,     c.id AS candidate_id,     rd.ch_presence AS presence,     rd.ch_score AS score FROM ( 	SELECT 		registration,         ch_presence,         ch_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 300000000000 1000000 300006000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	5 AS area_id,     c.id AS candidate_id,     rd.ch_presence AS presence,     rd.ch_score AS score FROM ( 	SELECT 		registration,         ch_presence,         ch_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 400000000000 1000000 400006000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	5 AS area_id,     c.id AS candidate_id,     rd.ch_presence AS presence,     rd.ch_score AS score FROM ( 	SELECT 		registration,         ch_presence,         ch_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 100000000000 1000000 100005000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	6 AS area_id,     c.id AS candidate_id,     rd.cn_presence AS presence,     rd.cn_score AS score FROM ( 	SELECT 		registration,         cn_presence,         cn_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 130000000000 1000000 130013000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	6 AS area_id,     c.id AS candidate_id,     rd.cn_presence AS presence,     rd.cn_score AS score FROM ( 	SELECT 		registration,         cn_presence,         cn_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 140000000000 1000000 140009000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	6 AS area_id,     c.id AS candidate_id,     rd.cn_presence AS presence,     rd.cn_score AS score FROM ( 	SELECT 		registration,         cn_presence,         cn_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 150000000000 1000000 150008000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	6 AS area_id,     c.id AS candidate_id,     rd.cn_presence AS presence,     rd.cn_score AS score FROM ( 	SELECT 		registration,         cn_presence,         cn_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done

for d in `seq 160000000000 1000000 160009000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -psomosedu appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	6 AS area_id,     c.id AS candidate_id,     rd.cn_presence AS presence,     rd.cn_score AS score FROM ( 	SELECT 		registration,         cn_presence,         cn_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
done

# for d in `seq 200000000000 1000000 200005000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	6 AS area_id,     c.id AS candidate_id,     rd.cn_presence AS presence,     rd.cn_score AS score FROM ( 	SELECT 		registration,         cn_presence,         cn_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 300000000000 1000000 300006000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	6 AS area_id,     c.id AS candidate_id,     rd.cn_presence AS presence,     rd.cn_score AS score FROM ( 	SELECT 		registration,         cn_presence,         cn_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 400000000000 1000000 400006000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	6 AS area_id,     c.id AS candidate_id,     rd.cn_presence AS presence,     rd.cn_score AS score FROM ( 	SELECT 		registration,         cn_presence,         cn_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 100000000000 1000000 100005000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	7 AS area_id,     c.id AS candidate_id,     rd.lc_presence AS presence,     rd.lc_score AS score FROM ( 	SELECT 		registration,         lc_presence,         lc_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 130000000000 1000000 130013000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	7 AS area_id,     c.id AS candidate_id,     rd.lc_presence AS presence,     rd.lc_score AS score FROM ( 	SELECT 		registration,         lc_presence,         lc_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 140000000000 1000000 140009000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	7 AS area_id,     c.id AS candidate_id,     rd.lc_presence AS presence,     rd.lc_score AS score FROM ( 	SELECT 		registration,         lc_presence,         lc_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 150000000000 1000000 150008000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	7 AS area_id,     c.id AS candidate_id,     rd.lc_presence AS presence,     rd.lc_score AS score FROM ( 	SELECT 		registration,         lc_presence,         lc_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done

for d in `seq 160000000000 1000000 160009000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -psomosedu appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	7 AS area_id,     c.id AS candidate_id,     rd.lc_presence AS presence,     rd.lc_score AS score FROM ( 	SELECT 		registration,         lc_presence,         lc_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
done

# for d in `seq 200000000000 1000000 200005000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	7 AS area_id,     c.id AS candidate_id,     rd.lc_presence AS presence,     rd.lc_score AS score FROM ( 	SELECT 		registration,         lc_presence,         lc_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 300000000000 1000000 300006000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	7 AS area_id,     c.id AS candidate_id,     rd.lc_presence AS presence,     rd.lc_score AS score FROM ( 	SELECT 		registration,         lc_presence,         lc_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 400000000000 1000000 400006000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	7 AS area_id,     c.id AS candidate_id,     rd.lc_presence AS presence,     rd.lc_score AS score FROM ( 	SELECT 		registration,         lc_presence,         lc_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 100000000000 1000000 100005000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	8 AS area_id,     c.id AS candidate_id,     rd.mt_presence AS presence,     rd.mt_score AS score FROM ( 	SELECT 		registration,         mt_presence,         mt_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 130000000000 1000000 130013000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	8 AS area_id,     c.id AS candidate_id,     rd.mt_presence AS presence,     rd.mt_score AS score FROM ( 	SELECT 		registration,         mt_presence,         mt_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 140000000000 1000000 140009000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	8 AS area_id,     c.id AS candidate_id,     rd.mt_presence AS presence,     rd.mt_score AS score FROM ( 	SELECT 		registration,         mt_presence,         mt_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 150000000000 1000000 150008000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	8 AS area_id,     c.id AS candidate_id,     rd.mt_presence AS presence,     rd.mt_score AS score FROM ( 	SELECT 		registration,         mt_presence,         mt_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done

for d in `seq 160000000000 1000000 160009000000`; do
  u=$((d+1000000))
  echo $d, $u
  time mysql -udatascience -psomosedu appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	8 AS area_id,     c.id AS candidate_id,     rd.mt_presence AS presence,     rd.mt_score AS score FROM ( 	SELECT 		registration,         mt_presence,         mt_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
done

# for d in `seq 200000000000 1000000 200005000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	8 AS area_id,     c.id AS candidate_id,     rd.mt_presence AS presence,     rd.mt_score AS score FROM ( 	SELECT 		registration,         mt_presence,         mt_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 300000000000 1000000 300006000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	8 AS area_id,     c.id AS candidate_id,     rd.mt_presence AS presence,     rd.mt_score AS score FROM ( 	SELECT 		registration,         mt_presence,         mt_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
#
# for d in `seq 400000000000 1000000 400006000000`; do
#   u=$((d+1000000))
#   echo $d, $u
#   time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e " SET foreign_key_checks=0; SET unique_checks=0; INSERT IGNORE INTO scores SELECT 	8 AS area_id,     c.id AS candidate_id,     rd.mt_presence AS presence,     rd.mt_score AS score FROM ( 	SELECT 		registration,         mt_presence,         mt_score 	FROM rawdata     WHERE registration BETWEEN $d AND $u ) AS rd INNER JOIN candidates AS c 	ON c.registration = rd.registration;"
# done
