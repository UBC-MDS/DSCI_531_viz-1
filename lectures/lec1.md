Lecture 1: Basic plot 'types' with `ggplot2`
================

Lecture Preamble
================

Today's Lessons
---------------

After going over the course syllabus, we'll go over the following three lessons:

1.  Orientation to statistical graphics
2.  The grammar of graphics
3.  Plotting with `x` and `y` aesthetics

Resources
---------

Concepts from today's class (and next class) are closely mirrored by the following resources, which introduce `ggplot2`, although are organized in different ways for each.

The following are good walk-throughs that introduce `ggplot2`:

-   [r4ds: data-vis](http://r4ds.had.co.nz/data-visualisation.html) chapter.
    -   Perhaps the most compact "walk-through" style resource.
-   The [ggplot2 book](http://webcat2.library.ubc.ca/vwebv/holdingsInfo?bibId=8489511), Chapter 2.
    -   A bit more comprehensive "walk-through" style resource.
    -   Section 1.2 introduces the actual grammar components.

Here are some other resources you might find useful:

-   [Jenny's ggplot2 tutorial](https://github.com/jennybc/ggplot2-tutorial).
    -   Has a lot of examples, but less dialogue.
-   [R Graphics Cookbook](http://www.cookbook-r.com/Graphs/)
    -   Good as a reference if you want to learn how to make a specific type of plot.
-   [`ggplot2` cheatsheet](https://github.com/rstudio/cheatsheets/blob/master/data-visualization-2.1.pdf)

Participation
-------------

To get participation points for today:

1.  Fill out this exercise sheet with me in class.
2.  `git commit` whatever we finish in class to your participation repository.

Lesson 1: Orientation to statistical graphics
=============================================

Learning Objectives
-------------------

By the end of this lesson, students are expected to be able to:

-   Identify the plotting framework available in R
-   Have a sense of why we're learning the `ggplot2` tool (not on quiz)
-   Have a sense of the importance of statistical graphics in communicating information

Discussion
----------

There are four main ways you can produce graphics in R. In order of inception, they are

-   base R
-   `lattice`
-   `ggplot2`
    -   Part of the `tidyverse`
-   `plotly`

`ggplot2` will receive the strongest focus in this course. Why?

-   once fluent, can make most plots up to publication quality standard very quickly.
-   has theoretical underpinning in the "layered grammar of graphics", which is described in [the book by Leland Wilkinson](http://resolve.library.ubc.ca/cgi-bin/catsearch?bid=5507286).

Stackoverflow was my main source of learning. Google what you're trying to do, and persevere. You can do it.

[Jenny Bryan on statistical graphics](https://speakerdeck.com/jennybc/ggplot2-tutorial?slide=7):

-   A picture is worth 1000 words
-   More philosophy on graphics
-   Comparing base R/lattice/ggplot2
-   The learning curve

Lesson 2: The grammar of graphics
=================================

Learning Objectives
-------------------

By the end of this lesson, students are expected to be able to:

-   Identify the seven components of the grammar of graphics underlying `ggplot2`
-   Have a sense of what the seven components are
    -   You'll later be expected to be able to explain the main idea behind the components.

Discussion
----------

Leland Wilkinson lays out the grammar of graphics [in his book](http://www.springer.com/gp/book/9780387245447).

They define the "space of statistical graphics".

The grammar components, adapted to `ggplot2` (gg = grammar of graphics), where the **bold** ones are necessary to specify for every plot:

-   **Data**
-   **Aesthetic mappings**
-   **Geometric objects**
-   Scales
-   Statistical transformations
-   Coordinate system
-   Facet specification

Lesson 3: Plotting with `x` and `y` aesthetics
==============================================

Learning Objectives
-------------------

This live-coding-based lesson focusses on:

-   using the `x` and `y` aesthetic mappings, while
-   using different geometric objects to explore various plot "types".

By the end of this lesson, students are expected to be able to:

-   Create a variety of "plot types" using `ggplot2` under the following situations:
    -   two numeric variables
    -   one numeric variable
    -   one numeric, one categorical variable

Demonstration
-------------

Let's fill out as much as we can of the worksheet labelled `lec1-worksheet.Rmd`.
