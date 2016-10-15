import React from 'react';
import cssModules from 'react-css-modules';
import classNames from 'classnames';

import { SVG_MAP } from '../../constants/paths';
import styles from './Test.scss';

const Test = (props) => {

  const classes = classNames({
    test: true,
  });
  const { word } = props;
  const svgIcon = `${SVG_MAP}#cross`;

  return (
    <div styleName={classes}>
      <svg>
        <use xlinkHref={svgIcon}></use>
      </svg>
      {word}
    </div>
  );
};

Test.propTypes = {
  word: React.PropTypes.string.isRequired
};

export default cssModules(Test, styles, { allowMultiple: true });
