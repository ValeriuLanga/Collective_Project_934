import React from "react";
import { connect } from "react-redux";
import Grid from "@material-ui/core/Grid";
import { CircularProgress } from "@material-ui/core";
import { withStyles } from "@material-ui/core/styles";
import { Link } from "react-router-dom";
import Typography from "@material-ui/core/Typography";

import AdItem from "../Ads/AdItem";
import { getAds } from "../../actions/ads";

import { URL_SERVER, RENTABLE_ITEMS, RENTABLE_DOWNLOAD_IMAGE } from "../../utils/constants";

const styles = theme => ({
  root: {
    display: "flex",
    flexWrap: "wrap"
  },
  margin: {
    margin: theme.spacing.unit
  },
  withoutLabel: {
    marginTop: theme.spacing.unit * 3
  },
  textField: {
    flexBasis: 200
  },
  container: {
    display: "flex",
    justifyContent: "center",
    maxWidth: "1080px",
    margin: "0 auto",
    paddingBottom: 50
  },
  paper: {
    padding: "20px 10px 35px 10px",
    margin: "20px auto 20px"
  },
  responsiveimg: {
    maxWidth: "100%"
  },
  link: {
    textDecoration: "none"
  },
  price: {
    color: "#ff7700",
    fontWeight: "700",
    padding: "3px"
  },
  "@media only screen and (max-width: 960px)": {
    container: {
      zIndex: 0,
      width: "100%",
    },
  },
});

class MostRecent extends React.Component {
  state = {
    favorite: true
  };
  componentDidMount() {
    this.props.dispatch(getAds());
  }

  render() {
    const { ads, classes, user } = this.props;
    let postContent;
    if (ads.isLoading) {
      postContent = (
        <div className={classes.root}>
          <CircularProgress />
        </div>
      );
    } else {
      postContent = ads.ads.slice(0, 3).map(item => {
        return (
          <Grid item md={4} key={item.id}>
            <AdItem
              file={`${URL_SERVER}/${RENTABLE_ITEMS}/${RENTABLE_DOWNLOAD_IMAGE}/${item.id}`}
              title={item.title}
              price={item.price}
              key={item.id}
              to={item.id}
              name={item.owner_name}
              rating={item.rating}
              category={item.category}
              description={item.item_description}
            />
          </Grid>
        );
      });
    }
    if (!ads.isLoading && ads.ads.length === 0) {
      postContent = (
        <div className={classes.root}>
          <h2>
            <em>No Ads</em>
            <br />
            <Link to="/submitad">Create New Ad</Link>
          </h2>
        </div>
      );
    }
    return (
      <div>
        <Grid container spacing={24} className={classes.container}>
          <Grid xs={12} item>
            <Typography style={{ textAlign: "center" }} variant="h4" gutterBottom>
              Recent Ads
            </Typography>
          </Grid>
          {postContent}
        </Grid>
      </div>
    );
  }
}

const mapStateToProps = state => {
  return {
    user: state.auth.user,
    ads: state.ads
  };
};

export default connect(mapStateToProps)(withStyles(styles)(MostRecent));
