library(shiny)



shinyServer(function(input, output){
  
  population <- reactive({
    if(input$dist=="norm") pop <- rnorm(input$N, 
                                        mean=input$mean, 
                                        sd=input$sd)
    if(input$dist=="exp") pop <- rexp(input$N, 
                                       rate=input$rate)
    if(input$dist=="chisq") pop <- rchisq(input$N, 
                                         df=input$df)
    pop
  })
  
  output$popPlot <- renderPlot({
    hist(population(), main="Histogram of the Population Data")
  })
  
  samp <- reactive({
    pop <- population()
    rep <- input$rep
    n <- input$n
    # The & here makes sure that the setseed box is true (otherwise, if it was true, then switched off, the seed from when it was set as true would stay active)
    if(!is.na(input$seed)&input$setseed==TRUE) set.seed(input$seed)
    sam <- matrix(NA,nrow=rep,ncol=n)
    for(i in 1:rep) sam[i,] <- sample(pop,n)
    apply(sam,1,mean)
  })
  
  output$samPlot <- renderPlot({
    hist(samp(), main="Histogram of the Means of the Samples")
  })
  
})
