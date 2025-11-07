# FAQ
## Lecture 1 - Intro to viz, ggplot, and Altair

1. > How is matplotlib more low level than pandas?

    This categorization is specifically referring to how we use the syntax of each when making  a plot. With pandas we describe what we want to compare in our data, whereas with matplotlib we need to speak more in the context of the details of how to construct the plot. So one focuses on the data, and the other on the plot construction.

2. > Could you tell a bit more about Patchworks/cowplot and why there isn’T a parallel in the Python viz world?

    The same functionality is built-into most Python visualization libraries, so there is no need for a separate package. We will see some examples later in the course.

3. > Why are we not use altair in both languages?

    While altair has some nice features such as interactivity and is available in both Python and R, ggplot is the most established grammar of graphics library across both languages. This means that ggplot has some plots things that altair does not, 

4. > Can we change the colour scheme as well?

    Yes, the default ones are already well chosen but we will get into details of this later.

1. > Could you pls elaborate how R is running using the python kernel?

    You don't need to know this for a quiz, but essentially an R kernel is spun up in the background by rpy2 and all the code written into cells starting with `%%R` is sent to the R kernel, and then the output is sent back to Python and the notebook.

1. What’s the difference btw defining size in aes and defining size in geom_point? 

    `aes` maps a column in a data to a suitable range of sizes so points will be of different size. Setting it in `geom_point` sets all the points to the same size.

1. > Is aes() a function? We can access it globally?

    Yes, it is from `ggplot`. You can use it inside a geom as well, but we will focus on using it inside the `ggplot()` call.

1. > do some of the parameters (like shape) only work well with categorical variables 

    Yes, it does not make sense to encode a numerical columns as the shape aesthetic, because there is no inherent order between shapes. Is circles bigger or smaller than star for example? They are just different, not ordered.

1. > Should we read the book you've mentioned? Is the key text Fundamentals of Data Viz as opposed to Viz Analysis and Design? 

    I will explicitly mention any mandatory reading material in the lecture notes. You should read the lecture notes and this material. There will also be optional reference links as well as general resource in the readme which you can read if you want.

1. > when plotting mean summary statistic in ggplot, it looks like the wrangling/transformation part is done in geom, whereas in altair, the wrangling is done as part of esthetic encoding.

    Correct, this is a slight difference in the grammar the two langauge use. Altair says "plot the mean value of column X and represent it with a point" whereas ggplot says "plot column X and represent it with a point of the mean value".

1. > Usually how do we decide which kind of plot should we use? 

    We will talk about this when we discuss exploratory exploration in week 2.

1. > can you please break down the arguments for geom_line like what does stat do? 

    `stat` gives you the option to represent a summary statistics instead of the raw value of the points (called the `identity` in ggplot). It is like the functions `'mean'` etc in altair. There is a brief explanation and good link in the lecture notes.

1. > Any benefit of using geom_line() vs stat_summary() or are they just doing the same thing via different syntax?

    The same, I think using the `geom_` syntax is more consistent and have updated the lecture notes to reflect that.

1. > How can we keep track on what we should quote? i.e.: Python - 'mean(Miles_per_Gallon)' R - 'line' and 'summary'

    In general, you need to quote column names in Python but not in R. You often need to quote and argument, such 'summary' or 'mean', but some parameters accept a function directly without quotes, so it depends on the function you are calling.

1. > Are the lectures demos in the student repo? 

    Yes, all code is in the lecture notes.

## Lecture 2 - Visual encodings and plot config



1. > For the color scale change example, why was there a change in the correct analysis? Not sure why the second color scale was better. 

    The rainbow color scale is noisy and lacks a clear progression (blu cyan green yellow red purple). The default ones in Altair and Python have continuous mappings. The one in the image also highlighted trouble areas in red instead of darkblue as the old colorscheme and without any other colors that stand out (black grey white). We will talk more about this later, this is a good resource https://mycarta.wordpress.com/2012/10/06/the-rainbow-is-deadlong-live-the-rainbow-part-3/ and so is this https://clauswilke.com/dataviz/color-basics.html.

