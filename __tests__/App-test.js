/**
 * @format
 */

import 'react-native';
import React from 'react';
import App from '../App';
import {NativeEventEmitter} from 'react-native';

// Note: test renderer must be required after react-native.
import renderer from 'react-test-renderer';
import { JestEnvironment } from '@jest/environment';


it('renders correctly', () => {
  let scanData =  renderer.create(<App />).getInstance();
  scanData.startCardScan();
  console.log(scanData.startCardScan());
});

jest.mock('NativeEventEmitter');

const nativeEmitter = new NativeEventEmitter();
nativeEmitter.emit('sayHello');