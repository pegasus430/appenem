import React from 'react';
import { ProgressBar } from 'react-toolbox';
import groupStyle from './GroupProgressBar.css';

const GroupProgressBar = (props) => (
  <ProgressBar theme={groupStyle} {...props} />
);

export default GroupProgressBar;
