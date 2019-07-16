library(shiny)

shinyUI(fluidPage(
  titlePanel("Predict iris flower specie based on morphologic variation"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderSepal.Length", "What is the sepal lentgh in cm?",
                  value = 6.0, min = 4.0, max = 8, step = 0.1),
      sliderInput("sliderSepal.Width", "What is the sepal width in cm?",
                  value = 3.5, min = 2.0, max = 5, step = 0.1),
      sliderInput("sliderPetal.Length", "What is the petal lenght in cm?",
                  value = 4.0, min = 1.0, max = 7, step = 0.1),
      sliderInput("sliderPetal.Width", "What is the petal width in cm?",
                  value = 1.5, min = 0.0, max = 3.0, step = 0.1),
      h4("Random Forest model accuracy:"),
      textOutput("accuracy_model1"),
      h4("Linear Discriminant Analysis accuracy:"),
      textOutput("accuracy_model2")
      ),
    mainPanel(
      h3("Setosa Specie:"),
      img(src = "setosa.jpg", height = 72, width = 72),
      h3("Versicolor Specie:"),
      img(src = "versicolor.jpg", height = 72, width = 72),
      h3("Virginica Specie:"),
      img(src = "virginica.jpg", height = 72, width = 72),
      h3("Iris specie based on Random Forest model:"),
      textOutput("pred1"),
      h3("Iris specie based on Linear Discriminant Analysis model:"),
      textOutput("pred2")
    )
  )
))
