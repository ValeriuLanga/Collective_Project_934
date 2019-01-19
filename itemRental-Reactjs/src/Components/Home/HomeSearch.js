import React from "react";
import PropTypes from "prop-types";
import { connect } from "react-redux";
import { withRouter } from "react-router-dom";
import { withStyles } from "@material-ui/core/styles";
import TextField from "@material-ui/core/TextField";
import { SearchSharp as Search } from "@material-ui/icons";
import Button from "@material-ui/core/Button";
import cities from "./cities.json";
import classNames from "classnames";
import Select from "react-select";
import Typography from "@material-ui/core/Typography";
import NoSsr from "@material-ui/core/NoSsr";
import Paper from "@material-ui/core/Paper";
import Chip from "@material-ui/core/Chip";
import MenuItem from "@material-ui/core/MenuItem";
import Grid from "@material-ui/core/Grid";
import orange from '@material-ui/core/colors/orange';

import { emphasize } from "@material-ui/core/styles/colorManipulator";

import { getAds } from "../../actions/ads";
import {URL_SERVER} from "../../utils/constants";

const styles = theme => ({
  root: {
    flexGrow: 1,
    height: 250
  },
  input: {
    display: "flex",
    padding: 0
  },
  valueContainer: {
    display: "flex",
    flexWrap: "wrap",
    flex: 1,
    alignItems: "center",
    zIndex: 100
  },
  chip: {
    margin: `${theme.spacing.unit / 2}px ${theme.spacing.unit / 4}px`
  },
  chipFocused: {
    backgroundColor: emphasize(
      theme.palette.type === "light"
        ? theme.palette.grey[300]
        : theme.palette.grey[700],
      0.08
    )
  },
  noOptionsMessage: {
    padding: `${theme.spacing.unit}px ${theme.spacing.unit * 2}px`
  },
  singleValue: {
    fontSize: 16
  },
  placeholder: {
    position: "absolute",
    left: 2,
    fontSize: 16
  },
  paper: {
    marginTop: theme.spacing.unit
  },
  divider: {
    height: theme.spacing.unit * 2
  },
  container: {
    flexWrap: "wrap",
    maxWidth: 1080,
    justifyContent: "center",
    margin: "0 auto",
    maxHeight: 93,
  },
  textField: {
    marginLeft: theme.spacing.unit,
    marginRight: theme.spacing.unit,
    paddingTop: 20,
    width: "100%",
    zIndex: 100
  },
  button: {
    margin: theme.spacing.unit,
    marginTop: "25px",
    backgroundColor: orange[500], 
    '&:hover': {
      backgroundColor: orange[700],
    },
  },
  leftIcon: {
    marginLeft: theme.spacing.unit
  },
  rightIcon: {
    marginLeft: theme.spacing.unit
  },
  "@media only screen and (max-width: 960px)": {
    container: {
      maxHeight: 300,
    },
  },
});

function NoOptionsMessage(props) {
  return (
    <Typography
      color="textSecondary"
      className={props.selectProps.classes.noOptionsMessage}
      {...props.innerProps}
    >
      {props.children}
    </Typography>
  );
}

function inputComponent({ inputRef, ...props }) {
  return <div ref={inputRef} {...props} />;
}

function Control(props) {
  return (
    <TextField
      fullWidth
      InputProps={{
        inputComponent,
        inputProps: {
          className: props.selectProps.classes.input,
          inputRef: props.innerRef,
          children: props.children,
          ...props.innerProps
        }
      }}
      {...props.selectProps.textFieldProps}
    />
  );
}

function Option(props) {
  return (
    <MenuItem
      buttonRef={props.innerRef}
      selected={props.isFocused}
      component="div"
      style={{
        fontWeight: props.isSelected ? 500 : 400
      }}
      {...props.innerProps}
    >
      {props.children}
    </MenuItem>
  );
}

function Placeholder(props) {
  return (
    <Typography
      color="textSecondary"
      className={props.selectProps.classes.placeholder}
      {...props.innerProps}
    >
      {props.children}
    </Typography>
  );
}

