import React from "react";
// import classNames from "classnames";
import { withStyles } from "@material-ui/core/styles";
import Typography from "@material-ui/core/Typography";
import Button from "@material-ui/core/Button";
import { FavoriteBorderOutlined, Favorite } from "@material-ui/icons";
import Paper from "@material-ui/core/Paper";
import Card from "@material-ui/core/Card";
import CardActionArea from '@material-ui/core/CardActionArea';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import Tooltip from "@material-ui/core/Tooltip";
import List from '@material-ui/core/List';
import ListItem from '@material-ui/core/ListItem';
import ListItemText from '@material-ui/core/ListItemText';
import { Link } from "react-router-dom";
import { connect } from "react-redux";
import { putAd } from "../../actions/ads";

import { URL_SERVER } from "../../utils/constants";
import StarIcon from "@material-ui/icons/Star";

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
    padding: "20px 10px 2px 10px",
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

class AdItem extends React.Component {
  state = {
    favorite: true
  };

  render() {
    const { classes } = this.props;
    /*return (
      <Paper className={classes.paper}>
        <img
          src={this.props.file}
          alt="Ad thumbnail"
          className={classes.responsiveimg}
        />
        <Link to={`/listings/${this.props.to}`} className={classes.link}>
          <h3>{this.props.title}</h3>
        </Link>
        <Typography color="primary">{this.props.name}</Typography>
        <p color="primary" className={classes.price}>
          Lei
          {this.props.price}
        </p>
      </Paper>
    );*/
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
          <Button size="small" color="primary" component={Link}
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
