#-------------------------------------------- Built-in themes --------------------------------------

#ggtheme package-> package with preinstalled graphics in ggplot.
#
# In addition to making your own themes, there are several out-of-the-box
#solutions that may save you lots of time.
#
# theme_gray() is the default.
# theme_bw() is useful when you use transparency.
# theme_classic() is more traditional.
# theme_void() removes everything but the data.
# plt_prop_unemployed_over_time is available.

#Add a black and white theme, theme_bw(), to the plot.

#--------------------------------------- Exploring ggthemes --------------------------------------
# Outside of ggplot2, another source of built-in themes is the ggthemes package.
# The workspace already contains the plt_prop_unemployed_over_time, the line plot from before.
# Let's explore some of the ready-made ggthemes themes.
#
# plt_prop_unemployed_over_time is available.

#-------------------------------Exploring ggthemes--------------------------------

# Outside of ggplot2, another source of built-in themes is the ggthemes package.
# The workspace already contains the plt_prop_unemployed_over_time, the line plot from before.
# Let's explore some of the ready-made ggthemes themes.
#
# plt_prop_unemployed_over_time is available.

#1
# Use the fivethirtyeight theme
plt_prop_unemployed_over_time +
   theme_fivethirtyeight()
# Use Tufte's theme
plt_prop_unemployed_over_time +
   theme_tufte()
# Use the Wall Street Journal theme
plt_prop_unemployed_over_time +
   theme_wsj()

#------------------------------------- Setting themes -------------------------------
# Reusing a theme across many plots helps to provide a consistent style.
# You have several options for this.
#
# Assign the theme to a variable, and add it to each plot.
# Set your theme as the default using theme_set().
# A good strategy that you'll use here is to begin with a built-in theme then modify it.
#
# plt_prop_unemployed_over_time is available. The theme you made earlier is shown in the sample code.
#
#
# Assign the theme to theme_recession.
# Add the Tufte theme and theme_recession together.
# Use the Tufte recession theme by adding it to the plot.

# Theme layer saved as an object, theme_recession
theme_recession <- theme(
   rect = element_rect(fill = "grey92"),
   legend.key = element_rect(color = NA),
   axis.ticks = element_blank(),
   panel.grid = element_blank(),
   panel.grid.major.y = element_line(color = "white", size = 0.5, linetype = "dotted"),
   axis.text = element_text(color = "grey25"),
   plot.title = element_text(face = "italic", size = 16),
   legend.position = c(0.6, 0.1)
)

# Combine the Tufte theme with theme_recession
theme_tufte_recession <- theme_tufte() + theme_recession

# Add the recession theme to the plot
plt_prop_unemployed_over_time + theme_tufte_recession
#
# Use theme_set() to set theme_tufte_recession as the default theme.
# Draw the plot, plt_prop_unemployed_over_time, without explicitly adding a theme.
# Look at the plot. Was it styled with the default theme or the new theme?*
theme_recession <- theme(
   rect = element_rect(fill = "grey92"),
   legend.key = element_rect(color = NA),
   axis.ticks = element_blank(),
   panel.grid = element_blank(),
   panel.grid.major.y = element_line(color = "white", size = 0.5, linetype = "dotted"),
   axis.text = element_text(color = "grey25"),
   plot.title = element_text(face = "italic", size = 16),
   legend.position = c(0.6, 0.1)
)
theme_tufte_recession <- theme_tufte() + theme_recession

# Set theme_tufte_recession as the default theme
theme_set(theme_tufte_recession)

# Draw the plot (without explicitly adding a theme)
plt_prop_unemployed_over_time

#-------------------------- Publication-quality plots ----------------------------------------------

# We've seen many examples of beautiful, publication-quality plots.
# Let's take a final look and put all the pieces together.
#
# plt_prop_unemployed_over_time is available.

plt_prop_unemployed_over_time +
   # Add Tufte's theme
   theme_set(theme_tufte())
# Call the function to add individual theme elements. Turn off the legend and the axis ticks.
plt_prop_unemployed_over_time +
   theme_tufte() +
   theme(
      legend.position = "none",
      axis.ticks = element_blank(),
      # Set the axis title's text color to grey60
      axis.title=element_text(color="grey60"),
      # Set the axis text's text color to grey60
      axis.text=element_text(color="grey60")
   )

# Set the panel gridlines major y values. Set the color to grey60,
# the size to 0.25, and the line type to dotted.
plt_prop_unemployed_over_time +
   theme_tufte() +
   theme(
      legend.position = "none",
      axis.ticks = element_blank(),
      axis.title = element_text(color = "grey60"),
      axis.text = element_text(color = "grey60"),
      # Set the panel gridlines major y values
      panel.grid.major.y = element_line (
         # Set the color to grey60
         color="grey60",
         # Set the size to 0.25
         size= 0.25,
         # Set the linetype to dotted
         linetype="dotted"
      )
   )
