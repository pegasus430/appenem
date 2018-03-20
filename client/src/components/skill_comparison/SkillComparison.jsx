import React from 'react';
import numeral from 'numeraljs';
import { Card, CardTitle } from 'react-toolbox';
import { Table, TableHead, TableRow, TableCell } from 'react-toolbox';
import { ProgressBar } from 'react-toolbox';
import { GroupProgressBar, SchoolProgressBar } from '../colored_progressbar';
import ContentLoader from '../content_loader';

const SkillComparison = ContentLoader()(
  ({ values }) => (
    <Table selectable={ false }>
      <TableHead>
        <TableCell>Habilidade</TableCell>
        <TableCell>Descrição</TableCell>
        <TableCell width={'20%'}>Sua escola</TableCell>
        <TableCell numeric> </TableCell>
        <TableCell width={'20%'}>Grupo de comparação</TableCell>
        <TableCell numeric> </TableCell>
      </TableHead>
      { values.map((skill, index) => (
        <TableRow key={ index }>
          <TableCell>{ skill.label }</TableCell>
          <TableCell>{ skill.description }</TableCell>
          <TableCell numeric>
            <SchoolProgressBar mode='determinate' max={ skill.own_answers }
                         value={ skill.own_correct_answers } />
          </TableCell>
          <TableCell numeric>
            { numeral(skill.own_correct_answers /
                      skill.own_answers || 0).format('0.0%') }
          </TableCell>
          <TableCell numeric>
            <GroupProgressBar mode='determinate' max={ skill.comparison_answers }
                         value={ skill.comparison_correct_answers } />
          </TableCell>
          <TableCell numeric>
            { numeral(skill.comparison_correct_answers /
                      skill.comparison_answers || 0).format('0.0%') }
          </TableCell>
        </TableRow>
      ))}
    </Table>
  )
);

export default (props) => (
  <Card>
    <CardTitle>Habilidades</CardTitle>
    <SkillComparison {...props} />
  </Card>
);
