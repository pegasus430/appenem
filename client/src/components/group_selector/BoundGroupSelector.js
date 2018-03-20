import GroupSelector from './GroupSelector';
import { connect } from 'react-redux';

const mapStateToProps = (state) => (
  {
    groups: state.user.groups,
    selected: state.user.groups.filter(group => group.id === state.user.group_id)[0]
  }
);

const BoundGroupSelector = connect(mapStateToProps)(GroupSelector);

export default BoundGroupSelector;
