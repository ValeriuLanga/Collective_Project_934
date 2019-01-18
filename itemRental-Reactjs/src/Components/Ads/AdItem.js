import React from "react";
// import classNames from "classnames";
import { withStyles } from "@material-ui/core/styles";
import Typography from "@material-ui/core/Typography";
import Button from "@material-ui/core/Button";
import Card from "@material-ui/core/Card";
import CardActionArea from '@material-ui/core/CardActionArea';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import orange from '@material-ui/core/colors/orange';
import indigo from '@material-ui/core/colors/indigo';

import { Link } from "react-router-dom";
import { connect } from "react-redux";

const styles = theme => ({
  root: {
    display: "flex",
    flexWrap: "wrap",
  },
  margin: {
    margin: theme.spacing.unit,
  },
  withoutLabel: {
    marginTop: theme.spacing.unit * 3,
  },
  textField: {
    flexBasis: 200,
  },
  container: {
    display: "flex",
    justifyContent: "center",
    maxWidth: "1080px",
    margin: "0 auto",
  },
  paper: {
    padding: "20px 10px 2px 10px",
    margin: "20px auto 20px",
  },
  responsiveimg: {
    maxWidth: "100%",
  },
  link: {
    textDecoration: "none",
  },
  price: {
    color: orange[500],
    fontWeight: "700",
    padding: "3px",
  },
  button: {
    color: indigo[500],
  },
});

class AdItem extends React.Component {
  state = {
    favorite: true
  };

  render() {
    const { classes } = this.props;
    return (
      <Card className={classes.card}>
        <CardActionArea component={Link}
                to={`/listings/${this.props.to}`}>
          <CardMedia
            component="img"
            alt={this.props.name}
            className={classes.media}
            image={this.props.file}
            title={this.props.name}
            onError={(e)=>{e.target.onerror = null; e.target.src="/images/no_image.png"}}
          />
          <CardContent>
            <Typography gutterBottom variant="h5" component="h2">
              {this.props.title}
            </Typography>
            <Typography variant="overline" gutterBottom>
              {this.props.description}
            </Typography>
          </CardContent>
        </CardActionArea>
        <CardActions>
          <Typography component="p" className={classes.price}>
            {this.props.price} Lei
          </Typography>
          <Button className={classes.button} size="small" color="primary" component={Link}
                to={`/listings/${this.props.to}`}>
            View Product
          </Button>
        </CardActions>
      </Card>
    )
  }
}

const mapStateToProps = state => {
  return {
    user: state.auth.user,
    ads: state.ads
  };
};

export default connect(mapStateToProps)(withStyles(styles)(AdItem));
