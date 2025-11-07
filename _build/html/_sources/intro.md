# Syllabus

👋 **Welcome to DSCI 531!** 🚀

In this course we will learn how to (and how not to) visualize data. We will cover graphical grammars and practice using them via ggplot in R and Altair in Python. With these tools, we will create effective data visualizations that strengthen our own exploratory data analysis skills and our ability to communicate insights to others.

## Course structure

The main parts of this course are the following:

- Lecture notes, lab solutions, and course info  are put together on this site.
- Lab assignments are submitted via Gradescope (use the link from Canvas to get into Gradescope).
- Quizzes will be administrated via PrairieLearn.
- Office hours will be administrated in person or via Zoom (Zoom links are on Canvas and in [the MDS calendar](https://ubc-mds.github.io/calendar/)).

A few additional details as we get started:

- Required readings are listed on top of the lecture notes.
  There are none for the first class,
  but there will be for many of the other classes.
- Important course announcements are made via on Slack by tagging everyone in the channel so that you get a notification.
  We will also [pin these messages](https://slack.com/help/articles/205239997-Pin-messages-and-bookmark-links)
  so that you can view a list of all important messages at one place by clicking "Pinned messages" in the top left corner of the Slack channel.
- Before asking a new question,
  please [search the FAQ from previous iterations of the course](lectures/faq.md).
- When asking about specific lab questions on Slack,
  you can add a text tag (e.g. `lab3py_q10`)
  to make it easier for you and your colleagues to search the channel.
- If you have any questions regarding the course content, lectures, labs, autograders, etc,
  please post your question in the course Slack channel
  instead of sending a direct message to the instructor or TAs.
  This approach enables the teaching team (or another student)
  to respond more promptly
  and also benefits other students
  who might have similar questions.
- Response time:
  We will try our best to reply to your inquiries as soon as possible
  during the regular working hours (9 am - 5 pm Mon-Fri).
  If you send us a message outside of regular working hours,
  please expect a response on the next working day.

## Conda environment setup

To set up the necessary packages for running the labs
and lecture material from 531,
[download the environment file from the student repo to your computer](https://github.ubc.ca/mds-2025-26/DSCI_531_viz-1_students/blob/master/environment.yaml)
(hit "Raw" and then `Ctrl` + `s` to save it, or copy paste the content).
Then create a virtual environment by using `conda` with the environment file you just downloaded:

```
conda env create --file environment.yaml
```

This will setup both R and Python
with the correct versions of all required packages.
If you prefer (or run into issues),
you are free to use your system R installation
and setup the packages from the environment file manually instead.

````{note}
If you don't remember how to use a conda environment with JupyterLab,
[review this section of Lec 8 in 521](https://ubc-mds.github.io/DSCI_521_platforms-dsci_book/lectures/7a-virtual-environments-conda.html#making-environments-work-well-with-jupyterlab).
In essence, you should only need to run the following command
from the environment where you have JupyterLab installed (e.g. `base` or `jl`)
if you haven't already done so.

```
conda install nb_conda_kernels
```

Next time you open JupyterLab,
you should be able to select `531-py` or `531-r`
as your notebook kernel.
````

## Running the lecture notes

If you want to annotate on the lecture notes,
you can download a PDF version by clicking on the little download icon on the top of the page.
If you want to run the lecture notes on your computer,
you can download the folder called `notebooks` from the student repo.

The Python cells can be run as is,
but you need to copy the R cells
to a new R notebook to run them.
The simplest way is manually copy the cells you are interested in trying out,
but if you want to extract all the R cells at once
you could try the `nbconvert` command line tool.
This is what it would look like to create a separate R-notebook for the first lecture
(this part is totally optional and might not work on all OSes):

```sh
jupyter nbconvert --to notebook --output=lec1-r.ipynb 1-intro-viz-altair-ggplot.ipynb \
    --ClearMetadataPreprocessor.enabled=True \
    --ClearMetadataPreprocessor.clear_notebook_metadata=True \
    --RegexRemovePreprocessor.enabled=True \
    --RegexRemovePreprocessor.patterns="(?\!%%R.*)" \
    && sed -i 's/"%%R.*\\n",//' lec1-r.ipynb
```

Alternatively you could also try installing [rpy2](https://github.com/rpy2/rpy2)
and run R and Python in the same notebook,
but in the past there have been some occasional issues with this package
so we generally don't recommend this unless you are OK potentially spending some extra time on troubleshooting.
This is an optional step and you don't need to install rpy2 for anything mandatory in 531.

## Course learning outcomes

In this course students will learn how to

1. Use a grammar of graphics to create data visualizations.
2. Use ggplot and Altair to generate data visualizations.
3. Perform exploratory data analysis on a dataset.
4. Select the data visualization most appropriate for the data-type and the communication goal.
5. Interpret data visualizations to answer questions and formulate follow-up questions.

Detailed learning outcomes are available in the lecture notes.

## Assessments

- For each lab, you will have two submissions:
  one notebook with your Python code and one notebook with your R code.
- In 531,
  the worksheet style questions are part of each lab notebook.
  This means that the first few questions in each lab
  will have all their tests visible for you.
  The reason for this
  is to reduce the number of separate documents and submissions
  that you have to keep track of.
- The weight for the assessments can be seen below;
  due dates can be found on Gradescope.

| Assessment    | Weight |
|---------------|--------|
| Lab 1         | 12.5%  |
| Lab 2         | 12.5%  |
| Quiz 1        | 25%    |
| Lab 3         | 12.5%  |
| Lab 4         | 12.5%  |
| Quiz 2        | 25%    |

## Lecture topics

See the [MDS Calendar](https://ubc-mds.github.io/calendar/) for lectures times.
Each week will focus on a separate theme.

| Lecture | Topic                                                      |
|---------|------------------------------------------------------------|
| 1       | Intro to data visualization and graphical grammars         |
| 2       | Effective use of visual channels                           |
| 3       | Visualizing data distributions                             |
| 4       | Exploratory data analysis                                  |
| 5       | Visualization for communication                            |
| 6       | Color theory and application                               |
| 7       | Uncertainty, layouts, and interactivity                    |
| 8       | Figure formats, paired comparisons, and more interactivity |

## Teaching team

See the [MDS Calendar](https://ubc-mds.github.io/calendar/) for office hours.

| Role            | Name                  | Slack                    | Email                 |
| --------------- | --------------------- | ------------------------ | --------------------- |
| Instructor Sec1 | Payman Nickchi        | `@Payman Nickchi`        | payman.nickchi@ubc.ca |
| Instructor Sec2 | Andy Tai              | `@Andy`                  | andy.tai@stat.ubc.ca  |
| TA Sec1         | Jenny Zhang           | `@Jenny Zhang`           |                       |
| TA Sec1         | Nima Hashemi          | `@Nima`                  |                       |
| TA Sec1         | Kate Manskaia         | `Kate Manskaia - TA`     |                       |
| TA Sec1         | Skylar Fang (TA)      | `@Skylar Fang (TA)`      |                       |
| TA Sec2         | Ali Balapour          | `Ali Balapour (TA)`      |                       |
| TA Sec2         | Inder Khera           | `Inder Khera`            |                       |
| TA Sec2         | Parsa Seyfourian      | `Parsa Seyfourian (TA)`  |                       |
| TA Sec2         | Tony Liang            | `Tony Liang (TA)`        |                       |

## Policies

Please see the general [MDS policies](https://ubc-mds.github.io/policies/).

## COVID-19 safety

Read the [UBC COVID-19 Campus Rules](https://srs.ubc.ca/health-safety/safety-programs/communicable-disease-prevention-framework/covid-19/) for the latest updates of what is expected of you in terms of COVID-safety.

## Annotated resources

Specific and required readings will be listed in the lecture notes.
The resources below are optional if you wish to learn more about visualization.

### General data visualization

1. [Fundamentals of Data Visualization](https://clauswilke.com/dataviz/index.html)
    - General principles of visualization independent of programming language.

1. [Visualization analysis and design](https://ubc.summon.serialssolutions.com/search?spellcheck=true&s.q=tamara+munzer#!/search?ho=t&l=en&q=visualization%20analysis%20and%20design)
   - More detailed resource, can be downloaded through the UBC online library

### Data visualization in R (ggplot2)

1. [ggplot2 book](https://ggplot2-book.org)
   - Comprehensive resource for learning about `ggplot2` by its main author.

1. [R for Data Science (r4ds)](http://r4ds.had.co.nz/)
   - Overall good book on using R for data science, including visualization.

1. [ggplot2 cheat sheet](https://github.com/rstudio/cheatsheets/blob/master/data-visualization-2.1.pdf)
   - Great for quick reference.

1. [ggplot examples from Fundamentals of Data Visualization](https://wilkelab.org/practicalgg/index.html)

### Data visualization in Python (Altair)

1. [Altair Example Gallery](https://altair-viz.github.io/gallery/index.html)
    - The user guide for the `Altair` library.

1. [UW CSE512 - Data Visualization curriculum](https://github.com/uwdata/visualization-curriculum/blob/master/LICENSE)
    - Parts of our curriculum are based of this course.
    - Available under the open BSD-3 license. Copyright (c) 2019, University of Washington. All rights reserved.

1. [Altair Tutorials](https://github.com/altair-viz/altair_notebooks)
    - Several annotated Altair examples.

### Collection of additional references

1. [R Graphics Cookbook](http://www.cookbook-r.com/Graphs/)

1. [STAT 545.com](http://stat545.com/graph00_index.html) by Jenny Bryan.
