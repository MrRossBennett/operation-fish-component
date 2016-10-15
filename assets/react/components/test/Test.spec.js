import React from 'react';
import { shallow } from 'enzyme';
import Test from './Test';

describe('SearchButton', () => {
  const props = {
    word: 'hello'
  };
  const element = shallow(<Test {...props} />);

  it('should contain a div with the correct class', () => {
    const div = element.find(`div.test`);
    expect(div.length).toEqual(1);
  });
});
