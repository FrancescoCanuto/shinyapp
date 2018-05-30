#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)

# Manipulation of dataset for analysis
mtcars
mtcars$cyl <- as.factor(mtcars$cyl)
mtcars$vs <- as.factor(mtcars$vs)
mtcars$am <- as.factor(mtcars$am)


# Define server logic required to draw a plot
shinyServer(function(input, output, session) {
    output$distPlot <- renderPlot({
        # Subset mtcars based on selection
        data.cars <- filter(mtcars, grepl(input$trasm, mtcars$am), grepl(input$vstype, mtcars$vs))
        # uodate sliderbar limits
        updateSliderInput(session, "power", value = input$power,
                         min = min(data.cars$hp), max = max(data.cars$hp))
        # linear regression model
        fit <- lm( mpg~hp, data.cars)
        # prediction of mpg
        pred <- predict(fit, newdata = data.frame(hp = input$power))
        # Draw plot using ggplot2
        
        
        
        plot <- ggplot(data=data.cars, aes(x=hp, y = mpg))+
            geom_point(aes(color = cyl), alpha = 0.6)+
            geom_smooth(method = "lm")+
            geom_point(x=input$power, y=pred, size=5) +
            annotate("text", x=input$power+10, y=pred+1, label=paste("mpg: ",
                                                                     round(pred, digits = 1.5)))
        plot
        
    })
    
    output$result <- renderText({
        # Renders the text for cost per year
        data.cars <- filter(mtcars, grepl(input$trasm, am), grepl(input$vstype, vs))
        fit <- lm( mpg~hp, data.cars)
        pred <- predict(fit, newdata = data.frame(hp = input$power))
        value.cost.year <- input$mpr / pred * input$fuelcost
        cost.year <- paste(round(value.cost.year, digits = 1.5),"$" )
        cost.year
    })
    
    
    
    
})
