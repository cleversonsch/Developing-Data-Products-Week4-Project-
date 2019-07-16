

shinyServer(function(input, output) {
  library(shiny)
  library(caret)
  library(randomForest)
  library(e1071)
  set.seed(1234)
  control <- trainControl(method="cv", number=10)
  metric <- "Accuracy"
  inTrain<-createDataPartition(y = iris$Species,p=0.8,list=FALSE)
  training<- iris[inTrain,]
  testing<- iris[-inTrain,]
  model1 <- train(Species ~., data = training, method = "rf", metric = metric,
                  trControl = control)
  model2 <- train(Species ~., data = training, method = "lda", metric = metric,
                  trControl = control)
  model1_prediction <- predict(model1, testing)
  model2_prediction <- predict(model2, testing)
  
  model1pred <- reactive({
    Sepal.LengthInput <- input$sliderSepal.Length
    Sepal.WidthInput <- input$sliderSepal.Width
    Petal.LengthInput <- input$sliderPetal.Length
    Petal.WidthInput <- input$sliderPetal.Width
    predict(model1, newdata=data.frame(Sepal.Length = Sepal.LengthInput, 
                                         Sepal.Width = Sepal.WidthInput,
                                         Petal.Length = Petal.LengthInput,
                                         Petal.Width = Petal.WidthInput))
    
  })
  model2pred <- reactive({
    Sepal.LengthInput <- input$sliderSepal.Length
    Sepal.WidthInput <- input$sliderSepal.Width
    Petal.LengthInput <- input$sliderPetal.Length
    Petal.WidthInput <- input$sliderPetal.Width
    predict(model2, newdata=data.frame(Sepal.Length = Sepal.LengthInput, 
                                       Sepal.Width = Sepal.WidthInput,
                                       Petal.Length = Petal.LengthInput,
                                       Petal.Width = Petal.WidthInput))
  })
  
  accuracy_model1 <- confusionMatrix(model1_prediction, testing$Species)
  accuracy_model1 <- accuracy_model1$overall['Accuracy']
  accuracy_model2 <- confusionMatrix(model2_prediction, testing$Species)
  accuracy_model2 <- accuracy_model2$overall['Accuracy']
  
  output$accuracy_model1 <- renderText({
    paste(round(accuracy_model1,3)*100,"%")
  })
  output$accuracy_model2 <- renderText({
    paste(round(accuracy_model2,3)*100,"%")
  })
  output$pred1 <- renderText({
    paste(model1pred())
  })
  output$pred2 <- renderText({
    paste(model2pred())
  })
})