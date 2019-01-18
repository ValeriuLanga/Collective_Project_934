import React from "react";

import { connect } from "react-redux";
import { withStyles } from "@material-ui/core/styles";
import List from '@material-ui/core/List';
import ListItem from '@material-ui/core/ListItem';
import ListItemText from '@material-ui/core/ListItemText';
import ListItemAvatar from '@material-ui/core/ListItemAvatar';
import Avatar from '@material-ui/core/Avatar';
import Grid from "@material-ui/core/Grid";
import Divider from "@material-ui/core/Divider";
import Typography from '@material-ui/core/Typography';
import StarRate from "@material-ui/icons/StarRate";
import StarBorder from "@material-ui/icons/StarBorder";

import orange from '@material-ui/core/colors/orange';
import grey from "@material-ui/core/colors/grey";

import getInitials from "../../utils/getInitials";

import { URL_SERVER, RENTABLE_ITEMS, RENTABLE_DOWNLOAD_IMAGE } from "../../utils/constants";

const styles = theme => ({
  responsiveimg: {
    maxWidth: "100%"
  },
  noDisplayDivider: {
    backgroundColor: 0
  },
  orangeAvatar: {
    margin: 10,
    color: '#fff',
    backgroundColor: orange[500],
  },
  starIcon: {
    color: orange[700],
  },
  borderStarIcon: {
    color: grey[400]
  },
  listItem: {
    paddingBottom: 20,
    paddingTop: 20,
  },
});

const reviews = [
    {
        "owner_name": "krisztian",
        "posted_date": "Jan 18 2019 10:21AM",
        "rating": 5,
        "rentableitem_id": "3",
        "text": "nice doggo man 5/5"
      },
      {
        "owner_name": "iulian",
        "posted_date": "Jan 18 2019 10:23AM",
        "rating": 5,
        "rentableitem_id": "3",
        "text": "nice doggo man 5/5"
      },
      {
        "owner_name": "iulian",
        "posted_date": "Jan 18 2019 11:57AM",
        "rating": 5,
        "rentableitem_id": "3",
        "text": "nice doggo man 5/5"
      },
      {
        "owner_name": "iulian",
        "posted_date": "Jan 18 2019 12:41PM",
        "rating": 5,
        "rentableitem_id": "3",
        "text": "nice doggo man 5/5. i love it so much and he also likes boops"
      }
]

class ReviewsAd extends React.Component {
    render() {
        const { classes } = this.props;
        return (
            <List className={classes.root}>
                {reviews.map(review => (
                    <ListItem alignItems="flex-start" className={classes.listItem} divider>
                        <ListItemAvatar>
                            <Avatar className={classes.orangeAvatar}>{getInitials(review.owner_name)}</Avatar>
                        </ListItemAvatar>
                        <ListItemText
                            primary={
                                <Grid container spacing={24} justify="space-between">
                                    <Grid item xs={6}>
                                        <Typography component="span" className={classes.inline} color="textPrimary">
                                            {review.owner_name}
                                        </Typography>
                                    </Grid>
                                    <Grid item xs={6} style={{ textAlign: "right" }}>
                                        {Array.from({length: review.rating}, (item, index) => 
                                            <StarRate className={classes.starIcon} key={index} />
                                        )}
                                        {Array.from({length: 5 - review.rating}, (item, index) => 
                                            <StarBorder className={classes.borderStarIcon} key={index} />
                                        )}
                                    </Grid>
                                </Grid>   
                            }
                            secondary={
                                <React.Fragment>
                                    {review.text}
                                </React.Fragment>
                            }
                        />
                    </ListItem>
                ))}
            </List>
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
  
export default connect(mapStateToProps)(withStyles(styles)(ReviewsAd));