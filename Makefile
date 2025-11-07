.PHONY: all

all: build site

convert_to_jb_format: labs/**/autograder/lab*.ipynb
	echo
	cp 2020-21/*pdf _build/html/2020-21/
	cp 2021-22/*pdf _build/html/2021-22/

# instead of changing the kernel names of each notebook manually, you can edit the jupyterbook utils file to specify the kernel name (e.g. ~/miniconda3/envs/jb_conda_env/lib/python3.9/site-packages/jupyter_cache/executors/utils.py). You need to add kernel_name='python3' as an input parameter to the executenb function at the end of this file. Details in https://github.com/executablebooks/jupyter-book/issues/1348#issuecomment-926729414
#
# Before running build, I manually swap the headings to ones that are compatible with jupyter book via
# cp lab4_r.ipynb lab4_r2.ipynb && sed -e "s/<div.*>/\`\`\`{admonition} Q/" -e "s/<\/div>/\`\`\`/" lab4_r2.ipynb -i
build:
	mkdir -p _build/html/lectures
	cp lectures/slides-lec?.pdf _build/html/lectures/
	jupyter-book build .

site:
	ghp-import -n -p -f ./_build/html -r git@github.ubc.ca:MDS-2025-26/DSCI_531_viz-1_students.git

preview:
	open _build/html/index.html

clean:
	jupyter-book clean -a .
