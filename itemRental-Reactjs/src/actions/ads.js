// POST_AD
import {
  GET_ERRORS,
  POST_AD,
  IS_LOADING,
  GET_ADS,
  GET_OWN_ADS,
  UPDATE_AD,
  DELETE_AD,
  GET_AD, 
  GET_OWN_REVIEWS, 
  GET_REVIEWS_ADD,
  RENT_AD,
  POST_REVIEW,
} from "./types";

import { URL_SERVER, USERS, RENTABLE_ITEMS, RENTABLE_UPLOAD_IMAGE, REVIEWS, CATEGORY, RENT } from "../utils/constants";

// Register User
export const postAd = (formData, history, file) => dispatch => {
  fetch(`${URL_SERVER}/${RENTABLE_ITEMS}/`, {
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

export const getAdsCategory = (category) => dispatch => {
    dispatch(isLoading());
    var url = `${URL_SERVER}/${RENTABLE_ITEMS}/${CATEGORY}/${category}`;
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

export const getOwnReviews = (uname) => dispatch => {
    console.log("Fetching reviews made by user", uname);
    dispatch(isLoading());
    var url = `${URL_SERVER}/${USERS}/${REVIEWS}/${uname}`;
    fetch(url)
        .then(res => res.json())
        .then(response => {
            dispatch({
                type: GET_OWN_REVIEWS,
                payload: response.reviewitems
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

export const getReviewsAdd = (id) => dispatch => {
    dispatch(isLoading());
    let url = `${URL_SERVER}/${RENTABLE_ITEMS}/${REVIEWS}/${id}`;
    fetch(url)
        .then(res => res.json())
        .then(response => {
            dispatch({
                type: GET_REVIEWS_ADD,
                payload: response.reviewitems
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

export const rentAd = (adId, startDate, endDate, user) => dispatch => {
  fetch(`${URL_SERVER}/${RENTABLE_ITEMS}/${RENT}/${adId}`, {
    method: "PUT",
    body: JSON.stringify({
      "start_date": startDate,
      "end_date": endDate,
      "user_name": user,
    }), // data can be `string` or {object}!
    headers: {
      "Content-Type": "application/json"
    }
  })
    .then(res => res.json())
    .then(response => {
      dispatch({
        type: RENT_AD,
        payload: response,
      });
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
}

export const postReview = (adId, rating, content, user) => dispatch => {
  console.log("Posting review with", {adId, rating, content,user});

  fetch(`${URL_SERVER}/${REVIEWS}/`, {
    method: "POST",
    body: JSON.stringify({
      "text": content,
      "rating": rating,
      "owner_name": user,
      "rentableitem_id": adId.toString(),
    }), // data can be `string` or {object}!
    headers: {
      "Content-Type": "application/json"
    }
  })
    .then(res => res.json())
    .then(response => {
      dispatch({
        type: POST_REVIEW,
        payload: response,
      });
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
}

// If Loading ads
export const isLoading = () => {
  return {
    type: IS_LOADING
  };
};
