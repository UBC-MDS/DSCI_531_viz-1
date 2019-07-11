# DSCI 531: Data Visualization I

Effective static data graphics using R and python for exploratory data analysis.

__Course website__: <https://ubc-mds.github.io/DSCI_531_viz-1/>


## Course Learning Outcomes

By the end of the course, students are expected to:

* Implement python libraries and R’s ggplot2 to generate static graphics.
* Understand the key components/encodings of a statistical graphic.
* Describe key modern plot types and their uses for EDA.
* Analyze and draw conclusions from data using EDA. 
* Make effective design choices when producing a data graphic.
* Understand where EDA falls short (Eg. Automatic decision making)

## Assessments

You'll be evaluated as follows:

| Assessment       | Weight  | Due Date         | Location | Covers | 
|------------------|---------|------------------|----------|--------|
| ["Half Lab" Assignment 1](release/lab1/lab1.ipynb) | 6%      | Saturday, Oct 13 at 18:00 | Submit to Github | Lec 1 |
| [Lab Assignment 2](release/lab2/lab2.ipynb) | 12%     | Saturday, Oct 20 at 18:00 | Submit to Github | Lec 2-3 |
| Quiz 1           | 20%     | Tuesday, Oct 23, 15:00-15:30   | Your lab room; submit to canvas | Lec 1-3, Lab 1-2 |
| [Lab Assignment 3](release/lab3/lab3.Rmd) | 12%     | Saturday, Oct 27 at 18:00 | Submit to Github | Lec 4-5 |
| [Lab Assignment 4](release/lab4/) | 12%     | Saturday, Nov 3 at 18:00     | Submit to Github | Lec 6-7 |
| Quiz 2           | 20%     | Wed, November 7, 14:00 – 14:30 | Your DSCI 512 (Wednesday) lab rooms | Lec 4-8, Lab 3-4 |
| [Lec 8 Hackathon](release/hackathon/hackathon.md)  | 6%      | Tuesday, Nov 6 at 18:00 | Submit to GitHub | NA |
| [Peer Review of Hackathon](release/peer_review/peer_review.md) | 5% | ~~Friday~~ Wednesday, Nov 7 at 18:00 | Submit to GitHub | NA |
| [Participation](participation/participation.md)    | 7%      | NA | NA | Seven lectures |

Tip: Use the lecture learning objectives as beacons when studying for your quizzes!


## Lecture Details

| Lecture | Topic | Pre-readings/Resources |
|---------|-------|------------------------|
| [1](lectures/lec1.md) / [complete worksheet](lectures/lec1-worksheet-complete.md) | Basic plot "types" with `ggplot2` | [r4ds: data-vis](http://r4ds.had.co.nz/data-visualisation.html), esp. 3.6 |
| [2](lectures/lec2.md) / [complete worksheet](lectures/lec2-worksheet-complete.md) | EDA; aesthetic mappings in `ggplot2` | [r4ds: data-vis](http://r4ds.had.co.nz/data-visualisation.html), esp. 3.3 |
| [3](lectures/lec3.md) / [complete worksheet](lectures/lec3-worksheet-complete.md) | Dependence. Finish looking at `ggplot2` as a tool. | [stat545: colors](http://stat545.com/block018_colors.html); [Jenny's theme tutorial](https://github.com/jennybc/ggplot2-tutorial/blob/master/gapminder-ggplot2-themes.md) |
| [4](lectures/lec4.md) / [complete worksheet](lectures/lec4-worksheet-complete.html) | Special plot types: `GGally`, Interactivity and 3D plotting with `plotly`, `ggmaps` | [ggobi's list of GGally extensions](http://ggobi.github.io/ggally/); [r-bloggers on `ggmap`](https://www.r-bloggers.com/how-to-plot-basic-maps-with-ggmap/) |
| [5](lectures/lec5.md) | Plotting for humans | [stat545: dos-and-donts](http://stat545.com/block015_graph-dos-donts.html), [Geckoboard tips](https://www.geckoboard.com/learn/data-literacy/data-visualization-tips/) |
| [6](lectures/lec6.ipynb)  | Plotting in Python, Part I: matplotlib | [pyplot tut](https://matplotlib.org/users/pyplot_tutorial.html) | 
| [7](lectures/lec7.ipynb)  | Plotting in Python, Part II: seaborn | [elitedatascience seaborn tut](https://elitedatascience.com/python-seaborn-tutorial) |
| [8](lectures/lec8.md) | Hackathon  |


## Annotated Resources

Here are prominent course resources that we will be referring to.

1. [R for Data Science (r4ds)](http://r4ds.had.co.nz/)
   - Overall good book on using R for data science -- including data vis, of course!
2. [ggplot2 book](http://webcat2.library.ubc.ca/vwebv/holdingsInfo?bibId=8489511)
   - Readable, comprehensive resource for learning about `ggplot2`, by the main author of the `ggplot2` package, Hadley Wickham. 
3. [STAT 545 "All the Graph Things"](http://stat545.com/graph00_index.html) by Jenny Bryan.
   - Contains tutorials relevant to our subject matter.

Other resource that you might find useful:

1. [R Graphics Cookbook](http://www.cookbook-r.com/Graphs/)
   - Good as a reference if you want to learn how to make a specific type of plot in `ggplot2`. 
2. [Jenny Bryan's ggplot2 tutorial](https://github.com/jennybc/ggplot2-tutorial)
   - Has a lot of examples and less dialogue.
3. [ggplot2 cheat sheet](https://github.com/rstudio/cheatsheets/blob/master/data-visualization-2.1.pdf)
   - Great for quick reference if you need something beyond tab-completion.
4. "Visualization Analysis and Design" by Tamara Munzner, CRC Press, 2014.
   - The go-to book for data vis theory.


## Policies

Please see the general [MDS policies](https://ubc-mds.github.io/policies/).

## License

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

