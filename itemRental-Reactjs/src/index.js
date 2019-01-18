import React from "react";
import ReactDOM from "react-dom";
import { Provider } from "react-redux";
import jwt_decode from "jwt-decode";

import store from "./Store/store";
import "./index.css";
import App from "./router";
import registerServiceWorker from "./registerServiceWorker";
import {
  setCurrentUser,
  logoutUser,
  clearCurrentProfile
} from "./actions/authActions";
import setAuthToken from "./utils/setAuthToken";
import 'typeface-roboto';
ReactDOM.render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.getElementById("root")
);
registerServiceWorker();

if (localStorage.user) {
  try{
    const user = JSON.parse(localStorage.user);
    setAuthToken(user.password);
    store.dispatch(setCurrentUser(user.name));
  } catch(error) {
    console.error(error);
    // expected output: ReferenceError: nonExistentFunction is not defined
    // Note - error messages will vary depending on browser
  }
}

// Check for token
/*if (localStorage.jwtToken) {
  // Set auth token header auth
  setAuthToken(localStorage.jwtToken);
  // Decode token and get user info and exp
  const decoded = jwt_decode(localStorage.jwtToken);
  // Set user and isAuthenticated
  store.dispatch(setCurrentUser(decoded));

  // Check for expired token
  const currentTime = Date.now() / 1000;
  if (decoded.exp < currentTime) {
    // Logout user
    store.dispatch(logoutUser());
    // Clear current Profile
    store.dispatch(clearCurrentProfile());
    // Redirect to login
    window.location.href = "/login";
  }
}*/
