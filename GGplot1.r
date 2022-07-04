###################### R visualization with GGplo2
require(ggplot2)
ggplot()
#---------------------- suavizando graficas -------------------
# Make the points 40% opaque
ggplot(diamonds, aes(carat, price, color = clarity)) +
  geom_point(alpha=0.4)+ #el aplha suaviza o engroza el color de una grafica.
  geom_smooth()

#---------------------caracteristicas de un grafico------------------------
#
# Esta parte ya es bien interesante porque yo puedo crear caracteristicas
# de un grafico despues de haberlo creado.

# aqui creo la grafica de base con dos variables X, Y
plt_price_vs_carat <- ggplot(diamonds, aes(X, Y))
#edito las caracterisitcas del grafico para agregar dentro del geom_point una
# una caracteristica de color = Z
plot_clarity<- plt_price_vs_carat + geom_point(aes(color=clarity))
#y guardo las nuevas caracteristicas en un nuevo objeto que despues puedo llamar

#--------------agregar caracteristicas a un grafico---------------------
#a continuacion creo un grafico con X, Y variables y despues lo guardo
# en un objeto nuevo, despues de eso al objeto le agrego las caracteristicas con
# + geom_point( y dentro todo lo que desee) en este caso puse adentro que queria
# que el size de esta figura fuera otra variable mas que se llama fcyl, pero yo
# puedo agregar cualquier variable al color, zise, shape, etc.

# Establish the base layer
plt_mpg_vs_wt <- ggplot(mtcars, aes(wt, mpg))
# Map fcyl to size
plt_mpg_vs_wt +
  geom_point(aes(size=fcyl))
# aqui hago el mismo cambio pero sobvre alpha
plt_mpg_vs_wt +
  geom_point(aes(alpha = fcyl))
# y aqui igual pero en shape
plt_mpg_vs_wt +
  geom_point(aes(shape = fcyl))
#Aqui hago lo mismo pero he cambiado la etiqueta geom_point por una de
#geom_text y he cambiado la etiqueta shape por label para introducir la
#variable Fcyl como una etiqueta dentro del grafico.
plt_mpg_vs_wt +
  geom_text(aes(label = fcyl))

#-------------------creo una grafica y color propio----------------
# A hexadecimal color
my_blue <- "#4ABEFF"
ggplot(mtcars, aes(wt, mpg))+
  #defino el color "my_blue" pero es muy importante no mezclar las
  #caracteristicas de los graficos... lo que va arriba es el grafico y abajo
  #todas las caracteristicas del mapeo del mismo
  geom_point(color=my_blue,alpha=0.6)

#---------------hay una diferencia entre el point y el mapeo-----------------
# A hexadecimal color
my_blue <- "#4ABEFF"
# aqui pongo el fill=fcyl (pero cae dentro del mapeo )
ggplot(mtcars, aes(wt, mpg, fill = fcyl)) +
  #y en los puntos de la grafica pongo otras caracteristicas.
  geom_point(color=my_blue,size=10, shape=1)

#no hay que confundirse porque n la parte del mapeo solo pueden ir variables
# porque ahi defino las caracteristicuas visuales de la grafica pero n los puntos
# puedo poner las caracteristicas de color y forma.
#
# aqui por ejemplo se puede ver claro el ejemplo... en esta grafica pongo como
# color la variable fcyl, pero abajo en el geom_text() defino el color que sera
# rojo para este grafico.
ggplot(mtcars, aes(wt, mpg, color = fcyl)) +
  # Add text layer with label rownames(mtcars) and color red
  geom_text(label=rownames(mtcars),color="red")
# 5 aesthetics: add a mapping of size to hp / wt
#este es muy interesante porque divido una de las caracteristicas que es size
# entre dos variables diferentes lo que hace que el grafico tome dos colores
ggplot(mtcars, aes(mpg, qsec, color = fcyl, shape = fam, size= hp/wt)) +
  geom_point()

#---------------------agregar etiquetas a las graficas---------------
ggplot(mtcars, aes(fcyl, fill = fam)) +
  geom_bar() +
  # Set the axis labels
  labs(x="Number of Cylinders",y="Count") #con la funcion labs creo etiquetas
#para cada eje que desee.

#agregando una posición en geom_point()----------------------------------
palette <- c(automatic = "#377EB8", manual = "#E41A1C")

# Set the position = dodge
ggplot(mtcars, aes(fcyl, fill = fam)) +
  geom_bar(position="dodge")+
  labs(x = "Number of Cylinders", y = "Count")
scale_fill_manual("Transmission", values = palette)

