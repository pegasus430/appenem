import { connect } from 'react-redux';
import { withRouter } from 'react-router';
import App from './App';

const mapStateToProps = (state) => (
  state.user
);

const BoundApp = withRouter(connect(mapStateToProps)(App));

export default BoundApp;
