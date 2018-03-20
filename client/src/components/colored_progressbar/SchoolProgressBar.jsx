import React from 'react';
import { ProgressBar } from 'react-toolbox';
import schoolStyle from './SchoolProgressBar.css';

const SchoolProgressBar = (props) => (
  <ProgressBar theme={schoolStyle} {...props} />
);

export default SchoolProgressBar;
