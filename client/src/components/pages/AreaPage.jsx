import React, { Component } from 'react';
import { NavLink, Route } from 'react-router-dom';
import { BoundQuestionComparison } from '../question_comparison';
import { BoundTagComparison } from '../tag_comparison';
import { BoundSkillComparison } from '../skill_comparison';
import styles from './AreaPage.css';

import { changeArea } from '../../reducers/user';
import { fetchSchoolQuestions,
         fetchSchoolOverviewHeader,
         fetchSchoolSubjects,
         fetchSchoolEvolution,
         fetchSchoolHistogram,
         fetchSchoolTags,
         fetchSchoolSkills } from '../../reducers/school';

import OverviewPage from './OverviewPage';

const StyledNavLink = (props) => (
  <NavLink {...props} activeClassName={ styles.active } />
);

class AreaPage extends Component {
  refetch(area_id) {
    this.props.dispatch(changeArea(area_id));
    this.props.dispatch(fetchSchoolOverviewHeader());
    this.props.dispatch(fetchSchoolHistogram());
    this.props.dispatch(fetchSchoolEvolution());
    this.props.dispatch(fetchSchoolSubjects());
    this.props.dispatch(fetchSchoolTags());
    this.props.dispatch(fetchSchoolSkills());
    this.props.dispatch(fetchSchoolQuestions());
  }

  componentWillMount() {
    this.refetch(this.props.match.params.area_id);
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.match.params.area_id !== this.props.match.params.area_id) {
      this.refetch(nextProps.match.params.area_id);
    }
  }

  render() {
    let { area, match } = this.props;
    return (
      <div>
        <div className={ styles.header }>
          <h1>{ area.name }</h1>
          <div className={ styles.tabs }>
            <StyledNavLink to={ match.url } exact>
              Visão Geral
            </StyledNavLink>
            <StyledNavLink to={ match.url + '/tags'}>
              Conteúdos
            </StyledNavLink>
            <StyledNavLink to={ match.url + '/skills'}>
              Habilidades
            </StyledNavLink>
            <StyledNavLink to={ match.url + '/questions'}>
              Questões
            </StyledNavLink>
          </div>
        </div>


        <div className={ styles.content }>
          <Route path={ match.url } exact component={ OverviewPage }/>
          <Route path={ match.url + '/tags'}
                 component={ BoundTagComparison } />
          <Route path={ match.url + '/skills'}
                 component={ BoundSkillComparison } />
          <Route path={ match.url + '/questions'}
                 component={ BoundQuestionComparison } />
        </div>
      </div>
    );
  }
}

export default AreaPage;
