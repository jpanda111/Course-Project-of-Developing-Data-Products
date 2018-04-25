
library(shiny)
library(caret)
library(ggplot2)
library(dplyr)
library(randomForest)
data(iris)

shinyServer(function(input, output) {

  model_lda <- train(Species ~ Petal.Length + Petal.Width, data = iris, method = "lda")
  model_rf <- train(Species ~ Petal.Length + Petal.Width, data = iris, method = "rf", prox = TRUE)
  
  modelpred <- reactive ({
    number_of_points <- input$numeric
    minPLInput <- input$petal_length[1]
    maxPLInput <- input$petal_length[2]
    minPWInput <- input$petal_width[1]
    maxPWInput <- input$petal_width[2]
    
    set.seed(12345)
    testing <- data.frame(Petal.Length=runif(number_of_points, minPLInput, maxPLInput), Petal.Width=runif(number_of_points, minPWInput, maxPWInput))
    testing$pred_rf <- predict(model_rf, testing)  
    testing$pred_lda <- predict(model_lda, testing)
    testing$pred_same <- testing$pred_rf == testing$pred_lda
    testing
  })

  output$plot1 <- renderPlot({
    ggplot(data=iris, aes(x=Petal.Width, y=Petal.Length)) + geom_point(aes(color=Species),alpha=0.4) 
  })
  
  output$plot2 <- renderPlot({
    if(input$show_lda_model){
      ggplot(data=modelpred(), aes(x=Petal.Width, y=Petal.Length)) + geom_point(aes(color=pred_lda),alpha=0.4) + ggtitle("LDA Model Prediction Plot")
    }
  })
  
  output$plot3 <- renderPlot({
    if(input$show_rf_model){
      ggplot(data=modelpred(), aes(x=Petal.Width, y=Petal.Length)) + geom_point(aes(color=pred_rf),alpha=0.4) + ggtitle("RF Model Prediction Plot")
    }
  })
  
  output$plot4 <- renderPlot({
    if(input$show_model_comparison){
      ggplot(data=modelpred(), aes(x=Petal.Width, y=Petal.Length)) + geom_point(aes(color=pred_same),alpha=0.4) + ggtitle("Model Prediction Comparison Plot")
    }
  })
})

## deploy your shiny App to shinyapps.io
## install.packages("rsconnect", type = "source")
## library(rsconnect)
## create a shinyapps.io account
## rsconnect::setAccountInfo(name='jpanda111',token='19B66440443B220CC8E726B777E12B0E', secret='herhVhZaH7uce+jtvuBziZpd8OOfJo0CYI9N/MrE')