#----------------------------Setting a dummy aesthetic-------------------------
# In the last chapter you saw that all the visible aesthetics can serve as
# attributes and aesthetics, but I very conveniently left out x and y.
# That's because although you can make univariate plots (such as histograms,
# which you'll get to in the next chapter), a y-axis will always be provided,
# even if you didn't ask for it.
#
# You can make univariate plots in ggplot2, but you will need to add a fake y
# axis by mapping y to zero.
#
# When using setting y-axis limits, you can specify the limits as separate
# arguments, or as a single numeric vector. That is, ylim(lo, hi) or
# ylim(c(lo, hi)).

#entonces aquí creo una grafica normal en la que defino una sola variable y en
#y no hay sino un 0, por otra parte defino un límite de la variable Y
#para que no pase de las cordenadas -2 a 2.
ggplot(mtcars, aes(mpg, 0)) +
  geom_jitter() +
  # Set the y-axis limits
  ylim(-2,2)


#-----------------------Overplotting 4: Integer data------------------------
# Let's take a look at the last case of dealing with overplotting:
# Integer data
# This can be type integer (i.e. 1 ,2, 3…) or categorical (i.e. class factor)
# variables. factor is just a special class of type integer.
#
# You'll typically have a small, defined number of intersections between two
# variables, which is similar to case 3, but you may miss it if you don't
# realize that integer and factor data are the same as low precision data.
#
# The Vocab dataset provided contains the years of education and vocabulary
# test scores from respondents to US General Social Surveys from 1972-2004.

ggplot(Vocab, aes(education, vocabulary)) +
   # Set the shape to 1
   geom_jitter(alpha = 0.2, shape=1)

#--------------------------- HISTOGRAMS ---------------------------------------
#mtcars is preatty popular database.
# Plot mpg
ggplot(mtcars, aes(mpg)) +
   # Set the shape to 1
   geom_histogram(alpha = 0.2, shape=1)
#Changing configuration on the histogram
ggplot(mtcars, aes(mpg)) +
   # Set the binwidth to 1
   geom_histogram(binwidth = 1)
#usando ..density.. en la variable "Y" de un histograma puedo mostrar
#las densidades de frecuencias del histograma en la vairiable X
# Map y to ..density..
ggplot(mtcars, aes(mpg, ..density..)) +
   geom_histogram(binwidth = 1)
#Now they asked me to change the color for a new one wich has been already
#defined for them.
datacamp_light_blue <- "#51A8C9"

ggplot(mtcars, aes(mpg, ..density..)) +
   # Set the fill color to datacamp_light_blue
   geom_histogram(binwidth = 1, fill=datacamp_light_blue)

#---------------------- Positions in histograms -------------------------------
# Here, we'll examine the various ways of applying positions to histograms.
# geom_histogram(), a special case of geom_bar(), has a position argument
# that can take on the following values:
#
# stack (the default): Bars for different groups are stacked on top of each
# other.
# dodge: Bars for different groups are placed side by side.
# fill: Bars for different groups are shown as proportions.
# identity: Plot the values as they appear in the dataset.

# Update the aesthetics so the fill color is by fam
ggplot(mtcars, aes(mpg, fill = fam)) +
   geom_histogram(binwidth = 1)
# Update the histogram layer to position the bars side-by-side, that is,
# "dodge".
ggplot(mtcars, aes(mpg, fill = fam)) +
   # Change the position to dodge
   geom_histogram(binwidth = 1, position="dodge")
#Update the histogram layer so the bars' positions "fill" the y-axis.
ggplot(mtcars, aes(mpg, fill = fam)) +
   # Change the position to fill
   geom_histogram(binwidth = 1, position = "fill")
# Update the histogram layer so bars are top of each other, using the
# "identity" position. So each bar can be seen, set alpha to 0.4.
ggplot(mtcars, aes(mpg, fill = fam)) +
   # Change the position to identity, with transparency 0.4
   geom_histogram(binwidth = 1, position = "identity", alpha=0.4)

#--------------------------- BARPLOTS -----------------------------------------

# Position in bar and col plots
# Let's see how the position argument changes geom_bar().
#
# We have three position options:
#
# stack: The default
# dodge: Preferred
# fill: To show proportions
# While we will be using geom_bar() here, note that the function geom_col()
# is just geom_bar() where both the position and stat arguments are set to
# "identity". It is used when we want the heights of the bars to represent
# the exact values in the data.
#
# In this exercise, you'll draw the total count of cars having a given number
# of cylinders (fcyl), according to manual or automatic transmission type (fam).

#Using mtcars, plot fcyl, filled by fam.
#Add a bar layer using geom_bar().
# Plot fcyl, filled by fam
ggplot(mtcars, aes(fcyl, fill = fam)) +
   # Add a bar layer
   geom_bar(binwidth = 1, position = "identity", alpha=0.4)

# Set the bar position argument to "fill".
ggplot(mtcars, aes(fcyl, fill = fam)) +
   # Set the position to "fill"
   geom_bar(position = "dodge")

#--------------------------Overlapping bar plots-------------------------------

