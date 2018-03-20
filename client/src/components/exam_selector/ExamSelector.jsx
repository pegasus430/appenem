import React, { Component } from 'react';
import { Button, Menu, MenuItem } from 'react-toolbox';

import { changeExam } from '../../reducers/user';

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

import styles from './ExamSelector.css';

class ExamSelector extends Component {
  state = {
    active: false
  }

  toggleMenu = () => {
    this.setState({ active: !this.state.active });
  }

  disableMenu = () => {
    this.setState({ active: false });
  }

  onExamSelect = (exam_id) => {
    if (exam_id !== this.props.selected.id) {
      this.props.dispatch(changeExam(exam_id));
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

  render() {
    return (
      <div className={ styles.anchor }>
        <Button flat theme={ styles }
                onClick={ this.toggleMenu }>{ this.props.selected.year }</Button>
              <Menu onSelect={ this.onExamSelect }
              position='auto'
              onHide={ this.disableMenu }
              active={ this.state.active }
              selected={ this.props.selected.id }>
          { this.props.exams.map((exam, index) => (
            <MenuItem key={ index } value={ exam.id }>{ exam.year }</MenuItem>
          ))}
        </Menu>
      </div>
    );
  }
}

export default ExamSelector;
