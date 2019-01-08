library(shiny)
library(shinyDND)
library(shinyjs)
library(shinyBS)
library(V8)
library(discrimARTs)
library(RUnit)
library(grid)



shinyUI(
  tagList(
    useShinyjs(),
  navbarPage(title = "Descriptive Statistics",id = "navMain", #Give an id to use the updateNavPage() later
             tabPanel(title = "Home",value = "a", ##Give a value to use the updateNavPage() later
                      fluidPage(
                        tags$style(type='text/css', '#scoreA {font-size: 25px; font-weight: bold;font family:Sans-serif; height: 140px}'),
                        tags$style(type='text/css', '#scoreB {font-size: 25px; font-weight: bold;font family:Sans-serif; height: 140px}'),
                        tags$style(type='text/css', '#scoreC {font-size: 25px; font-weight: bold;font family:Sans-serif; height: 140px}'),
                        tags$style(type='text/css', '#scoreD {font-size: 25px; font-weight: bold;font family:Sans-serif; height: 140px}'),
                        tags$style(type='text/css', '#scoreE {font-size: 25px; font-weight: bold;font family:Sans-serif; height: 140px}'),
                        tags$style(type='text/css', '#scoreF {font-size: 25px; font-weight: bold;font family:Sans-serif; height: 140px}'),
                        tags$style(type='text/css', '#scoreG {font-size: 25px; font-weight: bold;font family:Sans-serif; height: 140px}'),

                        tags$style(type='text/css', '#timer1 {background-color:#2C3E50; font-size: 30px; 
                                   color:white;font-weight: bold;font family:Sans-serif;text-align: center; border-radius: 100px}'),
                        tags$style(type='text/css', '#timer2 {background-color:#2C3E50; font-size: 30px; 
                                   color:white;font-weight: bold;font family:Sans-serif;text-align: center; border-radius: 100px}'),
                        tags$style(type='text/css', '#timer3 {background-color:#2C3E50; font-size: 30px; 
                                   color:white;font-weight: bold;font family:Sans-serif;text-align: center; border-radius: 100px}'),
                        tags$style(type='text/css', '#timer4 {background-color:#2C3E50; font-size: 30px; 
                                   color:white;font-weight: bold;font family:Sans-serif;text-align: center; border-radius: 100px}'),
                        tags$style(type='text/css', '#timer5 {background-color:#2C3E50; font-size: 30px; 
                                   color:white;font-weight: bold;font family:Sans-serif;text-align: center; border-radius: 100px}'),
                        tags$style(type='text/css', '#timer6 {background-color:#2C3E50; font-size: 30px; 
                                   color:white;font-weight: bold;font family:Sans-serif;text-align: center; border-radius: 100px}'),
                        tags$style(type='text/css', '#timer7 {background-color:#2C3E50; font-size: 30px; Zzl19970
                                   color:white;font-weight: bold;font family:Sans-serif;text-align: center; border-radius: 100px}'),
                        tags$style(type='text/css', '#timer8 {background-color:#2C3E50; font-size: 30px;
                                   color:white;font-weight: bold;font family:Sans-serif;text-align: center; border-radius: 100px}'),
  
                        
                        wellPanel(
                        
                          # fluidRow(column(1, img(src = "psu.PNG", width = 70)),
                          #   column(11, div(style = "text-align:center",h2("Matching Game of Descriptive Statistics")))),

                            tags$a(href='http://stat.psu.edu/',   tags$img(src='logo.png', align = "left", width = 180)),
                            br(),br(),br(),
                            h3(strong("About:")),
                            h4("There are 6 levels in the game:"),
                            h4(tags$li("Level 1: Match the distribution to mean & median.")),
                            h4(tags$li("Level 2 :Match the distribution to mean & standard deviation.")),
                            h4(tags$li("Level 3: Match histogram to boxplot.")), 
                            h4(tags$li("Level 4: Match the scatterplot to correlation.")),
                            h4(tags$li("Level 5: Match the application to correlation.")), 
                            h4(tags$li("Level 6: Order the correlation from the highest to the lowest.")),
                            br(),
                            h3(strong("Instructions:")),
                            h4(tags$li("Click GO! button to start the game.")), 
                      h4(tags$li("Submit your answer only after finishing all the questions.")), 
                      h4(tags$li("You may go to the next level only when you correct any wrong answer.")),
                      h4(tags$li("You have to use 'Penalty Box' to correct a wrong answer.")),
                      # h4(tags$li("The score you get after the first trial and the revised score you get after 
                      #  correcting any wrong answer will be weighted to generate your final score.
                      #    Keep in mind that both the final score and consumed time will determine whether you will be on the leaderboard!")),

                      div(style = "text-align: center" ,bsButton("go", "G O !", icon("bolt"),size = "medium", style = "warning")),
                      br(),
                      h3(strong("Acknowledgements:")),
                          h4("This app was developed and coded by Sitong Liu and further updated by Zhiliang Zhang and Jiajun Gao.",
                            
                             " Special thanks to Caihui Xiao and Yuxin Zhang for help on some programming issues."))
                      
                          )                                   
                          ),
             
             tabPanel("Level 1",value = "b"
                      ,
                       fluidPage(
                                 # theme = "bootstrap.css", #css theme
                                 # tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "themestyle.css")), #link to your own css file
                                 fluidRow(
                           #        column(1, img(src = "psu.PNG", width = 70)),
                                   column(10,
                                     h2("Level 1: Mean & Median")
                                   )
                                 ),
                                 fluidRow(
                                   column(3, 
                                          div(style="display: inline-block;vertical-align:top;",
                                              tags$a(href='https://shinyapps.science.psu.edu/',tags$img(src='homebut.PNG', width = 30))
                                          ),
                                          bsButton('bq1', '',icon = icon('question',class = "iconq fa-fw"),type = 'toggle', value = FALSE, class = 'butt'),
                                          bsButton('bt1', '',icon = icon('time', lib = 'glyphicon',class = "icont fa-fw"),type = 'toggle',value = FALSE, class = 'butt')
                                          #bsButton('reset1','',icon = icon('info', class = "iconq fa-fw"), type = 'toggle', value = FALSE, class = 'butt')
                                   ),
                                   #column(6, hidden(div(id='hint1q', textOutput('hint1')))),
                                   column(6, conditionalPanel("input.bq1 != 0",
                                                              id='hint1q', textOutput('hint1'))),
                                   column(3,
                                          hidden(div(id='timer1h',textOutput("timer1"))
                                          ))),br(),
                      
                      
                                conditionalPanel("input.go != 0", #Show everything only after the GO button is clicked
                      fluidPage(
                       # checkboxGroupInput(inputId="details", label = "", choices=list("Show more details"))
                        checkboxInput("details", "Show more details", FALSE)
                      ),
                                                 fluidRow(wellPanel(
                                                   br(),
                                                   dragUI("img1","A", style = "width: 120px; height: 23px;")
                                                   ,class = "col-lg-3 col-md-3 wellBorder",
                                                                 div(style = "text-align:center",
                      
                                                                     h2(textOutput('text1'))),
                                                   conditionalPanel("input.details != 0 ", 
                                                   div(style = "text-align:center",

                                                       h4(textOutput('text11')))),
                                                                     br(),
                                                                      br()
                                                                    ),
                      
                                                           wellPanel(
                                                             br(),
                                                             dragUI("img2","B", style = "width: 120px; height: 23px;")
                                                                     ,class = "col-lg-3 col-md-3 wellBorder",
                                                             
                                                            
                                                             div(style = "text-align:center", h2(textOutput('text2'))),
                                                             conditionalPanel("input.details != 0 ", 
                                                                              div(style = "text-align:center",
                                                                                  
                                                                                  h4(textOutput('text222')))),
                                                                     br()
                                                                     
                                                                  ),
                                                           wellPanel(
                                                             br(),
                                                             dragUI("img3","C", style = "width: 120px; height: 23px;")
                                                                     ,class = "col-lg-3 col-md-3 wellBorder",
                                                            
                                                             div(style = "text-align:center", h2(textOutput('text3'))),
                                                             conditionalPanel("input.details != 0 ", 
                                                                              div(style = "text-align:center",
                                                                                  
                                                                                  h4(textOutput('text33')))),
                                                                   br()
                                                                   
                                                                    ),
                                                           wellPanel(
                                                             br(),
                                                             dragUI("img4","D", style = "width: 120px; height: 23px;")
                                                                     ,class = "col-lg-3 col-md-3 wellBorder",
                                                            
                                                             div(style = "text-align:center", h2(textOutput('text4'))),
                                                             conditionalPanel("input.details != 0 ", 
                                                                              div(style = "text-align:center",
                                                                                  
                                                                                  h4(textOutput('text44')))),
                                                                     br()
                                                                     )),
                                                  fluidRow(
                                                    fluidRow(
                                                      wellPanel(dropUI("drp1", class = "dropelement"),
                                                                 div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer1")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br(),
                                                                uiOutput("image1")
                      
                                                                ),
                                                      wellPanel(dropUI("drp2", class = "dropelement"),
                                                                 div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer2")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br(),
                    
                                                                uiOutput("image2")
                                                                ),
                                                      wellPanel(dropUI("drp3", class = "dropelement"),
                                                                 div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer3")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                              br(),
                      
                                                               uiOutput("image3")
                                                                ),
                                                      wellPanel(dropUI("drp4", class = "dropelement"),
                                                                 div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer4")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br(),
                                                                uiOutput("image4")
                      
                                                                )
                                                    )
                                                  ),br(),
                      
                                                 fluidRow(
                                                                     column(1,bsButton("previous7","<<Previous", style = "primary",size = "small")),
                                                                     column(1,offset = 4, conditionalPanel("(input.drp1!='') & (input.drp2!='') & (input.drp3!='') & (input.drp4!='') "
                                                                                                           ,bsButton("submitA", "Submit Answer", style = "primary",size = "small",class = "grow"))),
                                                                     column(1,offset = 5,bsButton("next1","Next>>",style = "primary", size = "small", disabled = TRUE))
                                                                   ),br()
                                                                     ),
                      
                                                  conditionalPanel("input.submitA != 0",wellPanel(
                                                    fluidPage(
                                                      fluidRow(
                                                        wellPanel(
                                                         
                                                          # div(style = "position:absolute; bottom;200em; left:1em",
                                                               #h4("Please drag the wrong answers into this PENALTY box and click the CLEAR button to restart.")
                                                               h4(textOutput("warning1")
                                                                  #)
                                                               ),
                                                           
                                                          dropUI("home1",class = "dropelement dropelementHome"),
                                                           
                                                           div(style = "position:absolute; top:11em; right:2em",bsButton("clearA","CLEAR",style = "danger")),class = "wellTransparent col-lg-8"
                                                          ),
                                                        wellPanel(h4("Full score is 8 for level 1."),
                                                                  verbatimTextOutput("scoreA"),class = "wellTransparent col-lg-4")
                                                      )
                                                    )
                                                  ))
                      
                      
                                )
                      ),
             
             tabPanel("Level 2",value = "c"
                      ,
                       fluidPage(theme = "bootstrap.css", #css theme
                                 tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "themestyle.css")), #link to your own css file
                                 fluidRow(
                                   #column(1, img(src = "psu.PNG", width = 70)),
                                   column(10,
                                          h2("Level 2: Mean & Standard Deviation")
                                   )
                                 )
                                 ,
                                 fluidRow(
                                   column(3,
                                          div(style="display: inline-block;vertical-align:top;",
                                              tags$a(href='https://shinyapps.science.psu.edu/',tags$img(src='homebut.PNG', width = 30))
                                          ),
                                          bsButton('bq2', '',icon = icon('question',class = "iconq fa-fw"),type = 'toggle', class = 'butt'),
                                          
                                          bsButton('bt2', '',icon = icon('time', lib = 'glyphicon',class = "icont fa-fw"),type = 'toggle', class = 'butt')
                                          
                                   ),
                                   #column(6, hidden(div(id='hint2q', textOutput('hint2')))),
                                   column(6, conditionalPanel("input.bq2 != 0",
                                                              id='hint2q', textOutput('hint2'))),
                                   column(3,
                                          hidden(div(id='timer2h',textOutput("timer2"))
                                          ))),br(),
                                 
                                 conditionalPanel("input.next1 != 0", #Show everything only after the GO button is clicked
                                                  
                                                  fluidRow(wellPanel(
                                                    br(),
                                                  dragUI("img5","A", style = "width: 120px; height: 23px;")
                                                    ,class = "col-lg-3 col-md-3 wellBorder",
                                                    div(style = "text-align:center", h2(textOutput("text5"))),
                                                    br()
                                                    
                                                   ),
                                                    
                                                    wellPanel(
                                                      br(),
                                                    dragUI("img6","B", style = "width: 120px; height: 23px;")
                                                      ,class = "col-lg-3 col-md-3 wellBorder",
                                                      div(style = "text-align:center", h2(textOutput("text6"))),
                                                      br()
                                                      ),
                                                    wellPanel(
                                                      br(),
                                                     dragUI("img7","C", style = "width: 120px; height: 23px;")
                                                      ,class = "col-lg-3 col-md-3 wellBorder",
                                                      div(style = "text-align:center", h2(textOutput("text7"))),
                                                      br()
                                                      ),
                                                    wellPanel(
                                                      br(),
                                                     dragUI("img8","D", style = "width: 120px; height: 23px;")
                                                      ,class = "col-lg-3 col-md-3 wellBorder",
                                                      div(style = "text-align:center", h2(textOutput("text8"))),
                                                      br()
                                                      )),
                                                  fluidRow(
                                                    fluidRow(
                                                      wellPanel(dropUI("drp5", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer5")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br(),
                                                                #img(src = questionD[questionD[1] == "mean1",3], class = "col-lg-15 col-md-12")
                                                                uiOutput("image5")
                                                                ),
                                                      wellPanel(dropUI("drp6", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer6")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                               br(),
                                                                #img(src = questionD[questionD[1] == "mean2",3], class = "col-lg-15 col-md-12")
                                                                uiOutput("image6")
                                                                ),
                                                      wellPanel(dropUI("drp7", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer7")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br(),
                                                                #img(src = questionD[questionD[1] == "mean3",3], class = "col-lg-15 col-md-12")
                                                                uiOutput("image7")
                                                               ),
                                                      wellPanel(dropUI("drp8", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer8")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br(),
                                                               # img(src = questionD[questionD[1] == "mean4",3], class = "col-lg-15 col-md-12")
                                                               uiOutput("image8")
                                                                )
                                                    )
                                                  ),br(),
                                                  
                                                  fluidRow(
                                                 column(1,bsButton("previous6","<<Previous", style = "primary",size = "small")),
                                                  column(1,offset = 4, conditionalPanel("(input.drp5!='') & (input.drp6!='') & (input.drp7!='') & (input.drp8!='') "
                                                                                          ,bsButton("submitB", "Submit Answer", style = "primary",size = "small",class = "grow"))),
                                                    column(1,offset = 5,bsButton("next2","Next>>",style = "primary", size = "small", disabled = TRUE))
                                                  ),br()
                                 ),
                                 
                                 conditionalPanel("input.submitB != 0",wellPanel(
                                   fluidPage(
                                     fluidRow(
                                      wellPanel(
                                         #div(style = "position:absolute; top;50em; left:1em",
                                             #h4("Please drag the wrong answers into this PENALTY box and click the CLEAR button to restart.")
                                             h4(textOutput("warning2"))
                                             #)
                                             ,
                                         dropUI("home2",class = "dropelement dropelementHome"),
                                         div(style = "position:absolute; top:11em; right:2em",bsButton("clearB","CLEAR",style = "danger")),class = "wellTransparent col-lg-8"),
                                       wellPanel(h4("Full score is 8 for level 2."),
                                                 verbatimTextOutput("scoreB"),class = "wellTransparent col-lg-4")
                                     )
                                  )
                                 ))
                                
                                 
                                 
                       )
             ),
 
             tabPanel("Level 3",value = "e"
                      ,
                       fluidPage(theme = "bootstrap.css", #css theme
                                 tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "themestyle.css")), #link to your own css file
                                 fluidRow(
                                #   column(1, img(src = "psu.PNG", width = 70)),
                                   column(10,
                                          h2("Level 3: Histogram & Boxplot")
                                   )
                                 )
                                 ,
                                 fluidRow(
                                   column(3, 
                                          div(style="display: inline-block;vertical-align:top;",
                                              tags$a(href='https://shinyapps.science.psu.edu/',tags$img(src='homebut.PNG', width = 30))
                                          ),
                                          bsButton('bq3', '',icon = icon('question',class = "iconq fa-fw"),type = 'toggle', class = 'butt'),
                                          
                                          bsButton('bt3', '',icon = icon('time', lib = 'glyphicon',class = "icont fa-fw"),type = 'toggle', class = 'butt')
                                   ),
                                   #column(6, hidden(div(id='hint3q', textOutput('hint3')))),
                                   column(6, conditionalPanel("input.bq3 != 0",
                                                              id='hint3q', textOutput('hint3'))),
                                   column(3,
                                          hidden(div(id='timer3h',textOutput("timer3"))
                                          ))),br(),
                                 
                                 conditionalPanel("input.next2 != 0", #Show everything only after the GO button is clicked
                                                  
                                                  fluidRow(wellPanel(
                                                    #img(src = questionE[questionE[4] == "A",2], class = "picSize"),
                                                   uiOutput("image13"),
                                                    dragUI("img13","A", style = "width: 120px; height: 23px;")
                                                    , class = "wellTransparent col-sm-12 col-md-6 col-lg-3"),
                                                    
                                                    wellPanel(
                                                      uiOutput("image14"),
                                                      #img(src = questionE[questionE[4] == "B",2], class = "picSize"),
                                                      class = "col-lg-3 col-md-2",
                                                    
                                                      dragUI("img14","B", style = "width: 120px; height: 23px;")
                                                      ,class = "wellTransparent col-sm-12 col-md-6 col-lg-3"),
                                                    wellPanel(
                                                     # img(src = questionE[questionE[4] == "C",2], class = "picSize"),
                                                      uiOutput("image15"),
                                                      dragUI("img15","C", style = "width: 120px; height: 23px;")
                                                      , class = "wellTransparent col-sm-12 col-md-6 col-lg-3"),
                                                    wellPanel(
                                                      #img(src = questionE[questionE[4] == "D",2], class = "picSize"),
                                                      uiOutput("image16"),
                                                      dragUI("img16","D", style = "width: 120px; height: 23px;")
                                                      , class = "wellTransparent col-sm-12 col-md-6 col-lg-3")),
                                                  fluidRow(
                                                    fluidRow(
                                                    wellPanel(dropUI("drp13", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer13")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br(),
                                                                uiOutput("image17")
                                                                #img(src = questionE[questionE[1] == "left",3], class = "col-lg-15 col-md-12")
                                                                ),
                                                      wellPanel(dropUI("drp14", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer14")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br(),
                                                                uiOutput("image18")
                                                                #img(src = questionE[questionE[1] == "right",3], class = "col-lg-15 col-md-12")
                                                                ),
                                                      wellPanel(dropUI("drp15", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer15")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br(),
                                                                uiOutput("image19")
                                                                #img(src = questionE[questionE[1] == "normal",3], class = "col-lg-15 col-md-12")
                                                                ),
                                                      wellPanel(dropUI("drp16", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer16")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br(),
                                                                uiOutput("image20")
                                                                #img(src = questionE[questionE[1] == "uniform",3], class = "col-lg-15 col-md-12")
                                                                )
                                                    )
                                                  ),br(),
                                                  
                                                  fluidRow(
                                                    column(1,bsButton("previous5","<<Previous", style = "primary",size = "small")),
                                                    column(1,offset = 4, conditionalPanel("(input.drp13!='') & (input.drp14!='') & (input.drp15!='') & (input.drp16!='') "
                                                                                        ,bsButton("submitD", "Submit Answer", style = "primary",size = "small",class = "grow"))),
                                                  column(1,offset = 5,bsButton("next3","Next>>",style = "primary", size = "small", disabled = TRUE))
                                                ),br()
                                 ),
                                 
                                 conditionalPanel("input.submitD != 0",wellPanel(
                                   fluidPage(
                                     fluidRow(
                                       wellPanel(
                                         #div(style = "position:absolute; top;50em; left:1em",
                                             #h4("Please drag the wrong answers into this PENALTY box and click the CLEAR button to restart.")
                                             h4(textOutput("warning3"))
                                             #)
                                         ,
                                         dropUI("home3",class = "dropelement dropelementHome"),
                                         div(style = "position:absolute; top:11em; right:2em",bsButton("clearD","CLEAR",style = "danger")),class = "wellTransparent col-lg-8"),
                                       wellPanel(h4("Full score is 16 for level 3."),
                                                 verbatimTextOutput("scoreC"),class = "wellTransparent col-lg-4")
                                     )
                                   )
                                 ))
                                 
                                 
                                 
                       )
             ),
             tabPanel("Level 4",value = "f"
                      ,
                       fluidPage(theme = "bootstrap.css", #css theme
                                 tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "themestyle.css")), #link to your own css file
                                 fluidRow(
                               #    column(1, img(src = "psu.PNG", width = 70)),
                                 column(10,
                                          h2("Level 4: Correlation & Scatterplot"),
                                        h3("Watch out for outliers!")
                                   )
                                 )
                                 ,
                                 fluidRow(
                                   column(3, 
                                          div(style="display: inline-block;vertical-align:top;",
                                              tags$a(href='https://shinyapps.science.psu.edu/',tags$img(src='homebut.PNG', width = 30))
                                          ),
                                          bsButton('bq4', '',icon = icon('question',class = "iconq fa-fw"),type = 'toggle', class = 'butt'),
                                          bsButton('bt4', '',icon = icon('time', lib = 'glyphicon',class = "icont fa-fw"),type = 'toggle', class = 'butt')  
                                   ),
                                   #column(6, hidden(div(id='hint4q', textOutput('hint4')))),
                                   column(6, conditionalPanel("input.bq4 != 0",
                                                              id='hint4q', textOutput('hint4'))),
                                   column(3,
                                          hidden(div(id='timer4h',textOutput("timer4"))
                                          ))),br(),
                                 
                                 conditionalPanel("input.next3 != 0", #Show everything only after the GO button is clicked
                                                  
                                                  fluidRow(wellPanel(
                                                    br(),
                                                    dragUI("img17","A", style = "width: 120px; height: 23px;")
                                                    ,class = "col-lg-3 col-md-3 wellBorder2",
                                                  
                                                    div(style = "text-align:center", h2(textOutput("text17"))),
                                                  br()
                                                    ),
                                                    
                                                    wellPanel(
                                                      br(),
                                                    dragUI("img18","B", style = "width: 120px; height: 23px;")
                                                      ,class = "col-lg-3 col-md-3 wellBorder2",
                                                      div(style = "text-align:center", h2(textOutput("text18"))),
                                                      br()
                                                      ),
                                                    wellPanel(
                                                      br(),
                                                     dragUI("img19","C", style = "width: 120px; height: 23px;")
                                                      ,class = "col-lg-3 col-md-3 wellBorder2",
                                                      div(style = "text-align:center", h2(textOutput("text19"))),
                                                      br()
                                                    ),
                                                    wellPanel(
                                                      br(),
                                                      dragUI("img20","D", style = "width: 120px; height: 23px;")
                                                      ,class = "col-lg-3 col-md-3 wellBorder2",
                                                      div(style = "text-align:center", h2(textOutput("text20"))),
                                                      br()
                                                     )),
                                                  fluidRow(
                                                    fluidRow(
                                                      wellPanel(dropUI("drp17", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer17")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br(),
                                                               #img(src = questionD[questionD[1] == "mean1",3], class = "col-lg-15 col-md-12")
                                                                uiOutput("image21")
                                                      ),
                                                      wellPanel(dropUI("drp18", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer18")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br(),
                                                                #img(src = questionD[questionD[1] == "mean2",3], class = "col-lg-15 col-md-12")
                                                                uiOutput("image22")
                                                      ),
                                                      wellPanel(dropUI("drp19", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer19")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                              br(),
                                                                #img(src = questionD[questionD[1] == "mean3",3], class = "col-lg-15 col-md-12")
                                                                uiOutput("image23")
                                                      ),
                                                      wellPanel(dropUI("drp20", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer20")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br(),
                                                                # img(src = questionD[questionD[1] == "mean4",3], class = "col-lg-15 col-md-12")
                                                                uiOutput("image24")
                                                      )
                                                    )
                                                  ),br(),
                                                  
                                                  fluidRow(
                                                    column(1,bsButton("previous4","<<Previous", style = "primary",size = "small")),
                                                    column(1,offset = 4, conditionalPanel("(input.drp17!='') & (input.drp18!='') & (input.drp19!='') & (input.drp20!='') "
                                                                                          ,bsButton("submitE", "Submit Answer", style = "primary",size = "small",class = "grow"))),
                                                    column(1,offset = 5,bsButton("next4","Next>>",style = "primary", size = "small", disabled = TRUE))
                                                  ),br()
                                 ),
                                 
                                 conditionalPanel("input.submitE != 0",wellPanel(
                                   fluidPage(
                                     fluidRow(
                                       wellPanel(
                                       #div(style = "position:absolute; top;50em; left:1em",
                                           #h4("Please drag the wrong answers into this PENALTY box and click the CLEAR button to restart.")
                                           h4(textOutput("warning4"))
                                           #)
                                           ,
                                       dropUI("home4",class = "dropelement dropelementHome"),
                                       div(style = "position:absolute; top:11em; right:2em",bsButton("clearE","CLEAR",style = "danger")),class = "wellTransparent col-lg-8"),
                                       wellPanel(h4("Full score is 20 for level 4."),
                                                 verbatimTextOutput("scoreD"),class = "wellTransparent col-lg-4")
                                     )
                                   )
                                 ))
                                 
                                 
                                 
                       )
             ),
             tabPanel("Level 5",value = "g"
                      ,
                       fluidPage(theme = "bootstrap.css", #css theme
                                 tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "themestyle.css")), #link to your own css file
                                 fluidRow(
                               #    column(1, img(src = "psu.PNG", width = 70)),
                                   column(10,
                                          h2("Level 5 : Distribution Application")
                                   )
                                 )
                                 ,
                                 fluidRow(
                                   column(3, 
                                          div(style="display: inline-block;vertical-align:top;",
                                              tags$a(href='https://shinyapps.science.psu.edu/',tags$img(src='homebut.PNG', width = 30))
                                          ),
                                          bsButton('bq5', '',icon = icon('question',class = "iconq fa-fw"),type = 'toggle', class = 'butt'),
                                          bsButton('bt5', '',icon = icon('time', lib = 'glyphicon',class = "icont fa-fw"),type = 'toggle', class = 'butt')
                                   ),
                                   #column(6, hidden(div(id='hint5q', textOutput('hint5')))),
                                   column(6, conditionalPanel("input.bq5 != 0",
                                                              id='hint5q', textOutput('hint5'))),
                                   column(3,
                                          hidden(div(id='timer5h',textOutput("timer5"))
                                          ))),br(),
                                 
                                 conditionalPanel("input.go != 0", #Show everything only after the GO button is clicked
                                                  
                                                  fluidRow(wellPanel(
                                                
                                                    dragUI("img21","A", style = "width: 120px; height: 23px;")
                                                    ,class = "col-lg-3 col-md-3 wellBorder",
                                                    div(style = "text-align:center", h2(textOutput("text21"))),
                                                    br()
                                                    
                                                   ),
                                                    
                                                    wellPanel(
                                                   
                                                      
                                                      dragUI("img22","B", style = "width: 120px; height: 23px;")
                                                      ,class = "col-lg-3 col-md-3 wellBorder",
                                                      div(style = "text-align:center", h2(textOutput("text22"))),
                                                      br()
                                                    ),
                                                    wellPanel(
                                                   
                                                      
                                                      dragUI("img23","C", style = "width: 120px; height: 23px;")
                                                      ,class = "col-lg-3 col-md-3 wellBorder",
                                                      div(style = "text-align:center", h2(textOutput("text23"))),
                                                      br()
                                                      ),
                                                    wellPanel(
                                                              
                                                              dragUI("img24","D", style = "width: 120px; height: 23px;")
                                                              ,class = "col-lg-3 col-md-3 wellBorder",
                                                      div(style = "text-align:center", h2(textOutput("text24"))),
                                                      br()
                                                     )),
                                                  fluidRow(
                                                    fluidRow(
                                                      wellPanel(dropUI("drp21", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer21")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br(),
                                                                img(src = "symmetric.PNG", height = 250,  class = "col-lg-15 col-md-12")),
                                                      wellPanel(dropUI("drp22", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer22")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br(),
                                                                img(src = "right-skewed.PNG",  height = 250,class = "col-lg-15 col-md-12")),
                                                      wellPanel(dropUI("drp23", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer23")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br(),
                                                                img(src = "left-skewed.PNG",  height = 250,class = "col-lg-15 col-md-12")),
                                                      wellPanel(dropUI("drp24", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer24")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br(),
                                                                img(src = "bimodal.PNG", height = 250, class = "col-lg-15 col-md-12"))
                                                    )
                                                  ),br(),
                                                  
                                                  fluidRow(
                                                    column(1,bsButton("previous3","<<Previous", style = "primary",size = "small")),
                                                    column(1,offset = 4, conditionalPanel("(input.drp21!='') & (input.drp22!='') & (input.drp23!='') & (input.drp24!='') "
                                                                                          ,bsButton("submitF", "Submit Answer", style = "primary",size = "small",class = "grow"))),
                                                    column(1,offset = 5,bsButton("next5","Next>>",style = "primary", size = "small", disabled = TRUE))
                                                  ),br()
                                 ),
                                 
                                 conditionalPanel("input.submitF != 0",wellPanel(
                                   fluidPage(
                                     fluidRow(
                                       wellPanel(
                                         #div(style = "position:absolute; top;50em; left:1em",
                                             #h4("Please drag the wrong answers into this PENALTY box and click the CLEAR button to restart.")
                                             h4(textOutput("warning5"))
                                             #)
                                             ,
                                         dropUI("home5",class = "dropelement dropelementHome"),
                                         div(style = "position:absolute; top:11em; right:2em",bsButton("clearF","CLEAR",style = "danger")),class = "wellTransparent col-lg-8"),
                                       wellPanel(h4("Full score is 24 for level 5."),
                                                 verbatimTextOutput("scoreE"),class = "wellTransparent col-lg-4")
                                     )
                                   )
                                 ))
                                 
                                 
                                 
                       )
             ),
             tabPanel("Level 6",value = "h"
                      ,
                       fluidPage(theme = "bootstrap.css", #css theme
                                 tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "themestyle.css")), #link to your own css file
                                 fluidRow(
                               #    column(1, img(src = "psu.PNG", width = 70)),
                                   column(10,
                                          h2("Level 6: Correlation & Application"),
                                          h3('Order the correlation from the highest to the lowest.')
                                   )
                                 )
                                 ,
                                 fluidRow(
                                   column(3, 
                                          div(style="display: inline-block;vertical-align:top;",
                                              tags$a(href='https://shinyapps.science.psu.edu/',tags$img(src='homebut.PNG', width = 30))
                                          ),
                                          bsButton('bq6', '',icon = icon('question',class = "iconq fa-fw"),type = 'toggle', class = 'butt'),
                                          bsButton('bt6', '',icon = icon('time', lib = 'glyphicon',class = "icont fa-fw"),type = 'toggle', class = 'butt')
                                   ),
                                   #column(6, hidden(div(id='hint6q', textOutput('hint6')))),
                                   column(6, conditionalPanel("input.bq6 != 0",
                                                              id='hint6q', textOutput('hint6'))),
                                   column(3,
                                          hidden(div(id='timer6h',textOutput("timer6"))
                                          ))),br(),
                                 conditionalPanel("input.next5 != 0", #Show everything only after the GO button is clicked
                                                  
                                                  fluidRow(wellPanel(
                                                   
                                                    dragUI("img25","A", style = "width: 120px; height: 23px;")
                                                    ,class = "col-lg-3 col-md-3 wellBorder",
                                                    div(style = "text-align:center", h2(textOutput("text25"))),
                                                    br()
                                                    ),
                                                    
                                                    wellPanel(
                                                     
                                                      dragUI("img26","B", style = "width: 120px; height: 23px;")
                                                      ,class = "col-lg-3 col-md-3 wellBorder",
                                                      div(style = "text-align:center", h2(textOutput("text26"))),
                                                      br()
                                                    ),
                                                    wellPanel(
                                                     
                                                      
                                                      dragUI("img27","C", style = "width: 120px; height: 23px;")
                                                      ,class = "col-lg-3 col-md-3 wellBorder",
                                                      div(style = "text-align:center",h2(textOutput("text27"))),
                                                      br()
                                                      ),
                                                    wellPanel(
                                                    
                                                      
                                                      dragUI("img28","D", style = "width: 120px; height: 23px;")
                                                      ,class = "col-lg-3 col-md-3 wellBorder",
                                                      div(style = "text-align:center", h2(textOutput("text28"))),
                                                      br()
                                                     )),
                                                  fluidRow(
                                                    fluidRow(
                                                      wellPanel(h3("highest:"),dropUI("drp25", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer25")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br()
                                                                ),
                                                      wellPanel(br(),br(),br(),
                                                        dropUI("drp26", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer26")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br()
                                                                ),
                                                      wellPanel(br(),br(),br(),dropUI("drp27", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer27")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br()
                                                                ),
                                                      wellPanel(h3("lowest:"),
                                                                dropUI("drp28", class = "dropelement"),
                                                                div(style = "position:absolute;top: 10%;right:2%;",htmlOutput("answer28")), class = "wellTransparent col-sm-12 col-md-6 col-lg-3",
                                                                br()
                                                               )
                                                    )
                                                  ),br(),
                                                  
                                                  fluidRow(
                                                    column(1,bsButton("previous2","<<Previous", style = "primary",size = "small")),
                                                    column(1,offset = 4, conditionalPanel("(input.drp25!='') & (input.drp26!='') & (input.drp27!='') & (input.drp28!='') "
                                                                                          ,bsButton("submitG", "Submit Answer", style = "primary",size = "small",class = "grow"))),
                                                    column(1,offset = 5,bsButton("finish","STOP>>", style = "danger", disabled = TRUE, size = "small"))
                                                  ),br()
                                 ),
                                 
                                 conditionalPanel("input.submitG != 0",wellPanel(
                                   fluidPage(
                                     fluidRow(
                                       wellPanel(
                                         #div(style = "position:absolute; top;50em; left:1em",
                                             #h4("Please drag the wrong answers into this PENALTY box and click the CLEAR button to restart.")
                                             h4(textOutput("warning6"))
                                            # )
                                         ,
                                         dropUI("home6",class = "dropelement dropelementHome"),
                                         div(style = "position:absolute; top:11em; right:2em",bsButton("clearG","CLEAR",style = "danger")),class = "wellTransparent col-lg-8"),
                                       wellPanel(h4("Full score is 24 for level 6."),
                                                 verbatimTextOutput("scoreF"),class = "wellTransparent col-lg-4")
                                     )
                                   )
                                 ))
                                 
                                 
                                 
                       )
             )
             # tabPanel(title = "Score", value = "i",
             #          titlePanel(h1("Congratulations! You finished the game.")),
             #          fluidRow(column(3,offset = 9,textOutput("timer8"))),br(),br(),
             #          fluidPage(
             #            fluidRow(h3("Your scores:")),
             #            fluidRow(
             #              wellPanel(verbatimTextOutput("init"), class = "wellScore col-lg-4 col-md-6 col-sm-12"),
             #              wellPanel(verbatimTextOutput("end"), class = "wellScore col-lg-4 col-md-6 col-sm-12"),
             #              wellPanel(verbatimTextOutput("totalScore"), class = "wellScore col-lg-4 col-md-6 col-sm-12")
             #            ),br(),
             #            fluidRow(
             #              wellPanel(
             #                wellPanel(textInput("name",h4("Please type in your initials or nickname to submit the score:"),placeholder = "Initials",width = 600),class = "col-lg-8 col-md-9 col-sm-10 col-xs-9"),
             #                wellPanel(div(style = "position:absolute; top:60px",bsButton("check","Submit",style = "warning",size = "large")),class = "col-lg-2 col-md-2 col-sm-1 col-xs-1"),style = "height:200px")
             #            ),
             #            
             #            
             #       
             #            
             #            
             #            
             #           # htmlOutput("badge"),
             #            conditionalPanel("input.check >-1", dataTableOutput("highscore")),
             #            actionButton("weekhigh", "Show Weekly High Scores"),
             #            actionButton("totalhigh", "Show All-Time High Scores")
             #            
             #          ))
             
                      #############################################################################################             
         
             
             )))
    
