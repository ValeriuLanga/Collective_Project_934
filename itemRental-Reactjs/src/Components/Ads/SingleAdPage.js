import React from "react";

import { connect } from "react-redux";
import { withStyles } from "@material-ui/core/styles";
import { Grid } from "@material-ui/core";
import Typography from "@material-ui/core/Typography";
import Divider from '@material-ui/core/Divider';
import Button from '@material-ui/core/Button';

import orange from '@material-ui/core/colors/orange';

import LeftSideAdPage from "./LeftSideAd";
import RightSideAdPage from "./RightSideAd";
import ReviewsAd from "./ReviewsAd";
import Header from "../Header/MainHeader";
import Footer from "../Footer/Footer";

import { getAd } from "../../actions/ads";

const styles = theme => ({
  container: {
    display: "flex",
    justifyContent: "center",
    maxWidth: "1080px",
    margin: "0 auto",
    width: "1080px",
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
  paper: {
    /*padding: "20px 10px 35px 10px",
    margin: "20px auto 20px"*/
    padding: theme.spacing.unit * 2,
    marginBottom: theme.spacing.unit * 2,
  },
  responsiveimg: {
    maxWidth: "100%"
  },
  button: {
    color: orange[500], 
    width: "100%", 
    marginTop: 15,
    '&:hover': {
      backgroundColor: orange[50],
    },
  },
  orangeAvatar: {
    margin: 10,
    color: '#fff',
    backgroundColor: orange[500],
  },
  chip: {
    margin: theme.spacing.unit,
  },
  list: {
    width: '100%',
    backgroundColor: theme.palette.background.paper,
  },
  smartPricing: {
    marginTop: theme.spacing.unit,
    marginBottom: theme.spacing.unit,
  },
  smartPricingItem: {
    paddingRight: theme.spacing.unit * 2,
    color: orange[500],
  },
  noDisplayDivider: {
    backgroundColor: "white",
  },
});

class AdPage extends React.Component {
  componentDidMount() {
    const { id } = this.props.match.params;
    this.props.dispatch(getAd(id));
  }

  render() {
    const { classes, user, ads } = this.props;
    const item = ads.ad;
    return (
      <div>
        <Header />
        <Grid
          className={classes.container}
          container
          spacing={24}
          key={item.id}
        >
          <Grid item md={6} sm={12}>
            <LeftSideAdPage 
              id={item.id}
              title={item.title}
              description={item.item_description}
              city={item.city}
              address={item.address}
              details={item.receiving_details}
              category={item.category}
              usage_type={item.usage_type}
            />
            <Divider style={{ marginTop: 20, marginBottom: 20 }} className={classes.noDisplayDivider}/>
            <Typography style={{ textAlign: "left"}} variant="h6" gutterBottom>
              Reviews for the product
            </Typography>
            <ReviewsAd id={item.id} />
            <Button className={classes.button}>Add Review</Button>
          </Grid>
          <Grid item md={6} sm={12}>
            <RightSideAdPage 
              id={item.id}
              title={item.title}
              price={item.price}
              author={item.owner_name}
            />
          </Grid>
        </Grid>
        <Footer />
        </div>
    );
  }
}


// <h3 style={{ marginLeft: "1rem" }}>{item.owner_name}</h3>
const mapStateToProps = state => {
  return {
    user: state.auth.user,
    ads: state.ads,
    ad: state.ad
  };
};

export default connect(mapStateToProps)(withStyles(styles)(AdPage));
