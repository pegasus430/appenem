import React from 'react';
import styles from './ScoreDisplay.css';

const ScoreDisplay = ({name, score}) => (
  <div>
    <h2 className={styles.caption}>{name}</h2>
    <h1 className={styles.score}>{score}<span>pts</span></h1>
  </div>
);

export default ScoreDisplay;
