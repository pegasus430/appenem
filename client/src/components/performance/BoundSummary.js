import { connect } from 'react-redux';
import { changeAmplitude } from '../../reducers/school';
import Summary from './Summary';

const mapStateToProps = (state) => {
  const { amplitude, summary } = state.school;

  const transformed = summary.isFetching ? summary : {
    ...summary,
    positions: summary.positions.map((position) => ({
      ...position,
        selected: position.type === amplitude
    }))
  };

  return transformed;
};

const mapDispatchToProps = (dispatch) => ({
  onRankingSelect: (type) => (dispatch(changeAmplitude(type)))
});

const BoundSummary = connect(mapStateToProps, mapDispatchToProps)(Summary);

export default BoundSummary;
