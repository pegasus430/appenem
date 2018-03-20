import { connect } from 'react-redux';
import CrispLoader from './CrispLoader';

const mapStateToProps = ({ user }) => (
  {
    user: user,
    school: user.schools.filter((school) => school.id === user.school_id)[0]
  }
);

const BoundCrispLoader = connect(mapStateToProps)(CrispLoader);

export default BoundCrispLoader;
