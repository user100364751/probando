#--------------------------------------------------------------
#--------------------------------------------------------------
# Prediccion NBA 
#--------------------------------------------------------------
#--------------------------------------------------------------
rm(list = ls())
library(readr)
library(dplyr)
library(MASS)
library(gvlma)
library(car)

# Import data
data <- read_csv("nba.csv")

#--------------------------------------------------------------
# 1. Data cleaning
#--------------------------------------------------------------
# Show the colnames and change the conflictive names with %
colnames(data)
colnames(data)[10] <- "TS"
colnames(data)[13:20] <- c("ORB", "DRB", "TRB", "AST", "STL", "BLK","TOV","USG")
colnames(data)

# Drop duplicates and NAs
duplicated(data$Player) # There are two duplicates in rows 226 and 227
data[226:227, ] # We check both. The same player but slightly different predictors.
nrow(data) # 485 rows
data <- data[-227, ] # Delete the second duplicate 
nrow(data) # 1 row deleted

data <- na.omit(data) # remove rows with na
nrow(data) # 2 rows have been removed

# Identify outliers
attach(data)
boxplot(Salary)
outliers <- boxplot.stats(Salary)$out # There are 26 outliers
outliers
which(Salary %in% c(outliers)) # If we want to know the row of the outliers


# Create a new dataframe that excludes outliers
data_cleaned <- data[-c(68, 87, 112, 122, 152, 192, 203, 216, 236, 293, 306, 320, 321, 325, 357, 384, 409, 421, 425, 427, 432, 443, 449, 460, 467, 478), ]
boxplot(data_cleaned$Salary) # There are still outliers, but it is not as bad as before

# Check the rows have been removed and compare
nrow(data_cleaned)
nrow(data)
detach(data)
mean(data$Salary)
mean(data_cleaned$Salary) # The mean of the salaries have changed quite a lot 
mean(data_cleaned$Salary) - mean(data$Salary) # 1,137,713 difference 

# Remove the columns that will not be usefull for our prediction
data_cleaned$NBA_Country <- NULL
data_cleaned$Tm <- NULL
colnames(data_cleaned) # Check the change has been made


#--------------------------------------------------------------
# 2. Regression
#--------------------------------------------------------------
# Create a model with all varibles except player
attach(data_cleaned)
model_all <- lm(Salary~. -Player, data_cleaned) 
summary(model_all) # SER of 4,357,000 and F-statistic: 15.28

# Use as a method of selection "both"
stepAIC(model_all, direction = "both") # Menor AIC= 13,945.77

# Looking at the lower AIC we choose the following model
model_AIC <- lm(formula = Salary ~ NBA_DraftNumber + Age + G + MP + PER + 
                  `3PAr` + ORB + DRB + TRB + OBPM + VORP, data = data_cleaned) 
summary(model_AIC) # SER of 4,319,000 and F-statistic: 33.47

# We check if there is multicoliniarity
vif(model_AIC)
sqrt(vif(model_AIC)) > 2 # If it is larger than 2 there is multicoliniarity, Thus we delete conflicting varibles

# Fix multicoliniarity with a new model proposed
model_AIC <- lm(formula = Salary ~ NBA_DraftNumber + Age + G + PER + 
                  `3PAr` + TRB + VORP, data = data_cleaned)
summary(model_AIC) 

# Explanation of the variables deleted: MP has higher variance than G, between the rebounds, stay with the total (TRB) and 
# remove the remainings and PER is better than OBPM

# Check the multicoliniarity of the new model
vif(model_AIC)
sqrt(vif(model_AIC)) > 2 # All of them are smaller than 2, thus no multicoliniarity in the new model


# We want to know if there is interaction between the varibles
model_interaction <- lm(formula = Salary ~ NBA_DraftNumber * Age * G * PER * 
                          `3PAr` * TRB * VORP, data = data_cleaned)
summary(model_interaction) # There is no interaction between the variables

# We look at the global validation of the model
gvmodel <- gvlma(model_AIC) 
summary(gvmodel) # Heteroscedasticity and link functio assumptions are satisfied

# We create a column with the Predicted salary
data_cleaned["Prediction"] <- predict(model_AIC, data_cleaned)

# Prediction with a sample of 10 
set.seed(1234)
n <- 10
sample1 <- sample(1:nrow(data_cleaned), size = n, replace = FALSE) # Select the sample
sample1 
sample_data <- data_cleaned[sample1, ] #Create a table with only the result of the sample
sample_data

# We look at the accuracy of the model in the sample
difference <- sample_data$Salary - sample_data$Prediction
accuracy_dif <- abs(difference)
mean(accuracy_dif) # 2,109,445 average error 
error <- mean(accuracy_dif)/mean(data_cleaned$Salary)
accuracy <- 1 - error # Esto ultimo no esta en lo que subi

#--------------------------------------------------------------
# 3. Graphs
#--------------------------------------------------------------

qqPlot(model_AIC, labels = row.names(data_cleaned), id.method = "identify", simulate = TRUE, main = "Q-Q Plot") # Does not follow the Normal

# Influence Plot
influencePlot(model_AIC, id.method = "identify", main = "Influence Plot",
              sub = "Circle size is proportial to Cook's Distance") # The influential values are 142, 137, 218, 127, 444 and 387




