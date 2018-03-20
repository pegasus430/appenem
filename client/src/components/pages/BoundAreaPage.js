import { connect } from 'react-redux';
import { withRouter } from 'react-router';

import AreaPage from './AreaPage';

const mapStateToProps = (state, { match, dispatch }) => {
  return {
    area: state.areas.filter(
      (area) => (area.id === parseInt(match.params.area_id, 10)))[0]
  };
};

const BoundAreaPage = connect(mapStateToProps)(withRouter(AreaPage));

export default BoundAreaPage;
