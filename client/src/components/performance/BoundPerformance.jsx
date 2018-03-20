import { connect } from 'react-redux';
import Performance from './Performance';

const mapStateToProps = (state) => (state.school);
const BoundPerformance = connect(mapStateToProps)(Performance);

export default BoundPerformance;
