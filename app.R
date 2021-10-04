#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(plyr)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Central Limit Theorem"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            helpText("The experiment is to flip a coin a number of times; we repeat this experiment 10,000 times, and plot the histogram of Xbar. Select the sample size, i.e., how many times a coin is flipped, and the probability of showing a head"),
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

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$Plot <- renderPlot({
        # generate bins based on input$bins from ui.R
        n = input$n
        head = input$head; tail = 1-head
        mu=head; sd=sqrt(head*tail/n)
        out = sapply(seq(10000),function(k){
            mean(sample(0:1,size=n,replace=T,prob=c(tail,head)))
        })
        xbar.all = c(0:n)/n
        data = lapply(xbar.all,function(x){
            data.frame(xbar=x, count=sum(out==x))
        }) %>% do.call(rbind,.) %>%
            mutate(percentage=count/sum(count)) 
        g <- ggplot(data) + 
            geom_bar(aes(x=xbar,y=percentage),stat="identity",position="dodge",width=1/(n*2),fill="black") +
            scale_y_continuous(limits=c(0,max(data$percentage)),breaks=seq(0,max(data$percentage),by=0.05)) +
            scale_x_continuous(breaks=round_any(xbar.all,0.05))
        g
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