function SingleValue(props) {
  return (
    <Typography
      className={props.selectProps.classes.singleValue}
      {...props.innerProps}
    >
      {props.children}
    </Typography>
  );
}

function ValueContainer(props) {
  return (
    <div className={props.selectProps.classes.valueContainer}>
      {props.children}
    </div>
  );
}

function MultiValue(props) {
  return (
    <Chip
      tabIndex={-1}
      label={props.children}
      className={classNames(props.selectProps.classes.chip, {
        [props.selectProps.classes.chipFocused]: props.isFocused
      })}
      onDelete={event => {
        props.removeProps.onClick();
        props.removeProps.onMouseDown(event);
      }}
    />
  );
}

function Menu(props) {
  return (
    <Paper
      square
      className={props.selectProps.classes.paper}
      {...props.innerProps}
    >
      {props.children}
    </Paper>
  );
}

const components = {
  Option,
  Control,
  NoOptionsMessage,
  Placeholder,
  SingleValue,
  MultiValue,
  ValueContainer,
  Menu
};

class TextFieldMargins extends React.Component {
  componentDidMount() {
    this.props.dispatch(getAds());
    setTimeout(() => {
      if (this.props.ads.ads.length >= 1) {
        this.props.ads.ads.map(item => {
          if (item.favorite === true && item.fEmail === this.props.user.email) {
            caches.open(`${item._id}`).then(cache => {
              return cache.addAll([
                `/listings/${item._id}`,
                `${URL_SERVER}/${item.file}`,
                `${this.props.user.avatar}`
              ]);
            });
          } else {
            return item;
          }
        });
      }
    }, 3000);
  }
  state = {
    single: null,
    multi: null
  };
  handleChange = name => value => {
    this.setState({
      [name]: value
    });
  };

  handleCityChange = name => value => {
    this.setState({
      [name]: value
    });
    setTimeout(() => {
      if (this.state.single !== null) {
        let adList = [];
        this.props.ads.ads.map(item => {
          if (item.city === this.state.single.value.toLowerCase()) {
            return adList.push({
              value: item._id,
              label: item.title
            });
          } else {
            return item;
          }
        });
        this.setState({
          ads: adList
        });
      }
      console.log(this.state);
    }, 2000);
  };

  _handleSubmit = () => {
    this.props.history.push(`/listings/${this.state.ad.value}`);
  };

  render() {
    const { classes } = this.props;
    let citylist = [];
    cities.map(item => {
      return citylist.push({
        value: item.city,
        label: item.city
      });
    });
    const selectStyles = {
      input: base => ({
        ...base
      })
    };

    return (
      <div className={classes.container}>
        <div className="searchContainer">
          <form onSubmit={this._handleSubmit}>
          <Grid container spacing={24}>
            <Grid item md xs={12}>
              <NoSsr>
                <Select
                  classes={classes}
                  styles={selectStyles}
                  options={citylist}
                  components={components}
                  value={this.state.single}
                  className={classes.textField}
                  onChange={this.handleCityChange("single")}
                  placeholder="Search a county"
                />
              </NoSsr>
              </Grid>
              <Grid item md xs={12}>
                <NoSsr>
                  <Select
                    classes={classes}
                    styles={selectStyles}
                    options={this.state.ads && this.state.ads}
                    components={components}
                    value={this.state.ad}
                    className={classes.textField}
                    onChange={this.handleChange("ad")}
                    placeholder="Search an Ad"
                  />
                </NoSsr>
              </Grid>
              <Grid item md={2} xs={12}>
                <Button
                  variant="contained"
                  color="primary"
                  className={classes.button}
                  type="submit"
                >
                  Search
                  <Search className={classes.leftIcon} />
                </Button>
              </Grid>
            </Grid>
          </form>
        </div>
      </div>
    );
  }
}

TextFieldMargins.propTypes = {
  classes: PropTypes.object.isRequired
};
const mapStateToProps = state => {
  return {
    user: state.auth.user,
    ads: state.ads
  };
};

export default connect(mapStateToProps)(
  withRouter(withStyles(styles)(TextFieldMargins))
);
