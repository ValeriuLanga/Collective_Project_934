// POST_AD
import {
  GET_ERRORS,
  POST_AD,
  IS_LOADING,
  GET_ADS,
  GET_OWN_ADS,
  UPDATE_AD,
  DELETE_AD,
  GET_AD
} from "./types";

import { URL_SERVER, USERS, RENTABLE_ITEMS, RENTABLE_UPLOAD_IMAGE, } from "../utils/constants";
// Register User
export const postAd = (formData, history, file) => dispatch => {

  fetch(URL_SERVER + "/" + RENTABLE_ITEMS + "/", {
    method: "POST",
    body: JSON.stringify(formData),
      headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
      }
  })
    .then(res => res.json())
    .then(response => {
      dispatch({
        type: POST_AD,
        payload: response
      });
        const {id} = response;
        fetch(URL_SERVER + "/" + RENTABLE_ITEMS + "/" + RENTABLE_UPLOAD_IMAGE + "/" + id, {
            method: "POST",
            body: file
        }).then(res => res.json())
            .then(response => {
                history.push("/dashboard");
            })
            .catch(error => {
                if (error) {
                    dispatch({
                        type: GET_ERRORS,
                        payload: error
                    });
                }
            });
    })
    .catch(error => {
      if (error) {
        dispatch({
          type: GET_ERRORS,
          payload: error
        });
      }
    });
};

export const getAds = () => dispatch => {
  dispatch(isLoading());
  var url = `${URL_SERVER}/${RENTABLE_ITEMS}`;
  fetch(url)
    .then(res => res.json())
    .then(response => {
      dispatch({
        type: GET_ADS,
        payload: response.rentableitems
      });
    })
    .catch(error => {
      if (error) {
        dispatch({
          type: GET_ERRORS,
          payload: error
        });
      }
    });
};

export const getOwnAds = (uname) => dispatch => {
  console.log("Fetching ads for user", uname);
  dispatch(isLoading());
  var url = `${URL_SERVER}/${USERS}/${RENTABLE_ITEMS}/${uname}`;
  fetch(url)
    .then(res => res.json())
    .then(response => {
      dispatch({
        type: GET_OWN_ADS,
        payload: response.rentableitems
      });
    })
    .catch(error => {
      if (error) {
        dispatch({
          type: GET_ERRORS,
          payload: error
        });
      }
    });
};

// UPDATE_AD
export const putAd = (data, _id, avatar, fEmail) => dispatch => {
  console.log(data);
  fetch(`${URL_SERVER}/${_id}`, {
    method: "PUT",
    body: JSON.stringify(data), // data can be `string` or {object}!
    headers: {
      "Content-Type": "application/json"
    }
  })
    .then(res => res.json())
    .then(response => {
      dispatch({
        type: UPDATE_AD,
        payload: response,
        _id
      });
      if (response.favorite === true && response.fEmail === fEmail) {
        caches.open(`${response._id}`).then(cache => {
          return cache.addAll([
            `/listings/${response._id}`,
            `${URL_SERVER}/${response.file}`,
            `${avatar}`
          ]);
        });
      }
    })
    .catch(error => {
      console.log(error);
      if (error) {
        dispatch({
          type: GET_ERRORS,
          payload: error
        });
      }
    });
};

//DELETE_AD
export const deleteAd = (formData, history, _id) => dispatch => {
  fetch(`${URL_SERVER}/${_id}`, {
    method: "DELETE",
    body: formData
  })
    .then(res => res.json())
    .then(response => {
      dispatch({
        type: DELETE_AD,
        _id
      });
      history.push("/dashboard");
    })
    .catch(error => {
      if (error) {
        dispatch({
          type: GET_ERRORS,
          payload: error
        });
      }
    });
};

export const getAd = (adId) => dispatch => {
  console.log("Fetching ad with id", adId);
  dispatch(isLoading());
  var url = `${URL_SERVER}/${RENTABLE_ITEMS}/${adId}`;
  fetch(url)
    .then(res => res.json())
    .then(response => {
      dispatch({
        type: GET_AD,
        payload: response
      });
    })
    .catch(error => {
      if (error) {
        dispatch({
          type: GET_ERRORS,
          payload: error
        });
      }
    });
};


// If Loading ads
export const isLoading = () => {
  return {
    type: IS_LOADING
  };
};
