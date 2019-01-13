import React from "react";
import PropTypes from "prop-types";
import { withStyles } from "@material-ui/core/styles";
import AppBar from "@material-ui/core/AppBar";
import Toolbar from "@material-ui/core/Toolbar";
import Grid from "@material-ui/core/Grid";
import FavoriteIcon from "@material-ui/icons/Favorite";
import logo from "../../logo.svg";

const styles = {
  root: {
    flexGrow: 1
  },
  container: {
    maxWidth: "1080px",
    margin: "0 auto",
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center"
  },
  madeBy: {
    fontSize: "24px"
  },
};

function SimpleAppBar(props) {
  const { classes } = props;
  return (
    <div className={classes.root}>
      <AppBar position="static" color="default">
        <Toolbar>
          <Grid container className={classes.container}>
            <Grid item>
              <img src="/images/icons/icon-72x72.png" className="App-logo" alt="logo" />
            </Grid>
            <Grid item>
            </Grid>
            <Grid item>
              <span className={classes.madeBy}>Made with <FavoriteIcon /> by H.U.H. team</span>
            </Grid>
          </Grid>
        </Toolbar>
      </AppBar>
    </div>
  );
}

SimpleAppBar.propTypes = {
  classes: PropTypes.object.isRequired
};

export default withStyles(styles)(SimpleAppBar);
