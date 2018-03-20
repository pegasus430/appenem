import { connect } from 'react-redux';
import GroupList from './GroupList';

const mapStateToProps = (state) => (
  { groups: state.user.groups,
    selected: state.user.groups.filter(group => group.id === state.user.group_id)[0]
  }
);

const BoundGroupList = connect(mapStateToProps)(GroupList);

export default BoundGroupList;
