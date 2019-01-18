import React from "react";
import { connect } from "react-redux";
import Grid from "@material-ui/core/Grid";
import Button from "@material-ui/core/Button";
import Typography from "@material-ui/core/Typography";
import { CircularProgress } from "@material-ui/core";
import { withStyles } from "@material-ui/core/styles";
import orange from "@material-ui/core/colors/orange";

import { Link } from "react-router-dom";

import { getOwnReviews } from "../../actions/ads";
import ReviewItem from "../Reviews/ReviewItem";

import { URL_SERVER, RENTABLE_ITEMS, RENTABLE_DOWNLOAD_IMAGE } from "../../utils/constants";

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
        justifyContent: "flex-start",
        maxWidth: "1080px",
        margin: "0 auto",
    },
    paper: {
        padding: "20px 10px 35px 10px",
        margin: "20px auto 20px",
    },
    responsiveimg: {
        maxWidth: "100%",
    },
    link: {
        textDecoration: "none",
    },
    starIcon: {
        color: orange[700],
    },
});

class DashboardReview extends React.Component {
    componentDidMount(){
        const { user } = this.props;
        this.props.dispatch(getOwnReviews(user));
    }

    render() {
        const { ads, classes, user } = this.props;
        let filteredAds = ads.reviews;
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
                    <Grid item key={item.posted_date} xs={12}>
                        <ReviewItem
                            file={`${URL_SERVER}/${RENTABLE_ITEMS}/${RENTABLE_DOWNLOAD_IMAGE}/${item.rentableitem_id}`}
                            rating={item.rating}
                            key={item.posted_date}
                            to={"asd"}
                            posted_date={item.posted_date}
                            text={item.text}
                        />
                    </Grid>
                );
            });
        }
        if (filteredAds.length === 0) {
            postContent = (
                <div className={classes.root}>
                    <Grid container spacing={8} className={classes.container}>
                        <Grid item xs={12}>
                            <h2>
                                <em>
                                    <Typography color="primary">
                                        You have no ads published!
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
                <Typography variant="h4" gutterBottom align="center" style={{width: "100%"}}>
                    Your Reviews
                </Typography>
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

export default connect(mapStateToProps)(withStyles(styles)(DashboardReview));
