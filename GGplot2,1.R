# #---------------------------------------Smoothing------------------------------------------------
# To practice on the remaining layers (statistics, coordinates and facets),
# we'll continue working on several datasets from the first course.
#
# The mtcars dataset contains information for 32 cars from Motor Trends magazine from 1974.
# This dataset is small, intuitive, and contains a variety of continuous and categorical
# (both nominal and ordinal) variables.
#
# In the previous course you learned how to effectively use some basic geometries,
# such as point, bar and line. In the first chapter of this course you'll explore
# statistics associated with specific geoms, for example, smoothing and lines.
#
# Look at the structure of mtcars.
# Using mtcars, draw a scatter plot of mpg vs. wt.
# View the structure of mtcars
str(mtcars)

# Using mtcars, draw a scatter plot of mpg vs. wt
ggplot(mtcars, aes(y=mpg,x=wt))+
   geom_point()
# Update the plot to add a smooth trend line. Use the default method,
# which uses the LOESS model to fit the curve.
# Amend the plot to add a smooth layer
ggplot(mtcars, aes(x = wt, y = mpg)) +
   geom_point() +
   geom_smooth()
# Update the smooth layer. Apply a linear model by setting method to "lm",
# and turn off the model's 95% confidence interval (the ribbon) by setting se to FALSE.
# Amend the plot. Swap geom_smooth() for stat_smooth().
ggplot(mtcars, aes(x = wt, y = mpg)) +
   geom_point() +
   geom_smooth(method = "lm", se = FALSE)
# Draw the same plot again, swapping geom_smooth() for stat_smooth().
# Amend the plot. Swap geom_smooth() for stat_smooth().
ggplot(mtcars, aes(x = wt, y = mpg)) +
   geom_point() +
   stat_smooth(method = "lm", se = FALSE)
#---------------------------------------Grouping variables------------------------------------------------
# We'll continue with the previous exercise by considering the situation of looking at sub-groups in our dataset.
# For this we'll encounter the invisible group aesthetic.
#
# mtcars has been given an extra column, fcyl, that is the cyl column converted to a proper factor variable.
#
# Using mtcars, plot mpg vs. wt, colored by fcyl.
# Add a point layer.
# Add a smooth stat using a linear model, and don't show the se ribbon.
# Using mtcars, plot mpg vs. wt, colored by fcyl
ggplot(mtcars, aes(x = wt, y = mpg, color=fcyl)) +
   # Add a point layer
   geom_point() +
   # Add a smooth lin reg stat, no ribbon
   stat_smooth(method = "lm", se = F)

# Update the plot to add a second smooth stat.
# Add a dummy group aesthetic to this layer, setting the value to 1.
# Use the same method and se values as the first stat smooth layer.
# Amend the plot to add another smooth layer with dummy grouping
ggplot(mtcars, aes(x = wt, y = mpg, color = fcyl)) +
   geom_point() +
   stat_smooth(method = "lm", se = FALSE)+
   stat_smooth(aes(group=1),method = "lm", se = FALSE) #this part is pretty interesting because i can add
#many lines as i want to the model, this in order to compare figures or maybe to organize information.

#----------------------------------------Modifying stat_smooth----------------------

# In the previous exercise we used se = FALSE in stat_smooth() to remove the 95%
# Confidence Interval. Here we'll consider another argument, span, used in LOESS smoothing,
# and we'll take a look at a nice scenario of properly mapping different models.
#
# Compare LOESS and linear regression smoothing on small regions of data.
# Add a smooth LOESS stat, without the standard error ribbon.
# Add a smooth linear regression stat, again without the standard error ribbon.
ggplot(mtcars, aes(x = wt, y = mpg)) +
   geom_point() +
   # Add 3 smooth LOESS stats, varying span & color
   stat_smooth(se=F, color="red", span=0.9) + #here i compare 3 different models with 3 different lines.
   stat_smooth(se=F, color="green", span=0.6) +
   stat_smooth(se=F, color="blue", span=0.3)
# Compare LOESS and linear regression smoothing on small regions of data.
# Add a smooth LOESS stat, without the standard error ribbon.
# Add a smooth linear regression stat, again without the standard error ribbon.
# Amend the plot to color by fcyl
ggplot(mtcars, aes(x = wt, y = mpg)) +
   geom_point() +
   # Add a smooth LOESS stat, no ribbon
   stat_smooth(se=F, color="red", span=0.9) +
   # Add a smooth lin. reg. stat, no ribbon
   stat_smooth(aes(group=1),method = "lm", se = FALSE)
# LOESS isn't great on very short sections of data; compare the pieces of linear regression
# to LOESS over the whole thing.
# Amend the smooth LOESS stat to map color to a dummy variable, "All".
# Amend the plot
ggplot(mtcars, aes(x = wt, y = mpg, color = fcyl)) +
   geom_point() +
   # Map color to dummy variable "All"
   stat_smooth(se = FALSE,aes(color="All")) +
   stat_smooth(method = "lm", se = FALSE)
#--------------------------------------Modifying stat_smooth (2)--------------------------------------------
# In this exercise we'll take a look at the standard error ribbons, which show the 95% confidence interval of
# smoothing models. ggplot2 and the Vocab data frame are already loaded for you.
#
# Vocab has been given an extra column, year_group, splitting the dates into before and after 1995.
# Using Vocab, plot vocabulary vs. education, colored by year group
ggplot(Vocab,aes(education,vocabulary, color=year_group)) +
   # Add jittered points with transparency 0.25
   geom_jitter(alpha=0.25) +
   # Add a smooth lin. reg. line (with ribbon)
   stat_smooth(method = "lm", se = T)
