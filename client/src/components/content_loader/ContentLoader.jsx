import React from 'react';
import PropTypes from 'prop-types';
import { ProgressBar } from 'react-toolbox';

import primary from './PrimaryProgressBar.css';
import contrast from './ContrastProgressBar.css';

const ContentLoader = (color = 'primary') => {
  return (Component) => {
    const Loader = ({ isFetching = true, ...props }) => {
      if (isFetching)
        return <ProgressBar type='circular'
                            theme={ color === 'primary' ? primary : contrast } />;
      else
        return <Component { ...props } />;
    };

    Loader.propTypes = {
      isFetching: PropTypes.bool.isRequired
    };

    return Loader;
  };
};

ContentLoader.propTypes = {
  color: PropTypes.oneOf(['primary', 'contrast'])
};

export default ContentLoader;
