library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Central Limit Theorem Demonstration"),
  
  #
  sidebarPanel(
    selectInput("dist", 
                "Which distribution would you like this demonstrated for?",
                list("Normal"="norm",
                     "Exponential"="exp",
                     "Chi-Squared"="chisq",
                     "Poisson"="pois")),
    
    #### Setting unique inputs for the different kinds of distributions
    #normal
    conditionalPanel(
      condition = "input.dist == 'norm'",
      numericInput("mean", "Mean:",0),
      numericInput("sd", "Standard Deviation:",1)
    ),
    
    #exponential
    conditionalPanel(
      condition = "input.dist == 'exp'",
      numericInput("rate", "Rate:",1)
    ),
    
    #chi-squared
    conditionalPanel(
      condition = "input.dist == 'chisq'",
      numericInput("df", "Degrees of Freedom:",10)
    ),
    
    conditionalPanel(
      condition = "input.dist == 'pois'",
      numericInput("lambda", "Lambda:", 1)
    ),
    
    numericInput("n", "Sample Size (of each sample):", 10),
    
    numericInput("rep","Number of Samples To Take:", 10000),    
    
    #Giving users the option to select their population size (which shouldn't matter, so long as it is somewhat large)
    
    checkboxInput("setpop", "I wish to set the population size.", FALSE),
    
    conditionalPanel(
      condition = "input.setpop == true",
      numericInput("N","Population Size",10000)
    ),
    
    checkboxInput("setseed", "I wish to set the seed.", FALSE),
    
    conditionalPanel(
      condition = "input.setseed == true",
      numericInput("seed","Seed:",NA)
    )
    
  ),
  #
  mainPanel(
  
    #Do the population output as well as the CLT output, maybe with a run button on the side panel to keep it from doing so many calculations all at the same time?
    
    tabsetPanel(
      tabPanel("Population", plotOutput("popPlot")),
      tabPanel("Sample Means", plotOutput("samPlot"))
    )
    
    
    
  )
))