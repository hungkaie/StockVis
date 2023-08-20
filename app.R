# Load packages ----
library(shiny)
library(quantmod)

# Source helpers ----
source("helpers.R")

# User interface ----
ui <- fluidPage(
  titlePanel("stockVis"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Select a stock to examine.

        Information will be collected from Yahoo finance."),
      textInput("symb", "Symbol", "SPY"), # 2330.TW
      
      dateRangeInput("dates",
                     "Date range",
                     start = "2013-01-01",
                     end = as.character(Sys.Date())),
      
      br(),
      br(),
      
      checkboxInput("log", "Plot y axis on log scale",
                    value = FALSE),
      
      checkboxInput("adjust",
                    "Adjust prices for inflation", value = FALSE)
    ),
    
    mainPanel(plotOutput("plot"))
  )
)

# Server logic
server <- function(input, output) {
  # symbol choice: https://finance.yahoo.com/lookup/
  # SPY(S&P 500), GOOG(Google), AAPL(Apple), GS(Goldman Sachs)
  data <- reactive({
    getSymbols(input$symb, src = "yahoo",
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })
  
  dataInput <- reactive({
    if(input$adjust) return(adjust(data()))
    data()
  })
  
  output$plot <- renderPlot({
    # chartTheme: white, white.mono, black, black.mono, orange, beige, wsj
    # type: line, bar, auto
    # TA: c(addVo()), NULL, c(addVo(),addBBands())
    chartSeries(dataInput(), theme = chartTheme("white"),
                type = "line", log.scale = input$log, TA = c(addVo()))
  })
  
}

# Run the app
shinyApp(ui, server)