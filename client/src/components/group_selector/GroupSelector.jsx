import React, { Component } from 'react';
import { Button, Menu, MenuItem, FontIcon, Tooltip } from 'react-toolbox';

import { changeGroup } from '../../reducers/user';

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

import styles from './GroupSelector.css';

const TooltipButton = Tooltip(Button);

class GroupSelector extends Component {
  state = {
    active: false
  }

  toggleMenu = () => {
    this.setState({ active: !this.state.active });
  }

  disableMenu = () => {
    this.setState({ active: false });
  }

  onGroupSelect = (group_id) => {
    if (group_id !== this.props.selected.id) {
      this.props.dispatch(changeGroup(group_id));
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
        <TooltipButton flat
                       tooltip={ this.props.selected.name }
                       theme={ styles }
                       onClick={ this.toggleMenu }>
          <FontIcon value='layers' />
          { ` ${ this.props.selected.name }` }
        </TooltipButton>
        <Menu onSelect={ this.onGroupSelect }
              position='auto'
              onHide={ this.disableMenu }
              active={ this.state.active }
              selected={ this.props.selected.id }>
          { this.props.groups.map((group, index) => (
            <MenuItem key={ index } value={ group.id }>{ group.name }</MenuItem>
          ))}
        </Menu>
      </div>
    );
  }
}

export default GroupSelector;