# It's easier to read the plot if the standard error ribbons match the lines, and the lines have more emphasis.
# Update the smooth stat.
# Map the fill color to year_group.
# Set the line size to 2.
# Amend the plot
ggplot(Vocab, aes(x = education, y = vocabulary, color = year_group)) +
   geom_jitter(alpha = 0.25) +
   # Map the fill color to year_group, set the line size to 2
   stat_smooth(method = "lm",aes(fill=year_group,),size=2)

#--------------------------------------------Quantiles-------------------------------------------------

# Here, we'll continue with the Vocab dataset and use stat_quantile() to apply a quantile regression.
#
# Linear regression predicts the mean response from the explanatory variables, quantile regression
# predicts a quantile response (e.g. the median) from the explanatory variables. Specific quantiles
# can be specified with the quantiles argument.

# Specifying many quantiles and color your models according to year can make plots too busy.
# We'll explore ways of dealing with this in the next chapter.

# Update the plot to add a quantile regression stat, at quantiles 0.05, 0.5, and 0.95.
ggplot(Vocab, aes(x = education, y = vocabulary)) +
   geom_jitter(alpha = 0.25) +
   # Add a quantile stat, at 0.05, 0.5, and 0.95
   stat_quantile(quantilese=c(0.05, 0.50, 0.95))
# Amend the plot to color by year_group
ggplot(Vocab, aes(x = education, y = vocabulary,color=year_group)) +
   geom_jitter(alpha = 0.25) +
   stat_quantile(quantiles = c(0.05, 0.5, 0.95))

#------------------------------------Using stat_sum------------------------------------------
# In the Vocab dataset, education and vocabulary are integer variables. In the first course,
# you saw that this is one of the four causes of overplotting. You'd get a single point at
# each intersection between the two variables.
#
# One solution, shown in the step 1, is jittering with transparency. Another solution is to use
# stat_sum(), which calculates the total number of overlapping observations and maps that onto the size aesthetic.
#
# stat_sum() allows a special variable, ..prop.., to show the proportion of values within the dataset.
ggplot(Vocab, aes(x = education, y = vocabulary)) +
   stat_sum() +
   # Add a size scale, from 1 to 10
   scale_size(range = c(1, 10))
# Inside stat_sum(), set size to ..prop.. so circle size represents the proportion of the whole dataset.
# Amend the stat to use proportion sizes
ggplot(Vocab, aes(x = education, y = vocabulary)) +
   stat_sum(aes(size = ..prop..))
# Amend the plot to group by education
ggplot(Vocab, aes(x = education, y = vocabulary, group = education)) +
   stat_sum(aes(size = ..prop..))

#-------------------------------------------Preparations-------------------------------------------------------
# In the following exercises, we'll aim to make the plot shown in the viewer.
# Here, we'll establish our positions and base layer of the plot.
#
# Establishing these items as independent objects will allow us to recycle them easily in many layers, or plots.
#
# position_jitter() adds jittering (e.g. for points).
# position_dodge() dodges geoms, (e.g. bar, col, boxplot, violin, errorbar, pointrange).
# position_jitterdodge() jitters and dodges geoms, (e.g. points).
# As before, we'll use mtcars, where fcyl and fam are proper factor variables of the original cyl and am variables.

# Using these three functions, define these position objects:
#    posn_j: will jitter with a width of 0.2.
# posn_d: will dodge with a width of 0.1.
# posn_jd will jitter and dodge with a jitter.width of 0.2 and a dodge.width of 0.1.
# Define position objects
# 1. Jitter with width 0.2
posn_j <- position_jitter(width=0.2)
# 2. Dodge with width 0.1
posn_d <- position_dodge(width=0.1)
# 3. Jitter-dodge with jitter.width 0.2 and dodge.width 0.1
posn_jd <- position_jitterdodge(jitter.width=0.2,dodge.width=0.1)
# Plot wt vs. fcyl, colored by fam. Assign this base layer to p_wt_vs_fcyl_by_fam.
#
# Plot the data using geom_point().
# From previous step
posn_j <- position_jitter(width = 0.2)
posn_d <- position_dodge(width = 0.1)
posn_jd <- position_jitterdodge(jitter.width = 0.2, dodge.width = 0.1)

# Create the plot base: wt vs. fcyl, colored by fam
p_wt_vs_fcyl_by_fam<- ggplot(mtcars, aes(x=fcyl,y=wt, color=fam))

# Add a point layer
p_wt_vs_fcyl_by_fam +
   geom_point()


#----------------------------Using position objects--------------------------

# Now that the position objects have been created, you can apply them to the base plot to see their effects.
# You do this by adding a point geom and setting the position argument to the position object.
#
# The variables from the last exercise, posn_j, posn_d, posn_jd, and p_wt_vs_fcyl_by_fam are available
# in your workspace.

# Apply the jitter position, posn_j, to the base plot.
# Add jittering only
p_wt_vs_fcyl_by_fam +
   geom_point(position=posn_j)

# Apply the dodge position, posn_d, to the base plot.
# Add dodging only
p_wt_vs_fcyl_by_fam +
   geom_point(position=posn_d)

# Apply the jitter-dodge position, posn_jd, to the base plot.
p_wt_vs_fcyl_by_fam +
   geom_point(position=posn_jd)






























