import React from "react";
import classNames from "classnames";
import {withStyles} from "@material-ui/core/styles";
import Input from "@material-ui/core/Input";
import InputLabel from "@material-ui/core/InputLabel";
import FormControl from "@material-ui/core/FormControl";
import TextField from "@material-ui/core/TextField";
import MenuItem from "@material-ui/core/MenuItem";
import Button from "@material-ui/core/Button";
import Grid from "@material-ui/core/Grid";
import Paper from "@material-ui/core/Paper";
import Select from "@material-ui/core/Select";
import Divider from "@material-ui/core/Divider";
import Typography from "@material-ui/core/Typography";
import moment from 'moment'
import DateFnsUtils from '@date-io/date-fns';
import {MuiPickersUtilsProvider, TimePicker, DatePicker, DateTimePicker} from 'material-ui-pickers';
import ReactDropzone from "react-dropzone";
// import axios from "axios";
// import { Link } from "react-router-dom";

const styles = theme => ({
    root: {
        display: "flex",
        flexWrap: "wrap"
    },
    margin: {
        margin: theme.spacing.unit
    },
    withoutLabel: {
        marginTop: theme.spacing.unit * 3
    },
    container: {
        display: "flex",
        justifyContent: "center",
        maxWidth: "1080px",
        margin: "0 auto"
    },
    paper: {
        padding: "20px 30px 50px 15px",
        margin: "100px auto 30px"
    },
    selectEmpty: {
        marginTop: theme.spacing.unit * 2
    },
    formControl: {
        margin: theme.spacing.unit,
        minWidth: 120,
        width: "100%"
    },
    paddingTopSelect: {
        padding: "30px 0px 0px 0px",
    },
});

class InputAdornments extends React.Component {
    state = {
        title: "",
        receiving_details: "",
        category: "",
        usage_type: "",
        description: "",
        price: 0,
        start_date: moment(new Date()).format('LLL'),
        end_date: moment(new Date()).add(1, 'days').format('LLL'),
        files: "",
        imagePreviewUrl: "",
        error: ""
    };


    handleChange = prop => event => {
        this.setState({[prop]: event.target.value});
    };
    handleChangePickers = prop => event => {
        this.setState({[prop]: event});
    };

    onPreviewDrop = files => {
        this.setState({
            files: files[0]
        });
    };

    _handleSubmit = e => {
        const {name} = JSON.parse(localStorage.user);
        e.preventDefault();


        const state = this.state;
        if (!state.title ||
            !state.description ||
            !state.price ||
            !state.receiving_details ||
            !state.category ||
            !state.usage_type
        ) {
            this.setState({
                error: "Please fill all the feilds!"
            });
        } else if (!moment(state.end_date).isAfter(state.start_date)) {
            this.setState({
                error: "End date cannot be before start date!"
            });
        } else if( parseInt(state.price) <= 0){
            this.setState({
                error: "Price cannot be 0 or below!"
            });
        } else{
            this.setState({
                error: ""
            });
            const start_date = moment(state.start_date).format('MMM DD YYYY h:mma');
            const end_date = moment(state.end_date).format('MMM DD YYYY h:mma');

            let data = {
                category: state.category,
                usage_type: state.usage_type,
                receiving_details: state.receiving_details,
                item_description: state.description,
                owner_name: name,
                title: state.title,
                price: parseInt(state.price),
                start_date: start_date,
                end_date: end_date,
            };
            let formData = new FormData();
            formData.append("pic", state.files);

            console.log(this.state.files)

            this.props.onSubmit(data, formData);
            console.log(data);
        }
    };

