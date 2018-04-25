

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict Iris Species"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       helpText("Pick total random numbers to do prediction:"),
       numericInput("numeric", "How Many Random Numbers to Predict?", value = 1000, 
                    min = 1, max = 1000, step = 1),
       helpText("Pick a range of random data for petal length/width:"),
       sliderInput("petal_length", label = h4("Pick Minimum and Maximum Petal Length Value:"),
                   min = 1.0, max = 6.9, value = c(1.0, 6.9)),
       sliderInput("petal_width", label = h4("Pick Minimum and Maximum Petal Width Value:"),
                    min = 0.1, max = 2.5, value = c(0.1, 2.5)),
       checkboxInput("show_lda_model", "Show/Hide LDA Model Accuracy Plot", value = TRUE),
       checkboxInput("show_rf_model", "Show/Hide RF Model Accuracy Plot", value = TRUE),
       checkboxInput("show_model_comparison", "Show/Hide Model Comparison Plot", value = TRUE),
       submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("plot1"),
       plotOutput("plot2"),
       plotOutput("plot3"),
       plotOutput("plot4")
    )
  )
))
