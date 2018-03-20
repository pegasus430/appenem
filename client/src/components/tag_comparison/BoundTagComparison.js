import { connect } from 'react-redux';
import TagComparison from './TagComparison';

const mapStateToProps = (state) => (
  state.school.tags
);

const BoundTagComparison = connect(mapStateToProps)(TagComparison);

export default BoundTagComparison;
