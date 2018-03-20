import React, { Component } from 'react';
import { Button, FontIcon, Menu, MenuItem, Tooltip, MenuDivider,
         Input, ProgressBar } from 'react-toolbox';
import { debounce } from 'throttle-debounce';
import api from '../../api';

import { changeSchool, setSpecialSchool } from '../../reducers/user';

import { fetchSchool,
         fetchSchoolExcerpt,
         fetchSchoolComparison,
         fetchSchoolQuestions,
         fetchSchoolOverviewHeader,
         fetchSchoolSubjects,
         fetchSchoolEvolution,
         fetchSchoolHistogram,
         fetchSchoolTags,
         fetchSchoolSkills } from '../../reducers/school';

import styles from './SchoolSelector.css';
import theme from './SearchInput.css';

const TooltipButton = Tooltip(Button);

class SchoolSelector extends Component {
  state = {
    active: false,
    available: [],
    term: '',
    isFetching: false
  }

  toggleMenu = () => {
    this.setState({ active: !this.state.active });
  }

  disableMenu = () => {
    this.setState({ active: false });
  }

  clearTerm = () => {
    this.setState({ term: '' });
  }

  onSchoolSelect = (school_id) => {
    if (school_id !== this.props.selected.id) {
      this.props.dispatch(changeSchool(school_id));
      this.props.dispatch(fetchSchool());
      this.props.dispatch(fetchSchoolExcerpt());
      this.props.dispatch(fetchSchoolComparison());
      this.props.dispatch(fetchSchoolOverviewHeader());
      this.props.dispatch(fetchSchoolHistogram());
      this.props.dispatch(fetchSchoolEvolution());
      this.props.dispatch(fetchSchoolSubjects());
      this.props.dispatch(fetchSchoolTags());
      this.props.dispatch(fetchSchoolSkills());
      this.props.dispatch(fetchSchoolQuestions());
    }
  }

  updateTerm = (value) => {
    this.setState({ term: value, isFetching: true  });
    this.debouncedFetchSchools();
  }

  addSpecial = (school) => {
    this.disableMenu();
    this.props.dispatch(setSpecialSchool(school));
    this.onSchoolSelect(school.id);
    this.clearTerm();
  }

  componentDidUpdate() {
    if (this.state.active) this.menu.show();
  }

  fetchSchools = () => {
    if (this.state.term.length === 0) {
      return this.setState({ isFetching: false });
    };

    this.setState({ isFetching: true });

    api.searchSchoolWithExams(this.state.term)
       .then(response => response.json(),
             error => this.setState({ available: [], isFetching: false }))
       .then(json => this.setState({ available: json, isFetching: false }));
  }

  debouncedFetchSchools = debounce(300, this.fetchSchools)

  render() {
    let message;
    const { isFetching, term, schools, available } = this.state;

    if (isFetching) {
      message = <ProgressBar type='circular' className={ styles.center } />;
    } else if (term.length === 0) {
      message = (
        <div className={ styles.spaced }>Procure alguma escola pelo seu nome</div>
      );
    } else if (available.length === 0) {
      message = (
        <div className={ styles.spaced }>
          Nenhuma escola encontrada usando o termo
          <strong> {term} </strong>
        </div>
      );
    } else {
      message = (
        <div className={ styles.available }>
          { available.map((school, index) => (
            <MenuItem key={ index }
                      onClick={ () => this.addSpecial(school) }
                      value={ school.id }>{ school.name }</MenuItem>
          ))}
        </div>
      );
    }

    return (
      <div className={ styles.anchor }>
        <TooltipButton tooltip={ this.props.selected.name }
                       flat
                       theme={ styles }
                       onClick={ this.toggleMenu }>
          <FontIcon value='school' />
          { ` ${ this.props.selected.name }` }
        </TooltipButton>
        <Menu onSelect={ this.onSchoolSelect }
              position='auto'
              onHide={ this.disableMenu }
              active={ this.state.active }
              selected={ this.props.selected.id }
              innerRef={ (menu) => { this.menu = menu; } }>
          { this.props.schools.map((school, index) => (
            <MenuItem key={ index } value={ school.id }>{ school.name }</MenuItem>
          ))}
          { this.props.fullAccess ? (
            <div className={ styles.search }>
              <MenuDivider />
              <Input
                theme={ theme }
                icon='school'
                type='text'
                label='Buscar escola'
                value={ term }
                onChange={ this.updateTerm } />
              { message }
            </div>
          ) : null }
        </Menu>
      </div>
    );
  }
}

export default SchoolSelector;
