import { connect } from 'react-redux';
import HistogramChart from './HistogramChart';

const mapStateToProps = (state) => (
  state.school.histogram
);

const BoundHistogramChart = connect(mapStateToProps)(HistogramChart);

export default BoundHistogramChart;
