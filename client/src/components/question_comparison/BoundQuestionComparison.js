import { connect } from 'react-redux';
import QuestionComparison from './QuestionComparison';

import { fetchSchoolQuestion } from '../../reducers/school';

const mapStateToProps = (state) => (
  state.school.questions
);

const mapDispatchToProps = (dispatch) => (
  { onQuestionClick: (id) => dispatch(fetchSchoolQuestion(id)) }
);

const BoundQuestionComparison = connect(mapStateToProps, mapDispatchToProps)(QuestionComparison);

export default BoundQuestionComparison;
