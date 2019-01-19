import React from "react";

import { connect } from "react-redux";
import { withStyles } from "@material-ui/core/styles";
import Typography from "@material-ui/core/Typography";
import Button from '@material-ui/core/Button';
import TextField from "@material-ui/core/TextField";

import Card from '@material-ui/core/Card';
import CardActionArea from '@material-ui/core/CardActionArea';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import CardHeader from '@material-ui/core/CardHeader';

import { Rating } from 'material-ui-rating'

import orange from '@material-ui/core/colors/orange';

import { URL_SERVER, RENTABLE_ITEMS, RENTABLE_DOWNLOAD_IMAGE } from "../../utils/constants";

const styles = theme => ({
    orangeCardHeader: {
        backgroundColor: orange[200],
    },
    cardPaper: {
        position: 'absolute',
        width: theme.spacing.unit * 50,
        backgroundColor: theme.palette.background.paper,
        boxShadow: theme.shadows[5],
        outline: 'none',
        margin:'0 auto',
        top: '50%',
        left: '50%',
        transform: 'translateY(-50%) translateX(-50%)',
    },
    textField: {
        marginLeft: theme.spacing.unit,
        marginRight: theme.spacing.unit,
        width: '95%',
    },
    button: {
        transform: 'rotate(0deg)',
        marginLeft: 'auto',
        color: orange[500], 
        '&:hover': {
          backgroundColor: orange[50],
        },
    },
});

class RatingModalContent extends React.Component {
    state = {
        value: 1,
        multiline: '',
    }

    handleChange = name => event => {
        let value = event;
        if(event.target !== undefined) {
            value = event.target.value;    
        };

        this.setState({
            [name]: value,
        });
    };

    render() {
        const { classes, id, author, title } = this.props;
        const { value, multiline } = this.state;
        return (
            <Card className={classes.cardPaper}>
                <CardHeader
                    title="Rate and review"
                    subheader={title + " lent by " + author}       
                    className={classes.orangeCardHeader} 
                />
                <CardContent>
                    <Rating
                        value={value}
                        max={5}
                        onChange={this.handleChange('value')}
                        min={1}
                    />
                    <TextField
                        id="standard-multiline-flexible"
                        label="Share details of your own experience"
                        multiline
                        rowsMax="4"
                        value={multiline}
                        onChange={this.handleChange('multiline')}
                        className={classes.textField}
                        margin="normal"
                    />
                </CardContent>
                <CardActions>
                    <Button className={classes.button} size="small" color="primary">
                        Post Review
                    </Button>
                </CardActions>
            </Card>
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
  
export default connect(mapStateToProps)(withStyles(styles)(RatingModalContent));


