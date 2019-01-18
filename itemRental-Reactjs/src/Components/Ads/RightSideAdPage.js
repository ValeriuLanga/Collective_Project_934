import React from "react";

import { connect } from "react-redux";
import { withStyles } from "@material-ui/core/styles";
import Typography from "@material-ui/core/Typography";
import { Grid } from "@material-ui/core";
import Divider from '@material-ui/core/Divider';
import Button from '@material-ui/core/Button';
import Paper from '@material-ui/core/Paper';
import Chip from '@material-ui/core/Chip';
import Avatar from '@material-ui/core/Avatar';
import orange from '@material-ui/core/colors/orange';

import {MuiPickersUtilsProvider, DateTimePicker} from 'material-ui-pickers';

import DateFnsUtils from '@date-io/date-fns';
import moment from 'moment'

const styles = theme => ({
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
    /*padding: "20px 10px 35px 10px",
    margin: "20px auto 20px"*/
    padding: theme.spacing.unit * 2,
    marginBottom: theme.spacing.unit * 2,
  },
  responsiveimg: {
    maxWidth: "100%"
  },
  button: {
    backgroundColor: orange[500], 
    width: "100%", 
    marginTop: 15,
    '&:hover': {
      backgroundColor: orange[700],
    },
  },
  orangeAvatar: {
    margin: 10,
    color: '#fff',
    backgroundColor: orange[500],
  },
  chip: {
    margin: theme.spacing.unit,
  },
  list: {
    width: '100%',
    backgroundColor: theme.palette.background.paper,
  },
  smartPricing: {
    marginTop: theme.spacing.unit,
    marginBottom: theme.spacing.unit,
  },
  smartPricingItem: {
    paddingRight: theme.spacing.unit * 2,
    color: orange[500]
  },
});


class RightSideAdPage extends React.Component {
    state = {
        start_date: moment(new Date()).format('LLL'),
        end_date: moment(new Date()).add(1, 'days').format('LLL'),
      }
      
    handleChangePickers = prop => event => {
        this.setState({[prop]: event});
    };

    render() {
        const { classes, id, author, price, title } = this.props;
        return (
            <div>
                <Typography style={{ textAlign: "center" }} variant="h4" gutterBottom>
                    {title}
                </Typography>
                <Divider variant="middle" style={{ marginTop: 20, marginBottom: 20 }}/>
                <Grid container justify="center" alignItems="center" spacing={24} className={classes.smartPricing}>
                    <Typography style={{ textAlign: "center"}} variant="h5" gutterBottom className={classes.smartPricingItem}>
                        35 lei<br/>day
                    </Typography>
                    <Typography style={{ textAlign: "center"}} variant="h5" gutterBottom className={classes.smartPricingItem}>
                        35 lei<br/>week
                    </Typography>
                    <Typography style={{ textAlign: "center"}} variant="h5" gutterBottom className={classes.smartPricingItem}>
                        35 lei<br/>month
                    </Typography>
                </Grid>
                <Paper elevation={1} className={classes.paper}>
                    <Typography style={{ textAlign: "center" }} variant="h5" gutterBottom>
                        When do you want it?
                    </Typography>
                    <Grid
                        className={classes.container}
                        container
                        spacing={24}
                        key={id}
                    >
                        <Grid item md={6} sm={12}> 
                            <MuiPickersUtilsProvider utils={DateFnsUtils}>
                            <DateTimePicker
                                margin="normal"
                                label="Start Date"
                                value={this.state.end_date}
                                onChange={this.handleChangePickers("start_date")}
                            />
                            </MuiPickersUtilsProvider>
                        </Grid>
                        <Grid item md={6} sm={12}> 
                            <MuiPickersUtilsProvider utils={DateFnsUtils}>
                            <DateTimePicker
                                margin="normal"
                                label="End Date"
                                value={this.state.end_date}
                                onChange={this.handleChangePickers("end_date")}
                            />
                            </MuiPickersUtilsProvider>
                        </Grid>
                    </Grid>
                    <Divider variant="middle" />
                    <Button
                        variant="contained"
                        color="primary"
                        className={classes.button}
                        type="submit"
                        >
                        REQUEST TO RENT
                    </Button>
                </Paper>
                <Grid container justify="flex-start" alignItems="center">
                    <Grid item md={4} sm={12}> 
                        <Typography style={{ textAlign: "left", paddingTop: 5 }} variant="h6" gutterBottom>
                        Who's the lender?
                        </Typography>
                    </Grid>
                    <Grid item md={8} sm={12}> 
                        <Chip
                            avatar={<Avatar className={classes.orangeAvatar}>KK</Avatar>}
                            label="Krisztian Kristo"
                            className={classes.chip}
                            variant="outlined"
                        />
                    </Grid>
                </Grid>
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
  
  export default connect(mapStateToProps)(withStyles(styles)(RightSideAdPage));