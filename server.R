library(boastUtils)
#Let`s begin
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
# Server Start
shinyServer(function(input, output, session) {
  # information on 'i' icon on the top right corner
  observeEvent(input$info,{
    sendSweetAlert(
      session = session,
      title = "Instructions:",
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
      type = "info",
      btn_colors = "orange"
    )
  })
  ### Show pages by buttons like 'next', 'previous'.
  observe({
      hide(selector = "#navMain li a[data-value=a]")
    })
  observeEvent(input$start, {
      show(selector = "#navMain li a[data-value=a]")
  })
  observeEvent(input$tabs, {
    if (input$tabs == "game"){
    show(selector = "#navMain li a[data-value=a]")
    }
  })
  observe({
    hide(selector = "#navMain li a[data-value=b]")
  })
  observeEvent(input$next1, {
    show(selector = "#navMain li a[data-value=b]")
  })
  observe({
    hide(selector = "#navMain li a[data-value=c]")
  })
  observeEvent(input$next2, {
    show(selector = "#navMain li a[data-value=c]")
  })
  observe({
    hide(selector = "#navMain li a[data-value=d]")
  })
  observeEvent(input$next3, {
    show(selector = "#navMain li a[data-value=d]")
  })
  observe({
    hide(selector = "#navMain li a[data-value=e]")
  })
  observeEvent(input$next4, {
    show(selector = "#navMain li a[data-value=e]")
  })
  observe({
    hide(selector = "#navMain li a[data-value=f]")
  })
  observeEvent(input$next5, {
    show(selector = "#navMain li a[data-value=f]")
  })
  observe({
    hide(selector = "#navMain li a[data-value=g]")
  })
  observeEvent(input$finish, {
    show(selector = "#navMain li a[data-value=g]")
  })
  # naviate to the game tab
  observeEvent(input$start, {
    updateTabItems(session, "tabs", "game")
  })
  ### Next buttons
  observeEvent(input$start,{
    updateTabsetPanel(session = session,"navMain", selected = "a")
  })
  observeEvent(input$next1,{
    updateTabsetPanel(session = session,"navMain", selected = "b")
  })
  observeEvent(input$next2,{
    updateTabsetPanel(session = session,"navMain", selected = "c")
  })
  observeEvent(input$next3,{
    updateTabsetPanel(session = session,"navMain", selected = "d")
  })
  observeEvent(input$next4,{
    updateTabsetPanel(session = session,"navMain", selected = "e")
  })
  observeEvent(input$next5,{
    updateTabsetPanel(session = session,"navMain", selected = "f")
  })
  observeEvent(input$finish,{
    updateTabsetPanel(session = session,"navMain", selected = "g")
  })
  observeEvent(input$stop1,{ #go right ahead to the score tab
    updateTabsetPanel(session = session,"navMain", selected = "g")
  })
  observeEvent(input$stop2,{ #go right ahead to the score tab
    updateTabsetPanel(session = session,"navMain", selected = "g")
  })
  observeEvent(input$stop3,{ #go right ahead to the score tab
    updateTabsetPanel(session = session,"navMain", selected = "g")
  })
  observeEvent(input$stop4,{ #go right ahead to the score tab
    updateTabsetPanel(session = session,"navMain", selected = "g")
  })
  observeEvent(input$stop5,{ #go right ahead to the score tab
    updateTabsetPanel(session = session,"navMain", selected = "g")
  })
  ### Previous buttons
  observeEvent(input$previous6,{
    updateTabsetPanel(session = session,"navMain", selected = "a")
  })
  observeEvent(input$previous5,{
    updateTabsetPanel(session = session,"navMain", selected = "b")
  })
  observeEvent(input$previous4,{
    updateTabsetPanel(session = session,"navMain", selected = "c")
  })
  observeEvent(input$previous3,{
    updateTabsetPanel(session = session,"navMain", selected = "d")
  })
  observeEvent(input$previous2,{
    updateTabsetPanel(session = session,"navMain", selected = "e")
  })
  ##Set timer with start, stop, restart, stop, and termination; and show the timer
  time<-reactiveValues(inc=0, timer=reactiveTimer(1000), started=FALSE)
  ### When user click submit, timer stops and rerun on next level
  observeEvent(input$start, {time$started<-TRUE})
  observeEvent(input$tabs, {if (input$tabs == "game") {time$started<-TRUE}})
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
  observe({
    time$timer()
    if(isolate(time$started))
      time$inc<-isolate(time$inc)+1
  })
  #show the timer
  observeEvent(input$bt1 == TRUE, {
    toggle('timer1h')
    output$timer1 <- renderText({
      paste0("you have used: ", time$inc, " secs")})
  })
  observeEvent(input$bt2 == TRUE, {
    toggle('timer2h')
    output$timer2 <- renderText({
      paste0("you have used: ", time$inc, " secs")})
  })
  observeEvent(input$bt3 == TRUE, {
    toggle('timer3h')
    output$timer3 <- renderText({
      paste0("you have used: ", time$inc, " secs")})
  })
  observeEvent(input$bt4 == TRUE, {
    toggle('timer4h')
    output$timer4 <- renderText({
      paste0("you have used: ", time$inc, " secs")})
  })
  observeEvent(input$bt5 == TRUE, {
    toggle('timer5h')
    output$timer5 <- renderText({
      paste0("you have used: ", time$inc, " secs")})
  })
  observeEvent(input$bt6 == TRUE, {
    toggle('timer6h')
    output$timer6 <- renderText({
      paste0("you have used: ", time$inc, " secs")})
  })
  output$timer8 <- renderText({
    paste0("you have used: ", time$inc, " secs")
  })
  ### Hint messages on Hint button
  observeEvent(input$bq1 == FALSE, {
    toggle('hint1q')
    output$hint1 <- renderText({
      paste0('The mean and median are the same for symmetric histograms 
      while the mean is bigger for right-skewed histograms and the median
             is bigger for left skewed histograms')})
  })
  observeEvent(input$bq2 == TRUE, {
    toggle('hint2q')
    output$hint2 <- renderText({
      paste0("The standard deviation measures variation so it will be smaller 
             when there's more of the distribution close to the center")})
  })
  observeEvent(input$bq3 == TRUE, {
    toggle('hint3q')
    output$hint3 <- renderText({
      paste0("You should be able to tell where the median is and 
             whether the distribution is skewed or symmetric from looking at
             either the boxplot or the histogram")})
  })
  observeEvent(input$bq4 == TRUE, {
    toggle('hint4q')
    output$hint4 <- renderText({
      paste0("Correlations closer to -1 show points more tightly clustered
      around a downward sloping line. Correlations closer to +1 show points
      more tightly clustered around an upward sloping line. 
      Also outliers can have a big effect on the correlation.")})
  })
  observeEvent(input$bq5 == TRUE, {
    toggle('hint5q')
    output$hint5 <- renderText({
      paste0("Bimodal distributions arise when you are sampling from
      two different populations. For skewed possibilities think about whether
      the unusual values (outliers) are likely to be 
      on the right side or left side of the plot.")})
  })
  observeEvent(input$bq6 == TRUE, {
    toggle('hint6q')
    output$hint6 <- renderText({
      paste0("Remember that negative values are smaller than positive values.
          So your largest positive correlation goes under 'highest' 
          and your most negative correlation goes under 'lowest'")})
  })
  ##  Contents - This is where all third row elements came from
  # Level 1
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
  # Level 2
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
  # Level 3
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
  # Level 4
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
  # Level 5
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
  # Level 6-1
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
  # Level 6-2
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
  # Level 6-3
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
  # Level 6-4
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
  ### Submit button and show Penalty box.
  observeEvent(input$submitF,{
    updateButton(session,"submitF",disabled = TRUE)
    updateButton(session,"clearF",disabled = FALSE)
  })
  observeEvent(input$clearF,{
    updateButton(session,"submitF",disabled = FALSE)
    updateButton(session,"clearF",disabled = TRUE)
  })
  #First, click Submit button and it`ll show whether the answer is correct or not
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
    ### Submit button and show Penalty box.
    updateButton(session,"submitA",disabled = TRUE)
    updateButton(session,"clearA",disabled = FALSE)
  })
  #Second, drag wrong drop box into the penalty box and
  # click 'Re-attempt' button to clear cross marks.
  observeEvent(input$clearA,{
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
    updateButton(session,"submitA",disabled = FALSE)
    updateButton(session,"clearA",disabled = TRUE)
  })
  # Level 2
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
    updateButton(session,"submitB",disabled = TRUE)
    updateButton(session,"clearB",disabled = FALSE)
  })
  observeEvent(input$clearB,{
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
    updateButton(session,"submitB",disabled = FALSE)
    updateButton(session,"clearB",disabled = TRUE)
  })
  
  # Level 3
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
    updateButton(session,"submitC",disabled = TRUE)
    updateButton(session,"clearC",disabled = FALSE)
  })
  observeEvent(input$clearC,{
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
    updateButton(session,"submitC",disabled = FALSE)
    updateButton(session,"clearC",disabled = TRUE)
  })
  
  # Level 4
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
    updateButton(session,"submitD",disabled = TRUE)
    updateButton(session,"clearD",disabled = FALSE)
  })
  observeEvent(input$clearD,{
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
    updateButton(session,"submitD",disabled = FALSE)
    updateButton(session,"clearD",disabled = TRUE)
  })
  
  # Level 5
  observeEvent(input$submitE,{
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
    updateButton(session,"submitE",disabled = TRUE)
    updateButton(session,"clearE",disabled = FALSE)
  })
  observeEvent(input$clearE,{
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
    updateButton(session,"submitE",disabled = FALSE)
    updateButton(session,"clearE",disabled = TRUE)
  })

  # Level 6
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
  ## Score
  # The score system was made with reactive values, which need to be changed
  summation <- reactiveValues(summationA = c(rep(0,8)),
               summationB = c(rep(0,8)), summationC = c(rep(0,16)), 
               summationD = c(rep(0,20)), summationE = c(rep(0,24)),
               summationF = c(rep(0,24)), summationScore = c(rep(0,100)))
  # Level 1
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
  # Level 2
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
  # Level 3
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
  # Level 4
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
  # Level 5
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
  # Level 6
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
  ## Penalty box
  values = reactiveValues(
    count = 0
  )
  # Level 1
  observeEvent(input$submitA,{
    if(summation$summationA[input$submitA] == 8){
      updateButton(session, "next1",disabled = FALSE)
      updateButton(session, "stop1",disabled = FALSE)
    }})
  #####PENALTY BOX TEXT#####
  output$warning1 <- reactive({
    if(summation$summationA[input$submitA] == 8){
      output$warning1 <- renderText({"Congratulations!
        You are ready to move on!"})
    }
    else if((summation$summationA[input$submitA] < 8)) {
      output$warning1 <- renderText({"Please drag wrong answers 
        into this PENALTY box and drag back to try again."})
    }
  })
  # Level 2
  observeEvent(input$submitB,{
    if(summation$summationB[input$submitB] == 8){
      updateButton(session, "next2",disabled = FALSE)
      updateButton(session, "stop2",disabled = FALSE)
    }})
  #####PENALTY BOX TEXT#####
  output$warning2 <- reactive({
    if(summation$summationB[input$submitB] == 8){
      output$warning2 <- renderText({"Congratulations!
        You are ready to move on!"})
    }
    else if((summation$summationB[input$submitB] < 8)) {
      output$warning2 <- renderText({"Please drag wrong answers
        into this PENALTY box and drag back to try again."})
    }
  })
  # Level 3
  observeEvent(input$submitC,{
    if(summation$summationC[input$submitC] == 16){
      updateButton(session, "next3",disabled = FALSE)
      updateButton(session, "stop3",disabled = FALSE)
    }})
  #####PENALTY BOX TEXT#####
  output$warning3 <- reactive({
    if(summation$summationC[input$submitC] == 16){
      output$warning3 <- renderText({"Congratulations!
        You are ready to move on!"})
    }
    else if((summation$summationC[input$submitC] < 16)) {
      output$warning3 <- renderText({"Please drag wrong answers
        into this PENALTY box and drag back to try again."})
    }
  })
  # Level 4
  observeEvent(input$submitD,{
    if(summation$summationD[input$submitD] == 20){
      updateButton(session, "next4",disabled = FALSE)
      updateButton(session, "stop4",disabled = FALSE)
    }})
  #####PENALTY BOX TEXT#####
  output$warning4 <- reactive({
    if(summation$summationD[input$submitD] == 20){
      output$warning4 <- renderText({"Congratulations!
        You are ready to move on!"})
    }
    else if((summation$summationD[input$submitD] < 20)) {
      output$warning4 <- renderText({"Please drag wrong answers
        into this PENALTY box and drag back to try again."})
    }
  })
  # Level 5
  observeEvent(input$submitE,{
    if(summation$summationE[input$submitE] == 24){
      updateButton(session, "next5",disabled = FALSE)
      updateButton(session, "stop5",disabled = FALSE)
    }})
  #####PENALTY BOX TEXT#####
  output$warning5 <- reactive({
    if(summation$summationE[input$submitE] == 24){
      output$warning5 <- renderText({"Congratulations!
        You are ready to move on!"})
    }
    else if((summation$summationE[input$submitE] < 24)) {
      output$warning5 <- renderText({"Please drag wrong answers
        into this PENALTY box and drag back to try again."})
    }
  })
  # Level 6
  observeEvent(input$submitF,{
    if(summation$summationF[input$submitF] == 24){
      updateButton(session, "finish",disabled = FALSE)
    }
    else{
      updateButton(session, "finish", disabled = TRUE)
    }
  })
  #####PENALTY BOX TEXT#####
  output$warning6 <- reactive({
    if(summation$summationF[input$submitF] == 24){
      output$warning6 <- renderText({"Congratulations!
        You are ready to move on!"})
    }
    else if((summation$summationF[input$submitF] < 24)) {
      output$warning6 <- renderText({"Please drag wrong answers
        into this PENALTY box and drag back to try again."})
    }
  })
  ## Overall Score Section
  ### Initial score
  # This follows the score system and sum the scores
  output$init <- renderText({
    if(any(summation$summationA[1] != 0) & any(summation$summationB[1] == 0)
       & any(summation$summationC[1] == 0) & any(summation$summationD[1] == 0)
       & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {initialScore = summation$summationA[1]}
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0)
       & any(summation$summationC[1] == 0) & any(summation$summationD[1] == 0)
       & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {initialScore = summation$summationA[1] + summation$summationB[1]}
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0)
       & any(summation$summationC[1] != 0) & any(summation$summationD[1] == 0)
       & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {initialScore = summation$summationA[1] + summation$summationB[1]
                  + summation$summationC[1]}
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0)
       & any(summation$summationC[1] != 0) & any(summation$summationD[1] != 0)
       & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {initialScore = summation$summationA[1] + summation$summationB[1]
                  + summation$summationC[1] + summation$summationD[1]}
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0)
       & any(summation$summationC[1] != 0) & any(summation$summationD[1] != 0)
       & any(summation$summationE[1] != 0) & any(summation$summationF[1] == 0))
    {initialScore = summation$summationA[1] + summation$summationB[1]
                  + summation$summationC[1] + summation$summationD[1]
                  + summation$summationE[1]}
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0)
       & any(summation$summationC[1] != 0) & any(summation$summationD[1] != 0)
       & any(summation$summationE[1] != 0) & any(summation$summationF[1] != 0))
    {initialScore = summation$summationA[1] + summation$summationB[1]
                  + summation$summationC[1] + summation$summationD[1] 
                  + summation$summationE[1] + summation$summationF[1]}
    else{
      initialScore = 0
    }
    paste0("First: ",initialScore)
  })
  ### subsequent scores
  output$subsequent <- renderText({
    if(any(summation$summationA[1] != 0) & any(summation$summationB[1] == 0)
       & any(summation$summationC[1] == 0) & any(summation$summationD[1] == 0)
       & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {subsequentScore = 8}
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0)
       & any(summation$summationC[1] == 0) & any(summation$summationD[1] == 0)
       & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {subsequentScore = 16}
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0)
       & any(summation$summationC[1] != 0) & any(summation$summationD[1] == 0)
       & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {subsequentScore = 32}
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0)
       & any(summation$summationC[1] != 0) & any(summation$summationD[1] != 0)
       & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {subsequentScore = 52}
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0)
       & any(summation$summationC[1] != 0) & any(summation$summationD[1] != 0)
       & any(summation$summationE[1] != 0) & any(summation$summationF[1] == 0))
    {subsequentScore = 76}
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0)
       & any(summation$summationC[1] != 0) & any(summation$summationD[1] != 0)
       & any(summation$summationE[1] != 0) & any(summation$summationF[1] != 0))
    {subsequentScore = 100}
    else{
      subsequentScore = 0
    }
    paste0("Subsequent: ",subsequentScore)
  })
  ### Final Scores
  output$totalScore <- renderText({
    if(any(summation$summationA[1] != 0) & any(summation$summationB[1] == 0)
       & any(summation$summationC[1] == 0) & any(summation$summationD[1] == 0)
       & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {summationScore = round(as.numeric(summation$summationA[1]) * (2/3)
                            + 2.67, digits = 1)}
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0)
       & any(summation$summationC[1] == 0) & any(summation$summationD[1] == 0)
       & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {summationScore = round(as.numeric(summation$summationA[1]
                                       + summation$summationB[1]) * (2/3) + 5.33, digit = 1)}
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0)
       & any(summation$summationC[1] != 0) & any(summation$summationD[1] == 0)
       & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {summationScore = round(as.numeric(summation$summationA[1]
                   + summation$summationB[1] + summation$summationC[1]) * (2/3)
                   + 10.67, digits = 1)}
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0)
       & any(summation$summationC[1] != 0) & any(summation$summationD[1] != 0)
       & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {summationScore = round(as.numeric(summation$summationA[1]
                    + summation$summationB[1] + summation$summationC[1]
                    + summation$summationD[1]) * (2/3)
                    + 17.33, digits = 1)}
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0)
       & any(summation$summationC[1] != 0) & any(summation$summationD[1] != 0)
       & any(summation$summationE[1] != 0) & any(summation$summationF[1] == 0))
    {summationScore = round(as.numeric(summation$summationA[1]
                    + summation$summationB[1] + summation$summationC[1]
                    + summation$summationD[1] + summation$summationE[1]) * (2/3)
                    + 25.33, digits = 1)}
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0)
       & any(summation$summationC[1] != 0) & any(summation$summationD[1] != 0)
       & any(summation$summationE[1] != 0) & any(summation$summationF[1] != 0))
    {summationScore = round(as.numeric(summation$summationA[1]
                    + summation$summationB[1] + summation$summationC[1]
                    + summation$summationD[1] + summation$summationE[1]
                    + summation$summationF[1]) * (2/3) + 33.33, digits = 1)}
    else{
      summationScore = 0
    }
    paste0("Final: ", summationScore)
  })
})
