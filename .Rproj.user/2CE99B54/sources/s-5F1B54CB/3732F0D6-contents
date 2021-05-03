library("shiny")
library("EBImage")# >= 4.19.3

ui <- fluidPage(
  
  # Application title
  titlePanel("Image display"),
  
  # Sidebar with a select input for the image
  sidebarLayout(
    sidebarPanel(
      fileInput("image", "Select image")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Static raster", plotOutput("raster")),
        tabPanel("Interactive browser", displayOutput("widget"))
      )
    )
  )
  
)

server <- function(input, output) {
  
  img <- reactive({
    f <- input$image
    if (is.null(f))
      return(NULL)        
    readImage(f$datapath)
  })
  
  output$widget <- renderDisplay({
    req(img())
    display(img())
  })
  
  output$raster <- renderPlot({
    req(img())
    plot(img(), all=TRUE)
  })
  
}

# Run the application
shinyApp(ui = ui, server = server)
