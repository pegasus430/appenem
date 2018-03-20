import React from 'react';
import PropTypes from 'prop-types';

import { Card, CardTitle } from 'react-toolbox';
import { Table, TableHead, TableRow, TableCell } from 'react-toolbox';

import BoundSummary from './BoundSummary';
import ContentLoader from '../content_loader';

import styles from './Performance.css';

const ExcerptView = ({ id, areas, schools }) => (
  <Table selectable={ false }>
    <TableHead>
      <TableCell> </TableCell>
      <TableCell>Nome</TableCell>
      <TableCell>Geral</TableCell>
      { areas.map((area, index) => (
        <TableCell key={ index }>{ area }</TableCell>
      ))}
    </TableHead>

    { schools.map((school, index) => (
        <TableRow key={ index } className={ (id === school.id) ? styles.active : '' }>
          <TableCell>{ school.position }º</TableCell>
          <TableCell>{ school.name }</TableCell>
          <TableCell>{ school.general_score }</TableCell>
          { school.area_scores.map((score, index) => (
            <TableCell key={ index }>{ score }</TableCell>
          ))}
        </TableRow>
      )
    )}
  </Table>
)

ExcerptView.propTypes = {
  areas: PropTypes.arrayOf(PropTypes.string.isRequired),
  schools: PropTypes.arrayOf(PropTypes.shape({
    position: PropTypes.number.isRequired,
    name: PropTypes.string.isRequired,
    general_score: PropTypes.string.isRequired,
    area_scores: PropTypes.arrayOf(PropTypes.string.isRequired).isRequired
  }))
};

const Excerpt = ContentLoader()(ExcerptView);

const Performance = ({ amplitude, excerpt }) => {
  return <Card>
    <div className={ styles.header }>
      <CardTitle>Desempenho no ENEM</CardTitle>
      <BoundSummary />
    </div>
    <Excerpt { ...excerpt } />
  </Card>
};

Performance.propTypes = {
  excerpt: PropTypes.object.isRequired
};

export default Performance;
