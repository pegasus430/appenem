import { connect } from 'react-redux';
import SkillComparison from './SkillComparison';

const mapStateToProps = (state) => (
  state.school.skills
);

const BoundSkillComparison = connect(mapStateToProps)(SkillComparison);

export default BoundSkillComparison;
