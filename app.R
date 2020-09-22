# Call libraries
library(shiny)
library(shinyjs)
library(shinyBS)
library(shinydashboard)
library(boastUtils)
library(shinyDND) # for drag and drop
library(shinyWidgets)
library(sortable)

## App Meta Data-------------------------------------------------------------
APP_TITLE  <<- "Descriptive Statistics"
APP_DESCP  <<- paste(
  "Description of the app",
  "This app is designed for the game app, which is to help user better
 understand the concept of Descriptive Statistics."
)
## End App Meta Data---------------------------------------------------------

# Define global constants and functions ----
# read question csv files
bankA = read.csv("Level1.csv")
bankA = data.frame(lapply(bankA, as.character), stringsAsFactors = FALSE)
bankB = read.csv("Level2.csv")
bankB = data.frame(lapply(bankB, as.character), stringsAsFactors = FALSE)
bankC = read.csv("Level3.csv")
bankC = data.frame(lapply(bankC, as.character), stringsAsFactors = FALSE)
bankD = read.csv("Level4.csv")
bankD = data.frame(lapply(bankD, as.character), stringsAsFactors = FALSE)
bankE = read.csv("Level5.csv")
bankE = data.frame(lapply(bankE, as.character), stringsAsFactors = FALSE)
### These four files need to be combined in a single file for Level 6
bankF1 = read.csv("Level71.csv")
bankF1 = data.frame(lapply(bankF1, as.character), stringsAsFactors = FALSE)
bankF2 = read.csv("Level72.csv")
bankF2 = data.frame(lapply(bankF2, as.character), stringsAsFactors = FALSE)
bankF3 = read.csv("Level73.csv")
bankF3 = data.frame(lapply(bankF3, as.character), stringsAsFactors = FALSE)
bankF4 = read.csv("Level74.csv")
bankF4 = data.frame(lapply(bankF4, as.character), stringsAsFactors = FALSE)

