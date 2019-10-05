import React from "react";

import { connect } from "react-redux";
import { withStyles } from "@material-ui/core/styles";
import Typography from "@material-ui/core/Typography";
import Divider from '@material-ui/core/Divider';

import { URL_SERVER, RENTABLE_ITEMS, RENTABLE_DOWNLOAD_IMAGE } from "../../utils/constants";

const styles = theme => ({
  responsiveimg: {
    maxWidth: '100%'
  },
  noDisplayDivider: {
    backgroundColor: 0
  },
  description: {
    whiteSpace: 'pre-wrap',
    lineHeight: '2em',
    wordWrap: 'break-word',
  },
});

class LeftSideAdPage extends React.Component {
    render() {
        const { classes, id, description, details, category } = this.props;
        return (
            <div>
                <img
                    src={`${URL_SERVER}/${RENTABLE_ITEMS}/${RENTABLE_DOWNLOAD_IMAGE}/${id}`}
                    alt="Ad thumbnail"
                    className={classes.responsiveimg}
                />
                <Divider style={{ marginTop: 20, marginBottom: 20 }}/>
                
                <Typography style={{ textAlign: "left"}} variant="h6" gutterBottom>
                    What's the item?
                </Typography>
                <Typography className={classes.description} variant="body1" color="textSecondary" gutterBottom paragraph>
                    {description}
                </Typography>

                <Typography className={classes.description} variant="subtitle2" gutterBottom>
                    Additional Details
                </Typography>
                <Typography variant="body1" color="textSecondary" gutterBottom paragraph>
                    {details}
                </Typography>

                 <Typography variant="subtitle2" gutterBottom>
                    Category
                </Typography>
                <Typography variant="body1" color="textSecondary" gutterBottom paragraph>
                    {category}
                </Typography>
            </div>
        )
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
  
export default connect(mapStateToProps)(withStyles(styles)(LeftSideAdPage));