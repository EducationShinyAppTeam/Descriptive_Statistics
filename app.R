# Call libraries
library(shiny)
library(shinyBS)
library(shinydashboard)
library(boastUtils)
library(shinyWidgets)
library(sortable)
library(dplyr)
library(DT)

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
questionBank <- read.csv(file = "questionBank.csv", stringsAsFactors = FALSE)
questionBank <- questionBank %>%
  dplyr::group_by(level) %>%
  dplyr::group_split()
## Access levels of bank by questionBank[[#]], where # is the level number
maxScores <- c(8, 8, 16, 20, 24, 24)

# Define the UI ----
ui <- list(
  dashboardPage(
    skin = "yellow",
    ## Header ----
    dashboardHeader(
      titleWidth = 250,
      title = "Descriptive Statistics",
      tags$li(class = "dropdown",
              actionLink("info", icon("info", class = "myClass"))),
      tags$li(
        class = "dropdown",
        tags$a(target = "_blank", icon("comments"),
               href = "https://pennstate.qualtrics.com/jfe/form/SV_7TLIkFtJEJ7fEPz?appName=Descriptive_Statistics"
        )
      ),
      tags$li(
        class = "dropdown",
        tags$a(href = "https://shinyapps.science.psu.edu/",
               icon("home"))
      )
    ),
    ## Sidebar ----
    dashboardSidebar(
      width = 250,
      sidebarMenu(
        id = "pages",
        menuItem("Overview", tabName = "overview", icon = icon("tachometer-alt")),
        menuItem("Game", tabName = "game", icon = icon("gamepad")),
        menuItem("References", tabName = "References", icon = icon("leanpub"))
      ),
      tags$div(class = "sidebar-logo",
               boastUtils::psu_eberly_logo("reversed"))
    ),
    ## Body ----
    dashboardBody(
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
            tags$li("Level 1: Histograms, Sample Arithmetic Mean, and Sample Median"),
            tags$li("Level 2: Density Curves, Sample Arithmteic Mean, and Sample
                    Standard Deviation"),
            tags$li("Level 3: Histograms and Box Plots"),
            tags$li("Level 4: Scatterplots and Correlation"),
            tags$li("Level 5: Shapes of Distributions and Situations"),
            tags$li("Level 6: Ranking Correlation Situations")
          ),
          h2("Instructions"),
          tags$ol(
            tags$li("You can check time and hint by clicking the appropriate buttons."),
            tags$li("Rearrange the options so that the two columns are in the
                    same order OR, for a single column, the order requested."),
            tags$li("Click the submit button to grade your ordering."),
            tags$li("If you have any incorrect, continue reordering and press
                    Submit to update the feedback."),
            tags$li("You may move to the next level only when you get all correct."),
            tags$li("You may end the game at any time.")
          ),
          p("You can expand any of the pictures to get a closer look by clicking
            on the magnifying glass with each one."),
          p("Note for Apple Safari Users: you might need to double click on the
            images/drag boxes in order to rearrange them."),
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
          in June 2018. A special thanks to Caihui Xiao and Yuxin Zhang for help
          on some programming issues. Daehoon Gwak made updates in July 2020.",
            br(),
            "Neil Hatfield did a redesign in September 2020 based on Daehoon's
            work. Thank you to Bob Carey for creating the code for the expandable
            images.",
            br(),
            br(),
            br(),
            div(class = "updated", "Last Update: 9/29/2020 by NJH.")
          )
        ),
        ### Game Tab ----
        tabItem(
          tabName = "game",
          h2("Descriptive Statistics Reordering Game"),
          fluidRow(
            column(
              width = 2,
              bsButton(
                inputId = "timer",
                label = "Show Timer",
                icon = icon("stopwatch"),
                size = "large"
              )
            ),
            column(
              width = 5,
              offset = 5,
              uiOutput(
                outputId = "timerMessage",
                style = "text-align: right;"
              )
            )
          ),
          br(),
          tabsetPanel(
            id = "gameLevels",
            type = "hidden",
            #### Game Level 1 ----
            tabPanel(
              title = "Level 1",
              br(),
              h3("Level 1: Histograms, Sample Arithmetic Mean, and Sample Median"),
              p("Rearrange the histograms and/or values of the data sets by
                clicking and dragging on either so that they are in the same order.
                We've provided the values
                for the ", tags$em("sample median"), " and ",
                tags$em("sample arithmetic mean"), " for each data set.",
                br(),
                br(),
                "To see the values of the", tags$em("sample standard deviation"),
                " and ", tags$em("interquartile range"), "click the 'Show more
                details' box. Click the Hint button to
                display a hint."
              ),
              checkboxInput(
                inputId = "extraDetailsL1",
                label = "Show more details",
                value = FALSE
              ),
              fluidRow(
                column(
                  width = 2,
                  bsButton(
                    inputId = "hintL1",
                    label = "Hint",
                    style = "default",
                    size = "large"
                  )
                ),
                column(
                  width = 10,
                  uiOutput("hintTextL1")
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 6,
                  uiOutput("mainColL1")
                ),
                column(
                  width = 6,
                  offset = 0,
                  uiOutput("secondaryColL1")
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 2,
                  p("Feedback:")
                ),
                column(
                  width = 1,
                  p("1st Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL1P1")
                ),
                column(
                  width = 1,
                  p("2nd Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL1P2")
                ),
                column(
                  width = 1,
                  p("3rd Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL1P3")
                ),
                column(
                  width = 1,
                  p("4th Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL1P4")
                ),
                column(
                  width = 2,
                  uiOutput("scoreL1")
                )
              ),
              fluidRow(
                column(
                  width = 2,
                  bsButton(
                    inputId = "previousL1",
                    label = "<< Previous",
                    size = "large",
                    style = "default",
                    disabled = TRUE
                  )
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "submitL1",
                    label = "Submit",
                    size = "large",
                    style = "default"
                  )
                ),
                column(
                  width = 3,
                  p("Press Submit to score each attempt.")
                ),
                column(
                  width = 2,
                  offset = 1,
                  uiOutput("moveOnL1")
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "nextL1",
                    label = "Next >>",
                    size = "large",
                    style = "default",
                    disabled = TRUE
                  )
                )
              )
            ),
            #### Game Level 2 ----
            tabPanel(
              title = "Level 2",
              br(),
              h3("Level 2: Density Curves, Sample Arithmteic Mean, and Sample
                    Standard Deviation"),
              p("Rearrange the density curves and/or values of the data sets by
                clicking and dragging on either so that they are in the same order.
                We've provided the values
                for the ", tags$em("sample arithmetic mean"), " and ",
                tags$em("sample standard deviation"), " for each data set.",
                br(),
                br(),
                "Click the Hint button to display a hint."
              ),
              fluidRow(
                column(
                  width = 2,
                  bsButton(
                    inputId = "hintL2",
                    label = "Hint",
                    style = "default",
                    size = "large"
                  )
                ),
                column(
                  width = 10,
                  uiOutput("hintTextL2")
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 6,
                  uiOutput("mainColL2")
                ),
                column(
                  width = 6,
                  offset = 0,
                  uiOutput("secondaryColL2")
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 2,
                  p("Feedback:")
                ),
                column(
                  width = 1,
                  p("1st Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL2P1")
                ),
                column(
                  width = 1,
                  p("2nd Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL2P2")
                ),
                column(
                  width = 1,
                  p("3rd Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL2P3")
                ),
                column(
                  width = 1,
                  p("4th Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL2P4")
                ),
                column(
                  width = 2,
                  uiOutput("scoreL2")
                )
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
                  width = 3,
                  p("Press Submit to score each attempt.")
                ),
                column(
                  width = 2,
                  offset = 1,
                  uiOutput("moveOnL2")
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "nextL2",
                    label = "Next >>",
                    size = "large",
                    style = "default",
                    disabled = TRUE
                  )
                )
              )
            ),
            #### Game Level 3 ----
            tabPanel(
              title = "Level 3",
              br(),
              h3("Level 3: Histograms and Box Plots"),
              p("Rearrange the histograms and/or box plots by
                clicking and dragging on either so that they are in the same order.",
                br(),
                br(),
                "Click the Hint button to display a hint."
              ),
              fluidRow(
                column(
                  width = 2,
                  bsButton(
                    inputId = "hintL3",
                    label = "Hint",
                    style = "default",
                    size = "large"
                  )
                ),
                column(
                  width = 10,
                  uiOutput("hintTextL3")
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 6,
                  uiOutput("mainColL3")
                ),
                column(
                  width = 6,
                  offset = 0,
                  uiOutput("secondaryColL3")
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 2,
                  p("Feedback:")
                ),
                column(
                  width = 1,
                  p("1st Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL3P1")
                ),
                column(
                  width = 1,
                  p("2nd Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL3P2")
                ),
                column(
                  width = 1,
                  p("3rd Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL3P3")
                ),
                column(
                  width = 1,
                  p("4th Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL3P4")
                ),
                column(
                  width = 2,
                  uiOutput("scoreL3")
                )
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
                  width = 3,
                  p("Press Submit to score each attempt.")
                ),
                column(
                  width = 2,
                  offset = 1,
                  uiOutput("moveOnL3")
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "nextL3",
                    label = "Next >>",
                    size = "large",
                    style = "default",
                    disabled = TRUE
                  )
                )
              )
            ),
            #### Game Level 4 ----
            tabPanel(
              title = "Level 4",
              br(),
              h3("Level 4: Scatterplots and Correlation"),
              p("Rearrange the scatterplots and/or the correlation values by
                clicking and dragging on either so that they are in the same order.",
                br(),
                br(),
                "Click the Hint button to display a hint."
              ),
              fluidRow(
                column(
                  width = 2,
                  bsButton(
                    inputId = "hintL4",
                    label = "Hint",
                    style = "default",
                    size = "large"
                  )
                ),
                column(
                  width = 10,
                  uiOutput("hintTextL4")
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 6,
                  uiOutput("mainColL4")
                ),
                column(
                  width = 6,
                  offset = 0,
                  uiOutput("secondaryColL4")
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 2,
                  p("Feedback:")
                ),
                column(
                  width = 1,
                  p("1st Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL4P1")
                ),
                column(
                  width = 1,
                  p("2nd Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL4P2")
                ),
                column(
                  width = 1,
                  p("3rd Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL4P3")
                ),
                column(
                  width = 1,
                  p("4th Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL4P4")
                ),
                column(
                  width = 2,
                  uiOutput("scoreL4")
                )
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
                  width = 3,
                  p("Press Submit to score each attempt.")
                ),
                column(
                  width = 2,
                  offset = 1,
                  uiOutput("moveOnL4")
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "nextL4",
                    label = "Next >>",
                    size = "large",
                    style = "default",
                    disabled = TRUE
                  )
                )
              )
            ),
            #### Game Level 5 ----
            tabPanel(
              title = "Level 5",
              br(),
              h3("Level 5: Shapes of Distributions and Situations"),
              p("Rearrange the shape descriptions of distributions and/or the descriptions
                of situations by clicking and dragging on either so that they are in the same order.",
                br(),
                br(),
                "Click the Hint button to display a hint."
              ),
              fluidRow(
                column(
                  width = 2,
                  bsButton(
                    inputId = "hintL5",
                    label = "Hint",
                    style = "default",
                    size = "large"
                  )
                ),
                column(
                  width = 10,
                  uiOutput("hintTextL5")
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 6,
                  uiOutput("mainColL5")
                ),
                column(
                  width = 6,
                  offset = 0,
                  uiOutput("secondaryColL5")
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 2,
                  p("Feedback:")
                ),
                column(
                  width = 1,
                  p("1st Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL5P1")
                ),
                column(
                  width = 1,
                  p("2nd Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL5P2")
                ),
                column(
                  width = 1,
                  p("3rd Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL5P3")
                ),
                column(
                  width = 1,
                  p("4th Positions:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL5P4")
                ),
                column(
                  width = 2,
                  uiOutput("scoreL5")
                )
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
                  width = 3,
                  p("Press Submit to score each attempt.")
                ),
                column(
                  width = 2,
                  offset = 1,
                  uiOutput("moveOnL5")
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "nextL5",
                    label = "Next >>",
                    size = "large",
                    style = "default",
                    disabled = TRUE
                  )
                )
              )
            ),
            #### Game Level 6 ----
            tabPanel(
              title = "Level 6",
              br(),
              h3("Level 6: Ranking Correlation Situations"),
              p("Rearrange the situations by clicking and dragging on them so that the highest
                correlation comes first (e.g., +1) and the lowest correlation comes last (e.g., -1).",
                br(),
                br(),
                "Click the Hint button to display a hint."
              ),
              fluidRow(
                column(
                  width = 2,
                  bsButton(
                    inputId = "hintL6",
                    label = "Hint",
                    style = "default",
                    size = "large"
                  )
                ),
                column(
                  width = 10,
                  uiOutput("hintTextL6")
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 9,
                  div(
                    style = "text-align: center;",
                    uiOutput("mainColL6")
                  )
                ),
                column(
                  width = 3,
                  div(
                    style = "text-aling: center;",
                    class = "largerFont",
                    br(),
                    br(),
                    br(),
                    br(),
                    p("Highest Correlation"),
                    br(),
                    br(),
                    HTML('<i class="fas fa-sort-amount-down fa-7x" ></i>'),
                    br(),
                    br(),
                    br(),
                    p("Lowest Correlation")
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
                  width = 1,
                  p("1st Position:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL6P1")
                ),
                column(
                  width = 1,
                  p("2nd Position:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL6P2")
                ),
                column(
                  width = 1,
                  p("3rd Position:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL6P3")
                ),
                column(
                  width = 1,
                  p("4th Position:")
                ),
                column(
                  width = 1,
                  uiOutput("feedbackL6P4")
                ),
                column(
                  width = 2,
                  uiOutput("scoreL6")
                )
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
                  width = 3,
                  p("Press Submit to score each attempt.")
                ),
                column(
                  width = 2,
                  offset = 1,
                  uiOutput("moveOnL6")
                ),
                column(
                  width = 2,
                  bsButton(
                    inputId = "nextL6",
                    label = "Next >>",
                    size = "large",
                    style = "default",
                    disabled = TRUE
                  )
                )
              )
            ),
            ## Final Scores Tab ----
            tabPanel(
              title = "Final Scores",
              br(),
              h3("Congratulations! You finished the game."),
              uiOutput("finalTime"),
              br(),
              h3("Your scores"),
              br(),
              DT::DTOutput("finalScores")
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
        ### References ----
        tabItem(
          tabName = "References",
          h2("References"),
          p( #shinyBS
            class = "hangingindent",
            "Bailey, E. (2015), shinyBS: Twitter bootstrap components for shiny,
            R package. Available from https://CRAN.R-project.org/package=shinyBS"
          ),
          p( #Boast Utilities
            class = "hangingindent",
            "Carey, R. and Hatfield, N. (2020), boastUtils: BOAST Utilities,
            R Package. Available
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
          p( #sortable
            class = "hangingindent",
            "de Vries, A., Scholoerke, B., and Russel, K. (2020),
            sortable: Drag-and-Drop in 'shiny' Apps with 'SortableJS', R Package.
            Available from https://CRAN.R-project.org/package=sortable"
          ),
          p( #shinyWidgets
            class = "hangingindent",
            "Perrier, V., Meyer, F., Granjon, D., Fellows, I., and Davis, W.
            (2020), shinyWidgets: Custom Inputs Widgets for Shiny, R package.
            Available from
            https://cran.r-project.org/web/packages/shinyWidgets/index.html"
          ),
          p( #dplyr
            class = "hangingindent",
            "Wickham, H., François, R., Henry, L., and Müller, K. (2020),
            dplyr: A Grammar of Data Manipulation, R package.
            Available from https://CRAN.R-project.org/package=dplyr"
          ),
          p( #DT
            class = "hangingindent",
            "Xie, Y., Cheng, J., and Tan, X. (2020),
            DT: A Wrapper of the JavaScript Library 'DataTables', R package.
            Available from https://CRAN.R-project.org/package=DT"
          ),
          br(),
          br(),
          br(),
          boastUtils::copyrightInfo()
        )
      )
    )
  )
)

