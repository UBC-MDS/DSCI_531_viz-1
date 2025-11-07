---
jupytext:
  formats: ipynb,md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.14.7
kernelspec:
  display_name: Python [conda env:531]
  language: python
  name: conda-env-531-py
---

# Exploratory data analysis (EDA)

+++

::::{grid}

:::{grid-item-card}
**Lecture learning goals**
^^^

By the end of the lecture you will be able to:

1. Visualize missing values.
2. Define what EDA is on a conceptual levels both for numerical and categorical variables.
3. Use repeated plot grids to investigate multiple data frame columns in the same plot.
4. Visualize correlations.
5. Visualize counts of categorical variables.
:::

:::{grid-item-card}
**Required activities**
^^^

Before class:
- [This 10 min video on EDA concepts](https://ubcca-my.sharepoint.com/:v:/g/personal/joel_ostblom_ubc_ca/ETctjEToFRlJr38d8jqcOHMBRnJFHLlY0JHKXYLrD8Brvw?e=oZ9b59).

After class:
- Review the lecture notes.
- [Interactive flow chart](https://www.data-to-viz.com/) for which visualization to choose. Not really anything to read, but go there to look around and bookmark it to use as a reference when needed throughout this course and others.

:::
::::

```{code-cell} ipython3
import altair as alt
import pandas as pd

# Simplify working with large datasets in Altair
alt.data_transformers.enable('vegafusion')
```

## Missing values

### Py

First we are going to load in some weather data and simulate a faulty sensor by assigning some NaN values manually.

```{code-cell} ipython3
from vega_datasets import data
import numpy as np


df = data.seattle_weather()
# Artifically introduce some NaNs to simulate a sensor that can't measure below freezing
df.loc[df['temp_min'] <= 0.6, 'temp_min'] = np.nan
df.loc[df['temp_max'] <= 0.6, 'temp_max'] = np.nan
df = df[df['weather'].isin(['rain', 'snow', 'sun'])]
df
```

If we were to visualize this data 
in order to answer the the question
"what what the minimum temperature each year for the difference types of weather?"
it might look something like this:

```{code-cell} ipython3
alt.Chart(df).mark_point(size=120, opacity=0.7).encode(
    y='year(date):N',
    x='min(temp_min)',
    color='weather',
    shape='weather'
)
```

One immediate drawback with this visualization is that there could be overlapping dots in the exact same spot
which make it difficult to see the exact values from each weather type.
This chart still reveals something peculiar about our data:
it looks like the dots are neatly arranged in a grid around the lowest temperature for each year.
Almost too neat... this might be due to some binning on the data or maybe that the resolution of the sensor is low.
There is also probably something going where the lowest values are clamped to just over one degree celsius,
that seems quite odd as we would expect some variation in the yearly minimum temperature as well.
This could be due to some error in how the data was pre-processed
or maybe that the sensor mechanics don't tolerate values under freezing
and it stops measuring during that time.

In general when we read in data,
it is a good idea to perform some EDA on the missing values before starting to do it on the rest of the data,
regardless of whether we have already observed a weird pattern or not.
`df.info()` can show us how many missing values there are,
but we don't get any info on their pattern.

```{code-cell} ipython3
df.info()
```

To see if there is a pattern in the missing values, 
the simplest we could do would be to use pandas built in styling functions.
This produces quite long output,
so I have truncated it here,
but if you were to scroll through it 
you would see that there seems to be a periodicity to the data
and since this data set is ordered by the date the measurement was collected
it seems like this periodic variation is through time.

```{code-cell} ipython3
df[:50].style.highlight_null()
```

We could create a more effective visualization of this using Altair,
but it would be a bit involved as you can see below.
The reason we are melting the data
is so that we can perform this viz for all the columns
since we don't know where the EDA values are when we do EDA.
If you are only interested in one column,
you could skip the melting part.

```{code-cell} ipython3
alt.Chart(
    df.isna().reset_index().melt(
        id_vars='index'
    )
).mark_rect().encode(
    alt.X('index:O').axis(None),
    alt.Y('variable').title(None),
    alt.Color('value').title('NaN'),
    alt.Stroke('value')  # We set the stroke which is the outline of each rectangle in the heatmap
).properties(
    width=df.shape[0]
)
```

Aha! Here we can clearly see the periodic pattern in the data.
There is a predictable reoccurrence of the missing values.
Again,
remember that this data is ordered by time
even thought we are using the index when plotting it
to make sure this technique works with dataframe that do not have a date column.

We could explore what this patterns is due to
by sorting the data by another variable.
Let's test our hypothesis that the sensor
can't measure low temperatures.
If this is true,
we should see that all the temp_min values bunch up
to the left since this is also where the lowest temp_max temparatures are
(a day with a low max temperature is more likely to have a low min temperature).

```{code-cell} ipython3
alt.Chart(
    df.sort_values(
        'temp_max',
        ignore_index=True
    ).isna().reset_index().melt(
        id_vars='index'
    )
).mark_rect().encode(
    alt.X('index:O').axis(None),
    alt.Y('variable').title(None),
    alt.Color('value').title('NaN'),
    alt.Stroke('value')
).properties(
    width=df.shape[0]
)
```

There does indeed seem like the missing values are related to low daily temperatures!
(to the far right you can see the values that are NaN for both the max and min temperature,
NaNs are sorted after all numerical values in pandas).

We could have used the sorting technique with the pandas styler as well:

```{code-cell} ipython3
# Just showing the first 50 to save space
df.sort_values('temp_max')[:50].style.highlight_null()
```

The missing values in our case were directly related to the column itself,
low `temp_min` values meant that they were missing.
Values could also be missing seemingly randomly,
or depending on another column in the data frame.
These three types of missing values are sometimes called:

- Missing not at random - Depends on the value in the column itself
- Missing at random - Depends on the value in another column
- Missing completely at random - Doesn't seem to depend on any other *measured* variable

The underlying reasons for missing values can be quite domain specific,
e.g. a medical doctor might be missing blood pressure measurements for younger adults
than for older adults since that information might be more valuable for older people.
In this case we would say that the values are missing at random
since there is no relation between the actual blood pressure reading and whether a value goes missing
but there is a relation to the patients age
which would be another variable in our dataset
(it is more important you remember these principles than memorizing the exact names).
There are [more discussion of these concepts in this article](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4121561/).

+++

### R

There is no styler function in dplyer like in pandas,
so we will go straight to showing a summary and creating the heatmap:

```{code-cell} ipython3
%load_ext rpy2.ipython
```

```{code-cell} ipython3
%%R -i df
library(tidyverse)

df |> glimpse()
```

There is no overview of NAs in `glimpse`,
instead we can see the NAs in `summary`:

```{code-cell} ipython3
%%R
df |> summary()
```

We use the same strategy to visualize NaNs in ggplot as in Altair
where we first pivot_longer the dataframe:

```{code-cell} ipython3
%%R -w 1200
theme_set(theme_gray(base_size = 20))

df |>
    map_df(is.na) |>
    mutate(index = row_number()) |>
    pivot_longer(-index) |>
    ggplot(aes(x = index, y = name, fill = value)) +
        geom_raster() +
        labs(y = '', fill = 'NaN')
```

Sorted by max temp:

```{code-cell} ipython3
%%R -w 1200
theme_set(theme_gray(base_size = 20))

df |>
    arrange(temp_max) |>
    map_df(is.na) |>
    mutate(index = row_number()) |>
    pivot_longer(-index) |>
    ggplot(aes(x = index, y = name, fill = value)) +
        geom_raster() +
        labs(y = '', fill = 'NaN')
```

## Repeating the same plots for multiple dataframe columns

+++

### Py

Previously we have made subplots via faceting,
which creates one subplot per unique value in a categorical column
and displays the same numerical columns in all the subplots/facets.
This view of multiple subsets in the data
is often called a trellis plot or plot of small multiples.
Here,
we will see how we can create subplots that each display all the data points,
but is repeated for different columns in the data.

We specify which columns we want to use via the `.repeat` method,
and where we want to use them via `alt.repeat`.
For this plot,
we keep the y-axis constant,
and repeat the plot for different x-axis columns.

```{code-cell} ipython3
url = 'https://raw.githubusercontent.com/joelostblom/teaching-datasets/main/movies.json'
movies = pd.read_json(url)[['runtime', 'budget', 'revenue', 'genres', 'countries']]
movies
```

```{code-cell} ipython3
# You could extract the columns like this, but we will write them out for clarity here
# numeric_cols = movies.select_dtypes('number').columns.tolist()
alt.Chart(movies).mark_bar().encode(
     alt.X(alt.repeat()).type('quantitative').bin(maxbins=40),
     y='count()',
).properties(
    width=300,
    height=200
).repeat(
    ['runtime', 'revenue', 'budget']
)
```

### R

There is not "repeat" function in ggplot,
so we would first need to pivot all data frame variables
into the same column and then use faceting on this new column name.

```{code-cell} ipython3
%%R

library(rjson)
library(tidyverse)
theme_set(theme_gray(base_size = 16))


url <- 'https://raw.githubusercontent.com/joelostblom/teaching-datasets/main/movies.json'
movies <- fromJSON(file = url) %>%
    as_tibble() %>%
    select(runtime, revenue, budget, genres, countries) %>%
    unnest(-c(countries, genres))
glimpse(movies)
```

```{code-cell} ipython3
%%R

movies_long <- movies |>
    select_if(is.numeric) |>
    pivot_longer(everything())  # To get only some columns we can write c(revenue, budget)

movies_long
```

```{code-cell} ipython3
%%R -w 800 -h 250

movies_long |>
    ggplot(aes(x = value)) + 
        geom_density(fill = 'grey') + 
        facet_wrap(~name, scales = 'free')
```

### Repeating on two axes

#### Py

To efficiently repeat over both the axis,
we can use the `column` and `row` parameter to `repeat`.
These work similarly as they do for `facet`,
distributing the list of data frame variables 
over only one axis,
which we specify with `alt.repeat` to the x and y axis.

```{code-cell} ipython3
alt.Chart(movies).mark_point(opacity=0.3, size=10).encode(
     alt.X(alt.repeat()).type('quantitative'),
     y='revenue',
).properties(
    width=200,
    height=200
).repeat(
    ['runtime', 'revenue', 'budget']
)
```

When we don't give any named parameters to `repeat` and `alt.repeat`,
they use the default,
which is `repeat` and then you can wrap with `columns=2` if you want more than one row.
We could use this technique to create a what is usually called a scatter plot matrix (or pairplot),
where we repeat numerical columns on both axes to investigate their pairwise relationships.

```{code-cell} ipython3
alt.Chart(movies).mark_point(opacity=0.3, size=10).encode(
     alt.X(alt.repeat('row')).type('quantitative'),
     alt.Y(alt.repeat('column')).type('quantitative')
).properties(
    width=200,
    height=200
).repeat(
    column=['runtime', 'revenue', 'budget'],
    row=['runtime', 'revenue', 'budget']
)
```

```{code-cell} ipython3
alt.Chart(movies).mark_point(opacity=0.3, size=10).encode(
     alt.X(alt.repeat('column')).type('quantitative'),
     alt.Y(alt.repeat('row')).type('quantitative')
).properties(
    width=200,
    height=200
).repeat(
    row=['runtime', 'revenue', 'budget'],
    column=['runtime', 'revenue', 'budget']
)
```

#### R

+++

This would not work if both axes are numerical,
but luckiy there is an extension packagge for ggplot called GGally,
which can be used here.
It also plots the density curves on the diagonal and the correlations on top.

```{code-cell} ipython3
%%R -w 800 -h 550
library(GGally)
GGally::ggpairs(movies %>% select_if(is.numeric), progress = FALSE)
```

This function can also show info on categorical variables.

```{code-cell} ipython3
%%R -w 800 -h 550

free_countries <- movies %>% unnest(countries) %>% select(!genres)
GGally::ggpairs(free_countries, aes(color = countries), progress=FALSE)
```

Plotting multiple categories is also possible and will include counts of the combinations of categories as in the next plot.
Customizing these plots is a bit cumbersome,
[this blog post has some good examples](https://www.blopig.com/blog/2019/06/a-brief-introduction-to-ggpairs/),
and you can see one below too.

```{code-cell} ipython3
%%R -w 800 -h 750

free_both <- movies %>% unnest(genres) %>% unnest(countries)
GGally::ggpairs(
    free_both,
    aes(color = countries),
    progress = FALSE,
    lower = list(continuous = GGally::wrap('points', alpha = 0.3, size=0.1, color = 'steelblue')),
    diag = list(continuous = GGally::wrap('densityDiag', fill = 'coral', alpha = 0.4))) 
```

## Correlation plots

### Py

A good complement to a scatter plot matrix is a correlation plot
which helps formalize the correlation between numerical variables.
Using "spearman" correlation instead of "pearson" 
allows us to detect non-linear relationships better.

This can be done in pandas via the styler (requires matplotlib).

```{code-cell} ipython3
movies.corr(numeric_only=True).style.background_gradient()
```

We could do the same in Altair but it would require some more work

```{code-cell} ipython3
corr_df = (
    movies
    .corr('spearman', numeric_only=True)
    .abs()                      # Use abs for negative correlation to stand out
    .stack()                    # Get df into long format for altair
    .reset_index(name='corr'))  # Name the index that is reset to avoid name collision
corr_df
```

```{code-cell} ipython3
alt.Chart(corr_df).mark_circle().encode(
    x='level_0',
    y='level_1',
    size='corr',
    color='corr'
)
```

With some effort, we can make it look nicer and remove the correlation on the diagonal since that is just with the same column.

```{code-cell} ipython3
corr_df = movies.select_dtypes('number').corr('spearman', numeric_only=True).stack().reset_index(name='corr')
corr_df.loc[corr_df['corr'] == 1, 'corr'] = 0  # Remove diagonal
corr_df['abs'] = corr_df['corr'].abs()
corr_df
```

```{code-cell} ipython3
alt.Chart(corr_df).mark_circle().encode(
    x='level_0',
    y='level_1',
    size=alt.Size('abs').scale(domain=(0, 1)),
    color=alt.Color('corr').scale(scheme='blueorange', domain=(-1, 1))
)
```

The domain argument sets the extent of the colorscale
(from a perfect negative to a perfect positive correlation), 
we will talk more about colorscale later in the course.

+++

### R

We could do the separate calculation in ggplot as well,
but there is also a special function in GGally,
which does the computation and visualizes it as a heatmap.

```{code-cell} ipython3
:tags: [solution]

%%R -w 600 -h 350
GGally::ggcorr(movies)
```

## Counting combinations of categorical groups

### Py

Counting categoricals is helpful to get and overview of where most observations lie.
Often the size and color can be used for this, 
similar to the correlation plot.

```{code-cell} ipython3
boom_both = movies.explode('countries').explode('genres')
alt.Chart(boom_both).mark_square().encode(
    x='genres',
    y='countries',
    color='count()',
    size='count()'
)
```

As with bar charts of counts,
it is often helpful to sort these categorical plot according to which combinations have the most counts.
Here we can sort based on the `color` or `size` encoding,
just as we have sorted based on `x` and `y` before
(the effect of this sorting is more notable in larger charts).

```{code-cell} ipython3
boom_both = movies.explode('countries').explode('genres')
alt.Chart(boom_both).mark_square().encode(
    x=alt.X('genres').sort('-color'),
    y=alt.Y('countries').sort('color'),
    color='count()',
    size='count()'
)
```

A heatmap could be created as well,
but it can be a little harder to see the difference here
sine we are not using size for the count,
just color variations.

```{code-cell} ipython3
alt.Chart(boom_both).mark_rect().encode(
    x='genres',
    y='countries',
    color='count()'
)
```

For more precise counts,
we could use a faceted bar chart.

```{code-cell} ipython3
alt.Chart(boom_both).mark_bar().encode(
    x='count()',
    y='genres',
    color='genres'
).facet(
    'countries',
    columns=1
)
```

### R

GGally has a similar plot for counting categories.

```{code-cell} ipython3
%%R -w 600 -h 350

free_both <- movies %>% unnest(genres) %>% unnest(countries)
GGally::ggally_cross(free_both, aes(x = genres, y = countries))
```

We can create an heatmap using ggplot's `geom_tile` together with `add_count` (remember that this function adds the count in a column names `n`).

```{code-cell} ipython3
%%R -w 600 -h 350

free_both %>%
    add_count(genres, countries) %>%
    ggplot() +
        aes(x = genres,
            y = countries,
            fill = n) +
        geom_tile()
```

A barplot of counts could be made in ggplot without faceting by using `'dodge'` for he `position`.
The `color` parameter is used to create visual separation between the bars with a white outline.

```{code-cell} ipython3
%%R -w 600 -h 350

ggplot(free_both) +
    aes(y = countries,
        fill = genres) +
    geom_bar(stat = 'count', position = 'dodge', color = 'white')
```

## Optional material

In addition to the `ggally` package,
there are a few other packages in both R and Python
that facilitate quick EDA and missing value visualization.
As long as you understand the underlying principles you are free 
to use any of these:

```{code-cell} ipython3
import altair_ally as aly

aly.nan(df.sort_values('temp_max', ignore_index=True))
```

```{code-cell} ipython3
aly.pair(movies)
```

Python

- https://github.com/ResidentMario/missingno
- https://github.com/ydataai/pandas-profiling
- https://github.com/fbdesignpro/sweetviz
- https://github.com/AutoViML/AutoViz
- https://github.com/ing-bank/popmon
- https://github.com/joelostblom/altair_ally
- https://github.com/lux-org/lux

R

- https://github.com/ggobi/ggally/
- https://github.com/statistikat/VIM (https://www.datacamp.com/tutorial/visualize-data-vim-package)

Some of them go to great length to facilitate the creation of quick EDA visualizations:

![](https://raw.githubusercontent.com/lux-org/lux-resources/master/readme_img/basicDemo.gif)
