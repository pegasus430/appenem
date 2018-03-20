import React from 'react';
import { Card, CardTitle, Table, TableHead, TableCell, TableRow,
         Button } from 'react-toolbox';

import { removeGroup } from '../../reducers/user';

const GroupList = ({ groups, selected, dispatch }) => (
  <Card>
    <CardTitle>Meus grupos</CardTitle>
    <Table selectable={ false }>
      <TableHead>
        <TableCell>Nome</TableCell>
        <TableCell numeric> </TableCell>
      </TableHead>
      { groups.map((group, index) => (
        <TableRow key={ index } selected={ selected.id === group.id }>
          <TableCell>{ group.name }</TableCell>
          <TableCell numeric>
            { selected.id === group.id
              ? ''
              : <Button primary onClick={ () => dispatch(removeGroup(group)) } label='Excluir' icon='delete' /> }
          </TableCell>
        </TableRow>
      ))}
    </Table>
  </Card>
);

export default GroupList;
