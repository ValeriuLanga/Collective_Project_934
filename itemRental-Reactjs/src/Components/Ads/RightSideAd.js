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
import red from '@material-ui/core/colors/red';
import green from '@material-ui/core/colors/green';

import Dialog from '@material-ui/core/Dialog';
import DialogActions from '@material-ui/core/DialogActions';
import DialogContent from '@material-ui/core/DialogContent';
import DialogContentText from '@material-ui/core/DialogContentText';
import DialogTitle from '@material-ui/core/DialogTitle';

import Snackbar from '@material-ui/core/Snackbar';

import MySnackbarContentWrapper from './MySnackbarContentWrapper';

import { MuiPickersUtilsProvider, DatePicker } from 'material-ui-pickers';
import DateFnsUtils from '@date-io/date-fns';
import moment from 'moment'

import { rentAd } from "../../actions/ads";

import getInitials from "../../utils/getInitials";

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
    color: "white"
  },
  redButton: {
    color: red[500], 
    width: "100%", 
    marginTop: 15,
    '&:hover': {
      backgroundColor: red[50],
    },
  },
  greenButton: {
    color: green[500], 
    width: "100%", 
    marginTop: 15,
    '&:hover': {
      backgroundColor: green[50],
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
  noDisplayDivider: {
    backgroundColor: 0
  },
  orangeText: {
    color: orange[500],
    padding: theme.spacing.unit,
  },
  "@media only screen and (max-width: 960px)": {
    datePicker: {
        width: '95%'
    },
  },
  success: {
    backgroundColor: green[600],
  },
});


class RightSideAdPage extends React.Component {
    state = {
        start_date: moment(new Date()).toDate(),
        end_date: moment(new Date()).add(1, 'days').toDate(),
        invalid_dates: [],
        converted_start_date: null,
        converted_end_date: null,
        selected_days: 0,
        open: false,
        snackOpen: false,
    }
      
    handleChangePickers = prop => event => {
        this.setState({[prop]: event}, this.updateSelectedPeriod);
    };

    updateSelectedPeriod = () => {
        let start_moment = moment(this.state.start_date).startOf('day');
        let end_moment = moment(this.state.end_date).startOf('day');

        this.setState({
            selected_days: Math.abs(start_moment.diff(end_moment, 'days')) + 1
        });
    }

    convertDate = stringDate => {
        return moment(stringDate, "MMM DD YYYY").toDate();
    }

    setDateForState = (prop, stringDate) => {
        this.setState(
            {
                [prop]: this.convertDate(stringDate)
            }
        );
    } 

    enumerateDaysBetweenDates = function(startDate, endDate) {
        var dates = [];
        var currDate = moment(startDate).startOf('day');
        var lastDate = moment(endDate).startOf('day');
    
        dates.push(currDate.clone().toDate());
        while(currDate.add(1, 'days').diff(lastDate) < 0) {
            dates.push(currDate.clone().toDate());
        }
        dates.push(lastDate.clone().toDate());
    
        return dates;
    };

    rentProduct = () => {
        const { id, user } = this.props;
        const { start_date, end_date } = this.state;

        let startDate = moment(start_date).format('MMM DD YYYY');
        let endDate = moment(end_date).format('MMM DD YYYY');
        if (endDate < startDate)
            return;
        
        this.props.dispatch(rentAd(id, startDate, endDate, user));
        this.setState({ snackOpen: true });
    }

    handleClickOpen = () => {
        this.setState({ open: true });
    };
    
    handleClose = (buttonPressed) => {
        this.setState({ open: false });
        if (buttonPressed) 
            this.rentProduct();
    };

    componentDidMount() {
        const { id, available_start_date, available_end_date, rent_periods } = this.props;

        if (available_start_date) {
            let start_date_temp = this.convertDate(available_start_date);
            this.setState({
                converted_start_date: start_date_temp,
                start_date: start_date_temp,
            });
        }

        if (available_end_date) {
            this.setState({
                converted_end_date: this.convertDate(available_end_date),
            });
        }

        if (rent_periods) {
            let invalid_dates = [];
            rent_periods.forEach(e => 
                invalid_dates = invalid_dates.concat(
                    this.enumerateDaysBetweenDates(
                        this.convertDate(e.start_date),
                        this.convertDate(e.end_date)
                    )
                )
            );

            this.setState({
                invalid_dates: invalid_dates
            })
        }
    }

    isEmpty = (obj) =>  {
        for(let prop in obj) {
            if(obj.hasOwnProperty(prop))
                return false;
        }

        return true;
    }

    handleCloseSnack = (event, reason) => {
        if (reason === 'clickaway') {
          return;
        }
    
        this.setState({ snackOpen: false });
    };

