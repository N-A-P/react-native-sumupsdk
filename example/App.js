/**
 * Sample React Native App
 *
 * adapted from App.js generated by the following command:
 *
 * react-native init example
 *
 * https://github.com/facebook/react-native
 */

import React from 'react';
import {Button, StyleSheet, Text, View} from 'react-native';
import ReactNativeSumupsdk from 'react-native-sumupsdk';

const AFFILIATE_API_KEY = 'YOUR_API_KEY';
const ACCESS_TOKEN = 'ACCESS_TOKEN';


export function App() {

  const pressed = async () => {
    // try {
    // } catch (error) {
    //   console.log('ERROR', error);
    // }
  };

  const requestPayment = async () => {
    try {
      await ReactNativeSumupsdk.requestPayment(
        '15.4',
        'Title test',
        true,
        `foreginTransactionID ${Math.random()}`, // make sure it unique
      );
    } catch (error) {
      console.log('ERROR ', error);
    }
  };

  const login = async () => {
    try {
      const res = await ReactNativeSumupsdk.loginWithToken(ACCESS_TOKEN);
      console.log(' login ok ', res);
    } catch (error) {
      console.log('ERROR login', error);
    }
  };

  const setup = async () => {
    try {
      const res = await ReactNativeSumupsdk.setupWithKey(AFFILIATE_API_KEY);
      console.log(' Setup ok ', res);
    } catch (error) {
      console.log('ERROR ', error);
    }
  };

  const setupAndLogin = async () => {
    try {
      const res = await ReactNativeSumupsdk.setupAndLogin(
        AFFILIATE_API_KEY,
        ACCESS_TOKEN,
      );
      console.log(' Setup and login ok ', res);
    } catch (error) {
      console.log('ERROR ', error);
    }
  };
  return (
    <View style={styles.container}>
      <Text style={styles.welcome}>☆ReactNativeSumupsdk example☆</Text>
      <Button title="Test" onPress={pressed} />
      <Button title="setup" onPress={setup} />
      <Button title="Login" onPress={login} />
      <Button title="setup and login" onPress={setupAndLogin} />
      <Button title="Request payment" onPress={requestPayment} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
