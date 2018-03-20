import { connect } from 'react-redux';
import { withRouter } from 'react-router';

import Menu from './Menu';

const mapStateToProps = state => (
  { areas: state.areas }
)

const BoundMenu = withRouter(connect(mapStateToProps)(Menu));

export default BoundMenu;
