import React from "react";

import { connect } from "react-redux";
import { withStyles } from "@material-ui/core/styles";
import Typography from "@material-ui/core/Typography";
import { Grid } from "@material-ui/core";
import Header from "../Header/MainHeader";
import { getAd } from "../../actions/ads";
import Divider from '@material-ui/core/Divider';
import Button from '@material-ui/core/Button';
import Paper from '@material-ui/core/Paper';
import orange from '@material-ui/core/colors/orange';

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
    margin: "0 auto"
  },
  paper: {
    /*padding: "20px 10px 35px 10px",
    margin: "20px auto 20px"*/
    padding: theme.spacing.unit * 2,
  },
  responsiveimg: {
    maxWidth: "100%"
  },
  button: {
    backgroundColor: orange[500], 
    width: "100%", 
    marginTop: 15,
    '&:hover': {
      backgroundColor: orange[700],
    },
  }
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
      <div className={classes.root}>
        <Header />
        <Grid
          className={classes.container}
          container
          spacing={24}
          key={item.id}
        >
          <Grid item md={6} sm={12}>
              <img
                src={`${URL_SERVER}/${RENTABLE_ITEMS}/${RENTABLE_DOWNLOAD_IMAGE}/${item.id}`}
                alt="Ad thumbnail"
                className={classes.responsiveimg}
              />

              
              <p>Description : {item.description}</p>
              <Typography>City: {item.city}</Typography>
              <Typography>Address: {item.address}</Typography>
          </Grid>
          <Grid item md={6} sm={12}>
            <Typography style={{ textAlign: "center" }} variant="h4" gutterBottom>
              {item.title}
            </Typography>
            <Paper elevation={1} className={classes.paper}>
              <Typography style={{ textAlign: "center" }} variant="h5" gutterBottom>
                When do you want it?
              </Typography>
              <Divider variant="middle" />
              <Button
                variant="contained"
                color="primary"
                className={classes.button}
                type="submit"
                >
                RENT
              </Button>
            </Paper>
          </Grid>
        </Grid>
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
