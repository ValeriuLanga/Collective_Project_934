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
import Grid from '@material-ui/core/Grid';
import { URL_SERVER } from "../../utils/constants";
import StarIcon from "@material-ui/icons/Star";

const styles = theme => ({
    card: {
        display: "flex"
    },
    details: {
        display: "flex",
        flexDirection: "column"
    },
    content: {
        flex: "1 0 auto"
    },
    cover: {
        width: 250
    },
    controls: {
        display: "flex",
        alignItems: "center",
        paddingLeft: theme.spacing.unit,
        paddingBottom: theme.spacing.unit
    },
    playIcon: {
        height: 38,
        width: 38
    }
});

class ReviewItem extends React.Component {


    render() {
        const { classes, theme, posted_date, text, title } = this.props;
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

        // {/*<Card className={classes.card} >*/}
        //
        // {/*<CardContent>*/}
        // {/*<CardMedia*/}
        // {/*component="img"*/}
        // {/*alt={this.props.name}*/}
        // {/*className={classes.media}*/}
        // {/*image={this.props.file}*/}
        // {/*title={this.props.name}*/}
        // {/*onError={(e)=>{e.target.onerror = null; e.target.src="/images/no_image.png"}}*/}
        // {/*/>*/}
        // {/*<Typography gutterBottom variant="h5" component="h2">*/}
        // {/*{this.props.title}*/}
        // {/*</Typography>*/}
        // {/*<Typography variant="overline" gutterBottom>*/}
        // {/*{this.props.description}*/}
        // {/*</Typography>*/}
        //
        // {/*</CardContent>*/}
        // {/*<Typography component="p" className={classes.price}>*/}
        // {/*{this.props.price}*/}
        // {/*</Typography>*/}
        //
        // {/*</Card>*/}
        return (

            <Card className={classes.card}>
                <CardMedia
                    className={classes.cover}
                    image={this.props.file}
                        title="Live from space album cover"
                />
                <div className={classes.details}>
                    <CardContent className={classes.content}>
                        <Typography component="h5" variant="h5">
                            {title}
                        </Typography>
                        <Typography variant="subtitle1" color="textSecondary">
                            {text}
                        </Typography>
                        <Typography
                            variant="overline"
                            color="textSecondary"
                            style={{ paddingTop: 10 }}
                        >
                            {posted_date}
                        </Typography>
                    </CardContent>
                </div>
            </Card>
        );

    }
}

const mapStateToProps = state => {
    return {
        user: state.auth.user,
        ads: state.ads
    };
};

export default connect(mapStateToProps)(withStyles(styles)(ReviewItem));