# You can customize bar plots further by adjusting the dodging so that your
# bars partially overlap each other. Instead of using position = "dodge",
# you're going to use position_dodge(), like you did with position_jitter()
# in the the previous exercises. Here, you'll save this as an object, posn_d,
# so that you can easily reuse it.

# Remember, the reason you want to use position_dodge() (and position_jitter())
# is to specify how much dodging (or jittering) you want.
#
# For this example, you'll use the mtcars dataset.

# Use the functional form of the bar position: replace "dodge" with a call
# to position_dodge().
# Set its width to 0.2.
ggplot(mtcars, aes(cyl, fill = fam)) +
   # Change position to use the functional form, with width 0.2
   geom_bar(position = position_dodge(width=0.2))
#Set the bar transparency level of the bars to 0.6.
ggplot(mtcars, aes(cyl, fill = fam)) +
   # Set the transparency to 0.6
   geom_bar(position = position_dodge(width = 0.2), alpha=0.6)

#----------------Bar plots: sequential color palette---------------------------

# In this bar plot, we'll fill each segment according to an ordinal variable.
# The best way to do that is with a sequential color palette.
#
# Here's an example of using a sequential color palette with the mtcars dataset:
#
#    ggplot(mtcars, aes(fcyl, fill = fam)) +
#    geom_bar() +
#    scale_fill_brewer(palette = "Set1")
# In the exercise, you'll use similar code on the the Vocab dataset.
# Both datasets are ordinal.

# Plot the Vocab dataset, mapping education onto x and vocabulary onto fill.
# Plot education, filled by vocabulary
ggplot(Vocab, aes(education, fill = vocabulary)) +
   # Add a bar layer with position "fill"
   geom_bar(position ="fill")
#Add a brewer fill scale, using the default palette (don't pass any arguments).
#Notice how this generates a warning message and an incomplete plot.
# Plot education, filled by vocabulary
ggplot(Vocab, aes(education, fill = vocabulary)) +
   # Add a bar layer with position "fill"
   geom_bar(position = "fill") +
   # Add a brewer fill scale with default palette
   #----> el resultado es bien interesante
   scale_fill_brewer()

#------------------------  Basic line plots  ---------------------------------

# Here, we'll use the economics dataset to make some line plots.
# The dataset contains a time series for unemployment and population
# statistics from the Federal Reserve Bank of St. Louis in the United States.
# The data is contained in the ggplot2 package.
#
# To begin with, you can look at how the median unemployment time and the
# unemployment rate (the number of unemployed people as a proportion of the
# population) change over time.
#
# Print the head of the economics dataset.
# Plot unemploy vs. date as a line plot.
# Print the head of economics
print(head(economics))
# Using economics, plot unemploy vs. date
ggplot(economics, aes(date, unemploy))+
   # Make it a line plot
   geom_line()
# Change the y-axis to the proportion of the population that is unemployed
ggplot(economics, aes(date, unemploy/pop)) +
   geom_line()

#-----------------------  Multiple time series -------------------------------
#
# We already saw how the form of your data affects how you can plot it.
# Let's explore that further with multiple time series. Here, it's important
# that all lines are on the same scale, and if possible, on the same plot.
#
# fish.species contains the global capture rates of seven salmon species
# from 1950–2010. Each variable (column) is a Salmon species and each
# observation (row) is one year. fish.tidy contains the same data, but in
# three columns: Species, Year, and Capture (i.e. one variable per column).
#
# Use str() in the console to examine the structure of both fish.species and
# fish.tidy.
# Plot the Rainbow Salmon time series
ggplot(fish.species, aes(x = Year, y = Rainbow)) +
   geom_line()

# Plot the Pink Salmon time series
ggplot(fish.species, aes(x = Year, y = Pink)) +
   geom_line()

# Plot multiple time-series by grouping by species
ggplot(fish.tidy, aes(Year, Capture)) +
   geom_line(aes(group = Species))

   # Plot multiple time-series by coloring by species
ggplot(fish.tidy, aes(Year, Capture, color = Species)) +
   geom_line(aes(group = Species))


#-----------------------------Moving the legend------------------------------------------
#
# Let's wrap up this course by making a publication-ready plot communicating a clear message.
#
# To change stylistic elements of a plot, call theme() and set plot properties to a new value.
# For example, the following changes the legend position.
#
# p + theme(legend.position = new_value)
# Here, the new value can be
#
# "top", "bottom", "left", or "right'": place it at that side of the plot.
# "none": don't draw it.
# c(x, y): c(0, 0) means the bottom-left and c(1, 1) means the top-right.
# Let's revisit the recession period line plot (assigned to plt_prop_unemployed_over_time).
#
# Update the plot to remove the legend.
# Look at the changes in the plot.
# View the default plot
plt_prop_unemployed_over_time

# Remove legend entirely
plt_prop_unemployed_over_time +
  theme(legend.position = "none")

























