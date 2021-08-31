library(shiny)

ui <- fluidPage(
  
  # Application title
  titlePanel("Central Limit Theorem"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      helpText("Select the sample size, i.e., how many times a coin is flipped, and the probability of showing a head"),
      sliderInput("n",
                  "Number of flips:",
                  min = 0,
                  max = 400,
                  value = 1, step=1),
      sliderInput("head",
                  "Probability of head",
                  min = 0,
                  max = 1,
                  value = 0.5, step=0.1)
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("Plot")
    )
  )
)
