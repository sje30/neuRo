# An introduction to R for neuroscientists

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/sje30/neuRo/master?urlpath=rstudio)


I plan to give a one-hour, rough and ready, introduction to R for
Neuroscientists over Zoom.  R is very popular programming language
within some discplines (e.g. computational biology).  It is however
little used within Neuroscience compared to other tools such as
Matlab or Python.  In some ways, it should not matter what you use,
and my advice is to use what you are comfortable with and what gets
the job done most efficiently.

With that in mind, I will introduce R through some examples geared
towards Neuroscientists.  I provide a rough one hour outline below, open
to change as I prepare the materials.

I'm looking for up to ten volunteers to try out the material, and then
we can run it again if it is helpful (or quietly forget it if not...)

# Outline

## Preliminaries.

Install [R](https://www.stats.bris.ac.uk/R/) and [Rstudio
desktop](https://rstudio.com/products/rstudio/download/#download).
Brief introduction to why they are useful.  The session will work best
if you can install these two programs before the session so you can
follow along.  Introduction to
[CRAN](https://cran.r-project.org/mirrors.html) (Comprehensive R
Archive Network).

Grab the folder of materials from
[master.zip](https://github.com/sje30/neuRo/archive/master.zip) and
unpack it to find a folder called "neuRo-master".  We will be working
in there.


If you are stuck, you can get to work "in-the-cloud" via the "launch
binder" link at the top of this page; nothing will be installed on
your computer.

## Acknowledgements

Thanks to Dr Dervila Glynn and Ms Arielle Bennett-Lovell (Cambridge
Neuroscience).  Data for imaging experiments kindly provided by
Professor Evelyne Sernagor (University of Newcastle).


## Case study one: changes in firing rate in response to antagonists.

You have some recordings of neural activity in response to control and
drug conditions.  Did your drug cause a significant change in firing
rate?  Rather than rushing to perform a t-test, we will examine a
modern computational approach, that is much more intuitive, to
assessing the significance of firing rates.

For more details, see the [firingrates](firingrates/README.md) folder.

## Case study two: analysis of calcium imaging data.

You have some calcium imaging data reporting the simultaneous activity
levels of a group of neurons, stored in a spreadsheet.  We will load
the data in and interrogate the data to discover properties about the
neurons, writing some simple functions.

For more details, see the [imaging](imaging/README.md) folder.

## Case study three: modelling action potentials.

(Only if there is plenty of time, probably not).  We will examine how
a modern simplification (the Izhikevich model) to the traditional
Hodgkin-Huxley system.

For more details, see the [model](model/README.md) folder.
## Next steps

### Where to go next to learn more about R

I have some [lecture notes](https://github.com/sje30/rpc2018) (that
may be recorded over coming months).  Bioinformatics core facility in
Downing Site often runs R courses.

Many good online resources (e.g. books) including [R for Data
Science](https://r4ds.had.co.nz/).

CUP have a nice short book (although not biological enough) 
[Braun and Murdoch](https://www.cambridge.org/core/books/first-course-in-statistical-programming-with-r/C9F088122AB40517B07FA77F2F0FDE2F).






	


