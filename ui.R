#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Vehicle consumption and total cost per year estimator"),
    
    # Sidebar with options selectors
    sidebarLayout(
        sidebarPanel(
            helpText("This app estimate vehicle consumption and cost per year of ownership."),
            h4(helpText("Insert your data:")),
            numericInput("mpr", label = h4("Milage per year"), step = 500, value = 20000),
            numericInput("fuelcost", label = h4("Dollars per gallon"), step = 0.1, value = 2.5),
            sliderInput("power", "Engine power (hp):", min = 50, max = 350, value = 100),
            selectInput("trasm", label = h4("Type of transmission"),
                        choices = list("Unknown" = "*", "Manual" = "0", "Automatic" = "1")),
            #selectInput("cyl", label = h4("# of cylinder"),
                       # choices = list("Unknown" = "*", "4" = "4", "6" = "6","8" = "8")),
            selectInput("vstype", label = h4("Type of engine"),
                        choices = list("Unknown" = "*", "Straight" = "1", "V-shape" = "0"))
        ),
        
        # Show the plot and value of cost per year
        mainPanel(
            plotOutput("distPlot"),
            h4("Estimated cost per year:"),
            h3(textOutput("result"))
        )
    )
))
