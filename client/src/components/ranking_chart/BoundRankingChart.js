import { connect } from 'react-redux';
import RankingChart from './RankingChart';

const mapStateToProps = (state) => (state.school.comparison);

const BoundRankingChart = connect(mapStateToProps)(RankingChart);

export default BoundRankingChart;
