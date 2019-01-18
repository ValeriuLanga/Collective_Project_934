import React from "react";

import { connect } from "react-redux";
import { withStyles } from "@material-ui/core/styles";
import Typography from "@material-ui/core/Typography";
import Divider from '@material-ui/core/Divider';

import { URL_SERVER, RENTABLE_ITEMS, RENTABLE_DOWNLOAD_IMAGE } from "../../utils/constants";

const styles = theme => ({
  responsiveimg: {
    maxWidth: "100%"
  },
  noDisplayDivider: {
    backgroundColor: 0
  },
});

class AddReviewModal extends React.Component {
    render() {
        const { classes } = this.props;
        return (
            <div></div>
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
  
export default connect(mapStateToProps)(withStyles(styles)(AddReviewModal));