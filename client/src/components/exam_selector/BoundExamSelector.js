import ExamSelector from './ExamSelector';
import { connect } from 'react-redux';

const mapStateToProps = (state) => (
  {
    exams: state.user.exams,
    selected: state.user.exams.filter(exam => exam.id === state.user.exam_id)[0]
  }
);

const BoundExamSelector = connect(mapStateToProps)(ExamSelector);

export default BoundExamSelector;
