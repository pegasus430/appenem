import React from 'react';
import { Card } from 'react-toolbox/lib/card/';
import { OverviewHeader } from '../overview';
import { BoundSubjectComparison } from '../subject_comparison';
import { BoundEvolutionChart } from '../evolution_chart';
import { BoundHistogramChart } from '../histogram_chart';

import styles from './OverviewPage.css';

const OverviewPage = () => (
  <div>
    <Card>
      <OverviewHeader />
      <BoundHistogramChart />
    </Card>
    <div className={ styles.container }>
      <BoundEvolutionChart />
      <BoundSubjectComparison />
    </div>
  </div>
);

export default OverviewPage;
