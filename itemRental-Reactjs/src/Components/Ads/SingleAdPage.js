import React from "react";
// import classNames from "classnames";
import { connect } from "react-redux";
import { withStyles } from "@material-ui/core/styles";
import Typography from "@material-ui/core/Typography";
import Button from "@material-ui/core/Button";
import AddIcon from "@material-ui/icons/FavoriteBorder";
import { Paper, Tooltip } from "@material-ui/core";
import { Grid } from "@material-ui/core";
import ListItem from "@material-ui/core/ListItem";
import ListItemIcon from "@material-ui/core/ListItemIcon";
import ListItemText from "@material-ui/core/ListItemText";
import { PhoneAndroidOutlined } from "@material-ui/icons";
import Avatar from "@material-ui/core/Avatar";
import img from "../../assets/images/car.png";
import Header from "../Header/MainHeader";
import { getAd } from "../../actions/ads";
import { CircularProgress } from "@material-ui/core";

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
    padding: "20px 10px 35px 10px",
    margin: "20px auto 20px"
  },
  responsiveimg: {
    maxWidth: "100%"
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
          spacing={8}
          key={item.id}
        >
          <Grid item md={8} sm={12}>
            <Paper className={classes.paper}>
              <img
                src={`${URL_SERVER}/${RENTABLE_ITEMS}/${RENTABLE_DOWNLOAD_IMAGE}/${item.id}`}
                alt="Ad thumbnail"
                className={classes.responsiveimg}
              />

              <h3>{item.title}</h3>
              <p>Description : {item.description}</p>
              <Typography>City: {item.city}</Typography>
              <Typography>Address: {item.address}</Typography>
            </Paper>
          </Grid>
          <Grid item md={4} sm={12}>
            <Paper className={classes.paper}>
              <div
                style={{
                  display: "flex",
                  justifyContent: "flex-start",
                  background: "#f0f0f0",
                  borderRadius: "5px",
                  padding: "0 15px"
                }}
              >
                <h3 style={{ marginLeft: "1rem" }}>{item.owner_name}</h3>
              </div>
              <ListItem button>
                <ListItemIcon>
                  <PhoneAndroidOutlined />
                </ListItemIcon>
                <ListItemText
                  inset
                  primary={<a href={`tel:${item.phone}`}>{item.phone}</a>}
                />
              </ListItem>
            </Paper>
          </Grid>
        </Grid>
        </div>
    );
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
