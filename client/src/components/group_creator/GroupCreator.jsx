import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Card, CardTitle, Input, ProgressBar, Button } from 'react-toolbox';
import { Table, TableRow, TableCell } from 'react-toolbox';
import { debounce } from 'throttle-debounce';
import { saveGroup } from '../../reducers/user';
import api from '../../api';

import styles from './GroupCreator.css';
import theme from './SearchInput.css';

class GroupCreator extends Component {
  state = {
    isFetching: false,
    name: '',
    selected: [],
    available: [],
    term: ''
  }

  updateTerm = (value) => {
    this.setState({ term: value  });
    this.setState({ isFetching: true });
    this.debouncedFetchSchools();
  }

  updateName = (value) => {
    this.setState({ name: value  });
  }

  addSchool = (school) => {
    if (this.state.selected.filter(s => s.id === school.id).length > 0) return;
    this.setState({ selected: [...this.state.selected, school] });
  }

  removeSchool = (school) => {
    this.setState({ selected: this.state.selected.filter(s => s.id !== school.id) });
  }

  fetchSchools = () => {
    if (this.state.term.length === 0) {
      return this.setState({ isFetching: false });
    };

    this.setState({ isFetching: true });

    api.searchSchool(this.state.term)
       .then(response => response.json(),
             error => this.setState({ available: [], isFetching: false }))
       .then(json => this.setState({ available: json, isFetching: false }));
  }

  saveGroup = () => {
    let { name, selected } = this.state;
    this.props.dispatch(saveGroup(
      { group: {
        school_ids: selected.map(s => s.id), name
      }}
    ));
    this.setState({
      isFetching: false,
      name: '',
      selected: [],
      available: [],
      term: ''
    });
  }

  debouncedFetchSchools = debounce(300, this.fetchSchools)

  render() {
    const { isFetching, term, selected, available, name } = this.state;
    let message = null;

    if (isFetching) {
      message = <ProgressBar type='circular' className={ styles.center } />;
    } else if (term.length === 0) {
      message = <span className={ styles.spaced }>Procure alguma escola pelo seu nome</span>;
    } else if (available.length === 0) {
      message = (
        <span className={ styles.spaced }>
          Nenhuma escola encontrada usando o termo
          <strong> {term} </strong>
        </span>
      );
    } else {
      message = (
        <Table selectable={ false }>
          { available.map((school, index) => (
            <TableRow key={ index }>
              <TableCell>{ school.name }</TableCell>
              <TableCell numeric>
                <Button onClick={ () => this.addSchool(school) }
                        icon='add'
                        label='Adicionar' />
              </TableCell>
            </TableRow>
          ))}
        </Table>
      );
    }

    return (
      <div>
        <Card>
          <CardTitle>Novo grupo de comparação</CardTitle>
          <Input value={ term }
                 onChange={ this.updateTerm }
                 type='text'
                 label='Buscar escola'
                 theme={ theme } />
          { message }
        </Card>

        { selected.length > 0 && (
          <Card className={ styles.group }>
            <Input value={ name }
                   onChange={ this.updateName }
                   type='text'
                   label='Nome do grupo'
                   theme={theme} />
            <Table selectable={ false }>
              { selected.map((school, index) => (
                <TableRow key={ index }>
                  <TableCell>{ school.name }</TableCell>
                  <TableCell numeric>
                    <Button onClick={ () => this.removeSchool(school) }
                            icon='remove'
                            label='Remover' />
                  </TableCell>
                </TableRow>
              ))}
            </Table>
            { name.length > 0 && (
              <Button primary
                      onClick={ this.saveGroup }
                      icon='save'
                      label='Salvar grupo' />
            )}
          </Card>
        )}
      </div>
    );
  }
};

export default connect()(GroupCreator);
