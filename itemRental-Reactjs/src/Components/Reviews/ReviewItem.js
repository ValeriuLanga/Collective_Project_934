import React from "react";
// import classNames from "classnames";
import { withStyles } from "@material-ui/core/styles";
import Typography from "@material-ui/core/Typography";
import Card from "@material-ui/core/Card";
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import CardActionArea from '@material-ui/core/CardActionArea';

import StarRate from "@material-ui/icons/StarRate";
import StarBorder from '@material-ui/icons/StarBorder'

import orange from "@material-ui/core/colors/orange";
import grey from "@material-ui/core/colors/grey";

import { Link } from "react-router-dom";

import { connect } from "react-redux";

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
        width: 250,
        cursor: 'pointer',
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
    },
    starIcon: {
        color: orange[700],
    },
    borderStarIcon: {
        color: grey[400]
    },
});

class ReviewItem extends React.Component {
    render() {
        const { classes, posted_date, text, rating, rentableitem_id } = this.props;
        return (

            <Card className={classes.card}>
                <CardMedia
                    className={classes.cover}
                    image={this.props.file}
                    title="Review Image"
                    component={Link} 
                    to={`/listings/${rentableitem_id}`}
                />
                <div className={classes.details}>
                    <CardContent className={classes.content}>
                        {Array.from({length: rating}, (item, index) => 
                            <StarRate className={classes.starIcon} key={index} />
                        )}
                        {Array.from({length: 5 - rating}, (item, index) => 
                            <StarBorder className={classes.borderStarIcon} key={index} />
                        )}
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