1. > Are colour scales constant across cultures? 

    If you want to delve into this, you can read [this wiki article about linguistic relativity and color naming across culture](https://en.wikipedia.org/wiki/Linguistic_relativity_and_the_color_naming_debate). If you don't have time for that I can summarize at least the linguistic relativity part by saying that it is debated =) From what I recall (without rereading again so correct me if I'm wrong) the strong version of the linguigstic relativity hypothesis (that the differential availability of words in languages directly impacts how people of different nationalities think) is largely disproven, but there might still be an influential factor rather than a directly determining one. I am not an expert on this, the move "Arrival" contextualizes this hypothesis with aliens.

1. > I always hear bad things about 3D charts. Is there ever a reason to use a 3D chart over 2D? 

    Yes, there can be. The biggest issues with using 3D is when it is usd unnecessarily (like a 3D bar or pie chart), as the only way to compare position (like a 3D scatter plot), and when they are represented on a 2D medium like a paper where they can't be rotated. Sometimes 3D can be useful, like a topographical map or a protein folding visualization. But be cautious, we saw today that even in naturally 3D systems like blood vessels it is still mentally more complex when they are 3D. Claus Wilke's has a good chapter on this https://clauswilke.com/dataviz/no-3d.html that I will add to the lecture notes also.

    There is also some very interesting work done with the Rayshader library that maps 3D in an intuitive way and incorporates reasonable rotation of the objects. I will paste two GIFs here and you can read more at https://www.tylermw.com/3d-ggplots-with-rayshader/ (I don't know of research on this, but he makes valid points in his discussion at the end, and the viz look really neat). Especially in the space time plot, I do think the third dimension adds value.


![output](https://media.github.ubc.ca/user/1751/files/9e1aba80-0fd3-11eb-8d50-4af498eb7886)

---

![output2](https://media.github.ubc.ca/user/1751/files/da4e1b00-0fd3-11eb-940d-0b06a28a0186)

1. > why 2d is better than 3d?

    2D does not suffer from the problems mentioned above and are often less demanding cognitively,
    so more acessible to non-experts.

1. > So area chart is less effective than line when we want to illustrate the difference? 

    Yes, it is easier to compare lines since they all have the same baseline. Comparing and area on the top of the area chart versus the bottom can be particularly hard since they are far from each other.

1. > So area chart is less effective than line when we want to illustrate the difference? 

    Yes, the area is good when you want to show the total and the difference. The line is better for difference only.

1. > how do we reorder the area chart in altair?

    You can sort in ascending/descending order via the `order` parameter as in this example https://altair-viz.github.io/gallery/stacked_bar_chart_sorted_segments.html. For a custom categorical order, it is currently not possible (https://github.com/vega/vega-lite/issues/1734). The workaround is to create an additional column mapping the categories to numbers in the order you want, and then sort by that column (you can use `.map` in pandas with a dictionary for this).

1. > I see that R and Python have powerful visualization capabilities, I wonder what's the added value of the other visualization tools such as Tableau, Power BI, and Spotfire? 

    Many of these graphical dashboard solution can be quick to pick up for people not used to programming and also offer nice interfaces for interactive exploration of data, at least for simpler relationships. However, they don't have the same flexibility, automation possibilities, scalability and reproducibility qualities as when pro-grammatically generating plots. These pros and cons are similar across other programs also, like using excel vs pandas/dplyr.

    Depending on which type of job you are getting, it is possible that you might end up using a dashboard software like this, but it is probably more likely that you end up building custom visualizations and dashboards for you team using the tools we cover to look at exactly what you want instead of a less customizable interface. There is course related to MDS that offers [an introduction to Tableau for those interested](https://hfboyce.github.io/tableau_course/intro.html). There are also [new software such as Mode](https://youtu.be/jEfLC1w_oww) that offers a combination of notebooks and dashboarding in the same interface.

1. > If we want to change dates in python from [1918-01-01] to [1918], do we change the date to period? 

    You can do `df['col'].dt.year` to extract year from a date.

1. > Can you elaborate on the geom_* arguments? For example, what other options exist for stat = ‘blank’ and why we need to have this. 

    The default for `stat` is `'identity'` which means to have one mark per data point. For example one circle for each row in that column. If you want to create a summary or a count instead, you need to change `stat` similarly to how you add `'mean()'` in altair. So you say that you want a summary statistick and then which function you want to summarise by, more here https://stackoverflow.com/questions/38775661/what-is-the-difference-between-geoms-and-stats-in-ggplot2/44226841#44226841

1. > How it knows to sum on y axis not on x axis?

    In this case there is only one relevant axis to sum on (only one numerical one). See the link in the next question to read more exactly about how sum works.

1. > Can we use custom functions in the fun argument? If yes, how should those functions behave (return types, args)?

    Yes, it can be anything that behaves similarly to mean, sum, std etc, so returns one value. If you use `fun.data` it can even return multiple values, e.g. the default is `mean_se` which returns mean and standard error, more here https://ggplot2.tidyverse.org/reference/stat_summary.html

1. > How can we change value on y axis to supress scientific notation and show the full numbers instaed?

    You can use the tidyverse scales library https://scales.r-lib.org/ which allows you to do `scale_x_log10(labels = comma)`

1. So what did alt.X do on its own? Nothing? 

    Yup. `x = 'col'` is a shortcut for `alt.X('col')` so they do the same thing.

1. > Which method of searching for 2018 would be better in terms of big-O notation? 🧐 

    For a df > 200,000 rows, query is a bit faster, otherwise the Python versus is a bit faster. No big differences. https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html#performance-of-query

1. > why do we need the '' quotation marks around the `count()` function? 

    In Altair, you quote the function you use and then altair evaluates the entire string with function and column name (similar to how pandas query evaluates a string expression). The function are javascript functions so they are run in javascript rather than in Python, which is part of the reason you quote them.

1. > can we use any JavaScript function within quotation marks or we are limited to some set of available functions? 

    Technically is anything that vega-lite supports https://vega.github.io/vega-lite/docs/, which I believe is most common javascript function, but I could not find a complete reference.

1. > I’m just reading up the documentation, and it turns out add_count() can do the group_by implicitly, so instead of 2 separate lines, we could’ve written it as add_count(region). Let me know if there’s any flaw in my understanding here. Thanks.

    You are correct! I am used to doing the group by explicitly so I guess I got stuck in that, thanks for improving the lecture notes!

1. > so `add_count()` automatically added a count column with default col_name n right? 

    Correct.

1. > What does columns = 3 in facet do? Seems like there are many more columns than 3..

    It refers to the number of columns in the grid of subplots that is created, not the columns in the data frame.

1. > Can we add the interactiveness to R plots as we did with Altair?

    Yes, but it is not built into ggplot. You need to instal `plotly` for R and then use the `ggplotly` function. We will talk about this mostly in the next viz course, but you can see and example here https://plotly.com/ggplot2/geom_bar/.

1. > why don't we just use geom_histogram in R ?

    geom_histogram is a shorctut for geom_bar(stat = 'bin'), so the output will be exactly the same. Using geom_histogram is a bit more common,  but please remember that there is nothing magical with this function. It is just geom_bar with a different default argument to stat.

1. > can we add gaps between bars in ggplot just like in Altair?

    This is a philosophical question, is it a gap between bars or a line on top of the bars? Luckily, it doesn't matter for our perception, and we can add lines by setting the `color` argument of the geom itself. I have updated the lecture notes to use this so you can see examples there.

1. > Can we add multiple col name values in the tooltip?

1. > quick question on python formatting.. should we have space between for example x=2?  should it be x = 2? 

    ```
    fun(Python='this')
    fun(R = 'this')
    ```

1. > is alt.Size('pop_density') the same as size = "pop_density"? 

    Correct.

1. > and why do we use scale = alt.Scale() instead of just alt.Scale()? What would be a good rule of thumb when to add sth = alt.Sth? 

    They are equivalent. The only reason I use scale = alt.Scale() is that it is not possible to mix them IF you have a positional argument after a keywoard argument. This has nothing o do with altair but is the case for all python functions. 
    Since that might get confusing, I kept it as `scale = alt.Scale`.
    As an example, I cannot write `fun(x=5, 3)`, but I can write `fun(5, y=3)`. If you're comfortable with this, you can use either.

## Lecture 3 - Visualization concepts and EDA

1. > for the density graph, you said it will centre a bin on top of each point and then if two bins overlap they will sum up. Do we specify the width then of these bins or is there a standard for that?

    TLDR: You can, but the default width is good.

    Which is the optimal width for a kernel estimate is often estimated based on the amount of data. Exactly how to estimate it is a decades long discussion with many ideas (e.g. [here is an 111 pages long doctoral thesis on the topic](https://d-nb.info/104355470X/34)). I recommend reading [the documentation on KDEs in SciPy](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.gaussian_kde.html) for an overview of the common rule's of thumb that are usually used. Jake VanderPlas (core developer of Altair, Scikit-learn and SciPy, yup pretty astonishing...) has [a nice write-up on estimating the bandwidth via cross-validation](https://jakevdp.github.io/PythonDataScienceHandbook/05.13-kernel-density-estimation.html#Selecting-the-bandwidth-via-cross-validation) (you will learn about cross-validations in other similar contexts in MDS).

1. > is it possible for box plot to show outliers and maybe violin plot cannot?

    Technically, violin plots can. You could stop the violin before the outliers and the plot them separately, or just plot them on top of the violin.

1. > it's there good use case rule when to plot the violin graphs vertically or horizontally? I wonder if it has something to do with the number of values in the x variables? 

    The rule is that you want the labels to be easy to read, so for all plots with long categorical labels, it is usually easier if they are on the y-axis. When density traces / KDEs are plotted, they are usually horizontal and overlapping with each other so that you can fit more of them. It is especially useful when you have gradually changes values between categories like in temperature over the months:

    ![image](https://media.github.ubc.ca/user/1751/files/b442b680-1304-11eb-929a-f21c2eabe5f0)

1. > In what situation(s) will we prefer box plot over violin, only when we need the plot to show 5 values? Why are we focusing on making only boxplots in Altair and not the violin one? 

    Generally violin plots are preferable, so when using a box, it can be a good idea to plot the values on top as dots. However, if you have lots of categorical variables and you want to make one box/violin for each, boxes can be easier to interpret when they are really small, because the shape of the violing can be hard to see when small.

    With altair, there is a special case where violin and density plots right now don't work well with several categorical values on one axis, which is why we are using boxes there for the time being. This is a feature that the altair team is looking to implement.

1. > Also are we going to also be making boxplots in ggplot as well? 

    Use `geom_boxplot`.

1. > What’s the advantage of having a mirrored density plot as opposed to just the density plot?

    I personally don't experience any direct advantage, but in [the 1998 paper where violin plots were introduced](https://www.tandfonline.com/doi/epdf/10.1080/00031305.1998.10480559?needAccess=true), the authors explicitly designed it as a density trace + a small boxplot. Although violinplots nowadays don't always include the middle box plot, it might have been part of the decision to make the density trace symmetrical (maybe also because all their plots are of vertical violins):

    ![image](https://media.github.ubc.ca/user/1751/files/dd177b80-1305-11eb-802b-a6ff0ba54825)

    The authors also claim it is easier to perceive density differences with symmetrical curves but I don't know of a study that has tested this:

    > The density trace is plotted symmetrically to the left and the right of the (vertical) box plot. There is no difference in these density traces other than the direction in which they extend. Adding two density traces gives a symmetric plot which makes it easier to see the magnitude of the density. This hybrid of the density trace and the box plot allows quick and insightful comparison of several distributions.

## Lecture 4 - Exploratory data analysis and distribution plots

1. > when different color bars are stacked on top of each other - how do we interpret it? 

    You need to compare the length of the bars, which is tricky and this is not a great visualisation choice. It is better if you can stack them on the same baseline.

1. > Is it possible to do explode on a list of columns like .explode([‘country’, ‘’genres])?

    No, just one at a time.

1. > Don’t you need to add .interactive() to be able to mouse over points in altair? 

    In general yes, but boxplots add it by default.

1. > Why do the function calls in Altair documentation repeat "undefined" for each argument?

    I think it is the javascript default for "None" as it would be called in python. Some of altairs API documentation is autmatically generated from the vegalite javascript code.

1. > Is the "bw" argument in ggplot comparable to "step" in altair in terms of the graph style? 

    No, `bw` is how wide each gaussian kernel is, whereas `step` refers to the resolution used to create the kernel grid. There is more info in the KDE links from last Q&A.

1. > Are there any good cheat sheets for altair/ ggplot?

    [ggplot is here](https://rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf). For Altair, I am happy to create one with you and try to contribute it to the Altair docs. There are templates we can use similar to the ggplot one (maybe just the first page), so far two students are interested and I am thinking 2-4 would be a good number. Let me know and I will reach out, let's try to this at a time it does not affect your studying (it will probably take more time than you think designing things).

1. > Why is the number of bins I get not exactly the one i specify with `maxbins` in Altair histograms?

    TLDR: `maxbins` gives you a rough indication which is good enough, but if you want it to be exact you can use `step` instead (similar to `binwidth` in ggplot).

    This is a good observation and something that I have been meaning of looking into. I went on a treasure hunt right now to find the answer and my understanding is that this stems from an implementation detail all the way down in D3 (remember altair is the python implementation of vegalite, which is a javascript library that sits on top of vega which in turn sits on top of D3 which is the most used visualization library on the web).

    I believe that the answer is what you can find in this observable notebook (similar to Jupyter notebooks, but for Javascript) where it says:

    > The result is not guaranteed to yield the exact number of buckets we asked for. That number is only an indication, passed to the threshold generator. As you change that value with the slider, you might notice the reason why this happens: the domain gets sliced at “nicely-rounded” values — using d3.ticks — and these rounded values do not fall exactly on the bin’s domain.

    If you open up that notebook you can play around with the slider and see how the bins change.

1. > When we explode twice in a chain, aren't we overcounting? Because we get the Cartesian product of genres and studios

    It depends on the question. You need to explode all the categories that you will spread your data over in the visualization/observation counting (by coloring, faceting, etc). For example, consider the situation where you are in charge of creating the multiverse and you have compiled your proposed universes into the following table for presentation in front of the bureau of multiverse instantiation.

    ```python
    large_explosions = pd.DataFrame({
        'multiverse': ['A', 'Beta'],
        'laws': [['gravity', 'time'], 'gravity'],
        'planets': [['Neptune', 'Venus'], ['Poseidon', 'Aphrodite']]})
    print(large_explosions.to_markdown())
    ```
    ```
    |    | multiverse   | laws                | planets                   |
    |---:|:-------------|:--------------------|:--------------------------|
    |  0 | A            | ['gravity', 'time'] | ['Neptune', 'Venus']      |
    |  1 | Beta         | gravity             | ['Poseidon', 'Aphrodite'] |
    ```

    If the bureau asks you to present the number of planned universes that will include gravity, you would only need to explode a single column, and count the occurrences of `'gravity'`:
 
    ```
    large_explosions.explode('laws')
    ```

    ```
    |    | universe     | laws    | planets                   |
    |---:|:-------------|:--------|:--------------------------|
    |  0 | A            | gravity | ['Neptune', 'Venus']      |
    |  0 | A            | time    | ['Neptune', 'Venus']      |
    |  1 | Beta         | gravity | ['Poseidon', 'Aphrodite'] |
    ```

    However, if you were asked to instead demonstrate how many *planets* would be equipped with gravitational field, then you would need to explode both columns before counting the occurrences of `'gravity'`:

    ```
    large_explosions.explode('laws').explode('planets')
    ```

    ```
    |    | universe     | laws    | planets   |
    |---:|:-------------|:--------|:----------|
    |  0 | A            | gravity | Neptune   |
    |  0 | A            | gravity | Venus     |
    |  0 | A            | time    | Neptune   |
    |  0 | A            | time    | Venus     |
    |  1 | Beta         | gravity | Poseidon  |
    |  1 | Beta         | gravity | Aphrodite |
    ```

## Lecture 5 - Visualization for communication

1. > The link in Q3 of the lab is not working

    It is missing an `l` in the end: `htm` -> `html`.

1. > For the color of our 2d histograms, can we set the count limit to something below the maximum we observed? Extreme max outliers drown out the color of the rest of our heatmap 

    Yes you can set the color limit the same as for other continuous scales (`alt.Color(domain=(0, 10))` or `scale_color_continuous(limits = c(0, 10))`). Added similar material in the lecture notes.

3. > What is the difference between a heatmap and a 2d histogram?

    A 2D histogram is a heatmap where the color is mapped to the count of observations in each bin.

1. > Could you quickly elaborate on why we need to put `bin=alt.Bin( )` arguments in both `alt.X( )` and `alt.Y( )`, but not with ggplot? 

    `geom_bin2d` does the binning automatically, just like `geom_histogram()`.

1. > How do you reverse the colour of hexagons  Where lighter is lower counts and darker is higher counts (for ggplot)

    The same as for a continuous axis scale. Added detailed example to the lecture notes.

1. > How does the expand parameter for ggplot's continuous scales work exactly?

    I updated to use `expansion()` inside expand which sets the left and right side padding as a proporiton of the axis range, added details in the lecture notes. [This SO thread has some more examples to understand this](https://stackoverflow.com/questions/44170871/how-does-ggplot-scale-continuous-expand-argument-work).

1. > With altair, is there ever a case where we put scale = to something other than alt.Scale(). I find it strange in general with altair that we need to specify a keyword bin for example and then another key word alt.Bin() 

    Nope, it is redundant. [There is a proposal to add this sytax, which would be very neat:](https://github.com/altair-viz/altair/pull/1629)

    ```python
    alt.Chart(data).mark_point().encode(
        alt.X('column:Q').axis(None).scale(zero=False).title('my title'),
        alt.Color('color:N').legend(orient='bottom').scale(scheme='viridis'))
    ```

1. > How could we get rid of the decimal in the y-axis in Altair? Having it $19k instead of $19.0k 

    Prefix with `~`, added example in the notes.

1. > Is there a guideline for what to put in axis label vs how to format the numbers. For example: labeling the axis with ($) rather than putting a $ in front of every number 

    It depends on how busy the figure is. With lots of axis ticks it might be too much to have `$` on everyone. But no hard rule.

1. > Is there a way to put one single title for the repeats? When I tried to add in labs, I did not have time to explore, the usual way adds to all subtitles . 

    Add `title='Your title'` inside `.repeat()`

1. > In ggplot, what is the difference between “+ggtitle(“xxxxx”)” and “+labs(title=“xxxxx”)”? Or are they the same for creating titles? 

    Same thing, different names.

1. > what does `ticks` refer to in `theme(axis.ticks.x=element_blank( ))`?

    The step on each axis, often as a small bar perpendicular to the axis itself.

1. > Is there a way to change the default alt.Color color similar to alt.themes.enable()?

    Only via creating a custom theme and setting that as the default theme. I will try to cover this, probably last week.

1. > For axis value, how do we set value interval? e.g.(5k: 0, 5k, 10k, etc) instead of 1k interval.

    Added details in notes on how to control the number of ticks / the interval between them.

## Lecture 6 - Color theory and application

1. > For heat maps I’ve noticed that the highest value is usually the lightest colour, wouldn’t it make more sense to have it be the darkest colour (dark = highest concentration)?

    It often makes sense to have the highest value the most distinct from the background and/or NaN values, so if you have a white background I agree that making the highest values lighter often is a good idea. You can also make the lowest values the darkest if you want to highlight those instead, but I would be consistent if you are making multiple visualisations and not switch between plots if it can be avoided.

1. > When the points have some transparency to them, overlapping points look darker, giving the illusion of a different value. Is there a way to solve this?

    You could set the opacity to be lower (alpha to be higher), but this would introduce the issue of points hiding each other. When using color as a rough indicator of values (what we usually do) and/or using color schemes that transition in the hue a bit, this issue is less important.

1. > I find help documentation does not come up very much in R/Jupyter lab for graphing. For example, how would you go about finding out that alt.Scale is an argument for our encoding variables, and that alt.Scale can take arguments like range = … or scheme = … ?  What do you recommend we do to search?

    When you type `alt.X`, you should be able to view its docstring in the contextual help or via `Shift + Tab`. There you will see that `scale` is a parameter and that its type is of class "scale" which is referring to `alt.Scale`.

    Sometimes the help isn't detected correctly, but this has gotten much better in later IPython version I find. So if it does not show up, check that you have => version 7.15 of IPython, or use `?alt.X` in a new cell. The help in the pop up dialog can be a bit annoying to read because of the word wrap splitting the lines in an unfortunate way. I actually PRed this a few weeks ago and [you can see how the bigger pop up help dialog will look in JL 3.0 here.](https://github.com/jupyterlab/jupyterlab/pull/9134)

1. > So for x="year:0" is it 0 or o cus it is for ordinal variable?

    Yes. We could have changed the dtype in pandas to categorical, but here I am showing you how to do it with altair. I will talk more about this next week.

1. > Annotation is good for static charts but not for dynamic charts where data is from a database for example and varies, is there a way to make annotations also dynamic ?

    I think you would need both your graphical chart elements and text to update for streaming data, so this would be a problem with both or neither (the text annotation would not be the bottleneck). You could also use tooltips when hovering over the bars.

1. > Is there an order we need to follow, like write `geom_text` first then `geom_bar`?

    The order you write them in determines which ones shows up on top in the plot (sometimes called z-order, think of geoms and marks as layers put on top of each other).

1. > What if there are several legends (color,size,shape), and I only want to delete the color legend?

    In Altair, you can pass `legend=None` to a specific encoding to exclude just that one from the legend (will not work if the encodings are merged in the legend). For most geoms, there is a `show.legend` argument you can use to turn specific legends off if you have more than one (Thanks Raf!).

1. > This annotation syntax seems more complicated than Excel...

    :scream: :scream: :scream: I added an example in the the lecture notes with using `alt.Value` which is simpler than using the dataframe, but not quite as flexible (although should cover most situations where you only need to annotate a single value). Rafael also gave a tip to look at the extensions ggrepel and directlabel for ggplot.

1. > How about when you want to keep one grid line for example X axis  gridline and delete the other one, instead of major and minor?

    You can use for example `panel.grid.major.x` in ggplot. For altair you set it in the encoding for that relevant axis.


1. > What are the shortcuts you use for quickly deleting text and stuff like that? I would love to see a cheatsheet of your favourite jupyter lab editor shortcuts (and custom shortcuts)!

    For text editing I am using the [Jupyter Lab vim addon](https://github.com/axelfahy/jupyterlab-vim) (it will become part of core JL in 3.1). Vim is a wonderful place, but I would only visit if you have time to spare, since it is quite time consuming to learn. Essentially it is a grammar for editing text the same way altair/ggplot are grammars for creating graphics. If I want to Delete A Sentence, I type `das`. If I want to Change text Inside a parenthesis, I type `ci(`. I think you can be similarly fast with conventional bindings, but it is not as fun ;)

## Lecture 7 & 8 - Trendlines and figure composition

1. > Could you elaborate on when we would want to use moving average, loess, and linear/polynomial/etc regression? 

    - If it is important that the line has values that are easy to interpret, choose a rolling mean. These are also the most straightforward trendlines when communicating data to a general audience.
    - If you think a simple line equation (e.g. linear) describes your data well, this can be advantageous since you would know that your data follows a set pattern, and it is easy to predict how the data behaves outside the values you have collected (of course still with more uncertainty the further away from your data you predict).
    - If you are mainly interested in highlighting a trend in the current data, and the two situations described above are not of great importance for your figure, then a loess line could be sutiabe. It has the advantage that it describes trends in data very "naturally", meaning that it highlights patterns we would tend to highlight ourselves in qualitative assessment. It also less strict in its statistical assumption compared to e.g. a linear regression, so you don't have to worry about finding the correct equation for the line, and assessing whether your data truly follows that equation globally.

1. > How to interpret the ci of a regression line?

    It is the same principle as the CI of the mean and calculated for the coefficients rather than being bootstrapped. You don't need to details around this for 531, but if you are interested you can [read about it more here](https://www.econometrics-with-r.org/5.2-cifrc.html).

1. > Is it be better to use both color and e.g. line thickness or highlight a feature versus using one of the two.

    It depends on your application, but such double encoding can be helpful although it might seem redundant at first. For example, encoding the count of observations as both the color and the size of a circle in a dotplot can further enhance the differences between different counts. Encoding groups membership as both the color and shape of dots helps to distinguish them further and is friendlier for anyone with color vision deficiency.

