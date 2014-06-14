library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Hierarchical clustering on the mtcar dataset"),
  sidebarPanel(
    h2("Clustering parameters"),
    selectInput('method', 'Clustering Method', choices=list("complete", "single", "ward")),
    numericInput('number', 'Number of clusters?', 4,
                 min = 1, max = 9),
    hr(),
    h2("Exploration parameters"),
    selectInput("xcol", "X Variable", c("Miles per Gallon"="mpg", "Cylinders"="cyl", "Displacement"="disp", "Horsepower"="hp", "Axle Ratio"="drat","Weight"="wt", "Transmission"="am")),
    selectInput("ycol", "Y Variable", c("Miles per Gallon"="mpg", "Cylinders"="cyl", "Displacement"="disp", "Horsepower"="hp", "Axle Ratio"="drat","Weight"="wt", "Transmission"="am"),
                selected=names(mtcars)[[4]]),
    checkboxInput("cluster", "Show the clusters?", FALSE)
  ),
  mainPanel(
    h2("Introduction"),
    p("This app demonstrates the application of hierarchical clustering techniques. It utilizes the mtcars dataset which is built into R, and contains data for 32 different automobiles on 11 different variables, among them fuel consumption, number of cylinders, horsepower etc."),
    p("The idea is to find similar car types, based on the variables in the dataset."),
    hr(),
    h2("The clustering"),
    p("The user can choose between different methods for clustering in the left-hand side panel (\"complete\", \"single\", and \"ward\"). The tool then performs the clustering algorithm and displays it. Based on the choice of the user in terms of number of clusters, these are highlighted in red. Cars with similar attributes should fall into one cluster."),
    plotOutput('plot1'),
    hr(),
    h2("Data exploration"),
    p("The scatterplot below is a simple graphical representation of certain variables - the user can chose the variables on the left hand side. The user can also choose to display in colour the different clusters a car belongs to."),
    h5(textOutput("caption")),    
    plotOutput('plot2'),
    hr(),
    h3("The raw dataset (for information only):"),
    tableOutput("view")
  )
))

