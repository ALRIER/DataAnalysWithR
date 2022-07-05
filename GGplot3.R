#-------------------------------Effective explanatory plots----------------------------------------

#--------------------------Using geoms for explanatory plots
# Let's focus on producing beautiful and effective explanatory plots.
# In the next couple of exercises, you'll create a plot that is similar to the one
# shown in the video using gm2007, a filtered subset of the gapminder dataset.
#
# This type of plot will be in an info-viz style, meaning that it would be similar
# to something you'd see in a magazine or website for a mostly lay audience.
#
# A scatterplot of lifeExp by country, colored by lifeExp, with points of size 4, is provided.

# geom_segment() adds line segments and requires two additional aesthetics:
# xend and yend. To draw a horizontal line for each point, map 30 onto xend and country onto yend.
# Add a geom_segment() layer
ggplot(gm2007, aes(x = lifeExp, y = country, color = lifeExp)) +
   geom_point(size = 4) +
   geom_segment(aes(xend = 30, yend = country), size = 2)
# geom_text also needs an additional aesthetic: label. Map lifeExp onto label,
# and set the attributes color to "white" and size to 1.5.
# Add a geom_text() layer
ggplot(gm2007, aes(x = lifeExp, y = country, color = lifeExp)) +
   geom_point(size = 4) +
   geom_segment(aes(xend = 30, yend = country), size = 2) +
   geom_text(aes(label = lifeExp), color = "white", size = 1.5)
# The color scale has been set for you, but you need to clean up the scales. For the x scale:
#    Set expand to c(0, 0) and limits to c(30, 90).
# Place the axis on the top of the plot with the position argument.
# Set the color scale
palette <- brewer.pal(5, "RdYlBu")[-(2:4)]

# Modify the scales
ggplot(gm2007, aes(x = lifeExp, y = country, color = lifeExp)) +
   geom_point(size = 4) +
   geom_segment(aes(xend = 30, yend = country), size = 2) +
   geom_text(aes(label = round(lifeExp,1)), color = "white", size = 1.5) +
   scale_x_continuous("", expand = c(0, 0), limits =c(30, 90), position = "top") +
   scale_color_gradientn(colors = palette)
# Make sure to label the plot appropriately using labs():
#    Make the title "Highest and lowest life expectancies, 2007".
# Add a reference by setting caption to "Source: gapminder".
# Set the color scale
palette <- brewer.pal(5, "RdYlBu")[-(2:4)]
# Add a title and caption
ggplot(gm2007, aes(x = lifeExp, y = country, color = lifeExp)) +
   geom_point(size = 4) +
   geom_segment(aes(xend = 30, yend = country), size = 2) +
   geom_text(aes(label = round(lifeExp,1)), color = "white", size = 1.5) +
   scale_x_continuous("", expand = c(0,0), limits = c(30,90), position = "top") +
   scale_color_gradientn(colors = palette) +
   labs(title = "Highest and lowest life expectancies, 2007",caption = "Source: gapminder")

#----------------------------Using annotate() for embellishments---------------------------------
# In the previous exercise, we completed our basic plot.
# Now let's polish it by playing with the theme and adding annotations.
# In this exercise, you'll use annotate() to add text and a curve to the plot.
#
# The following values have been calculated for you to assist with adding embellishments to the plot:
#
# global_mean <- mean(gm2007_full$lifeExp)
# x_start <- global_mean + 4
# y_start <- 5.5
# x_end <- global_mean
# y_end <- 7.5
#
# Our previous plot has been assigned to plt_country_vs_lifeExp.

# Clean up the theme:
# Add a classic theme to the plot with theme_classic().
# Set axis.line.y, axis.ticks.y, and axis.title to element_blank().
# Set the axis.text color to "black".
# Remove the legend by setting legend.position to "none".
# Define the theme
plt_country_vs_lifeExp +
   theme_classic() +
   theme(axis.line.y = element_blank(),
         axis.ticks.y = element_blank(),
         axis.text = element_text(color="black"),
         axis.title = element_blank(),
         legend.position = "none")
# Use geom_vline() to add a vertical line.
# Set xintercept to global_mean,
# specify the color to be "grey40",
# and set linetype to 3
# Add a vertical line
plt_country_vs_lifeExp +
   step_1_themes +
   geom_vline(xintercept=global_mean, color="grey40", linetype= 3)
# x_start and y_start will be used as positions to place text and have been calculated for you.
# Add a "text" geom as an annotation.
# For the annotation, set x to x_start, y to y_start, and label to "The\nglobal\naverage".
# Add text
plt_country_vs_lifeExp +
   step_1_themes +
   geom_vline(xintercept = global_mean, color = "grey40", linetype = 3) +
   annotate(
      "text",
      x = x_start, y = y_start,
      label = "The\nglobal\naverage",
      vjust = 1, size = 3, color = "grey40"
   )
# Set the length of the arrowhead to 0.2 cm and the type to "closed".
# Add a curve
plt_country_vs_lifeExp +
   step_1_themes +
   geom_vline(xintercept = global_mean, color = "grey40", linetype = 3) +
   step_3_annotation +
   annotate(
      "curve",
      x = x_start, y = y_start,
      xend = x_end, yend = y_end,
      arrow = arrow(length = unit(0.2, "cm"), type = "closed"),
      color = "grey40"
   )