# Define the Server ----
server <- function(input, output, session) {
  ## Create Reactive Values ----
  gameInProgress <- reactiveVal(FALSE)
  time <- reactiveValues(
    inc = 0,
    min = 0,
    timer = reactiveTimer(1000),
    started = FALSE
  )
  initScore <- reactiveValues(
    level1 = 0, level2 = 0, level3 = 0,
    level4 = 0, level5 = 0, level6 = 0
  )
  subqScore <- reactiveValues(
    level1 = 0, level2 = 0, level3 = 0,
    level4 = 0, level5 = 0, level6 = 0
  )
  selectedQs <- reactiveValues(
    level1 = NULL, level2 = NULL, level3 = NULL,
    level4 = NULL, level5 = NULL, level6 = NULL
  )
  attempts <- reactiveValues(
    level1 = 0, level2 = 0, level3 = 0,
    level4 = 0, level5 = 0, level6 = 0
  )

  ## Store xAPI statement ----
  storeLevelSubmit <- function(description, answered, success, context) {
    
    stmt <- boastUtils::generateStatement(
      session,
      verb = "answered",
      object = "shiny-tab-game",
      description = description,
      interactionType = "matching",
      response = answered,
      success = success,
      extensions = list(
        ref = "https://educationshinyappteam.github.io/BOAST/xapi/result/extensions/context",
        value = context
      )
    )
    
    boastUtils::storeStatement(session, stmt)
  }

  ## Timer Operation ----
  observe({
    time$timer()
    if(isolate(time$started)) {
      time$inc <- isolate(time$inc) + 1
      if(time$inc > 1 && time$inc %% 60 == 0) {
        time$min <- isolate(time$min) + 1
      }
    }
  })

  ## Display Timer ----
  observeEvent(input$timer, {
    if (input$timer %% 2 == 1) {
      if (time$min == 0) {
        output$timerMessage <- renderUI(
          paste("You've used ", time$inc, "seconds.")
        )
      } else {
        output$timerMessage <- renderUI(
          paste("You've used ", time$min, "minutes and ",
                (time$inc %% 60), "seconds.")
        )
      }

      updateButton(
        session = session,
        inputId = "timer",
        value = TRUE,
        label = "Hide Timer"
      )
    } else {
      output$timerMessage <- renderUI(NULL)
      updateButton(
        session = session,
        inputId = "timer",
        value = FALSE,
        label = "Show Timer"
      )
    }
  })

  ## Generate Questions for all levels ----
  observeEvent(input$pages, {
    if (input$pages == "game" && !gameInProgress()) {
      time$started <- TRUE
      for (i in 1:(length(questionBank) - 1)) {
        selectedQs[[paste0("level", i)]] <- questionBank[[i]] %>%
          dplyr::ungroup() %>%
          dplyr::group_by(filters) %>%
          dplyr::slice_sample(n = 1)
      }
      selectedQs$level6 <- questionBank[[6]] %>%
        dplyr::filter(filters == sample(
          x = c("groupA", "groupB", "groupC", "groupD"),
          size = 1)
        )
      gameInProgress(TRUE)
    }
  })

  ## Information button ----
  observeEvent(input$info, {
    sendSweetAlert(
      session = session,
      title = "Instructions",
      text = tags$ol(
        tags$li("You can check time and hint by clicking the appropriate buttons."),
        tags$li("Rearrange the options so that the two columns are in the
                    same order OR, for a single column, the order requested."),
        tags$li("Click the submit button to grade your ordering."),
        tags$li("If you have any incorrect, continue reordering and press
                    Submit to update the feedback."),
        tags$li("You may move to the next level only when you get all correct."),
        tags$li("You may end the game at any time.")
      ),
      type = "info"
    )
  })

  ## Set up Level 1 ----
  output$mainColL1 <- renderUI({
    hist1 <- list(
      "1" = img(src = selectedQs$level1$mainColumn[1],
                width = "50%",
                alt = selectedQs$level1$mainAltText[1],
                class = "expandable"),
      "2" = img(src = selectedQs$level1$mainColumn[2],
                width = "50%",
                alt = selectedQs$level1$mainAltText[2],
                class = "expandable"),
      "3" = img(src = selectedQs$level1$mainColumn[3],
                width = "50%",
                alt = selectedQs$level1$mainAltText[3],
                class = "expandable"),
      "4" = img(src = selectedQs$level1$mainColumn[4],
                width = "50%",
                alt = selectedQs$level1$mainAltText[4],
                class = "expandable")
    )
    sortable::rank_list(
      input_id = "rank1Hists",
      text = "Drag the histograms into the same order as the values.",
      labels = sample(hist1, size = length(hist1))
    )
  })

  output$secondaryColL1 <- renderUI({
    if (input$extraDetailsL1) {
      sortable::rank_list(
        input_id = "rank1Values",
        text = "Drag the values into the same order as the
                    histograms.",
        labels = list(
          "1" = div(
            h4("Data Set A", align = "center"),
            p(selectedQs$level1$secondColumn[1],
              br(),
              selectedQs$level1$extraText[1]
            )
          ),
          "2" = div(
            h4("Data Set B", align = "center"),
            p(selectedQs$level1$secondColumn[2],
              br(),
              selectedQs$level1$extraText[2]
            )
          ),
          "3" = div(
            h4("Data Set C", align = "center"),
            p(selectedQs$level1$secondColumn[3],
              br(),
              selectedQs$level1$extraText[3]
            )
          ),
          "4" = div(
            h4("Data Set D", align = "center"),
            p(selectedQs$level1$secondColumn[4],
              br(),
              selectedQs$level1$extraText[4]
            )
          )
        )
      )
    } else {
      sortable::rank_list(
        input_id = "rank1Values",
        text = "Drag the values into the same order as the
                    histograms.",
        labels = list(
          "1" = div(
            h4("Data Set A", align = "center"),
            p(selectedQs$level1$secondColumn[1]
            )
          ),
          "2" = div(
            h4("Data Set B", align = "center"),
            p(selectedQs$level1$secondColumn[2]
            )
          ),
          "3" = div(
            h4("Data Set C", align = "center"),
            p(selectedQs$level1$secondColumn[3]
            )
          ),
          "4" = div(
            h4("Data Set D", align = "center"),
            p(selectedQs$level1$secondColumn[4]
            )
          )
        )
      )
    }
  })

  ## Level 1 Actions ----
  observeEvent(input$submitL1, {
    attempts$level1 <- isolate(attempts$level1) + 1
    matches <- input$rank1Hists == input$rank1Values
    
    for(i in 1:4){
      output[[paste0("feedbackL1P", i)]] <- boastUtils::renderIcon(
        icon = ifelse(matches[i], "correct", "incorrect")
      )
      if (attempts$level1 == 1) {
        initScore$level1 <- sum(3 * as.integer(matches) - 1)
      } else {
        subqScore$level1 <- sum(3 * as.integer(matches) - 1)
      }
      if (initScore$level1 == maxScores[1]) {subqScore$level1 <- maxScores[1]}
    }
    output$scoreL1 <- renderUI({
      paste("Your Score:", ifelse(attempts$level1 == 1,
                                  initScore$level1,
                                  subqScore$level1))
    })
    
    ### Build xAPI Statement ----
    answered <- jsonlite::toJSON(
      list(
        "hists" = input$rank1Hists,
        "values" = input$rank1Values
      ), auto_unbox = TRUE
    )
    
    context <- jsonlite::toJSON(
      list(
        "hists" = selectedQs$level1$mainAltText[as.numeric(input$rank1Hists)],
        "values" = selectedQs$level1$secondColumn[as.numeric(input$rank1Values)]
      ), auto_unbox = TRUE
    )
    
    storeLevelSubmit(
       description = "Level 1: Histograms, Sample Arithmetic Mean, and Sample Median",
       answered = answered,
       success = !any(matches == FALSE),
       context = context
    )
  })

  observeEvent(subqScore$level1, {
    if(isolate(subqScore$level1) == maxScores[1]) {
      updateButton(
        session = session,
        inputId = "nextL1",
        disabled = FALSE
      )
      updateButton(
        session = session,
        inputId = "submitL1",
        disabled = TRUE
      )
      output$moveOnL1 <- renderUI({
        "Congrats! You can move to the next level."
      })
    }
  })

  observeEvent(input$hintL1, {
    if(input$hintL1 %% 2 == 1){
      output$hintTextL1 <- renderUI({
        "The mean and median are the same for symmetric histograms while the mean
      is typically larger for right (positively) skewed histograms and the median is typically
      larger for left (negatively) skewed histograms."
      })
    } else {
      output$hintTextL1 <- renderUI({NULL})
    }
  })

  observeEvent(input$nextL1, {
    updateTabsetPanel(
      session = session,
      inputId = "gameLevels",
      selected = "Level 2"
    )
  })

  ### Clear feedback on reattempts
  observeEvent(input$rank1Hists, {
    for(i in 1:4){
      output[[paste0("feedbackL1P", i)]] <- boastUtils::renderIcon()
    }
    output$scoreL1 <- renderUI({NULL})
  })

  observeEvent(input$rank1Values, {
    for(i in 1:4){
      output[[paste0("feedbackL1P", i)]] <- boastUtils::renderIcon()
    }
    output$scoreL1 <- renderUI({NULL})
  })

  ## Set up Level 2 ----
  output$mainColL2 <- renderUI({
    dens2 <- list(
      "1" = img(src = selectedQs$level2$mainColumn[1],
                width = "50%",
                alt = selectedQs$level2$mainAltText[1],
                class = "expandable"),
      "2" = img(src = selectedQs$level2$mainColumn[2],
                width = "50%",
                alt = selectedQs$level2$mainAltText[2],
                class = "expandable"),
      "3" = img(src = selectedQs$level2$mainColumn[3],
                width = "50%",
                alt = selectedQs$level2$mainAltText[3],
                class = "expandable"),
      "4" = img(src = selectedQs$level2$mainColumn[4],
                width = "50%",
                alt = selectedQs$level2$mainAltText[4],
                class = "expandable")
    )
    sortable::rank_list(
      input_id = "rank2Density",
      text = "Drag the density curves into the same order as the values.",
      labels = sample(dens2, size = length(dens2))
    )
  })

  output$secondaryColL2 <- renderUI({
    sortable::rank_list(
      input_id = "rank2Values",
      text = "Drag the values into the same order as the
                    density curves.",
      labels = list(
        "1" = div(
          h4("Data Set A", align = "center"),
          p(selectedQs$level2$secondColumn[1]
          )
        ),
        "2" = div(
          h4("Data Set B", align = "center"),
          p(selectedQs$level2$secondColumn[2]
          )
        ),
        "3" = div(
          h4("Data Set C", align = "center"),
          p(selectedQs$level2$secondColumn[3]
          )
        ),
        "4" = div(
          h4("Data Set D", align = "center"),
          p(selectedQs$level2$secondColumn[4]
          )
        )
      )
    )
  })

  ## Level 2 Actions ----
  observeEvent(input$submitL2, {
    attempts$level2 <- isolate(attempts$level2) + 1
    matches <- input$rank2Density == input$rank2Values
    for(i in 1:4){
      output[[paste0("feedbackL2P", i)]] <- boastUtils::renderIcon(
        icon = ifelse(matches[i], "correct", "incorrect")
      )
      if (attempts$level2 == 1) {
        initScore$level2 <- sum(3 * as.integer(matches) - 1)
      } else {
        subqScore$level2 <- sum(3 * as.integer(matches) - 1)
      }
      if (initScore$level2 == maxScores[2]) {subqScore$level2 <- maxScores[2]}
    }
    output$scoreL2 <- renderUI({
      paste("Your Score:", ifelse(attempts$level2 == 1,
                                  initScore$level2,
                                  subqScore$level2))
    })
    
    ### Build xAPI Statement ----
    answered <- jsonlite::toJSON(
      list(
        "density" = input$rank2Density,
        "values" = input$rank2Values
      ), auto_unbox = TRUE
    )
    
    context <- jsonlite::toJSON(
      list(
        "density" = selectedQs$level2$mainAltText[as.numeric(input$rank2Density)],
        "values" = selectedQs$level2$secondColumn[as.numeric(input$rank2Values)]
      ), auto_unbox = TRUE
    )
    
    storeLevelSubmit(
      description = "Level 2: Density Curves, Sample Arithmteic Mean, and Sample Standard Deviation",
      answered = answered,
      success = !any(matches == FALSE),
      context = context
    )
  })

  observeEvent(subqScore$level2, {
    if(isolate(subqScore$level2) == maxScores[2]) {
      updateButton(
        session = session,
        inputId = "nextL2",
        disabled = FALSE
      )
      updateButton(
        session = session,
        inputId = "submitL2",
        disabled = TRUE
      )

      output$moveOnL2 <- renderUI({
        "Congrats! You can move to the next level."
      })
    }
  })

  observeEvent(input$hintL2, {
    if(input$hintL2 %% 2 == 1){
      output$hintTextL2 <- renderUI({
        "The standard deviation measures variation so it will be smaller when
      there's more of the distribution close to the center."
      })
    } else {
      output$hintTextL2 <- renderUI({NULL})
    }
  })

  observeEvent(input$nextL2, {
    updateTabsetPanel(
      session = session,
      inputId = "gameLevels",
      selected = "Level 3"
    )
  })

  observeEvent(input$previousL2, {
    updateTabsetPanel(
      session = session,
      inputId = "gameLevels",
      selected = "Level 1"
    )
  })

  ### Clear feedback on reattempts
  observeEvent(input$rank2Density, {
    for(i in 1:4){
      output[[paste0("feedbackL2P", i)]] <- boastUtils::renderIcon()
    }
    output$scoreL2 <- renderUI({NULL})
  })

  observeEvent(input$rank2Values, {
    for(i in 1:4){
      output[[paste0("feedbackL2P", i)]] <- boastUtils::renderIcon()
    }
    output$scoreL2 <- renderUI({NULL})
  })

  ## Set up Level 3 ----
  output$mainColL3 <- renderUI({
    hist3 <- list(
      "1" = img(src = selectedQs$level3$mainColumn[1],
                width = "50%",
                alt = selectedQs$level3$mainAltText[1],
                class = "expandable"),
      "2" = img(src = selectedQs$level3$mainColumn[2],
                width = "50%",
                alt = selectedQs$level3$mainAltText[2],
                class = "expandable"),
      "3" = img(src = selectedQs$level3$mainColumn[3],
                width = "50%",
                alt = selectedQs$level3$mainAltText[3],
                class = "expandable"),
      "4" = img(src = selectedQs$level3$mainColumn[4],
                width = "50%",
                alt = selectedQs$level3$mainAltText[4],
                class = "expandable")
    )
    sortable::rank_list(
      input_id = "rank3Hists",
      text = "Drag the histograms into the same order as the box plots.",
      labels = sample(hist3, size = length(hist3))
    )
  })

  output$secondaryColL3 <- renderUI({
    sortable::rank_list(
      input_id = "rank3Boxes",
      text = "Drag the box plots into the same order as the
                    histograms.",
      labels = list(
        "1" = img(src = selectedQs$level3$secondColumn[1],
                  width = "60%",
                  alt = selectedQs$level3$secondAltText[1],
                  class = "expandable"),
        "2" = img(src = selectedQs$level3$secondColumn[2],
                  width = "60%",
                  alt = selectedQs$level3$secondAltText[2],
                  class = "expandable"),
        "3" = img(src = selectedQs$level3$secondColumn[3],
                  width = "60%",
                  alt = selectedQs$level3$secondAltText[3],
                  class = "expandable"),
        "4" = img(src = selectedQs$level3$secondColumn[4],
                  width = "60%",
                  alt = selectedQs$level3$secondAltText[4],
                  class = "expandable")
      )
    )
  })

  ## Level 3 Actions ----
  observeEvent(input$submitL3, {
    attempts$level3 <- isolate(attempts$level3) + 1
    matches <- input$rank3Hists == input$rank3Boxes
    for(i in 1:4){
      output[[paste0("feedbackL3P", i)]] <- boastUtils::renderIcon(
        icon = ifelse(matches[i], "correct", "incorrect")
      )
      if (attempts$level3 == 1) {
        initScore$level3 <- sum(6 * as.integer(matches) - 2)
      } else {
        subqScore$level3 <- sum(6 * as.integer(matches) - 2)
      }
      if (initScore$level3 == maxScores[3]) {subqScore$level3 <- maxScores[3]}
    }
    output$scoreL3 <- renderUI({
      paste("Your Score:", ifelse(attempts$level3 == 1,
                                  initScore$level3,
                                  subqScore$level3))
    })
    
    ### Build xAPI Statement ----
    answered <- jsonlite::toJSON(
      list(
        "hists" = input$rank3Hists,
        "boxes" = input$rank3Boxes
      ), auto_unbox = TRUE
    )
    
    context <- jsonlite::toJSON(
      list(
        "hists" = selectedQs$level3$mainAltText[as.numeric(input$rank3Hists)],
        "boxes" = selectedQs$level3$secondAltText[as.numeric(input$rank3Boxes)]
      ), auto_unbox = TRUE
    )
    
    storeLevelSubmit(
      description = "Level 3: Histograms and Box Plots",
      answered = answered,
      success = !any(matches == FALSE),
      context = context
    )
  })

  observeEvent(subqScore$level3, {
    if(isolate(subqScore$level3) == maxScores[3]) {
      updateButton(
        session = session,
        inputId = "nextL3",
        disabled = FALSE
      )
      updateButton(
        session = session,
        inputId = "submitL3",
        disabled = TRUE
      )

      output$moveOnL3 <- renderUI({
        "Congrats! You can move to the next level."
      })
    }
  })

  observeEvent(input$hintL3, {
    if(input$hintL3 %% 2 == 1){
      output$hintTextL3 <- renderUI({
        "You should be able to tell where the median is and whether the
      distribution is skewed or symmetric from looking at either the box plot or
      the histogram."
      })
    } else {
      output$hintTextL3 <- renderUI({NULL})
    }
  })

  observeEvent(input$nextL3, {
    updateTabsetPanel(
      session = session,
      inputId = "gameLevels",
      selected = "Level 4"
    )
  })

  observeEvent(input$previousL3, {
    updateTabsetPanel(
      session = session,
      inputId = "gameLevels",
      selected = "Level 2"
    )
  })

  ### Clear feedback on reattempts
  observeEvent(input$rank3Hists, {
    for(i in 1:4){
      output[[paste0("feedbackL3P", i)]] <- boastUtils::renderIcon()
    }
    output$scoreL3 <- renderUI({NULL})
  })

  observeEvent(input$rank3Boxes, {
    for(i in 1:4){
      output[[paste0("feedbackL3P", i)]] <- boastUtils::renderIcon()
    }
    output$scoreL3 <- renderUI({NULL})
  })

  ## Set up Level 4 ----
  output$mainColL4 <- renderUI({
    scatter4 <- list(
      "1" = img(src = selectedQs$level4$mainColumn[1],
                width = "50%",
                alt = selectedQs$level4$mainAltText[1],
                class = "expandable"),
      "2" = img(src = selectedQs$level4$mainColumn[2],
                width = "50%",
                alt = selectedQs$level4$mainAltText[2],
                class = "expandable"),
      "3" = img(src = selectedQs$level4$mainColumn[3],
                width = "50%",
                alt = selectedQs$level4$mainAltText[3],
                class = "expandable"),
      "4" = img(src = selectedQs$level4$mainColumn[4],
                width = "50%",
                alt = selectedQs$level4$mainAltText[4],
                class = "expandable")
    )
    sortable::rank_list(
      input_id = "rank4Scatter",
      text = "Drag the scatterplots into the same order as the values.",
      labels = sample(scatter4, size = length(scatter4))
    )
  })

  output$secondaryColL4 <- renderUI({
    sortable::rank_list(
      input_id = "rank4Values",
      text = "Drag the values into the same order as the
                    scatterplots.",
      labels = list(
        "1" = div(
          h4("Data Set A", align = "center"),
          p(selectedQs$level4$secondColumn[1]
          )
        ),
        "2" = div(
          h4("Data Set B", align = "center"),
          p(selectedQs$level4$secondColumn[2]
          )
        ),
        "3" = div(
          h4("Data Set C", align = "center"),
          p(selectedQs$level4$secondColumn[3]
          )
        ),
        "4" = div(
          h4("Data Set D", align = "center"),
          p(selectedQs$level4$secondColumn[4]
          )
        )
      )
    )
})

  ## Level 4 Actions ----
  observeEvent(input$submitL4, {
    attempts$level4 <- isolate(attempts$level4) + 1
    matches <- input$rank4Scatter == input$rank4Values
    for(i in 1:4){
      output[[paste0("feedbackL4P", i)]] <- boastUtils::renderIcon(
        icon = ifelse(matches[i], "correct", "incorrect")
      )
      if (attempts$level4 == 1) {
        initScore$level4 <- sum(8 * as.integer(matches) - 3)
      } else {
        subqScore$level4 <- sum(8 * as.integer(matches) - 3)
      }
      if (initScore$level4 == maxScores[4]) {subqScore$level4 <- maxScores[4]}
    }
    output$scoreL4 <- renderUI({
      paste("Your Score:", ifelse(attempts$level4 == 1,
                                  initScore$level4,
                                  subqScore$level4))
    })
    
    ### Build xAPI Statement ----
    answered <- jsonlite::toJSON(
      list(
        "scatterplots" = input$rank4Scatter,
        "values" = input$rank4Values
      ), auto_unbox = TRUE
    )
    
    context <- jsonlite::toJSON(
      list(
        "scatterplots" = selectedQs$level4$mainAltText[as.numeric(input$rank4Scatter)],
        "values" = selectedQs$level4$secondColumn[as.numeric(input$rank4Values)]
      ), auto_unbox = TRUE
    )
    
    storeLevelSubmit(
      description = "Level 4: Scatterplots and Correlation",
      answered = answered,
      success = !any(matches == FALSE),
      context = context
    )
  })

  observeEvent(subqScore$level4, {
    if(isolate(subqScore$level4) == maxScores[4]) {
      updateButton(
        session = session,
        inputId = "nextL4",
        disabled = FALSE
      )
      updateButton(
        session = session,
        inputId = "submitL4",
        disabled = TRUE
      )
      output$moveOnL4 <- renderUI({
        "Congrats! You can move to the next level."
      })
    }
  })

  observeEvent(input$hintL4, {
    if(input$hintL4 %% 2 == 1){
      output$hintTextL4 <- renderUI({
        "Correlations closer to -1 show points more tightly clustered around a
      downward sloping line. Correlations closer to +1 show points more tightly
      clustered around an upward sloping line. Also outliers can have a big
      effect on the correlation."
      })
    } else {
      output$hintTextL4 <- renderUI({NULL})
    }
  })

  observeEvent(input$nextL4, {
    updateTabsetPanel(
      session = session,
      inputId = "gameLevels",
      selected = "Level 5"
    )
  })

  observeEvent(input$previousL4, {
    updateTabsetPanel(
      session = session,
      inputId = "gameLevels",
      selected = "Level 3"
    )
  })

  ### Clear feedback on reattempts
  observeEvent(input$rank4Scatter, {
    for(i in 1:4){
      output[[paste0("feedbackL4P", i)]] <- boastUtils::renderIcon()
    }
    output$scoreL4 <- renderUI({NULL})
  })

  observeEvent(input$rank4Values, {
    for(i in 1:4){
      output[[paste0("feedbackL4P", i)]] <- boastUtils::renderIcon()
    }
    output$scoreL4 <- renderUI({NULL})
  })

  ## Set up Level 5 ----
  output$mainColL5 <- renderUI({
    desc5 <- list(
      "1" = div(
        style = "text-align: center;",
        class = "largerFont",
        p(selectedQs$level5$mainColumn[1]
        )
      ),
      "2" = div(
        style = "text-align: center;",
        class = "largerFont",
        p(selectedQs$level5$mainColumn[2]
        )
      ),
      "3" = div(
        style = "text-align: center;",
        class = "largerFont",
        p(selectedQs$level5$mainColumn[3]
        )
      ),
      "4" = div(
        style = "text-align: center;",
        class = "largerFont",
        p(selectedQs$level5$mainColumn[4]
        )
      )
    )
    sortable::rank_list(
      input_id = "rank5Desc",
      text = "Drag the shape descriptions into the same order as the situations.",
      labels = sample(desc5, size = length(desc5))
    )
  })

  output$secondaryColL5 <- renderUI({
    sortable::rank_list(
      input_id = "rank5Situs",
      text = "Drag the situations into the same order as the
                    shape descriptions.",
      labels = list(
        "1" = div(
          style = "text-align: center;",
          class = "largerFont",
          p(selectedQs$level5$secondColumn[1]
          )
        ),
        "2" = div(
          style = "text-align: center;",
          class = "largerFont",
          p(selectedQs$level5$secondColumn[2]
          )
        ),
        "3" = div(
          style = "text-align: center;",
          class = "largerFont",
          p(selectedQs$level5$secondColumn[3]
          )
        ),
        "4" = div(
          style = "text-align: center;",
          class = "largerFont",
          p(selectedQs$level5$secondColumn[4]
          )
        )
      )
    )
  })

  ## Level 5 Actions ----
  observeEvent(input$submitL5, {
    attempts$level5 <- isolate(attempts$level5) + 1
    matches <- input$rank5Desc == input$rank5Situs
    for(i in 1:4){
      output[[paste0("feedbackL5P", i)]] <- boastUtils::renderIcon(
        icon = ifelse(matches[i], "correct", "incorrect")
      )
      if (attempts$level5 == 1) {
        initScore$level5 <- sum(9 * as.integer(matches) - 3)
      } else {
        subqScore$level5 <- sum(9 * as.integer(matches) - 3)
      }
      if (initScore$level5 == maxScores[5]) {subqScore$level5 <- maxScores[5]}
    }
    output$scoreL5 <- renderUI({
      paste("Your Score:", ifelse(attempts$level5 == 1,
                                  initScore$level5,
                                  subqScore$level5))
    })
    
    ### Build xAPI Statement ----
    answered <- jsonlite::toJSON(
      list(
        "descriptions" = input$rank5Desc,
        "situations" = input$rank5Situs
      ), auto_unbox = TRUE
    )
    
    context <- jsonlite::toJSON(
      list(
        "descriptions" = selectedQs$level5$mainColumn[as.numeric(input$rank5Desc)],
        "situations" = selectedQs$level5$secondColumn[as.numeric(input$rank5Situs)]
      ), auto_unbox = TRUE
    )
    
    storeLevelSubmit(
      description = "Level 5: Shapes of Distributions and Situations",
      answered = answered,
      success = !any(matches == FALSE),
      context = context
    )
  })

  observeEvent(subqScore$level5, {
    if(isolate(subqScore$level5) == maxScores[5]) {
      updateButton(
        session = session,
        inputId = "nextL5",
        disabled = FALSE
      )
      updateButton(
        session = session,
        inputId = "submitL5",
        disabled = TRUE
      )
      output$moveOnL5 <- renderUI({
        "Congrats! You can move to the next level."
      })
    }
  })

  observeEvent(input$hintL5, {
    if(input$hintL5 %% 2 == 1){
      output$hintTextL5 <- renderUI({
        "Bimodal distributions arise when you are sampling from two different
      populations. For skewed possibilities think about whether the unusual
      values (outliers) are likely to be on the right side or left side of the
      plot."
      })
    } else {
      output$hintTextL5 <- renderUI({NULL})
    }
  })

  observeEvent(input$nextL5, {
    updateTabsetPanel(
      session = session,
      inputId = "gameLevels",
      selected = "Level 6"
    )
  })

  observeEvent(input$previousL5, {
    updateTabsetPanel(
      session = session,
      inputId = "gameLevels",
      selected = "Level 4"
    )
  })

  ### Clear feedback on reattempts
  observeEvent(input$rank5Desc, {
    for(i in 1:4){
      output[[paste0("feedbackL5P", i)]] <- boastUtils::renderIcon()
    }
    output$scoreL5 <- renderUI({NULL})
  })

  observeEvent(input$rank5Situs, {
    for(i in 1:4){
      output[[paste0("feedbackL5P", i)]] <- boastUtils::renderIcon()
    }
    output$scoreL5 <- renderUI({NULL})
  })

  ## Set up Level 6 ----
  output$mainColL6 <- renderUI({
    situ6 <- list(
      "1" = div(
        style = "text-align: center;",
        class = "largerFont",
        p(selectedQs$level6$mainColumn[1]
        )
      ),
      "2" = div(
        style = "text-align: center;",
        class = "largerFont",
        p(selectedQs$level6$mainColumn[2]
        )
      ),
      "3" = div(
        style = "text-align: center;",
        class = "largerFont",
        p(selectedQs$level6$mainColumn[3]
        )
      ),
      "4" = div(
        style = "text-align: center;",
        class = "largerFont",
        p(selectedQs$level6$mainColumn[4]
        )
      )
    )
    sortable::rank_list(
      input_id = "rank6Situ",
      text = "Drag the situations so that the highest correlation comes first and lowest comes last.",
      labels = sample(situ6, size = length(situ6))
    )
  })

  ## Level 6 Actions ----
  observeEvent(input$submitL6, {
    attempts$level6 <- isolate(attempts$level6) + 1
    matches <- input$rank6Situ == selectedQs$level6$secondColumn
    for(i in 1:4){
      output[[paste0("feedbackL6P", i)]] <- boastUtils::renderIcon(
        icon = ifelse(matches[i], "correct", "incorrect")
      )
      if (attempts$level6 == 1) {
        initScore$level6 <- sum(9 * as.integer(matches) - 3)
      } else {
        subqScore$level6 <- sum(9 * as.integer(matches) - 3)
      }
      if (initScore$level6 == maxScores[6]) {subqScore$level6 <- maxScores[6]}
    }
    output$scoreL6 <- renderUI({
      paste("Your Score:", ifelse(attempts$level6 == 1,
                                  initScore$level6,
                                  subqScore$level6))
    })
    
    ### Build xAPI Statement ----
    answered <- jsonlite::toJSON(
      list(
        "situations" = input$rank6Situ,
        "values" = selectedQs$level6$secondColumn
      ), auto_unbox = TRUE
    )
    
    context <- jsonlite::toJSON(
      list(
        "situations" = selectedQs$level6$mainColumn[as.numeric(input$rank6Situ)]
      ), auto_unbox = TRUE
    )
    
    storeLevelSubmit(
      description = "Level 6: Ranking Correlation Situations",
      answered = answered,
      success = !any(matches == FALSE),
      context = context
    )
  })

  observeEvent(subqScore$level6, {
    if(isolate(subqScore$level6) == maxScores[6]) {
      updateButton(
        session = session,
        inputId = "nextL6",
        disabled = FALSE
      )
      updateButton(
        session = session,
        inputId = "submitL6",
        disabled = TRUE
      )
      output$moveOnL6 <- renderUI({
        "Congrats! You can move to the next level."
      })
    }
  })

  observeEvent(input$hintL6, {
    if(input$hintL6 %% 2 == 1){
      output$hintTextL6 <- renderUI({
        "Remember that negative values are smaller than positive values. So your
      largest positive correlation goes under 'highest' and your most negative
      correlation goes under 'lowest'."
      })
    } else {
      output$hintTextL6 <- renderUI({NULL})
    }
  })

  observeEvent(input$nextL6, {
    updateTabsetPanel(
      session = session,
      inputId = "gameLevels",
      selected = "Final Scores"
    )
  })

  observeEvent(input$previousL6, {
    updateTabsetPanel(
      session = session,
      inputId = "gameLevels",
      selected = "Level 5"
    )
  })

  ### Clear feedback on reattempts
  observeEvent(input$rank6Situ, {
    for(i in 1:4){
      output[[paste0("feedbackL6P", i)]] <- boastUtils::renderIcon()
    }
    output$scoreL6 <- renderUI({NULL})
  })

  ## Final Scores Page ----
  observeEvent(input$gameLevels, {
    if(input$gameLevels == "Final Scores") {
      time$started <- FALSE
      
      ### Store xAPI statement ----
      stmt <- boastUtils::generateStatement(
        session,
        verb = "completed",
        object = "shiny-tab-game",
        description = "Final Scores",
        success = ifelse(subqScore$level6 > 0, TRUE, FALSE)
      )
      
      boastUtils::storeStatement(session, stmt)
    }
  })

  output$finalTime <- renderUI({
    if (time$min == 0) {
      paste("You used a total of ", time$inc, "seconds.")
    } else {
      paste("You used a total of ", time$min, "minutes and ",
            (time$inc %% 60), "seconds.")
    }
  })

  output$finalScores <- DT::renderDT(
    expr = data.frame(
      row.names = c("Level 1: Histograms, Sample Arithmetic Mean, and Sample Median",
                    "Level 2: Density Curves, Sample Arithmteic Mean, and Sample
                    Standard Deviation",
                    "Level 3: Histograms and Box Plots",
                    "Level 4: Scatterplots and Correlation",
                    "Level 5: Shapes of Distributions and Situations",
                    "Level 6: Ranking Correlation Situations"),
      Initial = c(initScore$level1, initScore$level2, initScore$level3,
                          initScore$level4, initScore$level5, initScore$level6),
      Final = c(subqScore$level1, subqScore$level2, subqScore$level3,
                        subqScore$level4, subqScore$level5, subqScore$level6),
      Attempts = c(attempts$level1, attempts$level2, attempts$level3,
                     attempts$level4, attempts$level5, attempts$level6)
    ),
    caption = "Your Level Stats",
    style = "bootstrap4",
    rownames = TRUE,
    autoHideNavigation = TRUE,
    options = list(
      responsive = TRUE,
      scrollX = TRUE,
      paging = FALSE,
      searching = FALSE,
      info = FALSE,
      ordering = FALSE,
      columnDefs = list(
        list(className = "dt-center", targets = 1:3)
      )
    )
  )

  ## End Game Button ----
  observeEvent(input$endGame, {
    if(input$gameLevels == "Final Scores") {
      time$started <- FALSE
    }
    updateTabsetPanel(
      session = session,
      inputId = "gameLevels",
      selected = "Final Scores"
    )
  })

  ## Start Button ----
  observeEvent(input$start, {
    updateTabItems(
      session = session,
      inputId = "pages",
      selected = "game"
    )
  })

}

#Call Boast App
boastUtils::boastApp(ui = ui, server = server)