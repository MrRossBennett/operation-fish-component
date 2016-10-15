import React from 'react';
import { storiesOf } from '@kadira/storybook';
import Test from '../Test';

storiesOf('Test', module)
  .add('Regular version', () => (
    <Test word="hello" />
  ));
