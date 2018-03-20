import React from 'react';
import numeral from 'numeraljs';
import { Card, CardTitle } from 'react-toolbox';
import { Table, TableHead, TableRow, TableCell } from 'react-toolbox';
import { ProgressBar } from 'react-toolbox';
import QuestionDetail from './QuestionDetail';
import { GroupProgressBar, SchoolProgressBar } from '../colored_progressbar';
import ContentLoader from '../content_loader';

import styles from './QuestionComparison.css';

const QuestionComparison = ({ values, selected, onQuestionClick }) => (
  <Card>
    <CardTitle>Questões</CardTitle>
    <Table selectable={ false }>
      <TableHead>
        <TableCell>Questão</TableCell>
        <TableCell>Habilidade</TableCell>
        <TableCell>Disciplina</TableCell>
        <TableCell width={'20%'}>Sua escola</TableCell>
        <TableCell numeric> </TableCell>
        <TableCell width={'20%'}>Grupo de comparação</TableCell>
        <TableCell numeric> </TableCell>
      </TableHead>
      { values.map((question, index) => {
        if (selected.id === question.id) {
          return (
            <TableRow key={ index } className={ styles.content }>
              <TableCell colSpan={7}>
                <QuestionDetail {...selected} />
              </TableCell>
            </TableRow>
          );
        } else {
          return (
            <TableRow key={ index } onClick={ () => onQuestionClick(question.id) } className={ styles.line }>
              <TableCell>{ question.label }</TableCell>
              <TableCell>{ question.skill.label }</TableCell>
              <TableCell>{ question.subject.name }</TableCell>
              <TableCell numeric>
                <SchoolProgressBar mode='determinate' max={ question.own_answers }
                             value={ question.own_correct_answers } />
              </TableCell>
              <TableCell numeric>
                { numeral(question.own_correct_answers /
                          question.own_answers || 0).format('0.0%') }
              </TableCell>
              <TableCell numeric>
                <GroupProgressBar mode='determinate' max={ question.comparison_answers }
                             value={ question.comparison_correct_answers } />
              </TableCell>
              <TableCell numeric>
                { numeral(question.comparison_correct_answers /
                          question.comparison_answers || 0).format('0.0%') }
              </TableCell>
            </TableRow>
          );
        }
      })}
    </Table>
  </Card>
);

export default ContentLoader()(QuestionComparison);
