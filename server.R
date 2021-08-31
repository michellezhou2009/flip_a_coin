library(ggplot2)
library(dplyr)
library(plyr)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$Plot <- renderPlot({
    # generate bins based on input$bins from ui.R
    n = input$n
    head = input$head; tail = 1-head
    mu=head; sd=sqrt(head*tail/n)
    data = data.frame(xbar = sapply(seq(10000),function(k){
      mean(sample(0:1,size=n,replace=T,prob=c(tail,head)))
    }))
    g <- ggplot(data, aes(x = xbar)) + 
      geom_histogram(aes(y = ..density..), alpha = .20, binwidth=1/n, colour = "black") + stat_function(fun = dnorm, args = list(mean = head, sd = sd(data$xbar)),col="red",size=1.5) 
    g
  })
}