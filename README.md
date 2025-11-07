# DSCI 531: Data Visualization I

This repo contains all the files used to build a jupyter book website with the course material for the students.
The student readme/intro is in the file `intro.md`,
which is the landing page of the student website.
Since UBC enterprise does not support GitHub actions,
the book needs to be built locally with the command

```
jupyter book build .
```

Then the output of that command needs to be uploaded to the gh-pages branch of the student repo
which can be done by installing ghp-import (`pip install ghp-import`) and then running:

```
ghp-import -n -p -f ./_build/html -r git@github.ubc.ca:mds-2023-24/DSCI_531_viz-1_students.git
```

The `-r` flag allows us to upload the course book to the student repo instead of the instructor repo.
This is great because students can use the download button
in the top right corner of the build book to download the notebooks,
which they can't if the home of the built version of the book is the instructor repo
since they don't have access to it.

Having the lecture notebooks in md format (myst markdown to be specific)
makes version control a easier,
but requires a longer build time since longer since they need to be re-executed each time.
If a shorter build time is preferred, ipynb files can be used sine these store the output
and the execution of the files can be turned of in the `.config.yml` file.
