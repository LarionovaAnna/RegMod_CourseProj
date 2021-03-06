
##Introduction
###Looking at a data set of a collection of cars, we are interested in exploring the relationship between a set of variables and miles per gallon (MPG) (outcome). We will be using the mtcars dataset in R to do our analysis. We will be trying to answer the following questions:
  
###  �Is an automatic or manual transmission better for MPG�
###�Quantify the MPG difference between automatic and manual transmissions�
##Executive Summary
###A simple model was first designed (mpg ~ factor(am)) to answer the question being asked. But since we found the R squared to be low and other variables in the data set having linear relationship with mpg we designed a multivariate regression model that ultimately increased the R squared value to 83.4%. The final verdict being manual transmission being better for MPG than automatic. 1.8 is the estimated expected increase in miles per gallon when compared manual transmission to automatic transmission.

##Analysis
data("mtcars")
library(ggplot2)
library(car)
head(mtcars)
###the am variable stores the data for transmission (0 = automatic, 1 = manual)
###creating boxplot to understand effect of transmission on mpg
g <- ggplot(mtcars, aes(x = factor(am), y = mpg, fill = factor(am))) + 
  geom_boxplot() + ggtitle("Analyzing mpg ~ am data")
###there is a positive effect on mpg in cars with manual transmission
##fit the simple linear model with am
fit <- lm(mpg ~ as.factor(am), data = mtcars)
coef(summary(fit))
###coefficient of manual transmission have value 7.24 as expected increase in miles per gallon when compared manual transmission to automatic transmission. So our basic model answers the first question positively. But if we look at the Adjuster R-squared value we will see that it is pretty low (34%), and the explanation of variance low as well. Plot2 in apendix shows that there are more variables that have linear relationship to mpg. Let's try to see which variable has big variance inflation factor (vif). First we add all variables to new model.
fit_all <- lm(mpg ~ ., data = mtcars)
sqrt(vif(fit_all))
###Here we find that am variable actually is not that very significant, however we leave it be in our model together with weight (wt), disp, cyl, hp.
fit2 <- lm(mpg ~ factor(cyl) + disp + hp + wt + factor(am), data = mtcars)
summary(fit2)
###Now adjuster R-squared is 83%, the model do better than the previous one after we added more variables in it. We can use anova to see whether our multivariable model (fit2) is better than the simple model (fit)
anova(fit, fit2)
###low p-value does signify that the final model is a good fit.We run a diagnostic to be doubly sure

influence.measures(fit2)
###Residual plots are in Appendix. A pattern less residual plot signifies a good fit.
###
##Appendix
g

pairs(mtcars, panel = panel.smooth, main = "Pair graph of car variables")

par(mfrow = c(2,2))
plot(fit2)