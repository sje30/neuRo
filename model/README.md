# The Izhikevich model

Remember the **mechanistic** [Hodgkin Huxley
model](https://en.wikipedia.org/wiki/Hodgkin%E2%80%93Huxley_model) in
all its glory with coupled differential equations?

Its great, but sometimes overkill if you don't want to model all the
detail of the Na and K channels.

A key simplification came from the **phenemonelogical** model by
[Izhikevich](https://www.izhikevich.org/publications/spikes.htm).

## Which is real, which is fake?

In the following picture, one column of data is real, one is from the
model; which is which?

![real or fake?](https://www.izhikevich.org/human_brain_simulation/rssimple.gif)
one column is real data, one is from the model.  Which is which?

![Model description](https://www.izhikevich.org/publications/izhik.gif)

This figure explains how the model is created (top left) and then
shows examples of how it can generate different types of action
potential depending upon the settings of just four parameters.
	


## The code

Run through the code in [izh.R](izh.R).
