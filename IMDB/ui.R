
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("IMDB Keywords Analysis"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 50,
                  max = 125,
                  value = 80),
      checkboxInput("Picture", label = "WordsCloud", value = F)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      imageOutput("image")
    )
  )
))
