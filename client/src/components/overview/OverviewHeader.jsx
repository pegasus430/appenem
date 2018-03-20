import React from 'react';
import { CardTitle } from 'react-toolbox/lib/card/';
import ScoreDisplay from './ScoreDisplay';
import ContentLoader from '../content_loader';
import { connect } from 'react-redux';
import styles from './OverviewHeader.css';

const mapStateToProps = (state) => (
  state.school.overviewHeader
);

const OverviewHeader = ({isFetching, school, comparison_group}) => (
  <header className={styles.header}>
    <div className={styles.schoolHeader}>
      <CardTitle
        title="Sua Escola"
      />
      <section className={styles.scores}>
        <ScoreDisplay name='Média TRI' score={school.avg_score}/>
        <ScoreDisplay name='Mínimo' score={school.min_score}/>
        <ScoreDisplay name='Máximo' score={school.max_score}/>
      </section>
    </div>
    <div className={styles.comparisonHeader}>
      <CardTitle
        title="Grupo de Comparação"
      />
      <section className={styles.scores}>
        <ScoreDisplay name='Média TRI' score={comparison_group.avg_score}/>
        <ScoreDisplay name='Mínimo' score={comparison_group.min_score}/>
        <ScoreDisplay name='Máximo' score={comparison_group.max_score}/>
      </section>
    </div>
  </header>
);

export default connect(mapStateToProps)(ContentLoader()(OverviewHeader));
