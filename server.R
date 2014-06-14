library(shiny)

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

# Define server logic required to plot dendrogram
shinyServer(function(input, output) {
  
  clusters <- reactive({
    hclust(dist(scale(mtcars)), method=input$method)
  })
   cut <- reactive({
     cutree(clusters(), input$number)
   })
  output$plot1 <- renderPlot({
    plot(clusters(), hang=-1, main="Hierarchical clustering of cars", sub="1973-74 model year", xlab="Cars", ylab="")
    rect.hclust(clusters(),input$number)
})

  # Compute the forumla text in a reactive expression since it is 
  # shared by the output$caption and output$plot2 functions
  formulaText <- reactive({
    paste(input$ycol, "~", input$xcol)
  })
  
  # Return the formula text for printing as a caption
  output$caption <- renderText({
    formulaText()
  })
  
  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    mtcars[, c(input$xcol, input$ycol)]
  })
  
  output$plot2 <- renderPlot({
    plot(as.formula(formulaText()), data=mpgData,
         col = "gray",
         pch = 20, cex = 3)
    if(input$cluster){
      points(as.formula(formulaText()), data=mpgData, pch=20, cex=3, col=cut())
      legend("topright", legend=levels(factor(cut())), col=unique(cut()), pch=20, cex=1.5, horiz=TRUE, title="Cluster")
    }
  })

  output$view <-renderTable( {
    mtcars
  })

  
})

