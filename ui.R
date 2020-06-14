library(shiny)
library(shinyjs)
library(shinyBS)
library(shinydashboard)
library(boastUtils)
library(shinyDND)




shinyUI(
  dashboardPage(
  skin = "yellow",
  
  dashboardHeader(
    titleWidth = 250,
    title = "Descriptive Statistics",
    tags$li(
      class = "dropdown",
      tags$a(href = "https://shinyapps.science.psu.edu/",
             icon("home", lib = "font-awesome"))
    )
  ),
  
  dashboardSidebar(
    width = 250,
    sidebarMenu(
      id = 'tabs',
      menuItem("Overview", tabName = "overview", icon = icon("tachometer-alt")),
      menuItem("Game", tabName = "game", icon = icon("gamepad")),
      menuItem("Reference", tabName = "References", icon = icon("leanpub"))
    ),
    #PSU logo on bottom on the sidebar
    tags$div(class = "sidebar-logo",
             boastUtils::psu_eberly_logo("reversed"))
  ),
  
  #Let`s start with dashboard Body
  dashboardBody(
    #this is important in terms of CSS
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css",
                href = "https://educationshinyappteam.github.io/Style_Guide/theme/boast.css"),
    ),
    
    #Let`s work on tabs
    tabItems(
      ##First tab - Overview
      tabItem(
        tabName = "overview",

        h1("Descriptive Statistics"),
        p("This App is designed to help you better understand the concept of Descriptive Statistics"),
        
        h2("Levels"),
        tags$ol(
          p("Level1: Match the distribution to mean & median."),
          p("Level2: Match the distribution to mean & standard deviation."),
          p("Level3: Match histogram to boxplot."),
          p("Level4: Match the scatterplot to correlation."),
          p("Level5: Match the application to correlation."),
          p("Level6: Order the correlation from the highest to the lowest.")
        ),
        
        h2("Instructions"),
        tags$ol(
          p("1. You can check time and hint by clicking the icon."),
          p("2. Drag and drop A,B,C,D into the drop box."),
          p("3. Submit your answer only after finishing all the questions."),
          p("4. You will need to click 'Re-attempt' button to try again."),
          p("5. You have to use 'Penalty Box' to correct a wrong answer."),
          p("6. You can stop and check your score any level, once you get every question correct."),
          p("7. You may go to the next level only when you correct any wrong answer.")
        ),
        
        div(
          style = "text-align: center" ,
          bsButton(
            inputId = "start",
            label = "GO!",
            size = "large",
            icon("bolt"),
            style = "warning"
          )
        ),
        
        #Acknowledgement
        br(),
        br(),
        h2("Acknowledgements"),
        p(
          "This app was developed and coded by Sitong Liu and further updated by Zhiliang Zhang,Jiajun Gao and Daehoon Gwak.",
          br(),
          "Special thanks to Caihui Xiao and Yuxin Zhang for help on some programming issues.",
          br(),
          br(),
          br(),
          div(class = "updated", "Last Update: 06/14/2020 by DHG.")
        )
      ),
      
      ##Second tab - Game
      tabItem(
        tabName = "game",
        useShinyjs(), #this is for level tabs. Students can only move to the next level when they finish the previous level. 
        
        #in-line css style guides for Scores, Timer, and score boxes(init, subsequent, total)
        # tags$style(type='text/css', '#scoreA {font-size: 25px; font-weight: bold;font family:Sans-serif; height: 140px}'),
        # tags$style(type='text/css', '#scoreB {font-size: 25px; font-weight: bold;font family:Sans-serif; height: 140px}'),
        # tags$style(type='text/css', '#scoreC {font-size: 25px; font-weight: bold;font family:Sans-serif; height: 140px}'),
        # tags$style(type='text/css', '#scoreD {font-size: 25px; font-weight: bold;font family:Sans-serif; height: 140px}'),
        # tags$style(type='text/css', '#scoreE {font-size: 25px; font-weight: bold;font family:Sans-serif; height: 140px}'),
        # tags$style(type='text/css', '#scoreF {font-size: 25px; font-weight: bold;font family:Sans-serif; height: 140px}'),
        # tags$style(type='text/css', '#scoreG {font-size: 25px; font-weight: bold;font family:Sans-serif; height: 140px}'),
        # 
        # tags$style(type='text/css', '#timer1 {background-color:#2C3E50; font-size: 30px;
        #                 color:white;font-weight: bold;font family:Sans-serif;text-align: center; border-radius: 100px}'),
        # tags$style(type='text/css', '#timer2 {background-color:#2C3E50; font-size: 30px;
        #                 color:white;font-weight: bold;font family:Sans-serif;text-align: center; border-radius: 100px}'),
        # tags$style(type='text/css', '#timer3 {background-color:#2C3E50; font-size: 30px;
        #                 color:white;font-weight: bold;font family:Sans-serif;text-align: center; border-radius: 100px}'),
        # tags$style(type='text/css', '#timer4 {background-color:#2C3E50; font-size: 30px;
        #                 color:white;font-weight: bold;font family:Sans-serif;text-align: center; border-radius: 100px}'),
        # tags$style(type='text/css', '#timer5 {background-color:#2C3E50; font-size: 30px;
        #                 color:white;font-weight: bold;font family:Sans-serif;text-align: center; border-radius: 100px}'),
        # tags$style(type='text/css', '#timer6 {background-color:#2C3E50; font-size: 30px;
        #                 color:white;font-weight: bold;font family:Sans-serif;text-align: center; border-radius: 100px}'),
        # tags$style(type='text/css', '#timer7 {background-color:#2C3E50; font-size: 30px; Zzl19970
        #                 color:white;font-weight: bold;font family:Sans-serif;text-align: center; border-radius: 100px}'),
        # tags$style(type='text/css', '#timer8 {background-color:#2C3E50; font-size: 30px;
        #                 color:white;font-weight: bold;font family:Sans-serif;text-align: center; border-radius: 100px}'),
        # 
        # tags$style(type='text/css', '#init {background-color:#2C3E50; font-size: 30px;
        #                 color:white;font-weight: bold;font family:Sans-serif;text-align: center}'),
        # tags$style(type='text/css', '#subsequent {background-color:#2C3E50; font-size: 30px;
        #                 color:white;font-weight: bold;font family:Sans-serif;text-align: center}'),
        # tags$style(type='text/css', '#totalScore {background-color:#2C3E50; font-size: 30px;
        #                 color:white;font-weight: bold;font family:Sans-serif;text-align: center}'),
        
        
        tabsetPanel(id = "navMain", #id for this tabsetPanel
          
          ###First page - Level 1
          tabPanel(title = "Level 1", value = "a",
            fluidPage(
              # theme = "bootstrap.css",  #css theme
              # tags$head(
              #   tags$link(rel = "stylesheet", type = "text/css", href = "themestyle.css")
              # ), #link to your own css file
              
              ##First row - title of this level
              fluidRow(
                column(10, h2( "Level 1: Mean & Median"))
                ),
              
              ##Second row - hint & timer button and details
              fluidRow(
                column(3,
                  bsButton(
                    'bq1',
                    '',
                    icon = icon('question', class = "iconq fa-fw"),
                    type = 'toggle',
                    value = FALSE,
                    class = 'butt',
                    size = "large"
                  ),
                  bsButton(
                    'bt1',
                    '',
                    icon = icon('time', lib = 'glyphicon', class = "icont fa-fw"),
                    type = 'toggle',
                    value = FALSE,
                    class = 'butt',
                    size = "large"
                  )
                ),
                column(6, conditionalPanel("input.bq1 != 0",
                                           id = 'hint1q', textOutput('hint1'))),
                column(3, conditionalPanel("input.bt1 != 0",
                                   id = 'timer1h', textOutput('timer1'))
                )
              ),
              br(),
              
              conditionalPanel("input.start != 0", #Show everything only after the GO button is clicked
                fluidPage(checkboxInput("details", "Show more details", FALSE)),
                
                ##Third row - text boxes
                fluidRow(
                  wellPanel(
                    h3('A', style = "text-align:center;"),
                    dragUI("img1", "A", style = "width: 120px; height: 23px;"),
                    class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", h2(textOutput('text1'))),
                    
                    conditionalPanel("input.details != 0 ",
                                     div(style = "text-align:center",
                                         p(textOutput('text11')))),
                    ),
                  
                  wellPanel(
                    h3('B', style = "text-align:center;"),
                    dragUI("img2", "B", style = "width: 120px; height: 23px;"),
                    class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", h2(textOutput('text2'))),
                    
                    conditionalPanel("input.details != 0 ",
                                     div(style = "text-align:center",
                                         p(textOutput('text222')))),
                  ),
                  
                  wellPanel(
                    h3('C', style = "text-align:center;"),
                    dragUI("img3", "C", style = "width: 120px; height: 23px;"),
                    class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", h2(textOutput('text3'))),
                    
                    conditionalPanel("input.details != 0 ",
                                     div(style = "text-align:center",
                                         p(textOutput('text33')))),
                  ),
                  
                  
                  wellPanel(
                    h3('D', style = "text-align:center;"),
                    dragUI("img4", "D", style = "width: 120px; height: 23px;"),
                    class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", h2(textOutput('text4'))),
                    
                    conditionalPanel("input.details != 0 ",
                                     div(style = "text-align:center",
                                         p(textOutput('text44')))),
                  )
                ),
                
                ##Fourth row - drop boxes and images
                fluidRow(
                  wellPanel(
                    dropUI("drp1", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer1")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    uiOutput("image1")
                    
                  ),
                  wellPanel(
                    dropUI("drp2", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer2")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    uiOutput("image2")
                  ),
                  wellPanel(
                    dropUI("drp3", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer3")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    
                    uiOutput("image3")
                  ),
                  wellPanel(
                    dropUI("drp4", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer4")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    uiOutput("image4")
                  )
                ),
                br(),
                
                ##Fifth row - buttons: previous, submit, re-attempt, and next
                fluidRow(
                  column(1, offset = 5,
                         conditionalPanel("(input.drp1!='') & (input.drp2!='') & (input.drp3!='') & (input.drp4!='') ",
                      bsButton(
                        inputId = "submitA",
                        label = "Submit",
                        style = "warning",
                        size = "large"
                      )
                    )
                  ),
                  column(2, offset = 1, 
                         conditionalPanel("input.submitA != 0",
                    bsButton("clearA", "Re-attempt", style = "danger", size = "large")
                  )),
                  column(1, offset = 1,
                    bsButton(
                      inputId = "next1",
                      label = "Next>>",
                      size = "large",
                      disabled = TRUE
                    )
                  )
                ),
                br(),
                
                ##Sixth row - scores and 'stop' button.
                fluidRow(conditionalPanel("input.submitA != 0",
                  wellPanel(
                    htmlOutput("scoreA"),
                    class = "wellTransparent col-lg-12",
                    div(
                      style = "position:absolute; top:2em; right:2em",
                      bsButton(
                        "stop1",
                        "STOP",
                        style = "danger",
                        size = "large",
                        disabled = TRUE
                      )
                    )
                  )
                ))
              ),
              
              ##Last row - Penalty Box
              conditionalPanel("input.clearA != 0",
                               wellPanel(fluidPage(fluidRow(
                                 wellPanel(
                                   p(textOutput("warning1")),
                                   dropUI("home1", class = "dropelement dropelementHome"),
                                   class = "wellTransparent col-lg-12"
                                 )
                               ))))
              )
            ),
          
          ###Second page - Level 2
          tabPanel(title = "Level 2", value = "b",
            fluidPage(
              # theme = "bootstrap.css", #css theme
              # tags$head(
              #   tags$link(rel = "stylesheet", type = "text/css", href = "themestyle.css")
              # ), #link to your own css file
              
              ##First row - title of this level
              fluidRow(
                column(10,h2("Level 2: Mean & Standard Deviation"))
                ),
              
              ##Second row - hint & timer button and details
              fluidRow(
                column(3,
                  bsButton(
                    'bq2',
                    '',
                    icon = icon('question', class = "iconq fa-fw"),
                    type = 'toggle',
                    class = 'butt',
                    size = "large"
                  ),
                  
                  bsButton(
                    'bt2',
                    '',
                    icon = icon('time', lib = 'glyphicon', class = "icont fa-fw"),
                    type = 'toggle',
                    class = 'butt',
                    size = "large"
                  )
                  
                ),
                column(6, conditionalPanel("input.bq2 != 0",
                                           id ='hint2q', textOutput('hint2'))),
                column(
                  3,
                  conditionalPanel("input.bt2 != 0",
                                   id = 'timer2h', textOutput('timer2'))
                )
              ),
              br(),
              
              conditionalPanel("input.next1 != 0", #Show everything only after the next1 button is clicked
                
                ##Third row - text boxes
                fluidRow(
                  wellPanel(
                    h3('A', style = "text-align:center;"),
                    dragUI("img5", "A", style = "width: 120px; height: 23px;")
                    ,
                    class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", h2(textOutput("text5")))
                  ),
                  
                  wellPanel(
                    h3('B', style = "text-align:center;"),
                    dragUI("img6", "B", style = "width: 120px; height: 23px;")
                    ,
                    class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", h2(textOutput("text6")))
                  ),
                  
                  wellPanel(
                    h3('C', style = "text-align:center;"),
                    dragUI("img7", "C", style = "width: 120px; height: 23px;")
                    ,
                    class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", h2(textOutput("text7")))
                  ),
                  
                  wellPanel(
                    h3('D', style = "text-align:center;"),
                    dragUI("img8", "D", style = "width: 120px; height: 23px;")
                    ,
                    class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", h2(textOutput("text8"))),
                    br()
                  )
                ),
                
                ##Fourth row - drop boxes and images
                fluidRow(
                  wellPanel(
                    dropUI("drp5", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer5")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    uiOutput("image5")
                  ),
                  wellPanel(
                    dropUI("drp6", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer6")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    uiOutput("image6")
                  ),
                  wellPanel(
                    dropUI("drp7", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer7")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    uiOutput("image7")
                  ),
                  wellPanel(
                    dropUI("drp8", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer8")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    uiOutput("image8")
                  )
                ),
                br(),
                
                ##Fifth row - buttons: previous, submit, re-attempt, and next
                fluidRow(
                  column(1,
                    bsButton("previous6", "<<Previous", size = "large")
                  ),
                  column(1, offset = 4,
                    conditionalPanel("(input.drp5!='') & (input.drp6!='') & (input.drp7!='') & (input.drp8!='') ",
                      bsButton(
                        inputId = "submitB",
                        label = "Submit",
                        style = "warning",
                        size = "large"
                      )
                    )
                  ),
                  column(2, offset = 1, 
                         conditionalPanel("input.submitB != 0",
                    bsButton("clearB", "Re-attempt", style = "danger", size = "large")
                  )),
                  column(1, offset = 1,
                    bsButton(
                      inputId = "next2",
                      label = "Next>>",
                      size = "large",
                      disabled = TRUE
                    )
                  )
                ),
                br(),
                
                ##Sixth row - scores and 'stop' button.
                fluidRow(conditionalPanel("input.submitB != 0",
                  wellPanel(
                    htmlOutput("scoreB"),
                    class = "wellTransparent col-lg-12",
                    div(
                      style = "position:absolute; top:2em; right:2em",
                      bsButton(
                        "stop2",
                        "STOP",
                        style = "danger",
                        size = "large",
                        disabled = TRUE
                      )
                    )
                  )
                ))
              ),
              
              ##Last row - Penalty Box
              conditionalPanel("input.clearB != 0",
                               wellPanel(fluidPage(fluidRow(
                                 wellPanel(
                                   p(textOutput("warning2")),
                                   dropUI("home1", class = "dropelement dropelementHome"),
                                   class = "wellTransparent col-lg-12"
                                 )
                               ))))
              )
          ),
          
          ###Third page - Leve 3
          tabPanel(title = "Level 3",value = "c",
            fluidPage(
              # theme = "bootstrap.css", #css theme
              # tags$head(
              #   tags$link(rel = "stylesheet", type = "text/css", href = "themestyle.css")
              # ), #link to your own css file
              
              ##First row - title of this level
              fluidRow(
                column(10,h2("Level 3: Histogram & Boxplot"))
                ),
              
              ##Second row - hint & timer button and details
              fluidRow(
                column(3,
                  bsButton(
                    'bq3',
                    '',
                    icon = icon('question', class = "iconq fa-fw"),
                    type = 'toggle',
                    class = 'butt',
                    size = "large"
                  ),
                  
                  bsButton(
                    'bt3',
                    '',
                    icon = icon('time', lib = 'glyphicon', class = "icont fa-fw"),
                    type = 'toggle',
                    class = 'butt',
                    size = "large"
                  )
                ),
                column(6, conditionalPanel("input.bq3 != 0",
                                           id =
                                             'hint3q', textOutput('hint3'))),
                column(
                  3,
                  conditionalPanel("input.bt3 != 0",
                                   id =
                                     'timer3h', textOutput('timer3'))
                )
              ),
              br(),
              
              conditionalPanel("input.next2 != 0", #Show everything only after the next2 button is clicked
                
                ##Third row - text boxes
                fluidRow(
                  wellPanel(
                    h3('A', style = "text-align:center;"),
                    br(),
                    uiOutput("image13"),
                    dragUI("img13", "A", style = "width: 120px; height: 23px;"),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3"
                  ),
                  
                  wellPanel(
                    h3('B', style = "text-align:center;"),
                    br(),
                    uiOutput("image14"),
                    dragUI("img14", "B", style = "width: 120px; height: 23px;"),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3"
                  ),
                  
                  wellPanel(
                    h3('C', style = "text-align:center;"),
                    br(),
                    uiOutput("image15"),
                    dragUI("img15", "C", style = "width: 120px; height: 23px;"),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3"
                  ),
                  
                  wellPanel(
                    h3('D', style = "text-align:center;"),
                    br(),
                    uiOutput("image16"),
                    dragUI("img16", "D", style = "width: 120px; height: 23px;"),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3"
                  )
                ),
                
                ##Fourth row - drop boxes and images
                fluidRow(
                  wellPanel(
                    dropUI("drp13", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer13")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    uiOutput("image17")
                  ),
                  wellPanel(
                    dropUI("drp14", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer14")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    uiOutput("image18")
                  ),
                  wellPanel(
                    dropUI("drp15", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer15")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    uiOutput("image19")
                  ),
                  wellPanel(
                    dropUI("drp16", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer16")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    uiOutput("image20")
                  )
                ),
                br(),
                
                ##Fifth row - buttons: previous, submit, re-attempt, and next
                fluidRow(
                  column(1,
                    bsButton("previous5", "<<Previous", size = "large")
                  ),
                  column(1, offset = 4,
                    conditionalPanel("(input.drp13!='') & (input.drp14!='') & (input.drp15!='') & (input.drp16!='') ",
                      bsButton(
                        inputId = "submitC",
                        label = "Submit",
                        style = "warning",
                        size = "large"
                      )
                    )
                  ),
                  column(2, offset = 1, conditionalPanel(
                    "input.submitC != 0",
                    bsButton("clearC", "Re-attempt", style = "danger", size = "large")
                  )),
                  column(1, offset = 1,
                    bsButton(
                      inputId = "next3",
                      label = "Next>>",
                      size = "large",
                      disabled = TRUE
                    )
                  )
                ),
                br(),
                
                ##Sixth row - scores and 'stop' button.
                fluidRow(conditionalPanel("input.submitC != 0",
                  wellPanel(
                    htmlOutput("scoreC"),
                    class = "wellTransparent col-lg-12",
                    div(
                      style = "position:absolute; top:2em; right:2em",
                      bsButton(
                        "stop3",
                        "STOP",
                        style = "danger",
                        size = "large",
                        disabled = TRUE
                      )
                    )
                  )
                ))
              ),
              
              ##Last row - Penalty Box
              conditionalPanel("input.clearC != 0",
                               wellPanel(fluidPage(fluidRow(
                                 wellPanel(
                                   p(textOutput("warning3")),
                                   dropUI("home1", class = "dropelement dropelementHome"),
                                   class = "wellTransparent col-lg-12"
                                 )
                               ))))
              )
          ),
          
          ###Fourth page - Leve 4
          tabPanel(title = "Level 4",value = "d",
            fluidPage(
              # theme = "bootstrap.css", #css theme
              # tags$head(
              #   tags$link(rel = "stylesheet", type = "text/css", href = "themestyle.css")
              # ), #link to your own css file
              
              ##First row - title of this level
              fluidRow(
                column(10, h2("Level 4: Correlation & Scatterplot"),h3("Watch out for outliers!"))
                ),
              
              ##Second row - hint & timer button and details
              fluidRow(
                column(3,
                  bsButton(
                    'bq4',
                    '',
                    icon = icon('question', class = "iconq fa-fw"),
                    type = 'toggle',
                    class = 'butt',
                    size = "large"
                  ),
                  bsButton(
                    'bt4',
                    '',
                    icon = icon('time', lib = 'glyphicon', class = "icont fa-fw"),
                    type = 'toggle',
                    class = 'butt',
                    size = "large"
                  )
                ),
                column(6, conditionalPanel("input.bq4 != 0",
                                           id ='hint4q', textOutput('hint4'))),
                column(3,
                  conditionalPanel("input.bt4 != 0",
                                   id ='timer4h', textOutput('timer4'))
                )
              ),
              br(),
              
              conditionalPanel("input.next3 != 0", #Show everything only after the next3 button is clicked
                
                ##Third row - text boxes
                fluidRow(
                  wellPanel(
                    h3('A', style = "text-align:center;"),
                    br(),
                    dragUI("img17", "A", style = "width: 120px; height: 23px;"),
                    class = "col-lg-3 col-md-3 wellBorder2",
                    div(style = "text-align:center", h2(textOutput("text17"))),
                    br()
                  ),
                  
                  wellPanel(
                    h3('B', style = "text-align:center;"),
                    br(),
                    dragUI("img18", "B", style = "width: 120px; height: 23px;"),
                    class = "col-lg-3 col-md-3 wellBorder2",
                    div(style = "text-align:center", h2(textOutput("text18"))),
                    br()
                  ),
                  
                  wellPanel(
                    h3('C', style = "text-align:center;"),
                    br(),
                    dragUI("img19", "C", style = "width: 120px; height: 23px;"),
                    class = "col-lg-3 col-md-3 wellBorder2",
                    div(style = "text-align:center", h2(textOutput("text19"))),
                    br()
                  ),
                  
                  wellPanel(
                    h3('D', style = "text-align:center;"),
                    br(),
                    dragUI("img20", "D", style = "width: 120px; height: 23px;"),
                    class = "col-lg-3 col-md-3 wellBorder2",
                    div(style = "text-align:center", h2(textOutput("text20"))),
                    br()
                  ),
                ),
                
                ##Fourth row - drop boxes and images
                fluidRow(
                  wellPanel(
                    dropUI("drp17", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer17")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    uiOutput("image21")
                  ),
                  wellPanel(
                    dropUI("drp18", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer18")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    uiOutput("image22")
                  ),
                  wellPanel(
                    dropUI("drp19", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer19")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    uiOutput("image23")
                  ),
                  wellPanel(
                    dropUI("drp20", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer20")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    uiOutput("image24")
                  )
                ),
                br(),
                
                ##Fifth row - buttons: previous, submit, re-attempt, and next
                fluidRow(
                  column(1,
                    bsButton("previous4", "<<Previous", size = "large")
                  ),
                  column(1, offset = 4,
                    conditionalPanel("(input.drp17!='') & (input.drp18!='') & (input.drp19!='') & (input.drp20!='') ",
                      bsButton(
                        inputId = "submitD",
                        label = "Submit",
                        style = "warning",
                        size = "large"
                      )
                    )
                  ),
                  column(2, offset = 1, conditionalPanel("input.submitD != 0",
                    bsButton("clearD", "Re-attempt", style = "danger", size = "large")
                  )),
                  column(1, offset = 1,
                    bsButton(
                      inputId = "next4",
                      label = "Next>>",
                      size = "large",
                      disabled = TRUE
                    )
                  )
                ),
                br(),
                
                ##Sixth row - scores and 'stop' button.
                fluidRow(conditionalPanel("input.submitD != 0",
                  wellPanel(
                    htmlOutput("scoreD"),
                    class = "wellTransparent col-lg-12",
                    div(
                      style = "position:absolute; top:2em; right:2em",
                      bsButton(
                        "stop4",
                        "STOP",
                        style = "danger",
                        size = "large",
                        disabled = TRUE
                      )
                    )
                  )
                ))
              ),
              
              ##Last row - Penalty Box
              conditionalPanel("input.clearD != 0",
                               wellPanel(fluidPage(fluidRow(
                                 wellPanel(
                                   p(textOutput("warning4")),
                                   dropUI("home1", class = "dropelement dropelementHome"),
                                   class = "wellTransparent col-lg-12"
                                 )
                               ))))
              )
          ),
          
          ###Fifth page - Leve 5
          tabPanel(title = "Level 5",value = "e",
            fluidPage(
              # theme = "bootstrap.css", #css theme
              # tags$head(
              #   tags$link(rel = "stylesheet", type = "text/css", href = "themestyle.css")
              # ), #link to your own css file
              
              ##First row - title of this level
              fluidRow(
                column(10, h2("Level 5 : Distribution Application"))
                ),
              
              ##Second row - hint & timer button and details
              fluidRow(
                column(3,
                  bsButton(
                    'bq5',
                    '',
                    icon = icon('question', class = "iconq fa-fw"),
                    type = 'toggle',
                    class = 'butt',
                    size = "large"
                  ),
                  bsButton(
                    'bt5',
                    '',
                    icon = icon('time', lib = 'glyphicon', class = "icont fa-fw"),
                    type = 'toggle',
                    class = 'butt',
                    size = "large"
                  )
                ),
                column(6, conditionalPanel("input.bq5 != 0",
                                           id = 'hint5q', textOutput('hint5'))),
                column(3,
                  conditionalPanel("input.bt5 != 0",
                                   id = 'timer5h', textOutput('timer5'))
                )
              ),
              br(),
              
              conditionalPanel("input.next4 != 0", #Show everything only after the next4 button is clicked
                  
                ##Third row - text boxes             
                fluidRow(
                  wellPanel(
                    h3('A', style = "text-align:center;"),
                    dragUI("img21", "A", style = "width: 120px; height: 23px;"),
                    class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", h3(textOutput("text21")))
                  ),
                  
                  wellPanel(
                    h3('B', style = "text-align:center;"),
                    dragUI("img22", "B", style = "width: 120px; height: 23px;")
                    ,
                    class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", h3(textOutput("text22")))
                  ),
                  
                  wellPanel(
                    h3('C', style = "text-align:center;"),
                    dragUI("img23", "C", style = "width: 120px; height: 23px;")
                    ,
                    class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", h3(textOutput("text23")))
                  ),
                  
                  wellPanel(
                    h3('D', style = "text-align:center;"),
                    dragUI("img24", "D", style = "width: 120px; height: 23px;")
                    ,
                    class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", h3(textOutput("text24")))
                  ),
                ),
                
                ##Fourth row - drop boxes and images
                fluidRow(
                  wellPanel(
                    dropUI("drp21", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer21")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    img(
                      src = "symmetric.PNG",
                      height = 250,
                      class = "col-lg-15 col-md-12"
                    )
                  ),
                  wellPanel(
                    dropUI("drp22", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer22")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    img(
                      src = "right-skewed.PNG",
                      height = 250,
                      class = "col-lg-15 col-md-12"
                    )
                  ),
                  wellPanel(
                    dropUI("drp23", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer23")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    img(
                      src = "left-skewed.PNG",
                      height = 250,
                      class = "col-lg-15 col-md-12"
                    )
                  ),
                  wellPanel(
                    dropUI("drp24", class = "dropelement"),
                    div(style = "position:absolute;top: 4%;right:2%;", htmlOutput("answer24")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(),
                    img(
                      src = "bimodal.PNG",
                      height = 250,
                      class = "col-lg-15 col-md-12"
                    )
                  )
                ),
                br(),
                
                ##Fifth row - buttons: previous, submit, re-attempt, and next
                fluidRow(
                  column(1,
                    bsButton("previous3", "<<Previous", size = "large")
                  ),
                  column(1, offset = 4,
                    conditionalPanel("(input.drp21!='') & (input.drp22!='') & (input.drp23!='') & (input.drp24!='') ",
                      bsButton(
                        inputId = "submitE",
                        label = "Submit",
                        style = "warning",
                        size = "large"
                      )
                    )
                  ),
                  column(2, offset = 1, 
                         conditionalPanel("input.submitE != 0",
                    bsButton("clearE", "Re-attempt", style = "danger", size = "large")
                  )),
                  column(1, offset = 1,
                    bsButton(
                      inputId = "next5",
                      label = "Next>>",
                      size = "large",
                      disabled = TRUE
                    )
                  )
                ),
                br(),
                
                ##Sixth row - scores and 'stop' button.
                fluidRow(conditionalPanel("input.submitE != 0",
                  wellPanel(
                    htmlOutput("scoreE"),
                    class = "wellTransparent col-lg-12",
                    div(
                      style = "position:absolute; top:2em; right:2em",
                      bsButton(
                        "stop5",
                        "STOP",
                        style = "danger",
                        size = "large",
                        disabled = TRUE
                      )
                    )
                  )
                ))
              ),
              
              ##Last row - Penalty Box
              conditionalPanel("input.clearE != 0",
                               wellPanel(fluidPage(fluidRow(
                                 wellPanel(
                                   p(textOutput("warning5")),
                                   dropUI("home1", class = "dropelement dropelementHome"),
                                   class = "wellTransparent col-lg-12"
                                 )
                               ))))
              )
          ),
          
          ###Sixth page - Leve 6
          tabPanel(title = "Level 6",value = "f",
            fluidPage(
              # theme = "bootstrap.css",  #css theme
              # tags$head(
              #   tags$link(rel = "stylesheet", type = "text/css", href = "themestyle.css")
              # ), #link to your own css file
              
              ##First row - title of this level
              fluidRow(
                column(10,h2("Level 6: Correlation & Application"), h3('Order the correlation from the highest to the lowest.'))
                ),
              
              ##Second row - hint & timer button and details
              fluidRow(
                column(3,
                  bsButton(
                    'bq6',
                    '',
                    icon = icon('question', class = "iconq fa-fw"),
                    type = 'toggle',
                    class = 'butt',
                    size = "large"
                  ),
                  bsButton(
                    'bt6',
                    '',
                    icon = icon('time', lib = 'glyphicon', class = "icont fa-fw"),
                    type = 'toggle',
                    class = 'butt',
                    size = "large"
                  )
                ),
                column(6, conditionalPanel("input.bq6 != 0",
                                           id ='hint6q', textOutput('hint6'))),
                column(3,
                  conditionalPanel("input.bt6 != 0",
                                   id ='timer6h', textOutput('timer6'))
                )
              ),
              br(),
              
              conditionalPanel("input.next5 != 0", #Show everything only after the next5 button is clicked
                
                ##Third row - text boxes
                fluidRow(
                  wellPanel(
                    h3('A', style = "text-align:center;"),
                    dragUI("img25", "A", style = "width: 120px; height: 23px;"),
                    class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", h3(textOutput("text25")))
                  ),
                  
                  wellPanel(
                    h3('B', style = "text-align:center;"),
                    dragUI("img26", "B", style = "width: 120px; height: 23px;"),
                    class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", h3(textOutput("text26")))
                  ),
                  
                  wellPanel(
                    h3('C', style = "text-align:center;"),
                    dragUI("img27", "C", style = "width: 120px; height: 23px;"),
                    class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", h3(textOutput("text27")))
                  ),
                  
                  wellPanel(
                    h3('D', style = "text-align:center;"),
                    dragUI("img28", "D", style = "width: 120px; height: 23px;"),
                    class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", h3(textOutput("text28")))
                  ),
                ),
                
                ##Fourth row - drop boxes and images
                fluidRow(
                  wellPanel(
                    h3("highest:"),
                    dropUI("drp25", class = "dropelement"),
                    div(style = "position:absolute;top: 63%;right:2%;", htmlOutput("answer25")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br()
                  ),
                  wellPanel(
                    br(),
                    br(),
                    br(),
                    dropUI("drp26", class = "dropelement"),
                    div(style = "position:absolute;top: 63%;right:2%;", htmlOutput("answer26")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br()
                  ),
                  wellPanel(
                    br(),
                    br(),
                    br(),
                    dropUI("drp27", class = "dropelement"),
                    div(style = "position:absolute;top: 63%;right:2%;", htmlOutput("answer27")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br()
                  ),
                  wellPanel(
                    h3("lowest:"),
                    dropUI("drp28", class = "dropelement"),
                    div(style = "position:absolute;top: 63%;right:2%;", htmlOutput("answer28")),
                    class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br()
                  )
                ),
                br(),
                
                ##Fifth row - buttons: previous, submit, re-attempt, and next
                fluidRow(
                  column(1,
                    bsButton("previous2", "<<Previous", size = "large")
                  ),
                  column(1, offset = 4,
                    conditionalPanel("(input.drp25!='') & (input.drp26!='') & (input.drp27!='') & (input.drp28!='') ",
                      bsButton(
                        inputId = "submitF",
                        label = "Submit Answer",
                        style = "warning",
                        size = "large"
                      )
                    )
                  ),
                  column(2, offset = 1,
                         conditionalPanel("input.submitF != 0",
                    bsButton("clearF", "Re-attempt", style = "danger", size = "large")
                  )),
                  column(1, offset = 1,
                    bsButton(
                      inputId = "finish",
                      label = "FINISH>>",
                      disabled = TRUE,
                      size = "large"
                    )
                  )
                ),
                br(),
                
                ##Sixth row - scores and 'stop' button.
                fluidRow(conditionalPanel("input.submitF != 0",
                  wellPanel(
                    htmlOutput("scoreF"),
                    class = "wellTransparent col-lg-12"
                  )
                ))
              ),
              
              ##Last row - Penalty Box
              conditionalPanel("input.clearF != 0",
                               wellPanel(fluidPage(fluidRow(
                                 wellPanel(
                                   p(textOutput("warning6")),
                                   dropUI("home1", class = "dropelement dropelementHome"),
                                   class = "wellTransparent col-lg-12"
                                 )
                               ))))
              )
          ),
          
          ###Last page - Scores
          tabPanel(title = "Score", value = "g",
            h1("Congratulations! You finished the game."),
            fluidRow(column(3, offset = 9, textOutput("timer8"))),
            br(),
            br(),
            fluidPage(
              fluidRow(h3("Your scores:")),
              fluidRow(
                wellPanel(verbatimTextOutput("init"), class = "wellScore col-lg-4 col-md-6 col-sm-12"),
                wellPanel(verbatimTextOutput("subsequent"), class = "wellScore col-lg-4 col-md-6 col-sm-12"),
                wellPanel(verbatimTextOutput("totalScore"), class = "wellScore col-lg-4 col-md-6 col-sm-12")
              ),
              br(),
              #            fluidRow(
              #              wellPanel(
              #                wellPanel(textInput("name",p("Please type in your initials or nickname to submit the score:"),placeholder = "Initials",width = 600),class = "col-lg-8 col-md-9 col-sm-10 col-xs-9"),
              #                wellPanel(div(style = "position:absolute; top:60px",bsButton("check","Submit",style = "warning",size = "large")),class = "col-lg-2 col-md-2 col-sm-1 col-xs-1"),style = "height:200px")
              #            ),
              #           # htmlOutput("badge"),
              #            conditionalPanel("input.check >-1", dataTableOutput("highscore")),
              #            actionButton("weekhigh", "Show Weekly High Scores"),
              #            actionButton("totalhigh", "Show All-Time High Scores")
              #
            )
          )
          #############################################################################################
        )
      ),
      
      tabItem(
        tabName = "References",
        withMathJax(),
        h2("References"),
        p(
          #shinyjs
          class = "hangingindent",
          "Attali, D. (2020), Easily Improve the User Experience of Your Shiny Apps in Seconds.
            (v1.1), [R package]. Available from
            https://cran.r-project.org/web/packages/shinyjs/shinyjs.pdf"
        ),
        p(
          #shinyBS
          class = "hangingindent",
          "Bailey, E. (2015), shinyBS: Twitter bootstrap components for shiny.
            (v0.61), [R package]. Available from
            https://CRAN.R-project.org/package=shinyBS"
        ),
        p(
          #Boast Utilities
          class = "hangingindent",
          "Carey, R. (2019), boastUtils: BOAST Utilities. (v0.1.0),
            [R Package]. Available from
            https://github.com/EducationShinyAppTeam/boastUtils"
        ),
        p(
          #shinydashboard
          class = "hangingindent",
          "Chang, W. and Borges Ribeio, B. (2018), shinydashboard: Create
            dashboards with 'Shiny'. (v0.7.1), [R Package]. Available from
            https://CRAN.R-project.org/package=shinydashboard"
        ),
        p(
          #shiny
          class = "hangingindent",
          "Chang, W., Cheng, J., Allaire, J., Xie, Y., and McPherson, J.
            (2019), shiny: Web application framework for R. (v1.4.0),
            [R Package]. Available from https://CRAN.R-project.org/package=shiny"
        ),
        p(
          #shinyDND
          class = "hangingindent",
          "Hoffer, A. (2016), shinyDND: Shiny Drag-n-Drop. (v0.1.0),
            [R Package]. Available from
            https://cran.r-project.org/web/packages/shinyDND/index.html"
        )
      )
    )
  )
))
