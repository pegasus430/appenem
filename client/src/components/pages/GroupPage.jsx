import React from 'react';
import { BoundGroupList } from '../group_list';
import { GroupCreator } from '../group_creator';

import styles from './Page.css';

const GroupPage = () => (
  <div className={ styles.spaced }>
    <BoundGroupList />
    <GroupCreator />
  </div>
);

export default GroupPage;
