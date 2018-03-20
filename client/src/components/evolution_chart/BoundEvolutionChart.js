import { connect } from 'react-redux';
import EvolutionChart from './EvolutionChart';

const mapStateToProps = (state) => (
  state.school.evolution
);

const BoundEvolutionChart = connect(mapStateToProps)(EvolutionChart);

export default BoundEvolutionChart;
