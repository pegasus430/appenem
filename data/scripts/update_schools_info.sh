for d in `seq 2500 100 78700`; do
  u=$((d+100))
  echo $d, $u
  time mysql -udatascience -p<password> appenem -hfoster.cemfxnd3rpcm.us-east-1.rds.amazonaws.com -e "UPDATE schools AS s   SET s.status = (SELECT school_status FROM rawdata WHERE school_code = s.inep_code AND school_status IS NOT NULL ORDER BY year DESC LIMIT 1),   s.dependency = (SELECT school_dependency FROM rawdata WHERE school_code = s.inep_code AND school_dependency IS NOT NULL ORDER BY year DESC LIMIT 1),   s.location = (SELECT school_location FROM rawdata WHERE school_code = s.inep_code AND school_location IS NOT NULL ORDER BY year DESC LIMIT 1) WHERE s.id BETWEEN $d AND $u;"
done