    render() {
        const {classes} = this.props;

        return (
            <div className={classes.container}>
                <Paper className={classes.paper}>
                    <div className={classes.root}>
                        <Typography variant="h3" gutterBottom align="center" style={{width: "100%"}}>
                            Submit an Ad
                        </Typography>
                        <form onSubmit={this._handleSubmit} style={{width: "100%"}}>
                            <FormControl fullWidth className={classes.margin}>
                                <InputLabel htmlFor="adornment-password">Title</InputLabel>
                                <Input
                                    id="title"
                                    type="text"
                                    value={this.state.title}
                                    onChange={this.handleChange("title")}
                                />
                            </FormControl>
                            <FormControl fullWidth className={classes.margin}>
                                <InputLabel htmlFor="adornment-password">Receiving details</InputLabel>
                                <Input
                                    id="receiving_details"
                                    type="text"
                                    value={this.state.receiving_details}
                                    onChange={this.handleChange("receiving_details")}
                                />
                            </FormControl>
                            <Grid container spacing={24}>
                                <Grid item md={6}>
                                    <FormControl className={classes.formControl}>
                                        <InputLabel htmlFor="demo-controlled-open-select">
                                            Category
                                        </InputLabel>
                                        <Select
                                            value={this.state.category}
                                            onChange={this.handleChange("category")}
                                            inputProps={{
                                                name: "category",
                                                id: "demo-controlled-open-select"
                                            }}
                                        >
                                            <MenuItem value="">
                                                <em>None</em>
                                            </MenuItem>
                                            <MenuItem value={"Film and Photography"}>Film & Photography</MenuItem>
                                            <MenuItem value={"Projectors and Screens"}>Projectors & Screens</MenuItem>
                                            <MenuItem value={"Drones"}>Drones</MenuItem>
                                            <MenuItem value={"DJ Equipment"}>DJ Equipment</MenuItem>
                                            <MenuItem value={"Sports"}>Sports</MenuItem>
                                            <MenuItem value={"Musical Instruments"}>Musical Instruments</MenuItem>
                                        </Select>
                                    </FormControl>
                                </Grid>
                                <Grid item md={6}>
                                    <FormControl className={classes.formControl}>
                                        <InputLabel htmlFor="demo-controlled-open-select">
                                            Usage type
                                        </InputLabel>
                                        <Select
                                            value={this.state.usage_type}
                                            onChange={this.handleChange("usage_type")}
                                            inputProps={{
                                                name: "usage_type",
                                                id: "demo-controlled-open-select-1"
                                            }}
                                        >
                                            <MenuItem value="">
                                                <em>None</em>
                                            </MenuItem>
                                            <MenuItem value={"pets"}>Pets</MenuItem>
                                            <MenuItem value={"cars"}>Cars</MenuItem>
                                            <MenuItem value={"property"}>Property</MenuItem>
                                            <MenuItem value={"bikes"}>Bikes</MenuItem>
                                            <MenuItem value={"electronics"}>Electronics</MenuItem>
                                            <MenuItem value={"mobiles"}>Mobiles</MenuItem>
                                            <MenuItem value={"furniture"}>Furniture</MenuItem>
                                            <MenuItem value={"books"}>Books</MenuItem>
                                            <MenuItem value={"services"}>Services</MenuItem>
                                            <MenuItem value={"fashion"}>Fashion</MenuItem>
                                            <MenuItem value={"agriculture"}>Agriculture</MenuItem>
                                            <MenuItem value={"sports"}>Sports</MenuItem>
                                        </Select>
                                    </FormControl>
                                </Grid>
                            </Grid>
                            <FormControl
                                fullWidth
                                className={classNames(classes.margin, classes.textField)}
                            >
                                <TextField
                                    id="description"
                                    label="Description"
                                    multiline
                                    rowsMax="4"
                                    className={classes.textField}
                                    margin="normal"
                                    value={this.state.description}
                                    onChange={this.handleChange("description")}
                                />
                            </FormControl>
                            <FormControl
                                fullWidth
                                className={classNames(classes.margin, classes.textField)}
                            >
                                <InputLabel htmlFor="adornment-password">Price</InputLabel>
                                <Input
                                    id="price"
                                    type="number"
                                    value={this.state.price}
                                    onChange={this.handleChange("price")}
                                />
                            </FormControl>

                            <Grid container spacing={24}>
                                <Grid item md={6}>
                                    <FormControl
                                        fullWidth
                                        className={classNames(classes.margin, classes.textField)}
                                    >
                                        <MuiPickersUtilsProvider utils={DateFnsUtils}>
                                            <DateTimePicker
                                                margin="normal"
                                                label="Start Date"
                                                value={this.state.start_date}
                                                onChange={this.handleChangePickers("start_date")}
                                            />
                                        </MuiPickersUtilsProvider>
                                    </FormControl>
                                </Grid>
                                <Grid item md={6}>
                                    <FormControl
                                        fullWidth
                                        className={classNames(classes.margin, classes.textField)}
                                    >
                                        <MuiPickersUtilsProvider utils={DateFnsUtils}>
                                            <DateTimePicker
                                                margin="normal"
                                                label="End Date"
                                                value={this.state.end_date}
                                                onChange={this.handleChangePickers("end_date")}
                                            />
                                        </MuiPickersUtilsProvider>
                                    </FormControl>
                                </Grid>
                            </Grid>
                                <Grid container spacing={24}>
                                    <Grid item md={6}>
                                        <FormControl
                                            fullWidth
                                            className={classNames(classes.margin, classes.textField)}
                                        >
                                        <ReactDropzone accept="image/*" onDrop={this.onPreviewDrop}>
                                            Drop an image!
                                        </ReactDropzone>

                            </FormControl>

                        </Grid>
                                    <Grid item md={6}>
                                        <FormControl
                                            fullWidth
                                            className={classNames(classes.margin, classes.textField)}
                                        >

                                        {/*{this.state.files !== "" && <h4>Preview</h4>}*/}
                                        {this.state.files !== ""  &&
                                        <img
                                            src={this.state.files.preview}
                                            key={this.state.files.preview}
                                            alt="Preview"
                                            width="100px"
                                            style={{padding: "20px", marginBottom: "20px"}}
                                        />}
                                    </FormControl>
                                    </Grid>
                                </Grid>


                            {this.state.error && <p>{this.state.error}</p>}
                            <FormControl
                                fullWidth
                                className={classNames(classes.margin, classes.textField)}
                            >
                            <Button
                                variant="contained"
                                color="primary"
                                className={classes.button}
                                type="submit"
                                style={{ backgroundColor: "#FF7700" }}
                            >
                                POST
                            </Button>
                            </FormControl>
                        </form>
                    </div>
                </Paper>
            </div>
        );
    }
}

export default withStyles(styles)(InputAdornments);
