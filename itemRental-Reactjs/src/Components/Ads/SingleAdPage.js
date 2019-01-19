import React from "react";

import { connect } from "react-redux";
import { withStyles } from "@material-ui/core/styles";
import { CircularProgress, Grid } from "@material-ui/core";
import Typography from "@material-ui/core/Typography";
import Divider from '@material-ui/core/Divider';
import Button from '@material-ui/core/Button';
import Modal from '@material-ui/core/Modal';
import { getAd, getReviewsAdd } from "../../actions/ads";
import orange from '@material-ui/core/colors/orange';

import LeftSideAdPage from "./LeftSideAd";
import RightSideAdPage from "./RightSideAd";
import ReviewsAd from "./ReviewsAd";
import RatingModalContent from "./RatingModalContent";
import Header from "../Header/MainHeader";
import Footer from "../Footer/Footer";

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
  cardPaper: {
    position: 'absolute',
    width: theme.spacing.unit * 50,
    backgroundColor: theme.palette.background.paper,
    boxShadow: theme.shadows[5],
    //padding: theme.spacing.unit * 2,
    outline: 'none',
    margin:'0 auto',
    top: '50%',
    left: '50%',
    transform: 'translateY(-50%) translateX(-50%)',
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
  orangeCardHeader: {
    backgroundColor: orange[200],
  },
  "@media only screen and (max-width: 960px)": {
    container: {
      zIndex: 0,
      width: "100%",
    },
  },
});

class AdPage extends React.Component {
  state = {
    open: false,
  };

  componentDidMount() {
    const { id } = this.props.match.params;
    this.props.dispatch(getAd(id));
    this.props.dispatch(getReviewsAdd(id));
  }

  handleOpen = () => {
    this.setState({ open: true });
  };

  handleClose = () => {
    this.setState({ open: false });
  };

  render() {
    const { classes, user, ads } = this.props;
    const item = ads.ad;
    const reviews = ads.reviews;

    let postContent;
    if (ads.isLoading) {
      postContent = (
          <div className={classes.root}>
              <CircularProgress/>
          </div>
      )
    } else {
        postContent = (
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
              <ReviewsAd id={item.id} reviews={reviews}/>
              <Button className={classes.button} onClick={this.handleOpen}>Add Review</Button>
              <Modal
                aria-labelledby="simple-modal-title"
                aria-describedby="simple-modal-description"
                open={this.state.open}
                onClose={this.handleClose}
                style={{alignItems:'center',justifyContent:'center'}}
              >
                <RatingModalContent 
                  id={item.id}
                  title={item.title}
                  author={item.owner_name}
                />
              </Modal>
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
    return (
      <div>
          {postContent}
      </div>
    )
  }
}

const mapStateToProps = state => {
    return {
        user: state.auth.user,
        ads: state.ads,
        ad: state.ad
    };
};

export default connect(mapStateToProps)(withStyles(styles)(AdPage));
