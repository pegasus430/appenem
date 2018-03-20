import React from 'react';
import PropTypes from 'prop-types';

import { FontIcon, Ripple } from 'react-toolbox';

import ContentLoader from '../content_loader/';

import styles from './Summary.css';

const Tab = Ripple()(
  ({ selected, theme, children, ...props }) => (
    <div {...props} className={ selected ? styles.selected : styles.tab }>
      { children }
    </div>
  )
);

const GeneralScore = ({ score }) => (
  <Tab disabled>
    <h2>Geral</h2>
    <h1>{score}<small>pts</small></h1>
  </Tab>
);

const RankingPosition = ({ name, position, displacement, ...props }) => (
  <Tab {...props}>
    <h2>{name}</h2>
    <h1>
      {position}º
      { displacement !== 0 ?
        <span>
          <FontIcon value={ displacement < 0 ? 'arrow_drop_up' : 'arrow_drop_down' } />
          { Math.abs(displacement) }
        </span> : <span>-</span>
      }
    </h1>
  </Tab>
);

const SummaryView = ({
  score,
  positions,
  onRankingSelect
}) => (
  <div className={ styles.info }>
    <GeneralScore disabled score={ score } />
    { positions.map(
      ({ type, ...props }, index) => (
        <RankingPosition key={ index }
                         onClick={ () => onRankingSelect(type) }
                         {...props} />
      )
    )}
  </div>
);

SummaryView.propTypes = {
  score: PropTypes.number.isRequired,
  positions: PropTypes.array.isRequired
};

const Summary = ContentLoader('contrast')(
  (props) => (<SummaryView {...props} />)
);

export default Summary;
