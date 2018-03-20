import React from 'react';
import PropTypes from 'prop-types';

import styles from './Icon.css';

const Icon = ({name}) => (
  <span className={styles.icon}>
    <i className={`ae-${name}`}></i>
  </span>
);

Icon.propTypes = {
  name: PropTypes.string.isRequired
};

export default Icon;
