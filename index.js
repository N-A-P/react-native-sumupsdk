// main index.js

import { NativeModules } from "react-native";

const { RNSumupSDK } = NativeModules;

const RNSumupsdk = {
  setupAndLogin: ({ affiliateKey, accessToken }) => {
    return RNSumupSDK.setupAndLogin(affiliateKey, accessToken);
  },
  setupWithKey: ({ affiliateKey }) => {
    return RNSumupSDK.setupWithKey(affiliateKey);
  },
  loginWithToken: ({ accessToken }) => {
    return RNSumupSDK.loginWithToken(accessToken);
  },
  requestPayment: ({
    ammount,
    title,
    skipRecipScreen = true,
    foreginID = null,
  }) => {
    return RNSumupSDK.requestPayment(
      ammount,
      title,
      skipRecipScreen,
      foreginID
    );
  },
  test(){
    RNSumupSDK.test(" ")
  }
};

export default RNSumupsdk;
