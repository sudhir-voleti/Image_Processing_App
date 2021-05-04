library(shiny)
library(stringi)
library(shinycssloaders)
options(shiny.maxRequestSize=10*1024^2)

shinyUI(fluidPage(
 # headerPanel("Image Analysis App"),
  title = "Image Analysis App",
  titlePanel(title=div(img(src="logo.png",align='right'),"Image Analysis App")),
  sidebarPanel(
    
    ## conditionalPanel() functions for selected tab
    conditionalPanel(condition="input.tabselected==1",
                     fileInput(inputId = "file",label = h6("Upload Image"),multiple = FALSE,accept = "image/*"),
                     p("-------OR-------"),
                     textInput("url", label = h6("Enter Image URL"), value = "https://ww2.kqed.org/app/uploads/sites/12/2015/04/the-avengers.jpg"),
                     sliderInput("Rb", label = h6("Brightness (Red)"),min = -100, max = 100, value = 0),
                     sliderInput("Gb", label = h6("Brightness (Green)"),min = -100, max = 100, value = 0),
                     sliderInput("Bb", label = h6("Brightness (Blue)"),min = -100, max = 100, value = 0),
                     sliderInput("Rc", label = h6("Contrast (Red)"),min = 0, max = 200, value = 100),
                     sliderInput("Gc", label = h6("Contrast (Green)"),min = 0, max = 200, value = 100),
                     sliderInput("Bc", label = h6("Contrast (Blue)"),min = 0, max = 200, value = 100),
                     sliderInput("Rg", label = h6("Gamma Correction (Red)"),min = -10, max = 10, value = 1),
                     sliderInput("Gg", label = h6("Gamma Correction (Green)"),min = -10, max = 10, value = 1),
                     sliderInput("Bg", label = h6("Gamma Correction (Blue)"),min = -10, max = 10, value = 1)
                     
                     ),
    
    conditionalPanel(condition="input.tabselected==2",
                     checkboxGroupInput("flip",label = h6("Flip"), choices = list("Flip Image" = 1, "Flip Red" = 2, "Flip Green" = 3, "Flip Blue" = 4)),
                     checkboxGroupInput("flop",label = h6("Flop"), choices = list("Flop Image" = 1,"Flop Red" = 2, "Flop Green" = 3, "Flop Blue" = 4)),
                     numericInput("rot", label = h6("Rotation Angle"), value = 0),
                     numericInput("transx", label = h6("X Translate"), value = 0),
                     numericInput("transy", label = h6("Y Translate"), value = 0),
                     checkboxGroupInput("channel", label = h6("Channel"), choices = list("RGB" = 1,"Grey" = 2, "Red" = 3, "Green" = 4, "Blue" = 5))
                     
                     
    ),
    
    conditionalPanel(condition="input.tabselected==3",
                     sliderInput("lps", label = h6("Low-Pass Filter size"),min = 1, max = 50, value = 21),
                     sliderInput("hps", label = h6("High-Pass Filter size"),min = 1, max = 20, value = 10),
                     checkboxGroupInput("filt",label = h6("Filter Type"), choices = list("Low-Pass Filter" = 1, "High-Pass Filter" = 2))           
                     
                     
    ),
    conditionalPanel(condition="input.tabselected==4",
                     sliderInput("mm", label = h6("Magnitude"),min = 1, max = 50, value = 21),                              
                     checkboxGroupInput("morph",label = h6("Morphological Operators"), choices = list("Erode" = 1, "Dilate" = 2))            
                     
                     
    ),
    
    conditionalPanel(condition="input.tabselected==5",
                     sliderInput("pix",label = h6("Super Pixels"),min=200,max=800,value=600,step = 10)
    ),
    conditionalPanel(condition = "input.tabselected==6",
                    
    ),
    
  ),
  mainPanel(
    # recommend review the syntax for tabsetPanel() & tabPanel() for better understanding
    # id argument is important in the tabsetPanel()
    # value argument is important in the tabPanle()
    tabsetPanel(
      tabPanel("Overview", value=1, 
      
               ),
      tabPanel("Basic Operations", value=1, 
               textOutput("text"),
               imageOutput("img"),
               hr(),
               checkboxGroupInput("Save0", label = h6(""), choices = list("Save"=1)),
               downloadButton(outputId = "dn_1",label = "Download")
               
               ),
      tabPanel("Spatial Operations & Color", value=2, 
               imageOutput("img2"),
               hr(),
               checkboxGroupInput("Save", label = h6(""), choices = list("Save"=1)),
               downloadButton(outputId = "dn_2",label = "Download")
               ), 
      tabPanel("Image Filtering",value=3,
               imageOutput("img3"),
               hr(),
               checkboxGroupInput("Save1", label = h6(""), choices = list("Save"=1)),
               downloadButton(outputId = "dn_3",label = "Download")
               ),
      tabPanel("Morphing",value=4,
               imageOutput("img4"),
               hr(),
               checkboxGroupInput("Save2", label = h6(""), choices = list("Save"=1)),
               downloadButton(outputId = "dn_4",label = "Download")
               
               ),
      tabPanel("Avatarize",value=5,
               imageOutput("img5"),
               hr(),
               downloadButton(outputId = "dn_5",label = "Download")
               
               ),
      tabPanel("Gradient",value=6,
               plotOutput("img_6"),
               #downloadButton(outputId = "dn_6",label = "Download")
               ),
      id = "tabselected"
    )
  )
))