    render() {
        const { classes, id, author, price, title, user } = this.props;

        const emptyUser = this.isEmpty(user);
        let rentButton;

        if (!emptyUser && author == user) {
            rentButton = (
                <Button
                    variant="contained"
                    color="primary"
                    className={classes.button}
                    disabled
                >
                    YOU CAN'T RENT YOUR OWN ITEM
                </Button>
            );
          } else if (!emptyUser) {
            rentButton = (
                <Button
                    variant="contained"
                    color="primary"
                    className={classes.button}
                    type="submit"
                    onClick={this.handleClickOpen}
                >
                    REQUEST TO RENT
                </Button>
            );
          } else {
            rentButton = (
                <Button
                    variant="contained"
                    color="primary"
                    className={classes.button}
                    disabled
                >
                    LOGIN TO PROCEEED
                </Button>
            );
          }

        return (
            <div>
                <Typography style={{ textAlign: "center" }} variant="h4" gutterBottom>
                    {title}
                </Typography>
                <Divider className={classes.noDisplayDivider} variant="middle" style={{ marginTop: 20, marginBottom: 20 }}/>
                <Grid container justify="center" alignItems="center" spacing={24} className={classes.smartPricing}>
                    <Typography style={{ textAlign: "center"}} variant="h5" gutterBottom className={classes.smartPricingItem}>
                        {price} lei<br/>day
                    </Typography>
                    <Typography style={{ textAlign: "center"}} variant="h5" gutterBottom className={classes.smartPricingItem}>
                        {price * 7} lei<br/>week
                    </Typography>
                    <Typography style={{ textAlign: "center"}} variant="h5" gutterBottom className={classes.smartPricingItem}>
                        {price * 30} lei<br/>month
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
                            <DatePicker
                                margin="normal"
                                label="Start Date"
                                value={this.state.start_date}
                                minDate={this.state.converted_start_date}
                                maxDate={this.state.converted_end_date}
                                onChange={this.handleChangePickers('start_date')}
                                disablePast
                                shouldDisableDate={
                                    (date) => !!this.state.invalid_dates.find(item => {return item.getTime() == date.getTime()})
                                }
                                className={classes.datePicker}
                            />
                            </MuiPickersUtilsProvider>
                        </Grid>
                        <Grid item md={6} sm={12}> 
                            <MuiPickersUtilsProvider utils={DateFnsUtils}>
                            <DatePicker
                                margin="normal"
                                label="End Date"
                                value={this.state.end_date}
                                onChange={this.handleChangePickers('end_date')}
                                minDate={this.state.start_date}
                                maxDate={this.state.converted_end_date}
                                disablePast
                                shouldDisableDate={
                                    (date) => !!this.state.invalid_dates.find(item => {return item.getTime() == date.getTime()})
                                }
                                className={classes.datePicker}
                            />
                            </MuiPickersUtilsProvider>
                        </Grid>
                    </Grid>
                    { this.state.selected_days > 0 ? 
                        <div>
                            <Divider />
                            <Typography style={{ textAlign: "center"}} variant="h6" gutterBottom className={classes.orangeText}>
                                {this.state.selected_days} day(s) * {price} lei = {this.state.selected_days * price} lei
                            </Typography>
                        </div>
                     : null
                    }
                    {rentButton}
                </Paper>
                <Grid container justify="flex-start" alignItems="center">
                    <Grid item md={4} sm={12}> 
                        <Typography style={{ textAlign: "left", paddingTop: 5 }} variant="h6" gutterBottom>
                            Who's the lender?
                        </Typography>
                    </Grid>
                    <Grid item md={8} sm={12}> 
                        <Chip
                            avatar={<Avatar className={classes.orangeAvatar}>{getInitials(author)}</Avatar>}
                            label={author}
                            className={classes.chip}
                            variant="outlined"
                        />
                    </Grid>
                </Grid>
                <Dialog
                    open={this.state.open}
                    onClose={() => this.handleClose(false)}
                    aria-labelledby="alert-dialog-title"
                    aria-describedby="alert-dialog-description"
                    >
                    <DialogTitle id="alert-dialog-title">{"Are you sure you want to rent " + title + "?"}</DialogTitle>
                    <DialogContent>
                        <DialogContentText id="alert-dialog-description">
                            By clicking submit you are agreeing to the Terms and Conditions imposed by the lender.
                        </DialogContentText>
                    </DialogContent>
                    <DialogActions>
                        <Button onClick={() => this.handleClose(false)} color="primary" className={classes.redButton}>
                            No
                        </Button>
                        <Button onClick={() => this.handleClose(true)} color="primary" autoFocus className={classes.greenButton}>
                            Yes
                        </Button>
                    </DialogActions>
                </Dialog>
                <Snackbar
                    anchorOrigin={{
                        vertical: 'bottom',
                        horizontal: 'left',
                    }}
                    open={this.state.snackOpen}
                    autoHideDuration={6000}
                    onClose={this.handleCloseSnack}
                    >
                    <MySnackbarContentWrapper
                        onClose={this.handleCloseSnack}
                        variant="success"
                        message="Item rented!"
                    />
                </Snackbar>
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