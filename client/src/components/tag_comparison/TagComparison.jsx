import React from 'react';
import numeral from 'numeraljs';
import { Card, CardTitle } from 'react-toolbox';
import { Table, TableHead, TableRow, TableCell } from 'react-toolbox';
import { ProgressBar } from 'react-toolbox';
import { GroupProgressBar, SchoolProgressBar } from '../colored_progressbar';
import ContentLoader from '../content_loader';

const TagComparison = ContentLoader()(
  ({ values }) => (
    <Table selectable={ false }>
      <TableHead>
        <TableCell>Conteúdos</TableCell>
        <TableCell width={'20%'}>Sua escola</TableCell>
        <TableCell numeric> </TableCell>
        <TableCell width={'20%'}>Grupo de comparação</TableCell>
        <TableCell numeric> </TableCell>
      </TableHead>
      { values.map((tag, index) => (
        <TableRow key={ index }>
          <TableCell>{ tag.name }</TableCell>
          <TableCell numeric>
            <SchoolProgressBar mode='determinate' max={ tag.own_answers }
                         value={ tag.own_correct_answers } />
          </TableCell>
          <TableCell numeric>
            { numeral(tag.own_correct_answers /
                      tag.own_answers || 0).format('0.0%') }
          </TableCell>
          <TableCell numeric>
            <GroupProgressBar mode='determinate' max={ tag.comparison_answers }
                         value={ tag.comparison_correct_answers } />
          </TableCell>
          <TableCell numeric>
            { numeral(tag.comparison_correct_answers /
                      tag.comparison_answers || 0).format('0.0%') }
          </TableCell>
        </TableRow>
      ))}
    </Table>
  )
);

export default (props) => (
  <Card>
    <CardTitle>Conteúdos</CardTitle>
    <TagComparison {...props} />
  </Card>
);
