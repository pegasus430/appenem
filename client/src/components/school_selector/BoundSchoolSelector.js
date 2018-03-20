import SchoolSelector from './SchoolSelector';
import { connect } from 'react-redux';

const mapStateToProps = (state) => {
  let schools = state.user.specialSchool
    ? [...state.user.schools, state.user.specialSchool]
    : state.user.schools;

  return {
    fullAccess: state.user.full_access,
    schools: schools,
    selected: schools.filter(school => school.id === state.user.school_id)[0]
  }
};

const BoundSchoolSelector = connect(mapStateToProps)(SchoolSelector);

export default BoundSchoolSelector;
