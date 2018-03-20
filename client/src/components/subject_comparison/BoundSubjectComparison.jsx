import { connect } from 'react-redux';
import SubjectComparison from './SubjectComparison';

const mapStateToProps = (state) => (
  state.school.subjects
);

const BoundSubjectComparison = connect(mapStateToProps)(SubjectComparison);

export default BoundSubjectComparison;
