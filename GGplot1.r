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














