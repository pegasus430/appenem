import React from 'react';
import numeral from 'numeraljs';
import { Card, CardTitle } from 'react-toolbox';
import { Table, TableHead, TableRow, TableCell } from 'react-toolbox';
import { ProgressBar } from 'react-toolbox';
import ContentLoader from '../content_loader';
import { GroupProgressBar, SchoolProgressBar } from '../colored_progressbar';

const SubjectComparison = ContentLoader()(
  ({ values }) => (
    <Table selectable={ false }>
      <TableHead>
        <TableCell>Disciplina</TableCell>
        <TableCell width={'60%'}>Sua escola</TableCell>
        <TableCell numeric> </TableCell>
        <TableCell width={'60%'}>Grupo de comparação</TableCell>
        <TableCell numeric> </TableCell>
      </TableHead>
      { values.map((subject, index) => (
        <TableRow key={ index }>
          <TableCell>{ subject.name }</TableCell>
          <TableCell numeric>
            <SchoolProgressBar mode='determinate' max={ subject.own_answers }
                         value={ subject.own_correct_answers } />
          </TableCell>
          <TableCell numeric>
            { numeral(subject.own_correct_answers /
                      subject.own_answers || 0).format('0.0%') }
          </TableCell>
          <TableCell numeric>
            <GroupProgressBar mode='determinate' max={ subject.comparison_answers }
                         value={ subject.comparison_correct_answers } />
          </TableCell>
          <TableCell numeric>
            { numeral(subject.comparison_correct_answers /
                      subject.comparison_answers || 0).format('0.0%') }
          </TableCell>
        </TableRow>
      ))}
    </Table>
  )
);

export default (props) => (
  <Card>
    <CardTitle>Disciplinas</CardTitle>
    <SubjectComparison {...props} />
  </Card>
);
