library(shiny)
library(shinyjs)
library(shinyBS)
library(shinydashboard)
library(boastUtils)
library(shinyDND) # for drag and drop
library(shinyWidgets)
#Let`s begin
shinyUI(
  ## App Meta Data-------------------------------------------------------------
  # APP_TITLE  <<- "Descriptive Statistics",
  # APP_DESCP  <<- paste(
  #  "Description of the app",
  #  "This app is designed for the game app, which is to help user better 
  #  understand the concept of Descriptive Statistics."
  # ),
  ## End App Meta Data---------------------------------------------------------
  dashboardPage(
  skin = "yellow", 
  dashboardHeader(
    titleWidth = 250, 
    title = "Descriptive Statistics", 
    tags$li(class = "dropdown", 
            actionLink("info",icon("info",class = "myClass"))), 
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
      menuItem("References", tabName = "References", icon = icon("leanpub"))
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
      tags$link(rel = "stylesheet", type = "text/css",
                href = "https://educationshinyappteam.github.io/Style_Guide/theme/dragStyleYellow.css")
    ), 
    #Let`s work on tabs
    tabItems(
      ##First tab - Overview
      tabItem(
        tabName = "overview", 
        h1("Descriptive Statistics"), 
        p("This app is designed to help you better understand concepts
          of Descriptive Statistics."), 
        br(), 
        h2("Levels"), 
        tags$ul(
          tags$li("Level 1: Match the mean & median to the histogram"), 
          tags$li("Level 2: Match the mean & standard deviation
                  to the density curve"), 
          tags$li("Level 3: Match the boxplot to the histogram"), 
          tags$li("Level 4: Match the correlation to the scatterplot"), 
          tags$li("Level 5: Match the application to the density curve"), 
          tags$li("Level 6: Order the correlation from the highest
                  to the lowest.")
        ), 
        h2("Instructions"), 
        tags$ol(
          tags$li("You can check time and get hints by clicking the boxes"), 
          tags$li("Drag and drop A, B, C, and D into the appropriate drop boxes."), 
          tags$li("Submit your answer only after finishing all the questions."), 
          tags$li("You will need to click 'Reattempt' button to try again."), 
          tags$li("You have to use 'Penalty Box' to correct a wrong answer."), 
          tags$li("You can stop and check your score at any level,
                  once you get every question correct."), 
          tags$li("You may go to the next level only when you correct
                  any wrong answer.")
        ), 
        br(), 
        div(
          style = "text-align: center", 
          bsButton(
            inputId = "start", 
            label = "GO!", 
            size = "large", 
            icon = icon("bolt"), 
            style = "warning"
          )
        ), 
        #Acknowledgement
        br(), 
        br(), 
        h2("Acknowledgements"), 
        p(
          "This app was originally developed and coded by Sitong Liu.
          The app was further updated by Zhiliang Zhang and Jiajun Gao 
          in June 2018 and Daehoon Gwak in July 2020.
          Special thanks to Caihui Xiao and Yuxin Zhang for help
          on some programming issues.", 
          br(), 
          br(), 
          br(), 
          div(class = "updated", "Last Update: 07/24/2020 by DG.")
        )
      ), 
      ##Second tab - Game
      tabItem(
        tabName = "game", 
        # useShinyjs() is for level tabs. Students can only move to
        # the next level when they finish the previous level.
        useShinyjs(), 
        tabsetPanel(id = "navMain", #id for this tabsetPanel
          ###First page - Level 1
          tabPanel(title = "Level 1", value = "a", 
            fluidPage(
              # theme = "bootstrap.css",  #css theme
              # tags$head(
              #   tags$link(rel = "stylesheet", type = "text/css",
              # href = "themestyle.css")
              # ), #link to your own css file
              ##First row - title of this level
              fluidRow(
                column(width = 10, h2( "Level 1: Mean & Median"))
                ), 
              ##Second row - hint & timer button and details
              fluidRow(
                column(width = 3, 
                  bsButton(
                    inputId = 'bq1', 
                    label = 'Hint', 
                    #icon = icon('question', class = "iconq fa-fw"),
                    type = 'toggle', 
                    value = FALSE, 
                    size = "large"
                  ), 
                  bsButton(
                    inputId = 'bt1', 
                    label = 'Timer', 
                    #icon = icon('time', lib = 'glyphicon', class = "icont fa-fw"),
                    type = 'toggle', 
                    value = FALSE, 
                    size = "large"
                  )
                ), 
                column(width = 6, conditionalPanel("input.bq1 != 0", 
                                           id = 'hint1q', textOutput('hint1'))), 
                column(width = 3, conditionalPanel("input.bt1 != 0", 
                                   id = 'timer1h', textOutput('timer1'))
                )
              ), 
              br(), 
              fluidRow(checkboxInput(inputId = "details", 
                                  label =  "Show more details",value =  FALSE)), 
                ##Third row - text boxes(Upper boxes)
                fluidRow(
                  column(width = 3, 
                    h3('A', align = 'center'),  # Fixed static label
                    #class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", 
                     p(textOutput('text1'))),  # The values of statistics/picture
                    conditionalPanel("input.details != 0 ", 
                                     div(style = "text-align:center", 
                                         p(textOutput('text11')))), 
                    # The dragable element
                    dragUI("drag1", "A", style = "width: 90%") 
                    ), 
                  column(width = 3, 
                    h3('B', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", p(textOutput('text2'))), 
                    conditionalPanel("input.details != 0 ", 
                                     div(style = "text-align:center", 
                                         p(textOutput('text222')))), 
                    dragUI("drag2", "B", style = "width: 90%")
                    ), 
                  column(width = 3, 
                    h3('C', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", p(textOutput('text3'))), 
                    conditionalPanel("input.details != 0 ", 
                                     div(style = "text-align:center", 
                                         p(textOutput('text33')))), 
                    dragUI("drag3", "C", style = "width: 90%")
                    ), 
                  column(width = 3,
                    h3('D', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", p(textOutput('text4'))), 
                    conditionalPanel("input.details != 0 ", 
                                     div(style = "text-align:center", 
                                         p(textOutput('text44')))), 
                    dragUI("drag4", "D", style = "width: 90%")
                    )
                ), 
                br(), 
                ##Fourth row - drop boxes and images(lower boxes)
                fluidRow(
                  column(width = 3, 
                    dropUI("drp1", style = "width: 100%"),  # drop zone
                    div(align = "right", uiOutput("answer1")),  # answer mark
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(), 
                    uiOutput("image1") # data visualization
                  ), 
                  column(width = 3, 
                    dropUI("drp2", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer2")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(), 
                    uiOutput("image2")
                  ), 
                  column(width = 3, 
                    dropUI("drp3", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer3")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(), 
                    uiOutput("image3")
                  ), 
                  column(width = 3, 
                    dropUI("drp4", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer4")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(), 
                    uiOutput("image4")
                  )
                ), 
                br(), 
                ##Fifth row - buttons: previous, submit, Reattempt, and next
                fluidRow(
                  column(width = 1, offset = 5, 
                         conditionalPanel("(input.drp1!='') & (input.drp2!='')
                                        & (input.drp3!='') & (input.drp4!='') ", 
                      bsButton(
                        inputId = "submitA", 
                        label = "Submit", 
                        style = "warning", 
                        size = "large"
                      )
                    )
                  ), 
                  column(width = 2, offset = 1, 
                         conditionalPanel("input.submitA != 0", 
                    bsButton(inputId = "clearA",label =  "Reattempt", 
                             style = "danger", size = "large")
                  )), 
                  column(width = 1, offset = 1, 
                    bsButton(
                      inputId = "next1", 
                      label = "Next >>", 
                      size = "large", 
                      disabled = TRUE
                    )
                  )
                ), 
                br(), 
                ##Sixth row - scores and 'stop' button.
                fluidRow(
                  conditionalPanel("input.submitA != 0", 
                  wellPanel(style = "background-color:white", 
                  #column(12,
                    htmlOutput("scoreA"), 
                    #class = "wellTransparent col-lg-12",
                    div(
                      align = 'right', 
                      #style = "position:absolute; top:2em; right:2em",
                      bsButton(
                        inputId = "stop1", 
                        label = "STOP", 
                        style = "danger", 
                        size = "large", 
                        disabled = TRUE
                      )
                    )
                  )
                )), 
              ##Last row - Penalty Box
              conditionalPanel("input.clearA != 0", 
                               fluidRow(
                                 column(width = 12, 
                                   p(textOutput("warning1")), 
                                   dropUI("home", style = "width: 100%;
                                          height: 200px;"), 
                                   br()
                                   #class = "wellTransparent col-lg-12"
                                 )
                               ))
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
                column(width = 10, h2("Level 2: Mean & Standard Deviation"))
                ), 
              ##Second row - hint & timer button and details
              fluidRow(
                column(width = 3, 
                  bsButton(
                    inputId = 'bq2', 
                    label = 'Hint', 
                    #icon = icon('question', class = "iconq fa-fw"),
                    type = 'toggle', 
                    class = 'butt', 
                    size = "large"
                  ), 
                  bsButton(
                    inputId = 'bt2', 
                    label = 'Timer', 
                    #icon = icon('time', lib = 'glyphicon', class = "icont fa-fw"),
                    type = 'toggle', 
                    class = 'butt', 
                    size = "large"
                  )
                ), 
                column(width = 6, conditionalPanel("input.bq2 != 0", 
                                           id ='hint2q', textOutput('hint2'))), 
                column(
                  width = 3, 
                  conditionalPanel("input.bt2 != 0", 
                                   id = 'timer2h', textOutput('timer2'))
                )
              ), 
              br(), 
              #Show everything only after the next1 button is clicked
              conditionalPanel("input.next1 != 0", 
                ##Third row - text boxes
                fluidRow(
                  column(width = 3, 
                    h3('A', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", p(textOutput("text5"))), 
                    dragUI("drag5", "A", style = "width: 90%")
                  ), 
                  column(width = 3, 
                    h3('B', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", p(textOutput("text6"))), 
                    dragUI("drag6", "B", style = "width: 90%")
                  ), 
                  column(width = 3, 
                    h3('C', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", p(textOutput("text7"))), 
                    dragUI("drag7", "C", style = "width: 90%")
                  ), 
                  column(width = 3, 
                    h3('D', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", p(textOutput("text8"))), 
                    dragUI("drag8", "D", style = "width: 90%")
                  )
                ), 
                br(), 
                ##Fourth row - drop boxes and imagess
                fluidRow(
                  column(width = 3, 
                    dropUI("drp5", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer5")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(), 
                    uiOutput("image5")
                  ), 
                  column(width = 3, 
                    dropUI("drp6", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer6")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(), 
                    uiOutput("image6")
                  ), 
                  column(width = 3, 
                    dropUI("drp7", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer7")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(), 
                    uiOutput("image7")
                  ), 
                  column(width = 3, 
                    dropUI("drp8", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer8")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(), 
                    uiOutput("image8")
                  )
                ), 
                br(), 
                ##Fifth row - buttons: previous, submit, Reattempt, and next
                fluidRow(
                  column(width = 1, 
                    bsButton(inputId = "previous6",label =  "<< Previous", 
                             size = "large")
                  ), 
                  column(width = 1, offset = 4, 
                    conditionalPanel("(input.drp5!='') & (input.drp6!='')
                                     & (input.drp7!='') & (input.drp8!='') ", 
                      bsButton(
                        inputId = "submitB", 
                        label = "Submit", 
                        style = "warning", 
                        size = "large"
                      )
                    )
                  ), 
                  column(width = 2, offset = 1,  
                         conditionalPanel("input.submitB != 0", 
                    bsButton(inputId = "clearB",label =  "Reattempt", 
                             style = "danger", size = "large")
                  )), 
                  column(width = 1, offset = 1, 
                    bsButton(
                      inputId = "next2", 
                      label = "Next >>", 
                      size = "large", 
                      disabled = TRUE
                    )
                  )
                ), 
                br(), 
                ##Sixth row - scores and 'stop' button.
                fluidRow(conditionalPanel("input.submitB != 0", 
                  wellPanel(style = "background-color:white", 
                    htmlOutput("scoreB"), 
                    #class = "wellTransparent col-lg-12",
                    div(
                      align = 'right', 
                      #style = "position:absolute; top:2em; right:2em",
                      bsButton(
                        inputId = "stop2", 
                        label = "STOP", 
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
                               fluidRow(
                                 column(width = 12, 
                                   p(textOutput("warning2")), 
                                   dropUI("home", style = "width: 100%;
                                          height: 200px;"), 
                                   br()
                                   #class = "wellTransparent col-lg-12"
                                 )
                               ))
              )
          ), 
          ###Third page - Level 3
          tabPanel(title = "Level 3",value = "c", 
            fluidPage(
              # theme = "bootstrap.css", #css theme
              # tags$head(
              #   tags$link(rel = "stylesheet", type = "text/css", href = "themestyle.css")
              # ), #link to your own css file
              ##First row - title of this level
              fluidRow(
                column(width = 10, h2("Level 3: Histogram & Boxplot"))
                ), 
              ##Second row - hint & timer button and details
              fluidRow(
                column(width = 3, 
                  bsButton(
                    inputId = 'bq3', 
                    label = 'Hint', 
                    #icon = icon('question', class = "iconq fa-fw"),
                    type = 'toggle', 
                    class = 'butt', 
                    size = "large"
                  ), 
                  bsButton(
                    inputId = 'bt3', 
                    label = 'Timer', 
                    #icon = icon('time', lib = 'glyphicon', class = "icont fa-fw"),
                    type = 'toggle', 
                    class = 'butt', 
                    size = "large"
                  )
                ), 
                column(width = 6, conditionalPanel("input.bq3 != 0", 
                                           id ='hint3q', textOutput('hint3'))), 
                column(width = 3, 
                  conditionalPanel("input.bt3 != 0", 
                                   id ='timer3h', textOutput('timer3'))
                )
              ), 
              br(), 
              #Show everything only after the next2 button is clicked
              conditionalPanel("input.next2 != 0", 
                ##Third row - text boxes
                fluidRow(
                  column(width = 3, 
                    h3('A', align = 'center'), 
                    uiOutput("boxplot1"), 
                    dragUI("drag9", "A", style = "width: 90%"), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3"
                  ), 
                  column(width = 3, 
                    h3('B', align = 'center'), 
                    uiOutput("boxplot2"), 
                    dragUI("drag10", "B", style = "width: 90%"), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3"
                  ), 
                  column(width = 3, 
                    h3('C', align = 'center'), 
                    uiOutput("boxplot3"), 
                    dragUI("drag11", "C", style = "width: 90%"), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3"
                  ), 
                  column(width = 3, 
                    h3('D', align = 'center'), 
                    uiOutput("boxplot4"), 
                    dragUI("drag12", "D", style = "width: 90%"), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3"
                  )
                ), 
                br(), 
                ##Fourth row - drop boxes and images
                fluidRow(
                  column(width = 3, 
                    dropUI("drp9", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer9")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(), 
                    uiOutput("image9")
                  ), 
                  column(width = 3, 
                    dropUI("drp10", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer10")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(), 
                    uiOutput("image10")
                  ), 
                  column(width = 3, 
                    dropUI("drp11", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer11")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(), 
                    uiOutput("image11")
                  ), 
                  column(width = 3, 
                    dropUI("drp12", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer12")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(), 
                    uiOutput("image12")
                  )
                ), 
                br(), 
                ##Fifth row - buttons: previous, submit, Reattempt, and next
                fluidRow(
                  column(width = 1, 
                    bsButton(inputId = "previous5",label =  "<< Previous", 
                             size = "large")
                  ), 
                  column(width = 1, offset = 4, 
                    conditionalPanel("(input.drp9!='') & (input.drp10!='')
                                     & (input.drp11!='') & (input.drp12!='') ", 
                      bsButton(
                        inputId = "submitC", 
                        label = "Submit", 
                        style = "warning", 
                        size = "large"
                      )
                    )
                  ), 
                  column(width = 2, offset = 1, conditionalPanel(
                    "input.submitC != 0", 
                    bsButton(inputId = "clearC",label =  "Reattempt", 
                             style = "danger", size = "large")
                  )), 
                  column(width = 1, offset = 1, 
                    bsButton(
                      inputId = "next3", 
                      label = "Next >>", 
                      size = "large", 
                      disabled = TRUE
                    )
                  )
                ), 
                br(), 
                ##Sixth row - scores and 'stop' button.
                fluidRow(conditionalPanel("input.submitC != 0", 
                  wellPanel(style = "background-color:white", 
                    htmlOutput("scoreC"), 
                    #class = "wellTransparent col-lg-12",
                    div(
                      align = 'right', 
                      #style = "position:absolute; top:2em; right:2em",
                      bsButton(
                        inputId = "stop3", 
                        label = "STOP", 
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
                               fluidRow(
                                 column(width = 12, 
                                   p(textOutput("warning3")), 
                                   dropUI("home",  
                                        style = "width: 100%; height: 200px;"), 
                                   br()
                                   #class = "wellTransparent col-lg-12"
                                 )
                               ))
              )
          ), 
          ###Fourth page - Level 4
          tabPanel(title = "Level 4",value = "d", 
            fluidPage(
              # theme = "bootstrap.css", #css theme
              # tags$head(
              #   tags$link(rel = "stylesheet",
              # type = "text/css", href = "themestyle.css")
              # ), #link to your own css file
              ##First row - title of this level
              fluidRow(
                column(width = 10, h2("Level 4: Correlation & Scatterplot"),  
                       h3("Watch out for outliers!"))
                ), 
              ##Second row - hint & timer button and details
              fluidRow(
                column(width = 3, 
                  bsButton(
                    inputId = 'bq4', 
                    label = 'Hint', 
                    #icon = icon('question', class = "iconq fa-fw"),
                    type = 'toggle', 
                    class = 'butt', 
                    size = "large"
                  ), 
                  bsButton(
                    inputId = 'bt4', 
                    label = 'Timer', 
                    #icon = icon('time', lib = 'glyphicon', class = "icont fa-fw"),
                    type = 'toggle', 
                    class = 'butt', 
                    size = "large"
                  )
                ), 
                column(width = 6, conditionalPanel("input.bq4 != 0", 
                                           id ='hint4q', textOutput('hint4'))), 
                column(width = 3, 
                  conditionalPanel("input.bt4 != 0", 
                                   id ='timer4h', textOutput('timer4'))
                )
              ), 
              br(), 
              #Show everything only after the next3 button is clicked
              conditionalPanel("input.next3 != 0", 
                ##Third row - text boxes
                fluidRow(
                  column(width = 3, 
                    h3('A', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder2",
                    div(style = "text-align:center", p(textOutput("text13"))), 
                    dragUI("drag13", "A", style = "width: 90%")
                  ), 
                  column(width = 3, 
                    h3('B', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder2",
                    div(style = "text-align:center", p(textOutput("text14"))), 
                    dragUI("drag14", "B", style = "width: 90%")
                  ), 
                  column(width = 3, 
                    h3('C', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder2",
                    div(style = "text-align:center", p(textOutput("text15"))), 
                    dragUI("drag15", "C", style = "width: 90%")
                  ), 
                  column(width = 3, 
                    h3('D', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder2",
                    div(style = "text-align:center", p(textOutput("text16"))), 
                    dragUI("drag16", "D", style = "width: 90%")
                  )
                ), 
                br(), 
                ##Fourth row - drop boxes and images
                fluidRow(
                  column(width = 3, 
                    dropUI("drp13", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer13")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(), 
                    uiOutput("image13")
                  ), 
                  column(width = 3, 
                    dropUI("drp14", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer14")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(), 
                    uiOutput("image14")
                  ), 
                  column(width = 3, 
                    dropUI("drp15", style = "width: 100%"),
                    div(align = "right", uiOutput("answer15")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(), 
                    uiOutput("image15")
                  ), 
                  column(width = 3, 
                    dropUI("drp16", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer16")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(), 
                    uiOutput("image16")
                  )
                ), 
                br(), 
                ##Fifth row - buttons: previous, submit, Reattempt, and next
                fluidRow(
                  column(width = 1, 
                    bsButton(inputId = "previous4",label =  "<< Previous", 
                             size = "large")
                  ), 
                  column(width = 1, offset = 4, 
                    conditionalPanel("(input.drp13!='') & (input.drp14!='') 
                                     & (input.drp15!='') & (input.drp16!='') ", 
                      bsButton(
                        inputId = "submitD", 
                        label = "Submit", 
                        style = "warning", 
                        size = "large"
                      )
                    )
                  ), 
                  column(width = 2, offset = 1, 
                         conditionalPanel("input.submitD != 0", 
                    bsButton(inputId = "clearD",label =  "Reattempt", 
                             style = "danger", size = "large")
                  )), 
                  column(width = 1, offset = 1, 
                    bsButton(
                      inputId = "next4", 
                      label = "Next >>", 
                      size = "large", 
                      disabled = TRUE
                    )
                  )
                ), 
                br(), 
                ##Sixth row - scores and 'stop' button.
                fluidRow(conditionalPanel("input.submitD != 0", 
                  wellPanel(style = "background-color:white", 
                    htmlOutput("scoreD"), 
                    #class = "wellTransparent col-lg-12",
                    div(
                      align = 'right', 
                      #style = "position:absolute; top:2em; right:2em",
                      bsButton(
                        inputId = "stop4", 
                        label = "STOP", 
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
                               fluidRow(
                                 column(width = 12, 
                                   p(textOutput("warning4")), 
                                   dropUI("home", style = "width: 100%;
                                          height: 200px;"),
                                   br()
                                   #class = "wellTransparent col-lg-12"
                                 )
                               ))
              )
          ), 
          ###Fifth page - Level 5
          tabPanel(title = "Level 5",value = "e", 
            fluidPage(
              # theme = "bootstrap.css", #css theme
              # tags$head(
              #   tags$link(rel = "stylesheet", type = "text/css", href = "themestyle.css")
              # ), #link to your own css file
              ##First row - title of this level
              fluidRow(
                column(width = 10, h2("Level 5 : Distribution Application"))
                ), 
              ##Second row - hint & timer button and details
              fluidRow(
                column(width = 3, 
                  bsButton(
                    inputId = 'bq5', 
                    label = 'Hint', 
                    #icon = icon('question', class = "iconq fa-fw"),
                    type = 'toggle', 
                    class = 'butt', 
                    size = "large"
                  ), 
                  bsButton(
                    inputId = 'bt5', 
                    label = 'Timer', 
                    #icon = icon('time', lib = 'glyphicon', class = "icont fa-fw"),
                    type = 'toggle', 
                    class = 'butt', 
                    size = "large"
                  )
                ), 
                column(width = 6, conditionalPanel("input.bq5 != 0", 
                                           id = 'hint5q', textOutput('hint5'))), 
                column(width = 3, 
                  conditionalPanel("input.bt5 != 0", 
                                   id = 'timer5h', textOutput('timer5'))
                )
              ), 
              br(), 
              #Show everything only after the next4 button is clicked
              conditionalPanel("input.next4 != 0", 
                ##Third row - text boxes             
                fluidRow(
                  column(width = 3, 
                    h3('A', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", p(textOutput("text17"))), 
                    dragUI("drag17", "A", style = "width: 90%")
                  ), 
                  column(width = 3, 
                    h3('B', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder", 
                    div(style = "text-align:center", p(textOutput("text18"))), 
                    dragUI("drag18", "B", style = "width: 90%")
                  ), 
                  column(width = 3,
                    h3('C', align = 'center'),
                    #class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", p(textOutput("text19"))),
                    dragUI("drag19", "C", style = "width: 90%")
                  ), 
                  column(width = 3, 
                    h3('D', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder",
                    div(style = "text-align:center", p(textOutput("text20"))), 
                    dragUI("drag20", "D", style = "width: 90%")
                  )
                ), 
                br(), 
                ##Fourth row - drop boxes and images
                fluidRow(
                  column(width = 3, 
                    dropUI("drp17", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer17")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3", 
                    br(), 
                    uiOutput("image17")
                  ), 
                  column(width = 3, 
                    dropUI("drp18", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer18")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                    br(), 
                    uiOutput("image18")
                  ), 
                  column(width = 3, 
                    dropUI("drp19", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer19")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3", 
                    br(), 
                    uiOutput("image19")
                  ), 
                  column(width = 3, 
                    dropUI("drp20", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer20")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3", 
                    br(), 
                    uiOutput("image20")
                  )
                ), 
                br(), 
                ##Fifth row - buttons: previous, submit, Reattempt, and next
                fluidRow(
                  column(width = 1, 
                    bsButton(inputId = "previous3",label =  "<< Previous", 
                             size = "large")
                  ), 
                  column(width = 1, offset = 4, 
                    conditionalPanel("(input.drp17!='') & (input.drp18!='')
                                     & (input.drp19!='') & (input.drp20!='') ", 
                      bsButton(
                        inputId = "submitE", 
                        label = "Submit", 
                        style = "warning", 
                        size = "large"
                      )
                    )
                  ), 
                  column(width = 2, offset = 1, 
                         conditionalPanel("input.submitE != 0", 
                    bsButton(inputId = "clearE",label =  "Reattempt", 
                             style = "danger", size = "large")
                  )), 
                  column(width = 1, offset = 1, 
                    bsButton(
                      inputId = "next5", 
                      label = "Next >>", 
                      size = "large", 
                      disabled = TRUE
                    )
                  )
                ), 
                br(), 
                ##Sixth row - scores and 'stop' button.
                fluidRow(conditionalPanel("input.submitE != 0", 
                  wellPanel(style = "background-color:white", 
                    htmlOutput("scoreE"), 
                    #class = "wellTransparent col-lg-12",
                    div(
                      align = 'right', 
                      #style = "position:absolute; top:2em; right:2em",
                      bsButton(
                        inputId = "stop5", 
                        label = "STOP", 
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
                               fluidRow(
                                 column(width = 12, 
                                   p(textOutput("warning5")), 
                                   dropUI("home", style = "width: 100%;
                                          height: 200px;"), 
                                   br()
                                   #class = "wellTransparent col-lg-12"
                                 )
                               ))
              )
          ), 
          ###Sixth page - Level 6
          tabPanel(title = "Level 6",value = "f", 
            fluidPage(
              # theme = "bootstrap.css",  #css theme
              # tags$head(
              #   tags$link(rel = "stylesheet", type = "text/css", href = "themestyle.css")
              # ), #link to your own css file
              ##First row - title of this level
              fluidRow(
                column(width = 10, h2("Level 6: Correlation & Application"), 
                   h3('Order the correlation from the highest to the lowest.'))
                ), 
              ##Second row - hint & timer button and details
              fluidRow(
                column(width = 3, 
                  bsButton(
                    inputId = 'bq6', 
                    label = 'Hint', 
                    #icon = icon('question', class = "iconq fa-fw"), 
                    type = 'toggle', 
                    class = 'butt', 
                    size = "large"
                  ), 
                  bsButton(
                    inputId = 'bt6', 
                    label = 'Timer', 
                    #icon = icon('time', lib = 'glyphicon', class = "icont fa-fw"), 
                    type = 'toggle', 
                    class = 'butt', 
                    size = "large"
                  )
                ), 
                column(width = 6, conditionalPanel("input.bq6 != 0", 
                                           id ='hint6q', textOutput('hint6'))), 
                column(width = 3, 
                  conditionalPanel("input.bt6 != 0", 
                                   id ='timer6h', textOutput('timer6'))
                )
              ), 
              br(), 
              conditionalPanel("input.next5 != 0",  #Show everything only after the next5 button is clicked
                ##Third row - text boxes
                fluidRow(
                  column(width = 3, 
                    h3('A', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder", 
                    div(style = "text-align:center", p(textOutput("text21"))), 
                    dragUI("drag21", "A", style = "width: 90%")
                  ), 
                  column(width = 3, 
                    h3('B', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder", 
                    div(style = "text-align:center", p(textOutput("text22"))), 
                    dragUI("drag22", "B", style = "width: 90%")
                  ), 
                  column(width = 3, 
                    h3('C', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder", 
                    div(style = "text-align:center", p(textOutput("text23"))), 
                    dragUI("drag23", "C", style = "width: 90%")
                  ), 
                  column(width = 3, 
                    h3('D', align = 'center'), 
                    #class = "col-lg-3 col-md-3 wellBorder", 
                    div(style = "text-align:center", p(textOutput("text24"))), 
                    dragUI("drag24", "D", style = "width: 90%")
                  )
                ), 
                br(), 
                ##Fourth row - drop boxes and images
                fluidRow(
                  column(width = 3, 
                    dropUI("drp21", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer21")), 
                    h3("highest")
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3", 
                  ), 
                  column(width = 3, 
                    dropUI("drp22", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer22")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3", 
                  ), 
                  column(width = 3, 
                    dropUI("drp23", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer23")), 
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3", 
                  ), 
                  column(width = 3, 
                    dropUI("drp24", style = "width: 100%"), 
                    div(align = "right", uiOutput("answer24")), 
                    h3("lowest", align = 'right')
                    #class = "wellTransparent col-sm-12 col-md-6 col-lg-3", 
                  )
                ), 
                br(), 
                ##Fifth row - buttons: previous, submit, Reattempt, and next
                fluidRow(
                  column(width = 1, 
                    bsButton(inputId = "previous2",label =  "<< Previous", 
                             size = "large")
                  ), 
                  column(width = 1, offset = 4, 
                    conditionalPanel("(input.drp21!='') & (input.drp22!='')
                                     & (input.drp23!='') & (input.drp24!='') ", 
                      bsButton(
                        inputId = "submitF", 
                        label = "Submit", 
                        style = "warning", 
                        size = "large"
                      )
                    )
                  ), 
                  column(width = 2, offset = 1, 
                         conditionalPanel("input.submitF != 0", 
                    bsButton(inputId = "clearF",label =  "Reattempt", 
                             style = "danger", size = "large")
                  )), 
                  column(width = 1, offset = 1, 
                    bsButton(
                      inputId = "finish", 
                      label = "FINISH >>", 
                      disabled = TRUE, 
                      size = "large"
                    )
                  )
                ), 
                br(), 
                ##Sixth row - scores and 'stop' button.
                fluidRow(conditionalPanel("input.submitF != 0", 
                  wellPanel(style = "background-color:white", 
                    htmlOutput("scoreF")
                    #class = "wellTransparent col-lg-12"
                  )
                ))
              ), 
              ##Last row - Penalty Box
              conditionalPanel("input.clearF != 0", 
                               fluidRow(
                                 column(width = 12, 
                                   p(textOutput("warning6")), 
                                   dropUI("home", style = "width: 100%;
                                          height: 200px;"), 
                                   br()
                                   #class = "wellTransparent col-lg-12"
                                 )
                               ))
              )
          ),
          ###Last page - Scores
          tabPanel(title = "Score", value = "g", 
            h2("Congratulations! You finished the game."), 
            fluidRow(column(width = 3, offset = 9, 
                            tags$strong(textOutput("timer8")))), 
            br(), 
            br(), 
            h3("Your scores:"), br(), 
            column(width = 4,textOutput("init")), 
            #class = "wellScore col-lg-4 col-md-6 col-sm-12"
            column(width = 4,textOutput("subsequent")), 
            #class = "wellScore col-lg-4 col-md-6 col-sm-12"
            column(width = 4,textOutput("totalScore")) 
            #class = "wellScore col-lg-4 col-md-6 col-sm-12"
            )
          )
      ), 
      tabItem(
        tabName = "References", 
        h2("References"), 
        p(
          #shinyjs
          class = "hangingindent", 
          "Attali, D. (2020), Easily Improve the User Experience of 
          Your Shiny Apps in Seconds, R package. Available from
            https://cran.r-project.org/web/packages/shinyjs/shinyjs.pdf"
        ), 
        p(
          #shinyBS
          class = "hangingindent", 
          "Bailey, E. (2015), shinyBS: Twitter bootstrap components for shiny, 
           R package. Available from
            https://CRAN.R-project.org/package=shinyBS"
        ), 
        p(
          #Boast Utilities
          class = "hangingindent", 
          "Carey, R. (2019), boastUtils: BOAST Utilities, 
            R Package. Available from
            https://github.com/EducationShinyAppTeam/boastUtils"
        ), 
        p(
          #shinydashboard
          class = "hangingindent", 
          "Chang, W. and Borges Ribeio, B. (2018), shinydashboard: Create
            dashboards with 'Shiny', R Package. Available from
            https://CRAN.R-project.org/package=shinydashboard"
        ), 
        p(
          #shiny
          class = "hangingindent", 
          "Chang, W., Cheng, J., Allaire, J., Xie, Y., and McPherson, J.
           (2019), shiny: Web application framework for R, R Package. 
           Available from https://CRAN.R-project.org/package=shiny"
        ), 
        p(
          #shinyDND
          class = "hangingindent", 
          "Hoffer, A. (2016), shinyDND: Shiny Drag-n-Drop, R Package.
           Available from
            https://cran.r-project.org/web/packages/shinyDND/index.html"
        ), 
        p(     #shinyWidgets
          class = "hangingindent", 
          "Perrier, V., Meyer, F., Granjon, D., Fellows, I., and Davis, W.
            (2020), shinyWidgets: Custom Inputs Widgets for Shiny, R package.
            Available from
            https://cran.r-project.org/web/packages/shinyWidgets/index.html"
        )
      )
    )
  )
))
