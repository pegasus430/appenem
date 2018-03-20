import React from 'react';

import { BoundPerformance } from '../performance/';
import { BoundRankingChart } from '../ranking_chart/';

import base from './Page.css';

const HomePage = () => (
  <div className={ base.spaced }>
    <BoundPerformance />
    <BoundRankingChart reversed />
  </div>
);

export default HomePage;