# Define the UI ----
ui <- list(
  dashboardPage(
    skin = "yellow",
    ## Header ----
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
    ## Sidebar ----
    dashboardSidebar(
      width = 250,
      sidebarMenu(
        id = 'tabs',
        menuItem("Overview", tabName = "overview", icon = icon("tachometer-alt")),
        menuItem("Game-NEW", tabName = "game0", icon = icon("gamepad")),
        menuItem("Game-OLD", tabName = "game", icon = icon("gamepad")),
        menuItem("References", tabName = "References", icon = icon("leanpub"))
      ),
      tags$div(class = "sidebar-logo",
               boastUtils::psu_eberly_logo("reversed"))
    ),
    ## Body ----
    dashboardBody(
      tags$head(
        tags$link(rel = "stylesheet", type = "text/css",
                  href = "https://educationshinyappteam.github.io/Style_Guide/theme/boast.css"),
        tags$link(rel = "stylesheet", type = "text/css",
                  href = "https://educationshinyappteam.github.io/Style_Guide/theme/dragStyleYellow.css")
      ),
      tabItems(
        ### First tab - Overview ----
        tabItem(
          tabName = "overview",
          h1("Descriptive Statistics"),
          p("This app is designed to help you better understand the concept
          of Descriptive Statistics."),
          br(),
          h2("Levels"),
          tags$ul(
            tags$li("Level 1: Match the mean & median to histogram"),
            tags$li("Level 2: Match the mean & standard deviation
                  to density curve"),
            tags$li("Level 3: Match the boxplot to histogram"),
            tags$li("Level 4: Match the correlation to scatterplot"),
            tags$li("Level 5: Match the application to density curve"),
            tags$li("Level 6: Order the correlation from the highest
                  to the lowest.")
          ),
          h2("Instructions"),
          tags$ol(
            tags$li("You can check time and hint by clicking the boxes"),
            tags$li("Drag and drop A, B, C, D into the drop box."),
            tags$li("Submit your answer only after finishing all the questions."),
            tags$li("You will need to click 'Reattempt' button to try again."),
            tags$li("You have to use 'Penalty Box' to correct a wrong answer."),
            tags$li("You can stop and check your score any level, once you get
                  every question correct."),
            tags$li("You may go to the next level only when you correct
                  any wrong answer.")
          ),
          br(),
          div(
            style = "text-align: center;",
            bsButton(
              inputId = "start",
              label = "GO!",
              size = "large",
              icon = icon("bolt")
            )
          ),
          #Acknowledgment
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
        ### New Game Tab ----
        tabItem(
          tabName = "game0",
          h2("Descriptive Statistics Drag-and-Drop Game"),
          fluidRow(
            column(
              width = 2,
              bsButton(
                inputId = "timer",
                label = "Show Timer",
                icon = icon("stopwatch"),
                type = "toggle",
                value = FALSE,
                size = "large"
              )
            ),
            column(
              width = 4,
              offset = 6,
              uiOutput(
                outputId = "timerMessage",
                style = "text-align: right;"
              ),
              p(style = "text-align: right;",
                "timer message here")
            )
          ),
          br(),
          tabsetPanel(
            id = "gameLevels",
            type = "tabs",
            #### Game Level 1 ----
            tabPanel(
              title = "Level 1",
              br(),
              h3("Level 1: Sample Arithmetic Mean and Sample Median"),
              p("Rearrange the histograms and/or values of the data sets by
                clicking and draging on either so that they are in the same order.
                We've provided the values
                for the ", tags$em("sample median"), " and ",
                tags$em("sample arithmetic mean"), " for each data set.",
                br(),
                "Check the 'Show more details' box if you wish to see values for
                the ", tags$em("sample standard deviation"), " and ",
                tags$em("interquartile range"), "."
              ),
              checkboxInput(
                inputId = "extraDetailsL1",
                label = "Show more details",
                value = FALSE
              ),
              br(),
              fluidRow(
                column(
                  width = 6,
                  rank_list(
                    input_id = "rank1Hists",
                    text = "Drag the histograms into the same order as the values.",
                    labels = list(
                      "a" = img(src = "right1.PNG", width = "75%"),
                      "b" = img(src = "left1.PNG", width = "75%"),
                      "c" = img(src = "normal1.PNG", width = "75%"),
                      "d" = img(src = "uniform1.PNG", width = "75%")
                    )
                  )
                ),
                column(
                  width = 6,
                  rank_list(
                    input_id = "rank1Values",
                    text = "Drag the values into the same order as the
                    histograms.",
                    labels = list(
                      "a" = div(
                        h4("Data Set A", align = "center"),
                        p(bankA[1, "mean"],
                          br(),
                          bankA[1, "sd"]
                        )
                      ),
                      "b" = div(
                        h4("Data Set B", align = "center"),
                        p(bankA[4, "mean"],
                          br(),
                          bankA[4, "sd"]
                        )
                      ),
                      "c" = div(
                        h4("Data Set C", align = "center"),
                        p(bankA[7, "mean"],
                          br(),
                          bankA[7, "sd"]
                        )
                      ),
                      "d" = div(
                        h4("Data Set D", align = "center"),
                        p(bankA[10, "mean"],
                          br(),
                          bankA[10, "sd"]
                        )
                      )
                    )
                  )
                )
              ),
              verbatimTextOutput("test1"),
              br(),
              fluidRow(
                column(
                  width = 2,
                  p("Feedback:")
                ),
                column(
                  width = 2,
                  p("1st Pair Mark")
                ),
                column(
                  width = 2,
                  p("2nd Pair Mark")
                ),
                column(
                  width = 2,
                  p("3rd Pair Mark")
                ),
                column(
                  width = 2,
                  p("4th Pair Mark")
                ),
              ),
              fluidRow(
                column(
                  width = 2,
                  bsButton(
                    inputId = "previousL1",
                    label = "<< Previous",
                    size = "large",
                    style = "default"
                  )
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "reattemptL1",
                    label = "Reattempt",
                    size = "large",
                    style = "danger"
                  )
                ),
                column(
                  width = 2,
                  offset = 4,
                  bsButton(
                    inputId = "submitL1",
                    label = "Submit",
                    size = "large",
                    style = "default"
                  )
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "nextL1",
                    label = "Next >>",
                    size = "large",
                    style = "default"
                  )
                )
              )
            ),
            #### Game Level 2 ----
            tabPanel(
              title = "Level 2",
              br(),
              h3("Level 2: Sample Arithmetic Mean and Sample Standard Deviation"),
              p("Rearrange the histograms and/or values of the data sets by
                clicking and draging on either so that they are in the same order.
                We've provided the values
                for the ", tags$em("sample median"), " and ",
                tags$em("sample arithmetic mean"), " for each data set.",
                br(),
                "Check the 'Show more details' box if you wish to see values for
                the ", tags$em("sample standard deviation"), " and ",
                tags$em("interquartile range"), "."
              ),
              br(),
              fluidRow(
                column(
                  width = 6,
                  rank_list(
                    input_id = "rank2Hists",
                    text = "Drag the histograms into the same order as the values.",
                    labels = list(
                      "a" = img(src = "right1.PNG", width = "75%"),
                      "b" = img(src = "left1.PNG", width = "75%"),
                      "c" = img(src = "normal1.PNG", width = "75%"),
                      "d" = img(src = "uniform1.PNG", width = "75%")
                    )
                  )
                ),
                column(
                  width = 6,
                  rank_list(
                    input_id = "rank2Values",
                    text = "Drag the values into the same order as the
                    histograms.",
                    labels = list(
                      "a" = div(
                        h4("Data Set A", align = "center"),
                        p(bankA[1, "mean"],
                          br(),
                          bankA[1, "sd"]
                        )
                      ),
                      "b" = div(
                        h4("Data Set B", align = "center"),
                        p(bankA[4, "mean"],
                          br(),
                          bankA[4, "sd"]
                        )
                      ),
                      "c" = div(
                        h4("Data Set C", align = "center"),
                        p(bankA[7, "mean"],
                          br(),
                          bankA[7, "sd"]
                        )
                      ),
                      "d" = div(
                        h4("Data Set D", align = "center"),
                        p(bankA[10, "mean"],
                          br(),
                          bankA[10, "sd"]
                        )
                      )
                    )
                  )
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 2,
                  p("Feedback:")
                ),
                column(
                  width = 2,
                  p("1st Pair Mark")
                ),
                column(
                  width = 2,
                  p("2nd Pair Mark")
                ),
                column(
                  width = 2,
                  p("3rd Pair Mark")
                ),
                column(
                  width = 2,
                  p("4th Pair Mark")
                ),
              ),
              fluidRow(
                column(
                  width = 2,
                  bsButton(
                    inputId = "previousL2",
                    label = "<< Previous",
                    size = "large",
                    style = "default"
                  )
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "submitL2",
                    label = "Submit",
                    size = "large",
                    style = "default"
                  )
                ),
                column(
                  width = 2,
                  offset = 4,
                  bsButton(
                    inputId = "reattemptL2",
                    label = "Reattempt",
                    size = "large",
                    style = "danger"
                  )
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "nextL2",
                    label = "Next >>",
                    size = "large",
                    style = "default"
                  )
                )
              )
            ),
            #### Game Level 3 ----
            tabPanel(
              title = "Level 3",
              br(),
              h3("Level 3: Sample Arithmetic Mean and Sample Standard Deviation"),
              p("Rearrange the histograms and/or values of the data sets by
                clicking and draging on either so that they are in the same order.
                We've provided the values
                for the ", tags$em("sample median"), " and ",
                tags$em("sample arithmetic mean"), " for each data set.",
                br(),
                "Check the 'Show more details' box if you wish to see values for
                the ", tags$em("sample standard deviation"), " and ",
                tags$em("interquartile range"), "."
              ),
              br(),
              fluidRow(
                column(
                  width = 6,
                  rank_list(
                    input_id = "rank3Hists",
                    text = "Drag the histograms into the same order as the values.",
                    labels = list(
                      "a" = img(src = "right1.PNG", width = "75%"),
                      "b" = img(src = "left1.PNG", width = "75%"),
                      "c" = img(src = "normal1.PNG", width = "75%"),
                      "d" = img(src = "uniform1.PNG", width = "75%")
                    )
                  )
                ),
                column(
                  width = 6,
                  rank_list(
                    input_id = "rank3Values",
                    text = "Drag the values into the same order as the
                    histograms.",
                    labels = list(
                      "a" = div(
                        h4("Data Set A", align = "center"),
                        p(bankA[1, "mean"],
                          br(),
                          bankA[1, "sd"]
                        )
                      ),
                      "b" = div(
                        h4("Data Set B", align = "center"),
                        p(bankA[4, "mean"],
                          br(),
                          bankA[4, "sd"]
                        )
                      ),
                      "c" = div(
                        h4("Data Set C", align = "center"),
                        p(bankA[7, "mean"],
                          br(),
                          bankA[7, "sd"]
                        )
                      ),
                      "d" = div(
                        h4("Data Set D", align = "center"),
                        p(bankA[10, "mean"],
                          br(),
                          bankA[10, "sd"]
                        )
                      )
                    )
                  )
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 2,
                  p("Feedback:")
                ),
                column(
                  width = 2,
                  p("1st Pair Mark")
                ),
                column(
                  width = 2,
                  p("2nd Pair Mark")
                ),
                column(
                  width = 2,
                  p("3rd Pair Mark")
                ),
                column(
                  width = 2,
                  p("4th Pair Mark")
                ),
              ),
              fluidRow(
                column(
                  width = 2,
                  bsButton(
                    inputId = "previousL3",
                    label = "<< Previous",
                    size = "large",
                    style = "default"
                  )
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "submitL3",
                    label = "Submit",
                    size = "large",
                    style = "default"
                  )
                ),
                column(
                  width = 2,
                  offset = 4,
                  bsButton(
                    inputId = "reattemptL3",
                    label = "Reattempt",
                    size = "large",
                    style = "danger"
                  )
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "nextL3",
                    label = "Next >>",
                    size = "large",
                    style = "default"
                  )
                )
              )
            ),
            #### Game Level 4 ----
            tabPanel(
              title = "Level 4",
              br(),
              h3("Level 4: Sample Arithmetic Mean and Sample Standard Deviation"),
              p("Rearrange the histograms and/or values of the data sets by
                clicking and draging on either so that they are in the same order.
                We've provided the values
                for the ", tags$em("sample median"), " and ",
                tags$em("sample arithmetic mean"), " for each data set.",
                br(),
                "Check the 'Show more details' box if you wish to see values for
                the ", tags$em("sample standard deviation"), " and ",
                tags$em("interquartile range"), "."
              ),
              br(),
              fluidRow(
                column(
                  width = 6,
                  rank_list(
                    input_id = "rank4Hists",
                    text = "Drag the histograms into the same order as the values.",
                    labels = list(
                      "a" = img(src = "right1.PNG", width = "75%"),
                      "b" = img(src = "left1.PNG", width = "75%"),
                      "c" = img(src = "normal1.PNG", width = "75%"),
                      "d" = img(src = "uniform1.PNG", width = "75%")
                    )
                  )
                ),
                column(
                  width = 6,
                  rank_list(
                    input_id = "rank4Values",
                    text = "Drag the values into the same order as the
                    histograms.",
                    labels = list(
                      "a" = div(
                        h4("Data Set A", align = "center"),
                        p(bankA[1, "mean"],
                          br(),
                          bankA[1, "sd"]
                        )
                      ),
                      "b" = div(
                        h4("Data Set B", align = "center"),
                        p(bankA[4, "mean"],
                          br(),
                          bankA[4, "sd"]
                        )
                      ),
                      "c" = div(
                        h4("Data Set C", align = "center"),
                        p(bankA[7, "mean"],
                          br(),
                          bankA[7, "sd"]
                        )
                      ),
                      "d" = div(
                        h4("Data Set D", align = "center"),
                        p(bankA[10, "mean"],
                          br(),
                          bankA[10, "sd"]
                        )
                      )
                    )
                  )
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 2,
                  p("Feedback:")
                ),
                column(
                  width = 2,
                  p("1st Pair Mark")
                ),
                column(
                  width = 2,
                  p("2nd Pair Mark")
                ),
                column(
                  width = 2,
                  p("3rd Pair Mark")
                ),
                column(
                  width = 2,
                  p("4th Pair Mark")
                ),
              ),
              fluidRow(
                column(
                  width = 2,
                  bsButton(
                    inputId = "previousL4",
                    label = "<< Previous",
                    size = "large",
                    style = "default"
                  )
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "submitL4",
                    label = "Submit",
                    size = "large",
                    style = "default"
                  )
                ),
                column(
                  width = 2,
                  offset = 4,
                  bsButton(
                    inputId = "reattemptL4",
                    label = "Reattempt",
                    size = "large",
                    style = "danger"
                  )
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "nextL4",
                    label = "Next >>",
                    size = "large",
                    style = "default"
                  )
                )
              )
            ),
            #### Game Level 5 ----
            tabPanel(
              title = "Level 5",
              br(),
              h3("Level 5: Sample Arithmetic Mean and Sample Standard Deviation"),
              p("Rearrange the histograms and/or values of the data sets by
                clicking and draging on either so that they are in the same order.
                We've provided the values
                for the ", tags$em("sample median"), " and ",
                tags$em("sample arithmetic mean"), " for each data set.",
                br(),
                "Check the 'Show more details' box if you wish to see values for
                the ", tags$em("sample standard deviation"), " and ",
                tags$em("interquartile range"), "."
              ),
              br(),
              fluidRow(
                column(
                  width = 6,
                  rank_list(
                    input_id = "rank5Hists",
                    text = "Drag the histograms into the same order as the values.",
                    labels = list(
                      "a" = img(src = "right1.PNG", width = "75%"),
                      "b" = img(src = "left1.PNG", width = "75%"),
                      "c" = img(src = "normal1.PNG", width = "75%"),
                      "d" = img(src = "uniform1.PNG", width = "75%")
                    )
                  )
                ),
                column(
                  width = 6,
                  rank_list(
                    input_id = "rank5Values",
                    text = "Drag the values into the same order as the
                    histograms.",
                    labels = list(
                      "a" = div(
                        h4("Data Set A", align = "center"),
                        p(bankA[1, "mean"],
                          br(),
                          bankA[1, "sd"]
                        )
                      ),
                      "b" = div(
                        h4("Data Set B", align = "center"),
                        p(bankA[4, "mean"],
                          br(),
                          bankA[4, "sd"]
                        )
                      ),
                      "c" = div(
                        h4("Data Set C", align = "center"),
                        p(bankA[7, "mean"],
                          br(),
                          bankA[7, "sd"]
                        )
                      ),
                      "d" = div(
                        h4("Data Set D", align = "center"),
                        p(bankA[10, "mean"],
                          br(),
                          bankA[10, "sd"]
                        )
                      )
                    )
                  )
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 2,
                  p("Feedback:")
                ),
                column(
                  width = 2,
                  p("1st Pair Mark")
                ),
                column(
                  width = 2,
                  p("2nd Pair Mark")
                ),
                column(
                  width = 2,
                  p("3rd Pair Mark")
                ),
                column(
                  width = 2,
                  p("4th Pair Mark")
                ),
              ),
              fluidRow(
                column(
                  width = 2,
                  bsButton(
                    inputId = "previousL5",
                    label = "<< Previous",
                    size = "large",
                    style = "default"
                  )
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "submitL5",
                    label = "Submit",
                    size = "large",
                    style = "default"
                  )
                ),
                column(
                  width = 2,
                  offset = 4,
                  bsButton(
                    inputId = "reattemptL5",
                    label = "Reattempt",
                    size = "large",
                    style = "danger"
                  )
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "nextL5",
                    label = "Next >>",
                    size = "large",
                    style = "default"
                  )
                )
              )
            ),
            #### Game Level 6 ----
            tabPanel(
              title = "Level 6",
              br(),
              h3("Level 6: Sample Arithmetic Mean and Sample Standard Deviation"),
              p("Rearrange the histograms and/or values of the data sets by
                clicking and draging on either so that they are in the same order.
                We've provided the values
                for the ", tags$em("sample median"), " and ",
                tags$em("sample arithmetic mean"), " for each data set.",
                br(),
                "Check the 'Show more details' box if you wish to see values for
                the ", tags$em("sample standard deviation"), " and ",
                tags$em("interquartile range"), "."
              ),
              br(),
              div(
                style = "text-align: center;",
                rank_list(
                  input_id = "rank6Hists",
                  text = "Drag the histograms into the same order as the values.",
                  labels = list(
                    "a" = img(src = "right1.PNG", width = "75%"),
                    "b" = img(src = "left1.PNG", width = "75%"),
                    "c" = img(src = "normal1.PNG", width = "75%"),
                    "d" = img(src = "uniform1.PNG", width = "75%")
                  )
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 2,
                  p("Feedback:")
                ),
                column(
                  width = 2,
                  p("1st Pair Mark")
                ),
                column(
                  width = 2,
                  p("2nd Pair Mark")
                ),
                column(
                  width = 2,
                  p("3rd Pair Mark")
                ),
                column(
                  width = 2,
                  p("4th Pair Mark")
                ),
              ),
              fluidRow(
                column(
                  width = 2,
                  bsButton(
                    inputId = "previousL6",
                    label = "<< Previous",
                    size = "large",
                    style = "default"
                  )
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "submitL6",
                    label = "Submit",
                    size = "large",
                    style = "default"
                  )
                ),
                column(
                  width = 2,
                  offset = 4,
                  bsButton(
                    inputId = "reattemptL6",
                    label = "Reattempt",
                    size = "large",
                    style = "danger"
                  )
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "nextL6",
                    label = "Next >>",
                    size = "large",
                    style = "default"
                  )
                )
              )
            ),
            ## Final Scores Tab ----
            tabPanel(
              title = "Final Scores",
              br(),
              h3("Congratulations! You finished the game."),
              div(
                style = "text-align: right;",
                textOutput("finalTime")
              ),
              br(),
              h3("Your scores"),
              br(),
              fluidRow(
                column(
                  width = 4,
                  textOutput("initScore")
                ),
                column(
                  width = 4,
                  textOutput("subScore")
                ),
                column(
                  width = 4,
                  textOutput("finalScore")
                )
              )
            )
          ),
          br(),
          div(
            style = "text-align: right;",
            bsButton(
              inputId = "endGame",
              label = "End Game",
              size = "large",
              style = "danger"
            )
          )
        ),
        ### Second tab - Game ----
        tabItem(
          tabName = "game",
          useShinyjs(), # Delete soon
          tabsetPanel(
            id = "navMain", #id for this tabsetPanel
            type = "tabs",
            #### First page - Level 1 ----
            tabPanel(
              title = "Level 1",
              value = "a",
              br(),
              h2("Level 1: Mean & Median"),
              ## Second row - hint & timer button and details
              fluidRow(
                column(
                  width = 3,
                  bsButton(
                    inputId = 'bq1',
                    label = 'Hint',
                    type = 'toggle',
                    value = FALSE,
                    size = "large"
                  ),
                  bsButton(
                    inputId = 'bt1',
                    label = 'Timer',
                    type = 'toggle',
                    value = FALSE,
                    size = "large"
                  )
                ),
                column(
                  width = 6,
                  conditionalPanel(
                    condition = "input.bq1 != 0",
                    id = 'hint1q',
                    textOutput('hint1')
                  )
                ),
                column(
                  width = 3,
                  conditionalPanel(
                    condition = "input.bt1 != 0",
                    id = 'timer1h',
                    textOutput('timer1')
                  )
                )
              ),
              br(),
              checkboxInput(
                inputId = "details",
                label =  "Show more details",
                value =  FALSE
              )
            ),
            ##Third row - text boxes(Upper boxes)
            fluidRow(
              column(
                width = 3,
                h3('A', align = 'center'),  # Fixed static label
                div( # The values of statistics/picture
                  style = "text-align: center;",
                  textOutput('text1')
                ),
                conditionalPanel(
                  condition = "input.details != 0 ",
                  div(
                    style = "text-align: center;",
                    textOutput('text11')
                  )
                ),
                # The dragable element
                dragUI(
                  id = "drag1",
                  label = "A",
                  style = "width: 90%"
                )
              ),
              column(
                width = 3,
                h3('B', align = 'center'),
                div(
                  style = "text-align: center;",
                  textOutput('text2')
                ),
                conditionalPanel(
                  condition = "input.details != 0 ",
                  div(
                    style = "text-align: center;",
                    textOutput('text222')
                  )
                ),
                dragUI(
                  id = "drag2",
                  label = "B",
                  style = "width: 90%"
                )
              ),
              column(
                width = 3,
                h3('C', align = 'center'),
                div(
                  style = "text-align: center;",
                  textOutput('text3')
                ),
                conditionalPanel(
                  condition = "input.details != 0 ",
                  div(
                    style = "text-align: center;",
                    textOutput('text33')
                  )
                ),
                dragUI(
                  id = "drag3",
                  label = "C",
                  style = "width: 90%"
                )
              ),
              column(
                width = 3,
                h3('D', align = 'center'),
                div(
                  style = "text-align: center;",
                  textOutput('text4')
                ),
                conditionalPanel(
                  condition = "input.details != 0 ",
                  div(
                    style = "text-align: center;",
                    textOutput('text44')
                  )
                ),
                dragUI(
                  id = "drag4",
                  label = "D",
                  style = "width: 90%"
                )
              )
            ),
            br(),
            ##Fourth row - drop boxes and images(lower boxes)
            fluidRow(
              column(
                width = 3,
                dropUI(
                  id = "drp1",
                  style = "width: 100%"
                ),  # drop zone
                div(
                  align = "right",
                  uiOutput("answer1")
                ),  # answer mark
                br(),
                uiOutput("image1") # data visualization
              ),
              column(
                width = 3,
                dropUI(
                  id = "drp2",
                  style = "width: 100%"
                ),
                div(
                  align = "right",
                  uiOutput("answer2")
                ),
                br(),
                uiOutput("image2")
              ),
              column(
                width = 3,
                dropUI(
                  id = "drp3",
                  style = "width: 100%"
                ),
                div(
                  align = "right",
                  uiOutput("answer3")
                ),
                br(),
                uiOutput("image3")
              ),
              column(
                width = 3,
                dropUI(
                  id = "drp4",
                  style = "width: 100%"
                ),
                div(
                  align = "right",
                  uiOutput("answer4")
                ),
                br(),
                uiOutput("image4")
              )
            ),
            br(),
            ##Fifth row - buttons: previous, submit, Reattempt, and next
            fluidRow(
              column(
                width = 1,
                offset = 5,
                conditionalPanel(
                  condition = "(input.drp1!='') & (input.drp2!='') &
                  (input.drp3!='') & (input.drp4!='') ",
                  bsButton(
                    inputId = "submitA",
                    label = "Submit",
                    size = "large"
                  )
                )
              ),
              column(
                width = 2,
                offset = 1,
                conditionalPanel(
                  condition = "input.submitA != 0",
                  bsButton(
                    inputId = "clearA",
                    label =  "Reattempt",
                    style = "danger",
                    size = "large"
                  )
                )
              ),
              column(
                width = 1,
                offset = 1,
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
            conditionalPanel(
              condition = "input.submitA != 0",
              wellPanel(
                htmlOutput("scoreA"),
                div(
                  align = 'right',
                  bsButton(
                    inputId = "stop1",
                    label = "STOP",
                    style = "danger",
                    size = "large",
                    disabled = TRUE
                  )
                )
              )
            ),
            ##Last row - Penalty Box
            conditionalPanel(
              condition = "input.clearA != 0",
              fluidRow(
                column(
                  width = 12,
                  p(textOutput("warning1")),
                  dropUI(
                    id = "home1",
                    style = "width: 100%; height: 200px;"
                  ),
                  br()
                )
              )
            ),
            ###Second page - Level 2 ----
            tabPanel(
              title = "Level 2",
              value = "b",
              br(),
              h2("Level 2: Mean & Standard Deviation"),
              ##Second row - hint & timer button and details
              fluidRow(
                column(
                  width = 3,
                  bsButton(
                    inputId = 'bq2',
                    label = 'Hint',
                    type = 'toggle',
                    size = "large"
                  ),
                  bsButton(
                    inputId = 'bt2',
                    label = 'Timer',
                    type = 'toggle',
                    size = "large"
                  )
                ),
                column(
                  width = 6,
                  conditionalPanel(
                    condition = "input.bq2 != 0",
                    id ='hint2q',
                    textOutput('hint2')
                  )
                ),
                column(
                  width = 3,
                  conditionalPanel(
                    condition = "input.bt2 != 0",
                    id = 'timer2h',
                    textOutput('timer2')
                  )
                )
              ),
              br(),
              #Show everything only after the next1 button is clicked
              conditionalPanel(
                condition = "input.next1 != 0",
                ##Third row - text boxes
                fluidRow(
                  column(
                    width = 3,
                    h3('A', align = 'center'),
                    div(
                      style = "text-align: center;",
                      textOutput("text5")
                    ),
                    dragUI(
                      id = "drag5",
                      label = "A",
                      style = "width: 90%"
                    )
                  ),
                  column(
                    width = 3,
                    h3('B', align = 'center'),
                    div(
                      style = "text-align: center;",
                      textOutput("text6")
                    ),
                    dragUI(
                      id = "drag6",
                      label = "B",
                      style = "width: 90%"
                    )
                  ),
                  column(
                    width = 3,
                    h3('C', align = 'center'),
                    div(
                      style = "text-align: center;",
                      textOutput("text7")
                    ),
                    dragUI(
                      id = "drag7",
                      label = "C",
                      style = "width: 90%"
                    )
                  ),
                  column(
                    width = 3,
                    h3('D', align = 'center'),
                    div(
                      style = "text-align: center;",
                      textOutput("text8")
                    ),
                    dragUI(
                      id = "drag8",
                      label = "D",
                      style = "width: 90%"
                    )
                  )
                ),
                br(),
                ##Fourth row - drop boxes and imagess
                fluidRow(
                  column(
                    width = 3,
                    dropUI(
                      id = "drp5",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer5")
                    ),
                    br(),
                    uiOutput("image5")
                  ),
                  column(
                    width = 3,
                    dropUI(
                      id = "drp6",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer6")
                    ),
                    br(),
                    uiOutput("image6")
                  ),
                  column(
                    width = 3,
                    dropUI(
                      id = "drp7",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer7")
                    ),
                    br(),
                    uiOutput("image7")
                  ),
                  column(
                    width = 3,
                    dropUI(
                      id = "drp8",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer8")
                    ),
                    br(),
                    uiOutput("image8")
                  )
                ),
                br(),
                ##Fifth row - buttons: previous, submit, Reattempt, and next
                fluidRow(
                  column(
                    width = 1,
                    bsButton(
                      inputId = "previous6",
                      label =  "<< Previous",
                      size = "large"
                    )
                  ),
                  column(
                    width = 1,
                    offset = 4,
                    conditionalPanel(
                      condition = "(input.drp5!='') & (input.drp6!='') &
                    (input.drp7!='') & (input.drp8!='') ",
                      bsButton(
                        inputId = "submitB",
                        label = "Submit",
                        size = "large"
                      )
                    )
                  ),
                  column(
                    width = 2,
                    offset = 1,
                    conditionalPanel(
                      condition = "input.submitB != 0",
                      bsButton(
                        inputId = "clearB",
                        label =  "Reattempt",
                        style = "danger",
                        size = "large"
                      )
                    )
                  ),
                  column(
                    width = 1,
                    offset = 1,
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
                fluidRow(
                  conditionalPanel(
                    condition = "input.submitB != 0",
                    wellPanel(
                      htmlOutput("scoreB"),
                      div(
                        align = 'right',
                        bsButton(
                          inputId = "stop2",
                          label = "STOP",
                          style = "danger",
                          size = "large",
                          disabled = TRUE
                        )
                      )
                    )
                  )
                )
              ),
              ##Last row - Penalty Box
              conditionalPanel(
                condition = "input.clearB != 0",
                fluidRow(
                  column(
                    width = 12,
                    textOutput("warning2"),
                    dropUI(
                      id = "home2",
                      style = "width: 100%; height: 200px;"
                    ),
                    br()
                  )
                )
              )
            ),
            ###Third page - Level 3 ----
            tabPanel(
              title = "Level 3",
              value = "c",
              br(),
              h2("Level 3: Histogram & Boxplot"),
              ##Second row - hint & timer button and details
              fluidRow(
                column(
                  width = 3,
                  bsButton(
                    inputId = 'bq3',
                    label = 'Hint',
                    type = 'toggle',
                    size = "large"
                  ),
                  bsButton(
                    inputId = 'bt3',
                    label = 'Timer',
                    type = 'toggle',
                    size = "large"
                  )
                ),
                column(
                  width = 6,
                  conditionalPanel(
                    condition = "input.bq3 != 0",
                    id ='hint3q',
                    textOutput('hint3')
                  )
                ),
                column(
                  width = 3,
                  conditionalPanel(
                    condition = "input.bt3 != 0",
                    id ='timer3h',
                    textOutput('timer3')
                  )
                )
              ),
              br(),
              #Show everything only after the next2 button is clicked
              conditionalPanel(
                condition = "input.next2 != 0",
                ##Third row - text boxes
                fluidRow(
                  column(
                    width = 3,
                    h3('A', align = 'center'),
                    uiOutput("boxplot1"),
                    dragUI(
                      id = "drag9",
                      label = "A",
                      style = "width: 90%"
                    ),
                  ),
                  column(
                    width = 3,
                    h3('B', align = 'center'),
                    uiOutput("boxplot2"),
                    dragUI(
                      id = "drag10",
                      label = "B",
                      style = "width: 90%"
                    ),
                  ),
                  column(
                    width = 3,
                    h3('C', align = 'center'),
                    uiOutput("boxplot3"),
                    dragUI(
                      id = "drag11",
                      label = "C",
                      style = "width: 90%"
                    ),
                  ),
                  column(
                    width = 3,
                    h3('D', align = 'center'),
                    uiOutput("boxplot4"),
                    dragUI(
                      id = "drag12",
                      label = "D",
                      style = "width: 90%"
                    ),
                  )
                ),
                br(),
                ##Fourth row - drop boxes and images
                fluidRow(
                  column(
                    width = 3,
                    dropUI(
                      id = "drp9",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer9")
                    ),
                    br(),
                    uiOutput("image9")
                  ),
                  column(
                    width = 3,
                    dropUI(
                      id = "drp10",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer10")
                    ),
                    br(),
                    uiOutput("image10")
                  ),
                  column(
                    width = 3,
                    dropUI(
                      id = "drp11",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer11")
                    ),
                    br(),
                    uiOutput("image11")
                  ),
                  column(
                    width = 3,
                    dropUI(
                      id = "drp12",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer12")
                    ),
                    br(),
                    uiOutput("image12")
                  )
                ),
                br(),
                ##Fifth row - buttons: previous, submit, Reattempt, and next
                fluidRow(
                  column(
                    width = 1,
                    bsButton(
                      inputId = "previous5",
                      label =  "<< Previous",
                      size = "large"
                    )
                  ),
                  column(
                    width = 1,
                    offset = 4,
                    conditionalPanel(
                      condition = "(input.drp9!='') & (input.drp10!='') &
                    (input.drp11!='') & (input.drp12!='') ",
                      bsButton(
                        inputId = "submitC",
                        label = "Submit",
                        size = "large"
                      )
                    )
                  ),
                  column(
                    width = 2,
                    offset = 1,
                    conditionalPanel(
                      condition = "input.submitC != 0",
                      bsButton(
                        inputId = "clearC",
                        label =  "Reattempt",
                        size = "large"
                      )
                    )
                  ),
                  column(
                    width = 1,
                    offset = 1,
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
                fluidRow(
                  conditionalPanel(
                    condition = "input.submitC != 0",
                    wellPanel(
                      htmlOutput("scoreC"),
                      div(
                        align = 'right',
                        bsButton(
                          inputId = "stop3",
                          label = "STOP",
                          style = "danger",
                          size = "large",
                          disabled = TRUE
                        )
                      )
                    )
                  )
                )
              ),
              ##Last row - Penalty Box
              conditionalPanel(
                condition = "input.clearC != 0",
                fluidRow(
                  column(
                    width = 12,
                    textOutput("warning3"),
                    dropUI(
                      id = "home3",
                      style = "width: 100%; height: 200px;"
                    ),
                    br()
                  )
                )
              )
            ),
            ###Fourth page - Level 4 ----
            tabPanel(
              title = "Level 4",
              value = "d",
              br(),
              h2("Level 4: Correlation & Scatterplot"),
              p("Watch out for outliers!"),
              ##Second row - hint & timer button and details
              fluidRow(
                column(
                  width = 3,
                  bsButton(
                    inputId = 'bq4',
                    label = 'Hint',
                    type = 'toggle',
                    size = "large"
                  ),
                  bsButton(
                    inputId = 'bt4',
                    label = 'Timer',
                    type = 'toggle',
                    class = 'butt',
                    size = "large"
                  )
                ),
                column(
                  width = 6,
                  conditionalPanel(
                    condition = "input.bq4 != 0",
                    id ='hint4q',
                    textOutput('hint4')
                  )
                ),
                column(
                  width = 3,
                  conditionalPanel(
                    condition = "input.bt4 != 0",
                    id ='timer4h',
                    textOutput('timer4')
                  )
                )
              ),
              br(),
              #Show everything only after the next3 button is clicked
              conditionalPanel(
                condition = "input.next3 != 0",
                ##Third row - text boxes
                fluidRow(
                  column(
                    width = 3,
                    h3('A', align = 'center'),
                    div(
                      style = "text-align: center;",
                      textOutput("text13")
                    ),
                    dragUI(
                      id = "drag13",
                      label = "A",
                      style = "width: 90%"
                    )
                  ),
                  column(
                    width = 3,
                    h3('B', align = 'center'),
                    div(
                      style = "text-align: center;",
                      textOutput("text14")
                    ),
                    dragUI(
                      id = "drag14",
                      label = "B",
                      style = "width: 90%"
                    )
                  ),
                  column(
                    width = 3,
                    h3('C', align = 'center'),
                    div(
                      style = "text-align: center;",
                      textOutput("text15")
                    ),
                    dragUI(
                      id = "drag15",
                      label = "C",
                      style = "width: 90%"
                    )
                  ),
                  column(
                    width = 3,
                    h3('D', align = 'center'),
                    div(
                      style = "text-align: center;",
                      textOutput("text16")
                    ),
                    dragUI(
                      id = "drag16",
                      label = "D",
                      style = "width: 90%"
                    )
                  )
                ),
                br(),
                ##Fourth row - drop boxes and images
                fluidRow(
                  column(
                    width = 3,
                    dropUI(
                      id = "drp13",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer13")
                    ),
                    br(),
                    uiOutput("image13")
                  ),
                  column(
                    width = 3,
                    dropUI(
                      id = "drp14",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer14")
                    ),
                    br(),
                    uiOutput("image14")
                  ),
                  column(
                    width = 3,
                    dropUI(
                      id = "drp15",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer15")
                    ),
                    br(),
                    uiOutput("image15")
                  ),
                  column(
                    width = 3,
                    dropUI(
                      id = "drp16",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer16")
                    ),
                    br(),
                    uiOutput("image16")
                  )
                ),
                br(),
                ##Fifth row - buttons: previous, submit, Reattempt, and next
                fluidRow(
                  column(
                    width = 1,
                    bsButton(
                      inputId = "previous4",
                      label =  "<< Previous",
                      size = "large"
                    )
                  ),
                  column(
                    width = 1,
                    offset = 4,
                    conditionalPanel(
                      condition = "(input.drp13!='') & (input.drp14!='') &
                    (input.drp15!='') & (input.drp16!='') ",
                      bsButton(
                        inputId = "submitD",
                        label = "Submit",
                        size = "large"
                      )
                    )
                  ),
                  column(
                    width = 2,
                    offset = 1,
                    conditionalPanel(
                      condition = "input.submitD != 0",
                      bsButton(
                        inputId = "clearD",
                        label =  "Reattempt",
                        style = "danger",
                        size = "large"
                      )
                    )
                  ),
                  column(
                    width = 1,
                    offset = 1,
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
                fluidRow(
                  conditionalPanel(
                    condition = "input.submitD != 0",
                    wellPanel(
                      htmlOutput("scoreD"),
                      div(
                        align = 'right',
                        bsButton(
                          inputId = "stop4",
                          label = "STOP",
                          style = "danger",
                          size = "large",
                          disabled = TRUE
                        )
                      )
                    )
                  )
                )
              ),
              ##Last row - Penalty Box
              conditionalPanel(
                condition = "input.clearD != 0",
                fluidRow(
                  column(
                    width = 12,
                    textOutput("warning4"),
                    dropUI(
                      id = "home4",
                      style = "width: 100%; height: 200px;"
                    ),
                    br()
                  )
                )
              )
            ),
            ###Fifth page - Level 5 ----
            tabPanel(
              title = "Level 5",
              value = "e",
              h2("Level 5: Distribution Application"),
              ##Second row - hint & timer button and details
              fluidRow(
                column(
                  width = 3,
                  bsButton(
                    inputId = 'bq5',
                    label = 'Hint',
                    type = 'toggle',
                    size = "large"
                  ),
                  bsButton(
                    inputId = 'bt5',
                    label = 'Timer',
                    type = 'toggle',
                    size = "large"
                  )
                ),
                column(
                  width = 6,
                  conditionalPanel(
                    condition = "input.bq5 != 0",
                    id = 'hint5q',
                    textOutput('hint5')
                  )
                ),
                column(
                  width = 3,
                  conditionalPanel(
                    condition = "input.bt5 != 0",
                    id = 'timer5h',
                    textOutput('timer5')
                  )
                )
              ),
              br(),
              #Show everything only after the next4 button is clicked
              conditionalPanel(
                condition = "input.next4 != 0",
                ##Third row - text boxes
                fluidRow(
                  column(
                    width = 3,
                    h3('A', align = 'center'),
                    div(
                      style = "text-align: center;",
                      textOutput("text17")
                    ),
                    dragUI(
                      id = "drag17",
                      label = "A",
                      style = "width: 90%"
                    )
                  ),
                  column(
                    width = 3,
                    h3('B', align = 'center'),
                    div(
                      style = "text-align: center;",
                      textOutput("text18")
                    ),
                    dragUI(
                      id = "drag18",
                      label = "B",
                      style = "width: 90%"
                    )
                  ),
                  column(
                    width = 3,
                    h3('C', align = 'center'),
                    div(
                      style = "text-align: center;",
                      textOutput("text19")
                    ),
                    dragUI(
                      id = "drag19",
                      label = "C",
                      style = "width: 90%"
                    )
                  ),
                  column(
                    width = 3,
                    h3('D', align = 'center'),
                    div(
                      style = "text-align: center;",
                      textOutput("text20")
                    ),
                    dragUI(
                      id = "drag20",
                      label = "D",
                      style = "width: 90%"
                    )
                  )
                ),
                br(),
                ##Fourth row - drop boxes and images
                fluidRow(
                  column(
                    width = 3,
                    dropUI(
                      id = "drp17",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer17")
                    ),
                    br(),
                    uiOutput("image17")
                  ),
                  column(
                    width = 3,
                    dropUI(
                      id = "drp18",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer18")
                    ),
                    br(),
                    uiOutput("image18")
                  ),
                  column(
                    width = 3,
                    dropUI(
                      id = "drp19",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer19")
                    ),
                    br(),
                    uiOutput("image19")
                  ),
                  column(
                    width = 3,
                    dropUI(
                      id = "drp20",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer20")
                    ),
                    br(),
                    uiOutput("image20")
                  )
                ),
                br(),
                ##Fifth row - buttons: previous, submit, Reattempt, and next
                fluidRow(
                  column(
                    width = 1,
                    bsButton(
                      inputId = "previous3",
                      label =  "<< Previous",
                      size = "large"
                    )
                  ),
                  column(
                    width = 1,
                    offset = 4,
                    conditionalPanel(
                      condition = "(input.drp17!='') & (input.drp18!='') &
                    (input.drp19!='') & (input.drp20!='') ",
                      bsButton(
                        inputId = "submitE",
                        label = "Submit",
                        size = "large"
                      )
                    )
                  ),
                  column(
                    width = 2,
                    offset = 1,
                    conditionalPanel(
                      condition = "input.submitE != 0",
                      bsButton(
                        inputId = "clearE",
                        label =  "Reattempt",
                        style = "danger",
                        size = "large"
                      )
                    )
                  ),
                  column(
                    width = 1,
                    offset = 1,
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
                fluidRow(
                  conditionalPanel(
                    condition = "input.submitE != 0",
                    wellPanel(
                      htmlOutput("scoreE"),
                      div(
                        align = 'right',
                        bsButton(
                          inputId = "stop5",
                          label = "STOP",
                          style = "danger",
                          size = "large",
                          disabled = TRUE
                        )
                      )
                    )
                  )
                )
              ),
              ##Last row - Penalty Box
              conditionalPanel(
                condition = "input.clearE != 0",
                fluidRow(
                  column(
                    width = 12,
                    textOutput("warning5"),
                    dropUI(
                      id = "home5",
                      style = "width: 100%; height: 200px;"
                    ),
                    br()
                  )
                )
              )
            ),
            ###Sixth page - Level 6 ----
            tabPanel(
              title = "Level 6",
              value = "f",
              br(),
              h2("Level 6: Correlation & Application"),
              p('Order the correlation from the highest to the lowest.'),
              ##Second row - hint & timer button and details
              fluidRow(
                column(
                  width = 3,
                  bsButton(
                    inputId = 'bq6',
                    label = 'Hint',
                    type = 'toggle',
                    size = "large"
                  ),
                  bsButton(
                    inputId = 'bt6',
                    label = 'Timer',
                    type = 'toggle',
                    size = "large"
                  )
                ),
                column(
                  width = 6,
                  conditionalPanel(
                    condition = "input.bq6 != 0",
                    id ='hint6q',
                    textOutput('hint6')
                  )
                ),
                column(
                  width = 3,
                  conditionalPanel(
                    condition = "input.bt6 != 0",
                    id ='timer6h',
                    textOutput('timer6')
                  )
                )
              ),
              br(),
              #Show everything only after the next5 button is clicked
              conditionalPanel(
                condition = "input.next5 != 0",
                ##Third row - text boxes
                fluidRow(
                  column(
                    width = 3,
                    h3('A', align = 'center'),
                    div(
                      style = "text-align: center;",
                      textOutput("text21")
                    ),
                    dragUI(
                      id = "drag21",
                      label = "A",
                      style = "width: 90%"
                    )
                  ),
                  column(
                    width = 3,
                    h3('B', align = 'center'),
                    div(
                      style = "text-align: center;",
                      textOutput("text22")
                    ),
                    dragUI(
                      id = "drag22",
                      label = "B",
                      style = "width: 90%"
                    )
                  ),
                  column(
                    width = 3,
                    h3('C', align = 'center'),
                    div(
                      style = "text-align: center;",
                      textOutput("text23")
                    ),
                    dragUI(
                      id = "drag23",
                      label = "C",
                      style = "width: 90%"
                    )
                  ),
                  column(
                    width = 3,
                    h3('D', align = 'center'),
                    div(
                      style = "text-align: center;",
                      textOutput("text24")
                    ),
                    dragUI(
                      id = "drag24",
                      label = "D",
                      style = "width: 90%"
                    )
                  )
                ),
                br(),
                ##Fourth row - drop boxes and images
                fluidRow(
                  column(
                    width = 3,
                    dropUI(
                      id = "drp21",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer21")
                    ),
                    h3("highest")
                  ),
                  column(
                    width = 3,
                    dropUI(
                      id = "drp22",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer22")
                    )
                  ),
                  column(
                    width = 3,
                    dropUI(
                      id = "drp23",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer23")
                    )
                  ),
                  column(
                    width = 3,
                    dropUI(
                      id = "drp24",
                      style = "width: 100%"
                    ),
                    div(
                      align = "right",
                      uiOutput("answer24")
                    ),
                    h3("lowest", align = 'right')
                  )
                ),
                br(),
                ##Fifth row - buttons: previous, submit, Reattempt, and next
                fluidRow(
                  column(
                    width = 1,
                    bsButton(
                      inputId = "previous2",
                      label =  "<< Previous",
                      size = "large"
                    )
                  ),
                  column(
                    width = 1,
                    offset = 4,
                    conditionalPanel(
                      condition = "(input.drp21!='') & (input.drp22!='') &
                    (input.drp23!='') & (input.drp24!='') ",
                      bsButton(
                        inputId = "submitF",
                        label = "Submit",
                        size = "large"
                      )
                    )
                  ),
                  column(
                    width = 2,
                    offset = 1,
                    conditionalPanel(
                      condition = "input.submitF != 0",
                      bsButton(
                        inputId = "clearF",
                        label =  "Reattempt",
                        style = "danger",
                        size = "large"
                      )
                    )
                  ),
                  column(
                    width = 1,
                    offset = 1,
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
                fluidRow(
                  conditionalPanel(
                    condition = "input.submitF != 0",
                    wellPanel(
                      htmlOutput("scoreF")
                    )
                  )
                )
              ),
              ##Last row - Penalty Box
              conditionalPanel(
                condition = "input.clearF != 0",
                fluidRow(
                  column(
                    width = 12,
                    textOutput("warning6"),
                    dropUI(
                      id = "home6",
                      style = "width: 100%; height: 200px;"
                    ),
                    br()
                  )
                )
              )
            ),
            ###Last page - Scores ----
            tabPanel(
              title = "Score",
              value = "g",
              br(),
              h2("Congratulations! You finished the game."),
              fluidRow(
                column(
                  width = 3,
                  offset = 9,
                  tags$strong(textOutput("timer8"))
                )
              ),
              br(),
              br(),
              h3("Your scores:"),
              br(),
              fluidRow(
                column(
                  width = 4,
                  textOutput("init")
                ),
                column(
                  width = 4,
                  textOutput("subsequent")
                ),
                column(
                  width = 4,
                  textOutput("totalScore")
                )
              )
            )
          )
        ),
        ### References ----
        tabItem(
          tabName = "References",
          h2("References"),
          p( #shinyjs
            class = "hangingindent",
            "Attali, D. (2020), Easily Improve the User Experience of Your Shiny
            Apps in Seconds, R package. Available from
            https://cran.r-project.org/web/packages/shinyjs/shinyjs.pdf"
          ),
          p( #shinyBS
            class = "hangingindent",
            "Bailey, E. (2015), shinyBS: Twitter bootstrap components for shiny,
            R package. Available from https://CRAN.R-project.org/package=shinyBS"
          ),
          p( #Boast Utilities
            class = "hangingindent",
            "Carey, R. (2019), boastUtils: BOAST Utilities, R Package. Available
            from https://github.com/EducationShinyAppTeam/boastUtils"
          ),
          p( #shinydashboard
            class = "hangingindent",
            "Chang, W. and Borges Ribeio, B. (2018), shinydashboard: Create
            dashboards with 'Shiny', R Package. Available from
            https://CRAN.R-project.org/package=shinydashboard"
          ),
          p( #shiny
            class = "hangingindent",
            "Chang, W., Cheng, J., Allaire, J., Xie, Y., and McPherson, J. (2019),
            shiny: Web application framework for R, R Package. Available from
            https://CRAN.R-project.org/package=shiny"
          ),
          p( #shinyDND
            class = "hangingindent",
            "Hoffer, A. (2016), shinyDND: Shiny Drag-n-Drop, R Package. Available
            from https://cran.r-project.org/web/packages/shinyDND/index.html"
          ),
          p( #shinyWidgets
            class = "hangingindent",
            "Perrier, V., Meyer, F., Granjon, D., Fellows, I., and Davis, W.
            (2020), shinyWidgets: Custom Inputs Widgets for Shiny, R package.
            Available from
            https://cran.r-project.org/web/packages/shinyWidgets/index.html"
          )
        )
      )
    )
  )
)

# Define the Server ----
server <- function(input, output, session) {
  output$chosen <- renderPrint(input$selected)
  output$test1 <- renderPrint(paste("Match:", input$rank1Hists == input$rank1Values))

  # Information button ----
  observeEvent(input$info, {
    sendSweetAlert(
      session = session,
      title = "Instructions",
      text = tags$ol(
        tags$li("You can check time and hint by clicking the boxes"),
        tags$li("Drag and drop A, B, C, D into the drop box."),
        tags$li("Submit your answer only after finishing all the questions."),
        tags$li("You will need to click 'Reattempt' button to try again."),
        tags$li("You can stop and check your score any level,
                once you get every question correct."),
        tags$li("You may go to the next level only
                when you correct any wrong answer.")
      ),
      type = "info"
    )
  })

  ## Show/Hide Tabs ----
  ### Commenting out for now
  # ### Show pages by buttons like 'next', 'previous'.
  # observe({
  #   hide(selector = "#navMain li a[data-value=a]")
  # })
  # observeEvent(input$start, {
  #   show(selector = "#navMain li a[data-value=a]")
  # })
  # observeEvent(input$tabs, {
  #   if (input$tabs == "game"){
  #     show(selector = "#navMain li a[data-value=a]")
  #   }
  # })
  # observe({
  #   hide(selector = "#navMain li a[data-value=b]")
  # })
  # observeEvent(input$next1, {
  #   show(selector = "#navMain li a[data-value=b]")
  # })
  # observe({
  #   hide(selector = "#navMain li a[data-value=c]")
  # })
  # observeEvent(input$next2, {
  #   show(selector = "#navMain li a[data-value=c]")
  # })
  # observe({
  #   hide(selector = "#navMain li a[data-value=d]")
  # })
  # observeEvent(input$next3, {
  #   show(selector = "#navMain li a[data-value=d]")
  # })
  # observe({
  #   hide(selector = "#navMain li a[data-value=e]")
  # })
  # observeEvent(input$next4, {
  #   show(selector = "#navMain li a[data-value=e]")
  # })
  # observe({
  #   hide(selector = "#navMain li a[data-value=f]")
  # })
  # observeEvent(input$next5, {
  #   show(selector = "#navMain li a[data-value=f]")
  # })
  # observe({
  #   hide(selector = "#navMain li a[data-value=g]")
  # })
  # observeEvent(input$finish, {
  #   show(selector = "#navMain li a[data-value=g]")
  # })

  ## Start button ----
  observeEvent(input$start, {
    updateTabItems(
      session = session,
      inputId = "tabs",
      selected = "game"
    )
    ### This was listed lower down and isn't necessary
    # updateTabsetPanel(
    #   session = session,
    #   inputId = "navMain",
    #   selected = "a"
    # )
  })

  ## Next buttons ----
  observeEvent(input$next1, {
    updateTabsetPanel(
      session = session,
      inputId = "navMain",
      selected = "b"
    )
  })
  observeEvent(input$next2, {
    updateTabsetPanel(
      session = session,
      inputId = "navMain",
      selected = "c"
    )
  })
  observeEvent(input$next3, {
    updateTabsetPanel(
      session = session,
      inputId = "navMain",
      selected = "d"
    )
  })
  observeEvent(input$next4, {
    updateTabsetPanel(
      session = session,
      inputId = "navMain",
      selected = "e"
    )
  })
  observeEvent(input$next5, {
    updateTabsetPanel(
      session = session,
      inputId = "navMain",
      selected = "f"
    )
  })
  observeEvent(input$finish, {
    updateTabsetPanel(
      session = session,
      inputId = "navMain",
      selected = "g"
    )
  })

  ## Stop buttons ----
  observeEvent(input$stop1, {
    updateTabsetPanel(
      session = session,
      inputId = "navMain",
      selected = "g"
    )
  })
  observeEvent(input$stop2, {
    updateTabsetPanel(
      session = session,
      inputId = "navMain",
      selected = "g"
    )
  })
  observeEvent(input$stop3, {
    updateTabsetPanel(
      session = session,
      inputId = "navMain",
      selected = "g"
    )
  })
  observeEvent(input$stop4, {
    updateTabsetPanel(
      session = session,
      inputId = "navMain",
      selected = "g"
    )
  })
  observeEvent(input$stop5, {
    updateTabsetPanel(
      session = session,
      inputId = "navMain",
      selected = "g"
    )
  })

  ## Previous buttons ----
  observeEvent(input$previous6, {
    updateTabsetPanel(
      session = session,
      inputId = "navMain",
      selected = "a"
    )
  })
  observeEvent(input$previous5, {
    updateTabsetPanel(
      session = session,
      inputId = "navMain",
      selected = "b"
    )
  })
  observeEvent(input$previous4, {
    updateTabsetPanel(
      session = session,
      inputId = "navMain",
      selected = "c"
    )
  })
  observeEvent(input$previous3, {
    updateTabsetPanel(
      session = session,
      inputId = "navMain",
      selected = "d"
    )
  })
  observeEvent(input$previous2, {
    updateTabsetPanel(
      session = session,
      inputId = "navMain",
      selected = "e"
    )
  })

  ## Timer ----
  ### Define timer
  time <- reactiveValues(inc = 0, timer = reactiveTimer(1000), started = FALSE)
  observe({
    time$timer()
    if(isolate(time$started))
      time$inc <- isolate(time$inc) + 1
  })

  ### When user click submit, timer stops and rerun on next level
  observeEvent(input$start, {time$started <- TRUE})
  observeEvent(input$tabs, {if (input$tabs == "game") {time$started < -TRUE}})
  observeEvent(input$submitA, {time$started <- FALSE})
  observeEvent(input$submitB, {time$started <- FALSE})
  observeEvent(input$submitC, {time$started <- FALSE})
  observeEvent(input$submitD, {time$started <- FALSE})
  observeEvent(input$submitE, {time$started <- FALSE})
  observeEvent(input$submitF, {time$started <- FALSE})
  observeEvent(input$next1, {time$started <- TRUE})
  observeEvent(input$next2, {time$started <- TRUE})
  observeEvent(input$next3, {time$started <- TRUE})
  observeEvent(input$next4, {time$started <- TRUE})
  observeEvent(input$next5, {time$started <- TRUE})
  observeEvent(input$finish, {time$timer<-reactiveTimer(Inf)})

  ### Show the timer
  observeEvent(input$bt1 == TRUE, {
    toggle('timer1h')
    output$timer1 <- renderText({
      paste("You have used", time$inc, "seconds.")
    })
  })
  observeEvent(input$bt2 == TRUE, {
    toggle('timer2h')
    output$timer2 <- renderText({
      paste("You have used:", time$inc, "seconds.")
    })
  })
  observeEvent(input$bt3 == TRUE, {
    toggle('timer3h')
    output$timer3 <- renderText({
      paste("You have used:", time$inc, "seconds.")
    })
  })
  observeEvent(input$bt4 == TRUE, {
    toggle('timer4h')
    output$timer4 <- renderText({
      paste("You have used:", time$inc, "seconds.")
    })
  })
  observeEvent(input$bt5 == TRUE, {
    toggle('timer5h')
    output$timer5 <- renderText({
      paste("You have used:", time$inc, "seconds.")
    })
  })
  observeEvent(input$bt6 == TRUE, {
    toggle('timer6h')
    output$timer6 <- renderText({
      paste("You have used:", time$inc, "seconds.")
    })
  })
  output$timer8 <- renderText({
    paste("You have used:", time$inc, "seconds.")
  })

  ## Hints ----
  ### Hint messages on Hint button
  observeEvent(input$bq1 == FALSE, {
    toggle('hint1q')
    output$hint1 <- renderText({
      "The mean and median are the same for symmetric histograms while the mean
      is bigger for right-skewed histograms and the median is bigger for left
      skewed histograms."
    })
  })
  observeEvent(input$bq2 == TRUE, {
    toggle('hint2q')
    output$hint2 <- renderText({
      "The standard deviation measures variation so it will be smaller when
      there's more of the distribution close to the center"
    })
  })
  observeEvent(input$bq3 == TRUE, {
    toggle('hint3q')
    output$hint3 <- renderText({
      "You should be able to tell where the median is and whether the
      distribution is skewed or symmetric from looking at either the boxplot or
      the histogram"
    })
  })
  observeEvent(input$bq4 == TRUE, {
    toggle('hint4q')
    output$hint4 <- renderText({
      "Correlations closer to -1 show points more tightly clustered around a
      downward sloping line. Correlations closer to +1 show points more tightly
      clustered around an upward sloping line. Also outliers can have a big
      effect on the correlation."
    })
  })
  observeEvent(input$bq5 == TRUE, {
    toggle('hint5q')
    output$hint5 <- renderText({
      "Bimodal distributions arise when you are sampling from two different
      populations. For skewed possibilities think about whether the unusual
      values (outliers) are likely to be on the right side or left side of the
      plot."
    })
  })
  observeEvent(input$bq6 == TRUE, {
    toggle('hint6q')
    output$hint6 <- renderText({
      "Remember that negative values are smaller than positive values. So your
      largest positive correlation goes under 'highest' and your most negative
      correlation goes under 'lowest'"
    })
  })

  ## Level 1 Question Text ----
  ##  Contents - This is where all third row elements came from
  # set reactive value
  numbersA <- reactiveValues(right= c(), left= c(), normal = c(), random = c(),
                             indexA = c(), questionA = data.frame())
  observeEvent(input$start | input$game,{
    # first column on the level 1
    numbersA$right = sample(1:3,1)
    numbersA$left = sample(4:6,1)
    numbersA$normal = sample(7:12,1)
    numbersA$random = sample(13:20,1)
    # set index value
    numbersA$indexA = sample(c("A","B","C","D"),4)
    # this is where question generated
    numbersA$questionA = cbind(bankA[c(numbersA$right,
                                       numbersA$left,numbersA$normal,numbersA$random),],numbersA$indexA)
  })
  output$text1 <- renderText({
    numbersA$questionA[numbersA$questionA[6]== "A", 4]
  })
  output$text11 <- renderText({
    numbersA$questionA[numbersA$questionA[6]== "A", 5]
  })
  output$image1 <- renderUI({
    img(src = numbersA$questionA[numbersA$questionA[1] == "right",3],
        alt = 'Histogram', width = "100%")
  })
  output$text2 <- renderText({
    numbersA$questionA[numbersA$questionA[6]== "B", 4]
  })
  output$text222 <- renderText({
    numbersA$questionA[numbersA$questionA[6]== "B", 5]
  })
  output$image2 <- renderUI({
    img(src = numbersA$questionA[numbersA$questionA[1] == "left",3],
        alt = 'Histogram', width = "100%")
  })
  output$text3 <- renderText({
    numbersA$questionA[numbersA$questionA[6]== "C", 4]
  })
  output$text33 <- renderText({
    numbersA$questionA[numbersA$questionA[6]== "C", 5]
  })
  output$image3 <- renderUI({
    img(src = numbersA$questionA[numbersA$questionA[1] == "normal",3],
        alt = 'Histogram', width = "100%")
  })
  output$text4 <- renderText({
    numbersA$questionA[numbersA$questionA[6]== "D", 4]
  })
  output$text44 <- renderText({
    numbersA$questionA[numbersA$questionA[6]== "D", 5]
  })
  output$image4 <- renderUI({
    img(src = numbersA$questionA[numbersA$questionA[1] == "random",3],
        alt = 'Histogram', width = "100%")
  })
  ## Level 2 Question Text ----
  numbersB <- reactiveValues(mean1= c(), mean2= c(), mean3 = c(), mean4 = c(),
                             indexB = c(), questionB = data.frame())
  observeEvent(input$start | input$game,{
    numbersB$mean1 = sample(1:3,1)
    numbersB$mean2 = sample(4:6,1)
    numbersB$mean3 = sample(7:9,1)
    numbersB$mean4 = sample(10:12,1)
    numbersB$indexB = sample(c("A","B","C","D"),4)
    numbersB$questionB = cbind(bankB[c(numbersB$mean1,
                                       numbersB$mean2,numbersB$mean3,numbersB$mean4),],numbersB$indexB)
  })
  output$text5 <- renderText({
    numbersB$questionB[numbersB$questionB[4]== "A", 2]
  })
  output$image5 <- renderUI({
    img(src = numbersB$questionB[numbersB$questionB[1] == "mean1",3],
        alt = 'Distribution', width = "100%")
  })
  output$text6 <- renderText({
    numbersB$questionB[numbersB$questionB[4]== "B", 2]
  })
  output$image6 <- renderUI({
    img(src = numbersB$questionB[numbersB$questionB[1] == "mean2",3],
        alt = 'Distribution', width = "100%")
  })
  output$text7 <- renderText({
    numbersB$questionB[numbersB$questionB[4]== "C", 2]
  })
  output$image7 <- renderUI({
    img(src = numbersB$questionB[numbersB$questionB[1] == "mean3",3],
        alt = 'Distribution', width = "100%")
  })
  output$text8 <- renderText({
    numbersB$questionB[numbersB$questionB[4]== "D", 2]
  })
  output$image8 <- renderUI({
    img(src = numbersB$questionB[numbersB$questionB[1] == "mean4",3],
        alt = 'Distribution', width = "100%")
  })
  ## Level 3 Question Text ----
  numbersC <- reactiveValues(left= c(), right= c(), normal = c(),
                             uniform = c(), indexC = c(), questionC = data.frame())
  observeEvent(input$start | input$game,{
    numbersC$left = sample(1:4,1)
    numbersC$right = sample(5:9,1)
    numbersC$normal = sample(10:12,1)
    numbersC$uniform = sample(13:14,1)
    numbersC$indexC = sample(c("A","B","C","D"),4)
    numbersC$questionC = cbind(bankC[c(numbersC$left,
                                       numbersC$right,numbersC$normal,numbersC$uniform),],numbersC$indexC)
  })
  output$boxplot1 <- renderUI({
    img(src = numbersC$questionC[numbersC$questionC[4] == "A",3],
        alt = 'Boxplot', width = "100%")
  })
  output$boxplot2 <- renderUI({
    img(src = numbersC$questionC[numbersC$questionC[4] == "B",3],
        alt = 'Boxplot', width = "100%")
  })
  output$boxplot3 <- renderUI({
    img(src = numbersC$questionC[numbersC$questionC[4] == "C",3],
        alt = 'Boxplot', width = "100%")
  })
  output$boxplot4 <- renderUI({
    img(src = numbersC$questionC[numbersC$questionC[4] == "D",3],
        alt = 'Boxplot', width = "100%")
  })
  output$image9 <- renderUI({
    img(src = numbersC$questionC[numbersC$questionC[1] == "left",2],
        alt = 'Histogram', width = "100%")
  })
  output$image10 <- renderUI({
    img(src = numbersC$questionC[numbersC$questionC[1] == "right",2],
        alt = 'Histogram', width = "100%")
  })
  output$image11 <- renderUI({
    img(src = numbersC$questionC[numbersC$questionC[1] == "normal",2],
        alt = 'Histogram', width = "100%")
  })
  output$image12 <- renderUI({
    img(src = numbersC$questionC[numbersC$questionC[1] == "uniform",2],
        alt = 'Histogram', width = "100%")
  })
  ## Level 4 Question Text ----
  numbersD <- reactiveValues(neg= c(), pos= c(), out = c(), hhh = c(),
                             indexD = c(), questionD = data.frame())
  observeEvent(input$start | input$game,{
    numbersD$neg = sample(1:6,1)
    numbersD$pos = sample(7:12,1)
    numbersD$out = sample(13:16,1)
    numbersD$hhh = sample(17:20,1)
    numbersD$indexD = sample(c("A","B","C","D"),4)
    numbersD$questionD = cbind(bankD[c(numbersD$neg,
                                       numbersD$pos,numbersD$out,numbersD$hhh),],numbersD$indexD)
  })
  output$text13 <- renderText({
    numbersD$questionD[numbersD$questionD[4]== "A", 1]
  })
  output$image13 <- renderUI({
    img(src = numbersD$questionD[numbersD$questionD[3] == "neg",2],
        alt = 'Correlation Plot', width = "100%")
  })
  output$text14 <- renderText({
    numbersD$questionD[numbersD$questionD[4]== "B", 1]
  })
  output$image14 <- renderUI({
    img(src = numbersD$questionD[numbersD$questionD[3] == "pos",2],
        alt = 'Correlation Plot', width = "100%")
  })
  output$text15 <- renderText({
    numbersD$questionD[numbersD$questionD[4]== "C", 1]
  })
  output$image15 <- renderUI({
    img(src = numbersD$questionD[numbersD$questionD[3] == "out",2],
        alt = 'Correlation Plot', width = "100%")
  })
  output$text16 <- renderText({
    numbersD$questionD[numbersD$questionD[4]== "D", 1]
  })
  output$image16 <- renderUI({
    img(src = numbersD$questionD[numbersD$questionD[3] == "hhh",2],
        alt = 'Correlation Plot', width = "100%")
  })
  ## Level 5 Question Text ----
  ######## This code need to be changed because of its different coding
  ######## style compare to other levels, though all question bank needs updated
  numbersE <- reactiveValues(bimodal= c(), left= c(), right= c(),
                             normal = c(), indexE = c(), questionE = data.frame())
  observeEvent(input$start | input$game,{
    numbersE$bimodal = sample(1:5,1)
    numbersE$left = sample(6:10,1)
    numbersE$right = sample(11:15,1)
    numbersE$normal = sample(16:20,1)
    numbersE$indexE = sample(c("A","B","C","D"),4)
    numbersE$questionE = cbind(bankE[c(numbersE$bimodal,
                                       numbersE$left,numbersE$right,numbersE$normal),],numbersE$indexE)
  })
  output$text17 <- renderText({
    numbersE$questionE[numbersE$questionE[5]== "A", 4]
  })
  output$image17 <- renderUI({
    img(src = "symmetric.PNG", alt = 'Distribution', width = "100%")
  })
  output$text18 <- renderText({
    numbersE$questionE[numbersE$questionE[5]== "B", 4]
  })
  output$image18 <- renderUI({
    img(src = "right-skewed.PNG", alt = 'Distribution', width = "100%")
  })
  output$text19 <- renderText({
    numbersE$questionE[numbersE$questionE[5]== "C",4]
  })
  output$image19 <- renderUI({
    img(src = "left-skewed.PNG", alt = 'Distribution', width = "100%")
  })
  output$text20 <- renderText({
    numbersE$questionE[numbersE$questionE[5]== "D", 4]
  })
  output$image20 <- renderUI({
    img(src = "bimodal.PNG", alt = 'Distribution', width = "100%")
  })
  ## Level 6-1 Question Text ----
  numbersF1 <- reactiveValues(first = c(), indexF1 = c(),
                              questionF1 = data.frame())
  observeEvent(input$start | input$game,{
    numbersF1$first = c(1,2,3,4)
    numbersF1$indexF1 = sample(c("A","B","C","D"),4)
    numbersF1$questionF1 = cbind(bankF1[numbersF1$first,],numbersF1$indexF1)
  })
  choice = sample(1:4, 1)
  if (choice==1){
    output$text21 <- renderText({
      numbersF1$questionF1[numbersF1$questionF1[3]== "A", 1]
    })
    output$text22 <- renderText({
      numbersF1$questionF1[numbersF1$questionF1[3]== "B", 1]
    })
    output$text23 <- renderText({
      numbersF1$questionF1[numbersF1$questionF1[3]== "C", 1]
    })
    output$text24 <- renderText({
      numbersF1$questionF1[numbersF1$questionF1[3]== "D", 1]
    })}
  ## Level 6-2 Question Text ----
  numbersF2 <- reactiveValues(second = c(), indexF2 = c(),
                              questionF2 = data.frame())
  observeEvent(input$start,{
    numbersF2$second = c(1,2,3,4)
    numbersF2$indexF2 = sample(c("A","B","C","D"),4)
    numbersF2$questionF2 = cbind(bankF2[numbersF2$second,],numbersF2$indexF2)
  })
  if(choice==2){
    output$text21 <- renderText({
      numbersF2$questionF2[numbersF2$questionF2[3]== "A", 1]
    })
    output$text22 <- renderText({
      numbersF2$questionF2[numbersF2$questionF2[3]== "B", 1]
    })
    output$text23 <- renderText({
      numbersF2$questionF2[numbersF2$questionF2[3]== "C", 1]
    })
    output$text24 <- renderText({
      numbersF2$questionF2[numbersF2$questionF2[3]== "D", 1]
    })
  }
  ## Level 6-3 Question Text ----
  numbersF3 <- reactiveValues(third = c(), indexF3 = c(),
                              questionF3 = data.frame())
  observeEvent(input$start | input$game,{
    numbersF3$third = c(1,2,3,4)
    numbersF3$indexF3 = sample(c("A","B","C","D"),4)
    numbersF3$questionF3 = cbind(bankF3[numbersF3$third,],numbersF3$indexF3)
  })
  if(choice==3){
    output$text21 <- renderText({
      numbersF3$questionF3[numbersF3$questionF3[3]== "A", 1]
    })
    output$text22 <- renderText({
      numbersF3$questionF3[numbersF3$questionF3[3]== "B", 1]
    })
    output$text23 <- renderText({
      numbersF3$questionF3[numbersF3$questionF3[3]== "C", 1]
    })
    output$text24 <- renderText({
      numbersF3$questionF3[numbersF3$questionF3[3]== "D", 1]
    })
  }
  ## Level 6-4 Question Text ----
  numbersF4 <- reactiveValues(last = c(), indexF4 = c(),
                              questionF4 = data.frame())
  observeEvent(input$start | input$game,{
    numbersF4$last = c(1,2,3,4)
    numbersF4$indexF4 = sample(c("A","B","C","D"),4)
    numbersF4$questionF4 = cbind(bankF4[numbersF4$last,],numbersF4$indexF4)
  })
  if(choice==4){
    output$text21 <- renderText({
      numbersF4$questionF4[numbersF4$questionF4[3]== "A", 1]
    })
    output$text22 <- renderText({
      numbersF4$questionF4[numbersF4$questionF4[3]== "B", 1]
    })
    output$text23 <- renderText({
      numbersF4$questionF4[numbersF4$questionF4[3]== "C", 1]
    })
    output$text24 <- renderText({
      numbersF4$questionF4[numbersF4$questionF4[3]== "D", 1]
    })
  }

  ## Submit buttons ----
  observeEvent(input$submitF,{
    updateButton(
      session = session,
      inputId = "submitF",
      disabled = TRUE
    )
    updateButton(
      session = session,
      inputId = "clearF",
      disabled = FALSE
    )
  })
  ### Level 1
  observeEvent(input$submitA,{
    output$answer1 <- renderUI({
      # when dragable element droped in the drop box
      if (!is.null(input$drp1)){
        # check whether that element matches 'right'
        if (input$drp1 == numbersA$questionA[numbersA$questionA[1]== "right", 6]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    output$answer2 <- renderUI({
      if (!is.null(input$drp2)){
        if (input$drp2 == numbersA$questionA[numbersA$questionA[1]== "left", 6]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    output$answer3 <- renderUI({
      if (!is.null(input$drp3)){
        if (input$drp3 == numbersA$questionA[numbersA$questionA[1]== "normal", 6]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    output$answer4 <- renderUI({
      if (!is.null(input$drp4)){
        if (input$drp4 == numbersA$questionA[numbersA$questionA[1]== "random", 6]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    #### Submit button and show Penalty box.
    updateButton(
      session = session,
      inputId = "submitA",
      disabled = TRUE
    )
    updateButton(
      session = session,
      inputId = "clearA",
      disabled = FALSE
    )
  })

  ### Level 2
  observeEvent(input$submitB,{
    output$answer5 <- renderUI({
      if (!is.null(input$drp5)){
        if (input$drp5 ==numbersB$questionB[numbersB$questionB[1]== "mean1", 4]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    output$answer6 <- renderUI({
      if (!is.null(input$drp6)){
        if (input$drp6 == numbersB$questionB[numbersB$questionB[1]== "mean2", 4]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    output$answer7 <- renderUI({
      if (!is.null(input$drp7)){
        if (input$drp7 == numbersB$questionB[numbersB$questionB[1]== "mean3", 4]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    output$answer8 <- renderUI({
      if (!is.null(input$drp8)){
        if (input$drp8 == numbersB$questionB[numbersB$questionB[1]== "mean4", 4]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    updateButton(
      session = session,
      inputId = "submitB",
      disabled = TRUE
    )
    updateButton(
      session = session,
      inputId = "clearB",
      disabled = FALSE
    )
  })

  ### Level 3
  observeEvent(input$submitC,{
    output$answer9 <- renderUI({
      if (!is.null(input$drp9)){
        if (input$drp9 ==numbersC$questionC[numbersC$questionC[1] == "left",4]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    output$answer10 <- renderUI({
      if (!is.null(input$drp10)){
        if (input$drp10 == numbersC$questionC[numbersC$questionC[1] == "right",4]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    output$answer11 <- renderUI({
      if (!is.null(input$drp11)){
        if (input$drp11 == numbersC$questionC[numbersC$questionC[1] == "normal",4]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    output$answer12 <- renderUI({
      if (!is.null(input$drp12)){
        if (input$drp12 == numbersC$questionC[numbersC$questionC[1] == "uniform",4]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    updateButton(
      session = session,
      inputId = "submitC",
      disabled = TRUE
    )
    updateButton(
      session = session,
      inputId = "clearC",
      disabled = FALSE
    )
  })

  ### Level 4
  observeEvent(input$submitD,{
    output$answer13 <- renderUI({
      if (!is.null(input$drp13)){
        if (input$drp13 ==numbersD$questionD[numbersD$questionD[3] == "neg",4]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    output$answer14 <- renderUI({
      if (!is.null(input$drp14)){
        if (input$drp14 == numbersD$questionD[numbersD$questionD[3] == "pos",4]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    output$answer15 <- renderUI({
      if (!is.null(input$drp15)){
        if (input$drp15 == numbersD$questionD[numbersD$questionD[3] == "out",4]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    output$answer16 <- renderUI({
      if (!is.null(input$drp16)){
        if (input$drp16 == numbersD$questionD[numbersD$questionD[3] == "hhh",4]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    updateButton(
      session = session,
      inputId = "submitD",
      disabled = TRUE
    )
    updateButton(
      session = session,
      inputId = "clearD",
      disabled = FALSE
    )
  })

  ### Level 5
  observeEvent(input$submitE, {
    output$answer17 <- renderUI({
      if (!is.null(input$drp17)){
        if (input$drp17 ==numbersE$questionE[numbersE$questionE[1] == "normal",5]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    output$answer18 <- renderUI({
      if (!is.null(input$drp18)){
        if (input$drp18 ==numbersE$questionE[numbersE$questionE[1] == "right",5]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    output$answer19 <- renderUI({
      if (!is.null(input$drp19)){
        if (input$drp19 == numbersE$questionE[numbersE$questionE[1] == "left",5]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    output$answer20 <- renderUI({
      if (!is.null(input$drp20)){
        if (input$drp20 == numbersE$questionE[numbersE$questionE[1] == "binomial",5]){
          img(src = "check.png", alt = 'Correct', width = '10%')
        }else{
          img(src = "cross.png", alt = 'Incorrect', width = '10%')
        }
      }
    })
    updateButton(
      session = session,
      inputId = "submitE",
      disabled = TRUE
    )
    updateButton(
      session = session,
      inputId = "clearE",
      disabled = FALSE
    )
  })

  ### Level 6
  #### Needs to have the clear buttons moved
  if(choice==1){
    observeEvent(input$submitF,{
      output$answer21 <- renderUI({
        if (!is.null(input$drp21)){
          if (input$drp21 == numbersF1$questionF1[numbersF1$questionF1[2] == "1",3]){
            img(src = "check.png", alt = 'Correct', width = '10%')
          }else{
            img(src = "cross.png", alt = 'Incorrect', width = '10%')
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer21 <- renderUI({
        img(src = NULL)
      })
    })
    observeEvent(input$submitF,{
      output$answer22 <- renderUI({
        if (!is.null(input$drp22)){
          if (input$drp22 ==numbersF1$questionF1[numbersF1$questionF1[2] == "2",3]){
            img(src = "check.png", alt = 'Correct', width = '10%')
          }else{
            img(src = "cross.png", alt = 'Incorrect', width = '10%')
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer22 <- renderUI({
        img(src = NULL)
      })
    })
    observeEvent(input$submitF,{
      output$answer23 <- renderUI({
        if (!is.null(input$drp23)){
          if (input$drp23 == numbersF1$questionF1[numbersF1$questionF1[2] == "3",3]){
            img(src = "check.png", alt = 'Correct', width = '10%')
          }else{
            img(src = "cross.png", alt = 'Incorrect', width = '10%')
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer23 <- renderUI({
        img(src = NULL)
      })
    })
    observeEvent(input$submitF,{
      output$answer24 <- renderUI({
        if (!is.null(input$drp24)){
          if (input$drp24 == numbersF1$questionF1[numbersF1$questionF1[2] == "4",3]){
            img(src = "check.png", alt = 'Correct', width = '10%')
          }else{
            img(src = "cross.png", alt = 'Incorrect', width = '10%')
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer24 <- renderUI({
        img(src = NULL)
      })
    })}

  if(choice==2){
    observeEvent(input$submitF,{
      output$answer21 <- renderUI({
        if (!is.null(input$drp21)){
          if (input$drp21 ==numbersF2$questionF2[numbersF2$questionF2[2] == "1",3]){
            img(src = "check.png", alt = 'Correct', width = '10%')
          }else{
            img(src = "cross.png", alt = 'Incorrect', width = '10%')
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer21 <- renderUI({
        img(src = NULL)
      })
    })
    observeEvent(input$submitF,{
      output$answer22 <- renderUI({
        if (!is.null(input$drp22)){
          if (input$drp22 ==numbersF2$questionF2[numbersF2$questionF2[2] == "2",3]){
            img(src = "check.png", alt = 'Correct', width = '10%')
          }else{
            img(src = "cross.png", alt = 'Incorrect', width = '10%')
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer22 <- renderUI({
        img(src = NULL)
      })
    })
    observeEvent(input$submitF,{
      output$answer23 <- renderUI({
        if (!is.null(input$drp23)){
          if (input$drp23 == numbersF2$questionF2[numbersF2$questionF2[2] == "3",3]){
            img(src = "check.png", alt = 'Correct', width = '10%')
          }else{
            img(src = "cross.png", alt = 'Incorrect', width = '10%')
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer23 <- renderUI({
        img(src = NULL)
      })
    })
    observeEvent(input$submitF,{
      output$answer24 <- renderUI({
        if (!is.null(input$drp24)){
          if (input$drp24 == numbersF2$questionF2[numbersF2$questionF2[2] == "4",3]){
            img(src = "check.png", alt = 'Correct', width = '10%')
          }else{
            img(src = "cross.png", alt = 'Incorrect', width = '10%')
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer24 <- renderUI({
        img(src = NULL)
      })
    })}
  if(choice==3){
    observeEvent(input$submitF,{
      output$answer21 <- renderUI({
        if (!is.null(input$drp21)){
          if (input$drp21 ==numbersF3$questionF3[numbersF3$questionF3[2] == "1",3]){
            img(src = "check.png", alt = 'Correct', width = '10%')
          }else{
            img(src = "cross.png", alt = 'Incorrect', width = '10%')
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer21 <- renderUI({
        img(src = NULL)
      })
    })
    observeEvent(input$submitF,{
      output$answer22 <- renderUI({
        if (!is.null(input$drp22)){
          if (input$drp22 ==numbersF3$questionF3[numbersF3$questionF3[2] == "2",3]){
            img(src = "check.png", alt = 'Correct', width = '10%')
          }else{
            img(src = "cross.png", alt = 'Incorrect', width = '10%')
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer22 <- renderUI({
        img(src = NULL)
      })
    })
    observeEvent(input$submitF,{
      output$answer23 <- renderUI({
        if (!is.null(input$drp23)){
          if (input$drp23 == numbersF3$questionF3[numbersF3$questionF3[2] == "3",3]){
            img(src = "check.png", alt = 'Correct', width = '10%')
          }else{
            img(src = "cross.png", alt = 'Incorrect', width = '10%')
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer23 <- renderUI({
        img(src = NULL)
      })
    })
    observeEvent(input$submitF,{
      output$answer24 <- renderUI({
        if (!is.null(input$drp24)){
          if (input$drp24 == numbersF3$questionF3[numbersF3$questionF3[2] == "4",3]){
            img(src = "check.png", alt = 'Correct', width = '10%')
          }else{
            img(src = "cross.png", alt = 'Incorrect', width = '10%')
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer24 <- renderUI({
        img(src = NULL)
      })
    })}
  if(choice==4){
    observeEvent(input$submitF,{
      output$answer21 <- renderUI({
        if (!is.null(input$drp21)){
          if (input$drp21 ==numbersF4$questionF4[numbersF4$questionF4[2] == "1",3]){
            img(src = "check.png", alt = 'Correct', width = '10%')
          }else{
            img(src = "cross.png", alt = 'Incorrect', width = '10%')
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer21 <- renderUI({
        img(src = NULL)
      })
    })
    observeEvent(input$submitF,{
      output$answer22 <- renderUI({
        if (!is.null(input$drp22)){
          if (input$drp22 ==numbersF4$questionF4[numbersF4$questionF4[2] == "2",3]){
            img(src = "check.png", alt = 'Correct', width = '10%')
          }else{
            img(src = "cross.png", alt = 'Incorrect', width = '10%')
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer22 <- renderUI({
        img(src = NULL)
      })
    })
    observeEvent(input$submitF,{
      output$answer23 <- renderUI({
        if (!is.null(input$drp23)){
          if (input$drp23 == numbersF4$questionF4[numbersF4$questionF4[2] == "3",3]){
            img(src = "check.png", alt = 'Correct', width = '10%')
          }else{
            img(src = "cross.png", alt = 'Incorrect', width = '10%')
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer23 <- renderUI({
        img(src = NULL)
      })
    })
    observeEvent(input$submitF,{
      output$answer24 <- renderUI({
        if (!is.null(input$drp24)){
          if (input$drp24 == numbersF4$questionF4[numbersF4$questionF4[2] == "4",3]){
            img(src = "check.png", alt = 'Correct', width = '10%')
          }else{
            img(src = "cross.png", alt = 'Incorrect', width = '10%')
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer24 <- renderUI({
        img(src = NULL)
      })
    })}

  ## Clear buttons ----
  observeEvent(input$clearF, {
    updateButton(
      session = session,
      inputId = "submitF",
      disabled = FALSE
    )
    updateButton(
      session = session,
      inputId = "clearF",
      disabled = TRUE
    )
  })

  ### Level 1
  observeEvent(input$clearA, {
    output$answer1 <- renderUI({
      img(src = NULL)
    })
    output$answer2 <- renderUI({
      img(src = NULL)
    })
    output$answer3 <- renderUI({
      img(src = NULL)
    })
    output$answer4 <- renderUI({
      img(src = NULL)
    })
    updateButton(
      session = session,
      inputId = "submitA",
      disabled = FALSE
    )
    updateButton(
      session = session,
      inputId = "clearA",
      disabled = TRUE
    )
  })

  ### Level 2
  observeEvent(input$clearB, {
    output$answer5 <- renderUI({
      img(src = NULL)
    })
    output$answer6 <- renderUI({
      img(src = NULL)
    })
    output$answer7 <- renderUI({
      img(src = NULL)
    })
    output$answer8 <- renderUI({
      img(src = NULL)
    })
    updateButton(
      session = session,
      inputId = "submitB",
      disabled = FALSE
    )
    updateButton(
      session = session,
      inputId = "clearB",
      disabled = TRUE
    )
  })

  ### Level 3
  observeEvent(input$clearC, {
    output$answer9 <- renderUI({
      img(src = NULL)
    })
    output$answer10 <- renderUI({
      img(src = NULL)
    })
    output$answer11 <- renderUI({
      img(src = NULL)
    })
    output$answer12 <- renderUI({
      img(src = NULL)
    })
    updateButton(
      session = session,
      inputId = "submitC",
      disabled = FALSE
    )
    updateButton(
      session = session,
      inputId = "clearC",
      disabled = TRUE
    )
  })

  ### Level 4
  observeEvent(input$clearD, {
    output$answer13 <- renderUI({
      img(src = NULL)
    })
    output$answer14 <- renderUI({
      img(src = NULL)
    })
    output$answer15 <- renderUI({
      img(src = NULL)
    })
    output$answer16 <- renderUI({
      img(src = NULL)
    })
    updateButton(
      session = session,
      inputId = "submitD",
      disabled = FALSE
    )
    updateButton(
      session = session,
      inputId = "clearD",
      disabled = TRUE
    )
  })

  ### Level 5
  observeEvent(input$clearE, {
    output$answer17 <- renderUI({
      img(src = NULL)
    })
    output$answer18 <- renderUI({
      img(src = NULL)
    })
    output$answer19 <- renderUI({
      img(src = NULL)
    })
    output$answer20 <- renderUI({
      img(src = NULL)
    })
    updateButton(
      session = session,
      inputId = "submitE",
      disabled = FALSE
    )
    updateButton(
      session = session,
      inputId = "clearE",
      disabled = TRUE
    )
  })

  ### Level 6
  #### Currently tied up with the submit buttons and crazy if logic

  ## Individual Scoring Systems ----
  # The score system was made with reactive values, which need to be changed
  summation <- reactiveValues(
    summationA = c(rep(0,8)),
    summationB = c(rep(0,8)), summationC = c(rep(0,16)),
    summationD = c(rep(0,20)), summationE = c(rep(0,24)),
    summationF = c(rep(0,24)), summationScore = c(rep(0,100))
  )
  ### Level 1
  observeEvent(input$submitA,{
    score1 = c()
    score2 = c()
    score3 = c()
    score4 = c()
    for (i in input$drp1){
      if (i == numbersA$questionA[numbersA$questionA[1]== "right", 6]){
        score1 = c(score1,2)
      }else{
        score1 = c(score1,-1)
      }
    }
    for (i in input$drp2){
      if (i == numbersA$questionA[numbersA$questionA[1]== "left", 6]){
        score2 = c(score2,2)
      }else{
        score2 = c(score2,-1)
      }
    }
    for (i in input$drp3){
      if (i == numbersA$questionA[numbersA$questionA[1]== "normal", 6]){
        score3 = c(score3,2)
      }else{
        score3 = c(score3,-1)
      }
    }
    for (i in input$drp4){
      if (i == numbersA$questionA[numbersA$questionA[1]== "random", 6]){
        score4 = c(score4,2)
      }else{
        score4 = c(score4,-1)
      }
    }
    summation$summationA[input$submitA] <- sum(c(score1,score2, score3, score4))
  })
  output$scoreA <- renderUI({
    str1 <- paste("Your current score on this level is:")
    str2 <- paste(summation$summationA[input$submitA]," out of 8.")
    HTML(paste(str1, str2, sep = '<br/>'))
  })
  ### Level 2
  observeEvent(input$submitB,{
    score5 = c()
    score6 = c()
    score7 = c()
    score8 = c()
    for (i in input$drp5){
      if (i == numbersB$questionB[numbersB$questionB[1]== "mean1", 4]){
        score5 = c(score5,2)
      }else{
        score5 = c(score5,-1)
      }
    }
    for (i in input$drp6){
      if (i == numbersB$questionB[numbersB$questionB[1]== "mean2", 4]){
        score6 = c(score6,2)
      }else{
        score6 = c(score6,-1)
      }
    }
    for (i in input$drp7){
      if (i == numbersB$questionB[numbersB$questionB[1]== "mean3", 4]){
        score7 = c(score7,2)
      }else{
        score7 = c(score7,-1)
      }
    }
    for (i in input$drp8){
      if (i == numbersB$questionB[numbersB$questionB[1]== "mean4", 4]){
        score8 = c(score8,2)
      }else{
        score8 = c(score8,-1)
      }
    }
    summation$summationB[input$submitB] <- sum(c(score5,score6, score7, score8))
  })
  output$scoreB <- renderUI({
    str3 <- paste("Your current score on this level is:")
    str4 <- paste(summation$summationB[input$submitB]," out of 8.")
    HTML(paste(str3, str4, sep = '<br/>'))
  })
  ### Level 3
  observeEvent(input$submitC,{
    score9 = c()
    score10 = c()
    score11 = c()
    score12 = c()
    for (i in input$drp9){
      if (i ==  numbersC$questionC[numbersC$questionC[1] == "left",4]){
        score9 = c(score9,4)
      }else{
        score9 = c(score9,-2)
      }
    }
    for (i in input$drp10){
      if (i ==  numbersC$questionC[numbersC$questionC[1] == "right",4]){
        score10 = c(score10,4)
      }else{
        score10 = c(score10,-2)
      }
    }
    for (i in input$drp11){
      if (i ==  numbersC$questionC[numbersC$questionC[1] == "normal",4]){
        score11 = c(score11,4)
      }else{
        score11 = c(score11,-2)
      }
    }
    for (i in input$drp12){
      if (i ==  numbersC$questionC[numbersC$questionC[1] == "uniform",4]){
        score12 = c(score12,4)
      }else{
        score12 = c(score12,-2)
      }
    }
    summation$summationC[input$submitC] <- sum(c(score9,score10, score11, score12))
  })
  output$scoreC <- renderUI({
    str5 <- paste("Your current score on this level is:")
    str6 <- paste(summation$summationC[input$submitC]," out of 16.")
    HTML(paste(str5, str6, sep = '<br/>'))
  })
  ### Level 4
  observeEvent(input$submitD,{
    score13 = c()
    score14 = c()
    score15 = c()
    score16 = c()
    for (i in input$drp13){
      if (i == numbersD$questionD[numbersD$questionD[3]== "neg", 4]){
        score13 = c(score13,5)
      }else{
        score13 = c(score13,-3)
      }
    }
    for (i in input$drp14){
      if (i ==  numbersD$questionD[numbersD$questionD[3]== "pos", 4]){
        score14 = c(score14,5)
      }else{
        score14 = c(score14,-3)
      }
    }
    for (i in input$drp15){
      if (i ==  numbersD$questionD[numbersD$questionD[3]== "out", 4]){
        score15 = c(score15,5)
      }else{
        score15 = c(score15,-3)
      }
    }
    for (i in input$drp16){
      if (i == numbersD$questionD[numbersD$questionD[3]== "hhh", 4]){
        score16 = c(score16,5)
      }else{
        score16 = c(score16,-3)
      }
    }
    summation$summationD[input$submitD] <- sum(c(score13,score14, score15, score16))
  })
  output$scoreD <- renderUI({
    str7 <- paste("Your current score on this level is:")
    str8 <- paste(summation$summationD[input$submitD]," out of 20.")
    HTML(paste(str7, str8, sep = '<br/>'))
  })
  ### Level 5
  observeEvent(input$submitE,{
    score17 = c()
    score18 = c()
    score19 = c()
    score20 = c()
    for (i in input$drp17){
      if (i == numbersE$questionE[numbersE$questionE[1] == "normal",5]){
        score17 = c(score17,6)
      }else{
        score17 = c(score17,-3)
      }
    }
    for (i in input$drp18){
      if (i ==  numbersE$questionE[numbersE$questionE[1] == "right",5]){
        score18 = c(score18,6)
      }else{
        score18 = c(score18,-3)
      }
    }
    for (i in input$drp19){
      if (i ==  numbersE$questionE[numbersE$questionE[1] == "left",5]){
        score19 = c(score19,6)
      }else{
        score19 = c(score19,-3)
      }
    }
    for (i in input$drp20){
      if (i == numbersE$questionE[numbersE$questionE[1] == "binomial",5]){
        score20 = c(score20,6)
      }else{
        score20 = c(score20,-3)
      }
    }
    summation$summationE[input$submitE] <- sum(c(score17,score18, score19, score20))
  })
  output$scoreE <- renderUI({
    str9 <- paste("Your current score on this level is:")
    str10 <- paste(summation$summationE[input$submitE]," out of 24.")
    HTML(paste(str9, str10, sep = '<br/>'))
  })
  ### Level 6
  observeEvent(input$submitF,{
    score21 = c()
    score22 = c()
    score23 = c()
    score24 = c()
    if(choice==1){
      for (i in input$drp21){
        if (i == numbersF1$questionF1[numbersF1$questionF1[2] == "1",3]){
          score21 = c(score21,6)
        }else{
          score21 = c(score21,-3)
        }
      }
      for (i in input$drp22){
        if (i ==  numbersF1$questionF1[numbersF1$questionF1[2] == "2",3]){
          score22 = c(score22,6)
        }else{
          score22 = c(score22,-3)
        }
      }
      for (i in input$drp23){
        if (i ==  numbersF1$questionF1[numbersF1$questionF1[2] == "3",3]){
          score23 = c(score23,6)
        }else{
          score23 = c(score23,-3)
        }
      }
      for (i in input$drp24){
        if (i == numbersF1$questionF1[numbersF1$questionF1[2] == "4",3]){
          score24 = c(score24,6)
        }else{
          score24 = c(score24,-3)
        }
      } }
    else if(choice==2){
      for (i in input$drp21){
        if (i == numbersF2$questionF2[numbersF2$questionF2[2] == "1",3]){
          score21 = c(score21,6)
        }else{
          score21 = c(score21,-3)
        }
      }
      for (i in input$drp22){
        if (i ==  numbersF2$questionF2[numbersF2$questionF2[2] == "2",3]){
          score22 = c(score22,6)
        }else{
          score22 = c(score22,-3)
        }
      }
      for (i in input$drp23){
        if (i ==  numbersF2$questionF2[numbersF2$questionF2[2] == "3",3]){
          score23 = c(score23,6)
        }else{
          score23 = c(score23,-3)
        }
      }
      for (i in input$drp24){
        if (i == numbersF2$questionF2[numbersF2$questionF2[2] == "4",3]){
          score24 = c(score24,6)
        }else{
          score24 = c(score24,-3)
        }
      } }
    else if(choice==3){
      for (i in input$drp21){
        if (i == numbersF3$questionF3[numbersF3$questionF3[2] == "1",3]){
          score21 = c(score21,6)
        }else{
          score21 = c(score21,-3)
        }
      }
      for (i in input$drp22){
        if (i ==  numbersF3$questionF3[numbersF3$questionF3[2] == "2",3]){
          score22 = c(score22,6)
        }else{
          score22 = c(score22,-3)
        }
      }
      for (i in input$drp23){
        if (i ==  numbersF3$questionF3[numbersF3$questionF3[2] == "3",3]){
          score23 = c(score23,6)
        }else{
          score23 = c(score23,-3)
        }
      }
      for (i in input$drp24){
        if (i == numbersF3$questionF3[numbersF3$questionF3[2] == "4",3]){
          score24 = c(score24,6)
        }else{
          score24 = c(score24,-3)
        }
      } }
    else if(choice==4){
      for (i in input$drp21){
        if (i == numbersF4$questionF4[numbersF4$questionF4[2] == "1",3]){
          score21 = c(score21,6)
        }else{
          score21 = c(score21,-3)
        }
      }
      for (i in input$drp22){
        if (i == numbersF4$questionF4[numbersF4$questionF4[2] == "2",3]){
          score22 = c(score22,6)
        }else{
          score22 = c(score22,-3)
        }
      }
      for (i in input$drp23){
        if (i ==  numbersF4$questionF4[numbersF4$questionF4[2] == "3",3]){
          score23 = c(score23,6)
        }else{
          score23 = c(score23,-3)
        }
      }
      for (i in input$drp24){
        if (i == numbersF4$questionF4[numbersF4$questionF4[2] == "4",3]){
          score24 = c(score24,6)
        }else{
          score24 = c(score24,-3)
        }
      } }
    summation$summationF[input$submitF] <- sum(c(score21,score22, score23, score24))
  })
  output$scoreF <- renderUI({
    str11 <- paste("Your current score on this level is:")
    str12 <- paste(summation$summationF[input$submitF]," out of 24.")
    HTML(paste(str11, str12, sep = '<br/>'))
  })

  ## Penalty box ----
  values = reactiveValues(count = 0)

  ### Level 1
  observeEvent(input$submitA, {
    if(summation$summationA[input$submitA] == 8){
      updateButton(
        session = session,
        inputId = "next1",
        disabled = FALSE
      )
      updateButton(
        session = session,
        inputId = "stop1",
        disabled = FALSE
      )
      output$warning1 <- renderText({
        "Congratulations! You are ready to move on!"
      })
    } else {
      output$warning1 <- renderText({
        "Please drag wrong answers into this PENALTY box and drag back to try
        again."
      })
    }
  })

  ### Level 2
  observeEvent(input$submitB, {
    if(summation$summationB[input$submitB] == 8){
      updateButton(
        session = session,
        inputId = "next2",
        disabled = FALSE
      )
      updateButton(
        session = session,
        inputId = "stop2",
        disabled = FALSE
      )
      output$warning2 <- renderText({
        "Congratulations! You are ready to move on!"
      })
    } else {
      output$warning2 <- renderText({
        "Please drag wrong answers into this PENALTY box and drag back to try
        again."
      })
    }
  })

  ### Level 3
  observeEvent(input$submitC, {
    if(summation$summationC[input$submitC] == 16){
      updateButton(
        session = session,
        inputId = "next3",
        disabled = FALSE
      )
      updateButton(
        session = session,
        inputId = "stop3",
        disabled = FALSE
      )
      output$warning3 <- renderText({
        "Congratulations! You are ready to move on!"
      })
    } else {
      output$warning3 <- renderText({
        "Please drag wrong answers into this PENALTY box and drag back to try
        again."
      })
    }
  })

  ### Level 4
  observeEvent(input$submitD, {
    if(summation$summationD[input$submitD] == 20) {
      updateButton(
        session = session,
        inputId = "next4",
        disabled = FALSE
      )
      updateButton(
        session = session,
        inputId = "stop4",
        disabled = FALSE
      )
      output$warning4 <- renderText({
        "Congratulations! You are ready to move on!"
      })
    } else {
      output$warning4 <- renderText({
        "Please drag wrong answers into this PENALTY box and drag back to try
        again."
      })
    }
  })

  ### Level 5
  observeEvent(input$submitE, {
    if(summation$summationE[input$submitE] == 24){
      updateButton(
        session = session,
        inputId = "next5",
        disabled = FALSE
      )
      updateButton(
        session = session,
        inputId = "stop5",
        disabled = FALSE
      )
      output$warning5 <- renderText({
        "Congratulations! You are ready to move on!"
      })
    } else {
      output$warning5 <- renderText({
        "Please drag wrong answers into this PENALTY box and drag back to try
        again."
      })
    }
  })

  ### Level 6
  observeEvent(input$submitF, {
    if(summation$summationF[input$submitF] == 24){
      updateButton(
        session = session,
        inputId = "finish",
        disabled = FALSE
      )
      output$warning6 <- renderText({
        "Congratulations! You are ready to move on!"
      })
    }
    else{
      updateButton(
        session = session,
        inputId = "finish",
        disabled = TRUE
      )
      output$warning6 <- renderText({
        "Please drag wrong answers into this PENALTY box and drag back to try
        again."
      })
    }
  })

  ## Final Scores ----
  ### Initial score
  output$init <- renderText({
    if (
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] == 0) &
      any(summation$summationC[1] == 0) &
      any(summation$summationD[1] == 0) &
      any(summation$summationE[1] == 0) &
      any(summation$summationF[1] == 0)
    ) {
      initialScore = summation$summationA[1]
    } else if (
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] != 0) &
      any(summation$summationC[1] == 0) &
      any(summation$summationD[1] == 0) &
      any(summation$summationE[1] == 0) &
      any(summation$summationF[1] == 0)
    ) {
      initialScore = summation$summationA[1] + summation$summationB[1]
    } else if(
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] != 0) &
      any(summation$summationC[1] != 0) &
      any(summation$summationD[1] == 0) &
      any(summation$summationE[1] == 0) &
      any(summation$summationF[1] == 0)
    ) {
      initialScore = summation$summationA[1] + summation$summationB[1] +
        summation$summationC[1]
    } else if (
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] != 0) &
      any(summation$summationC[1] != 0) &
      any(summation$summationD[1] != 0) &
      any(summation$summationE[1] == 0) &
      any(summation$summationF[1] == 0)
    ) {
      initialScore = summation$summationA[1] + summation$summationB[1] +
        summation$summationC[1] + summation$summationD[1]
    } else if (
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] != 0) &
      any(summation$summationC[1] != 0) &
      any(summation$summationD[1] != 0) &
      any(summation$summationE[1] != 0) &
      any(summation$summationF[1] == 0)
    ) {
      initialScore = summation$summationA[1] + summation$summationB[1] +
        summation$summationC[1] + summation$summationD[1] +
        summation$summationE[1]
    } else if (
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] != 0) &
      any(summation$summationC[1] != 0) &
      any(summation$summationD[1] != 0) &
      any(summation$summationE[1] != 0) &
      any(summation$summationF[1] != 0)
    ) {
      initialScore = summation$summationA[1] + summation$summationB[1] +
        summation$summationC[1] + summation$summationD[1] +
        summation$summationE[1] + summation$summationF[1]
    } else {
      initialScore = 0
    }
    paste("Total First Attempt Score:", initialScore)
  })
  ### Subsequent score
  output$subsequent <- renderText({
    if (
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] == 0) &
      any(summation$summationC[1] == 0) &
      any(summation$summationD[1] == 0) &
      any(summation$summationE[1] == 0) &
      any(summation$summationF[1] == 0)
    ) {
      subsequentScore <- 8
    } else if (
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] != 0) &
      any(summation$summationC[1] == 0) &
      any(summation$summationD[1] == 0) &
      any(summation$summationE[1] == 0) &
      any(summation$summationF[1] == 0)
    ) {
      subsequentScore <- 16
    } else if (
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] != 0) &
      any(summation$summationC[1] != 0) &
      any(summation$summationD[1] == 0) &
      any(summation$summationE[1] == 0) &
      any(summation$summationF[1] == 0)
    ) {
      subsequentScore <- 32
    } else if (
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] != 0) &
      any(summation$summationC[1] != 0) &
      any(summation$summationD[1] != 0) &
      any(summation$summationE[1] == 0) &
      any(summation$summationF[1] == 0)
    ) {
      subsequentScore <- 52
    } else if (
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] != 0) &
      any(summation$summationC[1] != 0) &
      any(summation$summationD[1] != 0) &
      any(summation$summationE[1] != 0) &
      any(summation$summationF[1] == 0)
    ) {
      subsequentScore <- 76
    } else if (
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] != 0) &
      any(summation$summationC[1] != 0) &
      any(summation$summationD[1] != 0) &
      any(summation$summationE[1] != 0) &
      any(summation$summationF[1] != 0)
    ) {
      subsequentScore <- 100
    } else {
      subsequentScore <- 0
    }
    paste("Total Subsequent Attempt Scores:", subsequentScore)
  })

  ### Final Score
  output$totalScore <- renderText({
    if (
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] == 0) &
      any(summation$summationC[1] == 0) &
      any(summation$summationD[1] == 0) &
      any(summation$summationE[1] == 0) &
      any(summation$summationF[1] == 0)
    ) {
      summationScore <- round(
        as.numeric(summation$summationA[1]) * (2/3) + 2.67,
        digits = 1
      )
    } else if (
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] != 0) &
      any(summation$summationC[1] == 0) &
      any(summation$summationD[1] == 0) &
      any(summation$summationE[1] == 0) &
      any(summation$summationF[1] == 0)
    ) {
      summationScore <- round(
        as.numeric(summation$summationA[1] + summation$summationB[1]) * (2/3) +
          5.33,
        digits = 1
      )
    } else if (
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] != 0) &
      any(summation$summationC[1] != 0) &
      any(summation$summationD[1] == 0) &
      any(summation$summationE[1] == 0) &
      any(summation$summationF[1] == 0)
    ) {
      summationScore <- round(
        as.numeric(summation$summationA[1] + summation$summationB[1] +
                     summation$summationC[1]) * (2/3) + 10.67,
        digits = 1
      )
    } else if(
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] != 0) &
      any(summation$summationC[1] != 0) &
      any(summation$summationD[1] != 0) &
      any(summation$summationE[1] == 0) &
      any(summation$summationF[1] == 0)
    ) {
      summationScore <- round(
        as.numeric(summation$summationA[1] + summation$summationB[1] +
                     summation$summationC[1] + summation$summationD[1]) * (2/3)
        + 17.33,
        digits = 1
      )
    } else if (
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] != 0) &
      any(summation$summationC[1] != 0) &
      any(summation$summationD[1] != 0) &
      any(summation$summationE[1] != 0) &
      any(summation$summationF[1] == 0)
    ) {
      summationScore <- round(
        as.numeric(summation$summationA[1] + summation$summationB[1] +
                     summation$summationC[1] + summation$summationD[1] +
                     summation$summationE[1]) * (2/3) + 25.33,
        digits = 1
      )
    } else if (
      any(summation$summationA[1] != 0) &
      any(summation$summationB[1] != 0) &
      any(summation$summationC[1] != 0) &
      any(summation$summationD[1] != 0) &
      any(summation$summationE[1] != 0) &
      any(summation$summationF[1] != 0)
    ) {
      summationScore <- round(
        as.numeric(summation$summationA[1] + summation$summationB[1] +
                     summation$summationC[1] + summation$summationD[1] +
                     summation$summationE[1] + summation$summationF[1]) * (2/3)
        + 33.33,
        digits = 1
      )
    } else {
      summationScore <- 0
    }
    paste("Final Total Score:", summationScore)
  })
}

#Call Boast App
boastUtils::boastApp(ui = ui, server = server)