import React from "react";
import { connect } from "react-redux";
import Grid from "@material-ui/core/Grid";
import Button from "@material-ui/core/Button";
import { CircularProgress } from "@material-ui/core";
import Typography from "@material-ui/core/Typography";
import { withStyles } from "@material-ui/core/styles";
import { Link } from "react-router-dom";

import AdItem from "../Ads/AdItem";
import Header from "../Header/MainHeader";
import { getAds } from "../../actions/ads";

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
    margin: "0 auto"
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
  }
});

class AdsCategory extends React.Component {
  state = {
    favorite: true
  };
  componentDidMount() {
    this.props.dispatch(getAds());
  }

  goHome = () => this.props.location.pathname = "/";

  render() {
    const { ads, classes, user } = this.props;
    const { category } = this.props.match.params;
    let filteredAds = ads.ads.filter(item => {
      return category === item.category;
    });
    let postContent;
    if (ads.isLoading) {
      postContent = (
        <div className={classes.root}>
          <CircularProgress />
        </div>
      );
    } else {
      postContent = filteredAds.map(item => {
        return (
          <Grid item md={4} key={item._id}>
            <AdItem
              file={`/${item.file}`}
              title={item.title}
              price={item.price}
              key={item._id}
              to={item._id}
              avatar={user.avatar}
              favorite={item.favorite}
            />
          </Grid>
        );
      });
    }
    if (!ads.isLoading && filteredAds.length === 0) {
      postContent = (
        <div className={classes.root}>
          <Grid container spacing={8} className={classes.container}>
            <Grid item xs={12}>
              <h2>
                <em>
                  <Typography color="primary">
                  No ads to show in this category
                  </Typography>
                </em>
              </h2>
            </Grid>
            <Grid item xs={12}>
              <Button 
                variant="contained" 
                size="large" 
                color="primary" 
                className={classes.button} 
                component={Link}
                to="/">
                  BACK TO HOME
              </Button>
            </Grid>
          </Grid>
        </div>
      );
    }
    return (
      <div>
        <Header />
        <div>
          <Grid container spacing={8} className={classes.container}>
            {postContent}
          </Grid>
        </div>
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

export default connect(mapStateToProps)(withStyles(styles)(AdsCategory));
