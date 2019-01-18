import React from "react";
import PropTypes from "prop-types";
import { withStyles } from "@material-ui/core/styles";
import Grid from "@material-ui/core/Grid";
import Typography from "@material-ui/core/Typography";

import CategoryItem from "./CategoryItem";

const styles = theme => ({
  root: {
    flexGrow: 1,
    maxWidth: "1080px",
    display: "flex",
    margin: "0 auto",
    padding: "50px 15px"
  },
  paper: {
    padding: theme.spacing.unit * 2,
    textAlign: "center",
    color: theme.palette.text.secondary
  },
  container: {
    zIndex: 0
  }
});

// Film & Photography, Projectors and Screens, Drones, DJ Equipment, Sports, Musical Instruments
const categories = [
  {
    url: '/images/categories/film_photography.jpg',
    title: 'Film & Photography',
    width: '100%',
    caturl: '/category/Film%20%26%20Photography',
  },
  {
    url: '/images/categories/screen_projectors.jpg',
    title: 'Projectors & Screens',
    width: '100%',
    caturl: '/category/Projectors%20and%20Screens',
  },
  {
    url: '/images/categories/drones.jpg',
    title: 'Drones',
    width: '100%',
    caturl: '/category/drones',
  },
  {
    url: '/images/categories/dj_equipment.jpg',
    title: 'DJ Equipment',
    width: '100%',
    caturl: '/category/dj%20equipment',
  },
  {
    url: '/images/categories/sport.jpg',
    title: 'Sports',
    width: '100%',
    caturl: '/category/sports',
  },
  {
    url: '/images/categories/musical_instruments.jpg',
    title: 'Musical Instruments',
    width: '100%',
    caturl: '/category/musical%20instruments',
  },
]

function FullWidthGrid(props) {
  const { classes } = props;

  return (
    <div className={classes.root}>
      <Grid container spacing={24} className={classes.container}>
        <Grid xs={12} item>
          <Typography style={{ textAlign: "center" }} variant="h4" gutterBottom>
            Categories
          </Typography>
        </Grid>
        {categories.map(category => (
          <Grid item xs={6} sm={4}>
            <CategoryItem
              url={category.url}
              width={category.width}
              title={category.title}
              caturl={category.caturl}
              key={category.title}
            />
          </Grid>
        ))}
      </Grid>
    </div>
  );
}

FullWidthGrid.propTypes = {
  classes: PropTypes.object.isRequired
};

export default withStyles(styles)(FullWidthGrid);
