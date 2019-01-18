import React from "react";
import Tabs from "@material-ui/core/Tabs";
import Tab from "@material-ui/core/Tab";
import { ListAlt } from "@material-ui/icons";
import { ChatOutlined } from "@material-ui/icons";
import DashboardReview from "./DashboardReview";
import DashboardAds from "./DashboardAds"
import AppBar from '@material-ui/core/AppBar';
import Typography from '@material-ui/core/Typography';
import { withStyles } from '@material-ui/core/styles';
import orange from '@material-ui/core/colors/orange'


function TabContainer(props) {
    return (
        <Typography component="div" style={{ padding: 8 * 3 }}>
            {props.children}
        </Typography>
    );
}

const styles = theme => ({
    root: {
        flexGrow: 0,
        backgroundColor: theme.palette.background.paper,
    },
    middle: {
        justifyContent: "center",
    },
    tabs: {
        color: orange[500], 
        backgroundColor: theme.palette.background.paper,
    },
});

class IconLabelTabs extends React.Component {
    state = {
        value: 0
    };

    handleChange = (event, value) => {
        this.setState({ value });
    };
    render() {
        const { classes } = this.props;
        const { value } = this.state;

        return (
            <div className={classes.middle}>
                <AppBar position="static" elevation={1}>
                    <Tabs 
                        value={value} 
                        className={classes.tabs} 
                        onChange={this.handleChange} 
                        centered
                    >
                        <Tab icon={<ListAlt />} label="Your Ads" />
                        <Tab icon={<ChatOutlined />} label="Your Reviews" />
                    </Tabs>
                </AppBar>
                {value === 0 && <TabContainer><DashboardAds /></TabContainer>}
                {value === 1 && <TabContainer><DashboardReview /></TabContainer>}
            </div>

        );
    }
}

export default withStyles(styles)(IconLabelTabs);