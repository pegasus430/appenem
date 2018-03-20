import React from 'react';
import { NavLink } from 'react-router-dom';

import styles from './StyledNavLink.css';

const StyledNavLink = ({ children, ...props }) => (
  <span className={ styles.styled }>
    <NavLink {...props} activeClassName={ styles.active }>{children}</NavLink>
  </span>
);

export default StyledNavLink;
