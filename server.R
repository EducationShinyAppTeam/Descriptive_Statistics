library(shiny)
library(shinyDND)
library(shinyjs)
library(shinyBS)
library(V8)

# bank <- read.csv("questionBank.csv")
# bank = data.frame(lapply(bank, as.character), stringsAsFactors = FALSE)

bankA = read.csv("Level1.csv")
bankA = data.frame(lapply(bankA, as.character), stringsAsFactors = FALSE)
bankB = read.csv("Level2.csv")
bankB = data.frame(lapply(bankB, as.character), stringsAsFactors = FALSE)
bankC = read.csv("Level3.csv")
bankC = data.frame(lapply(bankC, as.character), stringsAsFactors = FALSE)
bankD = read.csv("Level4.csv")
bankD = data.frame(lapply(bankD, as.character), stringsAsFactors = FALSE)
bankE = read.csv("Level45.csv")
bankE = data.frame(lapply(bankE, as.character), stringsAsFactors = FALSE)

### Since the last level is order the application, four files would be easier to check the answer 
bankF1 = read.csv("Level71.csv")
bankF1 = data.frame(lapply(bankF1, as.character), stringsAsFactors = FALSE)
bankF2 = read.csv("Level72.csv")
bankF2 = data.frame(lapply(bankF2, as.character), stringsAsFactors = FALSE)
bankF3 = read.csv("Level73.csv")
bankF3 = data.frame(lapply(bankF3, as.character), stringsAsFactors = FALSE)
bankF4 = read.csv("Level74.csv")
bankF4 = data.frame(lapply(bankF4, as.character), stringsAsFactors = FALSE)
# bankA <- read.csv("Level1.csv")
# bankA = data.frame(lapply(bankA, as.character), stringsAsFactors = FALSE)



shinyServer(function(input, output, session) {
  
  #########  ###########  ###########  ###########  ###########  ###########
  # observe({
  #   hide(selector = "#navMain li a[data-value=b]")
  # })
  # observeEvent(input$go, {
  #   show(selector = "#navMain li a[data-value=b]")
  # })
  ### Show pages by buttons like 'next', 'previous'.
  observe({
    if(input$go == 0){
      hide(selector = "#navMain li a[data-value=b]")
    }
    else{
      show(selector = "#navMain li a[data-value=b]")
    }
  })
  observe({
    hide(selector = "#navMain li a[data-value=c]")
  })
  observeEvent(input$next1, {
    show(selector = "#navMain li a[data-value=c]")
  })
  
  observe({
    hide(selector = "#navMain li a[data-value=d]")
  })
  observeEvent(input$next2, {
    show(selector = "#navMain li a[data-value=d]")
  })
  
  observe({
    hide(selector = "#navMain li a[data-value=e]")
  })
  observeEvent(input$next3, {
    show(selector = "#navMain li a[data-value=e]")
  })
  
  observe({
    hide(selector = "#navMain li a[data-value=f]")
  })
  observeEvent(input$next4, {
    show(selector = "#navMain li a[data-value=f]")
  })
  
  observe({
    hide(selector = "#navMain li a[data-value=g]")
  })
  observeEvent(input$next5, {
    show(selector = "#navMain li a[data-value=g]")
  })
  
  observe({
    hide(selector = "#navMain li a[data-value=h]")
  })
  observeEvent(input$finish, {
    show(selector = "#navMain li a[data-value=h]")
  })
  ###########  ###########  ###########  ###########  ###########  ###########  ###########
  
  observeEvent(input$start, {
    updateTabItems(session, "tabs", "game")
  })
  
  ### Next buttons
  observeEvent(input$go,{
    updateTabsetPanel(session = session,"navMain", selected = "b")
  })
  observeEvent(input$next1,{
    updateTabsetPanel(session = session,"navMain", selected = "c")
  })
  observeEvent(input$next2,{
    updateTabsetPanel(session = session,"navMain", selected = "d")
  })
  observeEvent(input$next3,{
    updateTabsetPanel(session = session,"navMain", selected = "e")
  })
  observeEvent(input$next4,{
    updateTabsetPanel(session = session,"navMain", selected = "f")
  })
  observeEvent(input$next5,{
    updateTabsetPanel(session = session,"navMain", selected = "g")
  })
  observeEvent(input$finish,{
    updateTabsetPanel(session = session,"navMain", selected = "h")
  })
  observeEvent(input$stop1,{ #go right ahead to the score session
    updateTabsetPanel(session = session,"navMain", selected = "h")
  })
  observeEvent(input$stop2,{ #go right ahead to the score session
    updateTabsetPanel(session = session,"navMain", selected = "h")
  })
  observeEvent(input$stop3,{ #go right ahead to the score session
    updateTabsetPanel(session = session,"navMain", selected = "h")
  })
  observeEvent(input$stop4,{ #go right ahead to the score session
    updateTabsetPanel(session = session,"navMain", selected = "h")
  })
  observeEvent(input$stop5,{ #go right ahead to the score session
    updateTabsetPanel(session = session,"navMain", selected = "h")
  })
  
  ############# ############# ############# ############# ############# ############# ############# #############
  
  
  ### Previous buttons
  observeEvent(input$previous7,{
    updateTabsetPanel(session = session,"navMain", selected = "a")
  })
  observeEvent(input$previous6,{
    updateTabsetPanel(session = session,"navMain", selected = "b")
  })
  observeEvent(input$previous5,{
    updateTabsetPanel(session = session,"navMain", selected = "c")
  })
  observeEvent(input$previous4,{
    updateTabsetPanel(session = session,"navMain", selected = "d")
  })
  observeEvent(input$previous3,{
    updateTabsetPanel(session = session,"navMain", selected = "e")
  })
  observeEvent(input$previous2,{
    updateTabsetPanel(session = session,"navMain", selected = "f")
  })
  #observeEvent(input$check, {
  #  updateButton(session,"check",disabled = TRUE)
  #})
  
  ##Set timer with start, stop, restart, stop, and termination; and show the timer
  time<-reactiveValues(inc=0, timer=reactiveTimer(1000), started=FALSE)
  
  ### When student click submit, timer stops and rerun on next level when the person click 'Next'.
  observeEvent(input$go, {time$started<-TRUE})
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
  #observeEvent(input$next6, {time$started <- TRUE})
  
  
  observeEvent(input$finish, {time$timer<-reactiveTimer(Inf)})
  
  observe({
    time$timer()
    if(isolate(time$started))
      time$inc<-isolate(time$inc)+1
  })
  #show the timer
  observeEvent(input$bt1 == TRUE, {
    toggle('timer1h')
    output$timer1 <- renderPrint({
      cat("you have used:", time$inc, "secs")})
  })
  
  observeEvent(input$bt2 == TRUE, {
    toggle('timer2h')
    output$timer2 <- renderPrint({
      cat("you have used:", time$inc, "secs")})
  })
  observeEvent(input$bt3 == TRUE, {
    toggle('timer3h')
    output$timer3 <- renderPrint({
      cat("you have used:", time$inc, "secs")})
  })
  
  observeEvent(input$bt4 == TRUE, {
    toggle('timer4h')
    output$timer4 <- renderPrint({
      cat("you have used:", time$inc, "secs")})
  })
  observeEvent(input$bt5 == TRUE, {
    toggle('timer5h')
    output$timer5 <- renderPrint({
      cat("you have used:", time$inc, "secs")})
  })
  
  observeEvent(input$bt6 == TRUE, {
    toggle('timer6h')
    output$timer6 <- renderPrint({
      cat("you have used:", time$inc, "secs")})
  })
  
  output$timer8 <- renderPrint({
    cat("you have used:", time$inc, "secs")})
  
  
  ### Icon buttons for questions and hints.
  observeEvent(input$bq1 == FALSE, {
    toggle('hint1q')
    output$hint1 <- renderPrint({
      cat('The mean and median are the same for symmetric histograms while the mean is bigger for right-skewed histograms
    and the median is bigger for left skewed histograms')})
  })
  observeEvent(input$bq2 == TRUE, {
    toggle('hint2q')
    output$hint2 <- renderPrint({
      cat("The standard deviation measures variation so it will be smaller when there's more of the 
          distribution close to the center")})
  })
  observeEvent(input$bq3 == TRUE, {
    toggle('hint3q')
    output$hint3 <- renderPrint({
      cat("You should be able to tell where the median is and whether the distribution is skewed or symmetric 
          from looking at either the boxplot or the histogram")})
  })
  observeEvent(input$bq4 == TRUE, {
    toggle('hint4q')
    output$hint4 <- renderPrint({
      cat("Correlations closer to -1 show points more tightly clustered around a downward sloping line. 
          Correlations closer to +1 show points more tightly clustered around an upward sloping line. 
          Also outliers can have a big effect on the correlation.")})
  })
  observeEvent(input$bq5 == TRUE, {
    toggle('hint5q')
    output$hint5 <- renderPrint({
      cat("Bimodal distributions arise when you are sampling from two different populations. 
          For skewed possibilities think about whether the unusual values (outliers) are likely to be on the right
          side or left side of the plot.")})
  })
  observeEvent(input$bq6 == TRUE, {
    toggle('hint6q')
    output$hint6 <- renderPrint({
      cat("Remember that negative values are smaller than positive values.
          So your largest positive correlation goes under 'highest' and your most negative correlation goes under 'lowest'")})
  })
  
  
  ################################################################################################## 
  ####################### Contents - This is where all drop UIs came from. #########################
  ################################################################################################## 
  numbersA <- reactiveValues(right= c(), left= c(), normal = c(), random = c(), indexA = c(), questionA = data.frame())
  observeEvent(input$go,{
    numbersA$right = sample(1:3,1)
    numbersA$left = sample(4:6,1)
    numbersA$normal = sample(7:12,1)
    numbersA$random = sample(13:20,1)
    
    numbersA$indexA = sample(c("A","B","C","D"),4)
    numbersA$questionA = cbind(bankA[c(numbersA$right,numbersA$left,numbersA$normal,numbersA$random),],numbersA$indexA)
    
  })
  ###################################################################################################
  
  output$text1 <- renderText({
    numbersA$questionA[numbersA$questionA[6]== "A", 4]
    #numbersB$questionB[numbersB$questionB[5] == "A",4]
  })
  # if(input$details !=0){
  output$text11 <- renderText({
    numbersA$questionA[numbersA$questionA[6]== "A", 5]
    #numbersB$questionB[numbersB$questionB[5] == "A",4]
  })
  # }
  output$image1 <- renderUI({
    img(src = numbersA$questionA[numbersA$questionA[1] == "right",3], width = "95%", height = "95%", style = "text-align: center")
  })
  output$text2 <- renderText({
    numbersA$questionA[numbersA$questionA[6]== "B", 4]
    # numbersB$questionB[numbersB$questionB[5] == "B",4]
  })
  output$text222 <- renderText({
    numbersA$questionA[numbersA$questionA[6]== "B", 5]
    #numbersB$questionB[numbersB$questionB[5] == "A",4]
  })
  output$image2 <- renderUI({
    img(src = numbersA$questionA[numbersA$questionA[1] == "left",3], width = "95%", height = "95%")
  })
  output$text3 <- renderText({
    numbersA$questionA[numbersA$questionA[6]== "C", 4]
    # numbersB$questionB[numbersB$questionB[5] == "C",4]
  })
  output$text33 <- renderText({
    numbersA$questionA[numbersA$questionA[6]== "C", 5]
    #numbersB$questionB[numbersB$questionB[5] == "A",4]
  })
  output$image3 <- renderUI({
    img(src = numbersA$questionA[numbersA$questionA[1] == "normal",3], width = "95%", height = "95%")
  })
  output$text4 <- renderText({
    numbersA$questionA[numbersA$questionA[6]== "D", 4]
    #numbersB$questionB[numbersB$questionB[5] == "D",4]
  })
  output$text44 <- renderText({
    numbersA$questionA[numbersA$questionA[6]== "D", 5]
    #numbersB$questionB[numbersB$questionB[5] == "A",4]
  })
  output$image4 <- renderUI({
    img(src = numbersA$questionA[numbersA$questionA[1] == "random",3], width = "95%", height = "95%")
  })
  
  #################################################################################################
  numbersB <- reactiveValues(mean1= c(), mean2= c(), mean3 = c(), mean4 = c(), indexB = c(), questionB = data.frame())
  observeEvent(input$go,{
    numbersB$mean1 = sample(1:3,1)
    numbersB$mean2 = sample(4:6,1)
    numbersB$mean3 = sample(7:9,1)
    numbersB$mean4 = sample(10:12,1)
    
    numbersB$indexB = sample(c("A","B","C","D"),4)
    numbersB$questionB = cbind(bankB[c(numbersB$mean1,numbersB$mean2,numbersB$mean3,numbersB$mean4),],numbersB$indexB)
    
  })
  ###################################################################################################
  
  output$text5 <- renderText({
    numbersB$questionB[numbersB$questionB[4]== "A", 2]
    #numbersB$questionB[numbersB$questionB[5] == "A",4]
  })
  
  output$image5 <- renderUI({
    img(src = numbersB$questionB[numbersB$questionB[1] == "mean1",3], width = "95%", height = "95%", style = "text-align: center")
  })
  output$text6 <- renderText({
    numbersB$questionB[numbersB$questionB[4]== "B", 2]
    # numbersB$questionB[numbersB$questionB[5] == "B",4]
  })
  
  output$image6 <- renderUI({
    img(src = numbersB$questionB[numbersB$questionB[1] == "mean2",3], width = "95%", height = "95%")
  })
  output$text7 <- renderText({
    numbersB$questionB[numbersB$questionB[4]== "C", 2]
    # numbersB$questionB[numbersB$questionB[5] == "C",4]
  })
  output$image7 <- renderUI({
    img(src = numbersB$questionB[numbersB$questionB[1] == "mean3",3], width = "95%", height = "95%")
  })
  output$text8 <- renderText({
    numbersB$questionB[numbersB$questionB[4]== "D", 2]
    #numbersB$questionB[numbersB$questionB[5] == "D",4]
  })
  output$image8 <- renderUI({
    img(src = numbersB$questionB[numbersB$questionB[1] == "mean4",3], width = "95%", height = "95%")
  })
  
  ##############################################################################################
  numbersC <- reactiveValues(left= c(), right= c(), normal = c(), uniform = c(), indexC = c(), questionC = data.frame())
  observeEvent(input$go,{
    numbersC$left = sample(1:4,1)
    numbersC$right = sample(5:9,1)
    numbersC$normal = sample(10:12,1)
    numbersC$uniform = sample(13:14,1)
    
    numbersC$indexC = sample(c("A","B","C","D"),4)
    numbersC$questionC = cbind(bankC[c(numbersC$left,numbersC$right,numbersC$normal,numbersC$uniform),],numbersC$indexC)
    
  })
  #############################
  output$image13 <- renderUI({
    img(src = numbersC$questionC[numbersC$questionC[4] == "A",3], width = "95%", height = "95%")
  })
  output$image14 <- renderUI({
    img(src = numbersC$questionC[numbersC$questionC[4] == "B",3], width = "95%", height = "95%")
  })
  output$image15 <- renderUI({
    img(src = numbersC$questionC[numbersC$questionC[4] == "C",3], width = "95%", height = "95%")
  })
  output$image16 <- renderUI({
    img(src = numbersC$questionC[numbersC$questionC[4] == "D",3], width = "95%", height = "95%")
  })
  
  output$image17 <- renderUI({
    img(src = numbersC$questionC[numbersC$questionC[1] == "left",2], width = "95%", height = "95%", style = "text-align: center")
  })
  output$image18 <- renderUI({
    img(src = numbersC$questionC[numbersC$questionC[1] == "right",2], width = "95%", height = "95%", style = "text-align: center")
  })
  output$image19 <- renderUI({
    img(src = numbersC$questionC[numbersC$questionC[1] == "normal",2], width = "95%", height = "95%", style = "text-align: center")
  })
  output$image20 <- renderUI({
    img(src = numbersC$questionC[numbersC$questionC[1] == "uniform",2], width = "95%", height = "95%", style = "text-align: center")
  })
  
  ##############################################################################################
  numbersD <- reactiveValues(neg= c(), pos= c(), out = c(), hhh = c(), indexD = c(), questionD = data.frame())
  observeEvent(input$go,{
    numbersD$neg = sample(1:6,1)
    numbersD$pos = sample(7:12,1)
    numbersD$out = sample(13:16,1)
    numbersD$hhh = sample(17:20,1)
    
    numbersD$indexD = sample(c("A","B","C","D"),4)
    numbersD$questionD = cbind(bankD[c(numbersD$neg,numbersD$pos,numbersD$out,numbersD$hhh),],numbersD$indexD)
    
  })
  ############################# #
  output$text17 <- renderText({
    numbersD$questionD[numbersD$questionD[4]== "A", 1]
    #numbersB$questionB[numbersB$questionB[5] == "A",4]
  })
  
  output$image21 <- renderUI({
    img(src = numbersD$questionD[numbersD$questionD[3] == "neg",2], width = "95%", height = "95%", style = "text-align: center")
  })
  output$text18 <- renderText({
    numbersD$questionD[numbersD$questionD[4]== "B", 1]
    # numbersB$questionB[numbersB$questionB[5] == "B",4]
  })
  
  output$image22 <- renderUI({
    img(src = numbersD$questionD[numbersD$questionD[3] == "pos",2], width = "95%", height = "95%", style = "text-align: center")
  })
  output$text19 <- renderText({
    numbersD$questionD[numbersD$questionD[4]== "C", 1]
    # numbersB$questionB[numbersB$questionB[5] == "C",4]
  })
  output$image23 <- renderUI({
    img(src = numbersD$questionD[numbersD$questionD[3] == "out",2], width = "95%", height = "95%", style = "text-align: center")
  })
  output$text20 <- renderText({
    numbersD$questionD[numbersD$questionD[4]== "D", 1]
    #numbersB$questionB[numbersB$questionB[5] == "D",4]
  })
  output$image24 <- renderUI({
    img(src = numbersD$questionD[numbersD$questionD[3] == "hhh",2], width = "95%", height = "95%", style = "text-align: center")
  })
  ############################################################################################### 
  
  output$right <- renderPlot({
    plot(seq(0,5,.001),dgamma(seq(0,5,.001),2,2),
         type="l",main="Right-skewed",col="red",lwd=2,axes = F, xlab = " ", ylab = " ") # Funcion de densidad de una Gamma(20,10)
  })
  output$left <- renderPlot({
    plot(seq(5,0,-.001),dgamma(seq(0,5,.001),2,2),
         type="l",main="Left-skewed",col="red",lwd=2,axes = F, xlab = " ", ylab = " ") # Funcion de densidad de una Gamma(20,10)
  })
  output$normal <- renderPlot({
    x<-seq(0,1,length=1000)
    dens <- dbeta(x,shape1 = 1.5,shape2 = 1.5)
    plot(x, dens, type="l",
         main="symmetric", lwd=2, axes = F, col = "red", xlab = " ", ylab = " ")
  })
  output$bimodal <- renderPlot({
    a<-mix.synthetic.facing.gamma(N = 5008, mix.prob = 0.5, lower=0, upper=6,
                                  1, 1, 1, 1)
    length(a)
    t<-5/length(a)
    y<-seq(0+t,5,t)
    z<-seq(5-t,0,-t)
    x1<-dgamma(z,5,5)
    y1<-dgamma(y,4, 4)
    p<-0.55
    Z<-p*x1+(1-p)*y1
    plot(y,Z,type="l", yaxs="i", xaxs="i",
         xlab=" ", ylab=" ", main="Bimodal distribution", lwd=2, axes = F, col = "red")
    lines(y,Z,type="l",main="population",col="red",xlab=" ",ylab=" ")
  })
  ############################################################################################### 
  numbersE <- reactiveValues(bimodal= c(), left= c(), right= c(), normal = c(), indexE = c(), questionE = data.frame())
  observeEvent(input$go,{
    numbersE$bimodal = sample(1:5,1)
    numbersE$left = sample(6:10,1)
    numbersE$right = sample(11:15,1)
    numbersE$normal = sample(16:20,1)
    
    numbersE$indexE = sample(c("A","B","C","D"),4)
    numbersE$questionE = cbind(bankE[c(numbersE$bimodal,numbersE$left,numbersE$right,numbersE$normal),],numbersE$indexE)
    
  })
  ############################################################################################### 
  
  output$text21 <- renderText({
    numbersE$questionE[numbersE$questionE[5]== "A", 4]
    #numbersB$questionB[numbersB$questionB[5] == "A",4]
  })
  output$text22 <- renderText({
    numbersE$questionE[numbersE$questionE[5]== "B", 4]
    #numbersB$questionB[numbersB$questionB[5] == "A",4]
  })
  output$text23 <- renderText({
    numbersE$questionE[numbersE$questionE[5]== "C",4]
    #numbersB$questionB[numbersB$questionB[5] == "A",4]
  })
  output$text24 <- renderText({
    numbersE$questionE[numbersE$questionE[5]== "D", 4]
    #numbersB$questionB[numbersB$questionB[5] == "A",4]
  })
  ############################################################################################### 
  numbersF1 <- reactiveValues(first = c(), indexF1 = c(), questionF1 = data.frame())
  observeEvent(input$go,{
    numbersF1$first = c(1,2,3,4)
    
    
    numbersF1$indexF1 = sample(c("A","B","C","D"),4)
    numbersF1$questionF1 = cbind(bankF1[numbersF1$first,],numbersF1$indexF1)
    
  })
  # ##############################################################################################
  choice = sample(1:4, 1)
  if (choice==1){
    
    output$text25 <- renderText({
      numbersF1$questionF1[numbersF1$questionF1[3]== "A", 1]
      
    })
    output$text26 <- renderText({
      numbersF1$questionF1[numbersF1$questionF1[3]== "B", 1]
      
    })
    output$text27 <- renderText({
      numbersF1$questionF1[numbersF1$questionF1[3]== "C", 1]
      
    })
    output$text28 <- renderText({
      numbersF1$questionF1[numbersF1$questionF1[3]== "D", 1]
      
    })}
  # ############################################################################################### 
  numbersF2 <- reactiveValues(second = c(), indexF2 = c(), questionF2 = data.frame())
  observeEvent(input$go,{
    numbersF2$second = c(1,2,3,4)
    
    
    numbersF2$indexF2 = sample(c("A","B","C","D"),4)
    numbersF2$questionF2 = cbind(bankF2[numbersF2$second,],numbersF2$indexF2)
    
  })
  # ##############################################################################################
  if(choice==2){
    output$text25 <- renderText({
      numbersF2$questionF2[numbersF2$questionF2[3]== "A", 1]
      
    })
    output$text26 <- renderText({
      numbersF2$questionF2[numbersF2$questionF2[3]== "B", 1]
      
    })
    output$text27 <- renderText({
      numbersF2$questionF2[numbersF2$questionF2[3]== "C", 1]
      
    })
    output$text28 <- renderText({
      numbersF2$questionF2[numbersF2$questionF2[3]== "D", 1]
      
    })
  }
  # ############################################################################################### 
  numbersF3 <- reactiveValues(third = c(), indexF3 = c(), questionF3 = data.frame())
  observeEvent(input$go,{
    numbersF3$third = c(1,2,3,4)
    
    
    numbersF3$indexF3 = sample(c("A","B","C","D"),4)
    numbersF3$questionF3 = cbind(bankF3[numbersF3$third,],numbersF3$indexF3)
    
  })
  # ##############################################################################################
  if(choice==3){
    output$text25 <- renderText({
      numbersF3$questionF3[numbersF3$questionF3[3]== "A", 1]
      
    })
    output$text26 <- renderText({
      numbersF3$questionF3[numbersF3$questionF3[3]== "B", 1]
      
    })
    output$text27 <- renderText({
      numbersF3$questionF3[numbersF3$questionF3[3]== "C", 1]
      
    })
    output$text28 <- renderText({
      numbersF3$questionF3[numbersF3$questionF3[3]== "D", 1]
      
    })}
  # ############################################################################################### 
  numbersF4 <- reactiveValues(last = c(), indexF4 = c(), questionF4 = data.frame())
  observeEvent(input$go,{
    numbersF4$last = c(1,2,3,4)
    
    
    numbersF4$indexF4 = sample(c("A","B","C","D"),4)
    numbersF4$questionF4 = cbind(bankF4[numbersF4$last,],numbersF4$indexF4)
    
  })
  # ##############################################################################################
  if(choice==4){
    output$text25 <- renderText({
      numbersF4$questionF4[numbersF4$questionF4[3]== "A", 1]
      
    })
    output$text26 <- renderText({
      numbersF4$questionF4[numbersF4$questionF4[3]== "B", 1]
      
    })
    output$text27 <- renderText({
      numbersF4$questionF4[numbersF4$questionF4[3]== "C", 1]
      
    })
    output$text28 <- renderText({
      numbersF4$questionF4[numbersF4$questionF4[3]== "D", 1]
      
    })}
  
  
  
  
  
  #################################################################################
  ### Submit button and show Penalty box.
  observeEvent(input$submitA,{
    updateButton(session,"submitA",disabled = TRUE)
    updateButton(session,"clearA",disabled = FALSE)
  })
  observeEvent(input$clearA,{
    updateButton(session,"submitA",disabled = FALSE)
    updateButton(session,"clearA",disabled = TRUE)
  })
  
  observeEvent(input$submitB,{
    updateButton(session,"submitB",disabled = TRUE)
    updateButton(session,"clearB",disabled = FALSE)
  })
  observeEvent(input$clearB,{
    updateButton(session,"submitB",disabled = FALSE)
    updateButton(session,"clearB",disabled = TRUE)
  })
  
  observeEvent(input$submitC,{
    updateButton(session,"submitC",disabled = TRUE)
    updateButton(session,"clearC",disabled = FALSE)
  })
  observeEvent(input$clearC,{
    updateButton(session,"submitC",disabled = FALSE)
    updateButton(session,"clearC",disabled = TRUE)
  })
  
  observeEvent(input$submitD,{
    updateButton(session,"submitD",disabled = TRUE)
    updateButton(session,"clearD",disabled = FALSE)
  })
  observeEvent(input$clearD,{
    updateButton(session,"submitD",disabled = FALSE)
    updateButton(session,"clearD",disabled = TRUE)
  })
  
  observeEvent(input$submitE,{
    updateButton(session,"submitE",disabled = TRUE)
    updateButton(session,"clearE",disabled = FALSE)
  })
  observeEvent(input$clearE,{
    updateButton(session,"submitE",disabled = FALSE)
    updateButton(session,"clearE",disabled = TRUE)
  })
  
  observeEvent(input$submitF,{
    updateButton(session,"submitF",disabled = TRUE)
    updateButton(session,"clearF",disabled = FALSE)
  })
  observeEvent(input$clearF,{
    updateButton(session,"submitF",disabled = FALSE)
    updateButton(session,"clearF",disabled = TRUE)
  })
  ###################################################################################
  
  
  ### After click Submit buttons. Watch out for the clear code that might occur the error
  #First, click Submit button and it will show whether the answer is correct or not
  observeEvent(input$submitA,{
    output$answer1 <- renderUI({
      if (!is.null(input$drp1)){
        if (input$drp1 == numbersA$questionA[numbersA$questionA[1]== "right", 6]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  #Second, drag wrong drop box into the penalty box and click 'Re-attempt' button to clear cross marks.
  observeEvent(input$clearA,{
    output$answer1 <- renderUI({
      #if (input$drp1 == numbersA$questionA[numbersA$questionA[1]== "right", 6]){
      #  img(src = "check.png",width = 30)
      #}else{
      #  img(src = NULL,width = 30)
      #}
        img(src = NULL,width = 30)
    })
  })
  
  observeEvent(input$submitA,{
    output$answer2 <- renderUI({
      if (!is.null(input$drp2)){
        if (input$drp2 == numbersA$questionA[numbersA$questionA[1]== "left", 6]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  observeEvent(input$clearA,{
    output$answer2 <- renderUI({
      #if (input$drp2 == numbersA$questionA[numbersA$questionA[1]== "left", 6]){
      #  img(src = "check.png",width = 30)
      #}else{
      #  img(src = NULL,width = 30)
      #}
         img(src = NULL,width = 30)
    })
  })
  
  observeEvent(input$submitA,{  
    output$answer3 <- renderUI({
      if (!is.null(input$drp3)){
        if (input$drp3 == numbersA$questionA[numbersA$questionA[1]== "normal", 6]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  
  observeEvent(input$clearA,{
    output$answer3 <- renderUI({
      #if (input$drp3 == numbersA$questionA[numbersA$questionA[1]== "normal", 6]){
      #  img(src = "check.png",width = 30)
      #}else{
      #  img(src = NULL,width = 30)
      #}
        img(src = NULL,width = 30)
    })
  })
  
  
  observeEvent(input$submitA,{  
    output$answer4 <- renderUI({
      if (!is.null(input$drp4)){
        if (input$drp4 == numbersA$questionA[numbersA$questionA[1]== "random", 6]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  
  observeEvent(input$clearA,{
    output$answer4 <- renderUI({
      #if (input$drp4 == numbersA$questionA[numbersA$questionA[1]== "random", 6]){
      #  img(src = "check.png",width = 30)
      #}else{
      #  img(src = NULL,width = 30)
      #}
          img(src = NULL,width = 30)
    })
  })
  
  
  ####################################################################
  # Level 2
  
  observeEvent(input$submitB,{  
    output$answer5 <- renderUI({
      if (!is.null(input$drp5)){
        if (input$drp5 ==numbersB$questionB[numbersB$questionB[1]== "mean1", 4]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  observeEvent(input$clearB,{
    output$answer5 <- renderUI({
      img(src = NULL,width = 30)
    })
  })
  
  
  observeEvent(input$submitB,{  
    output$answer6 <- renderUI({
      if (!is.null(input$drp6)){
        if (input$drp6 == numbersB$questionB[numbersB$questionB[1]== "mean2", 4]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  observeEvent(input$clearB,{
    output$answer6 <- renderUI({
      img(src = NULL,width = 30)
    })
  })
  
  
  observeEvent(input$submitB,{
    output$answer7 <- renderUI({
      if (!is.null(input$drp7)){
        if (input$drp7 == numbersB$questionB[numbersB$questionB[1]== "mean3", 4]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  observeEvent(input$clearB,{
    output$answer7 <- renderUI({
      img(src = NULL,width = 30)
    })
  })
  
  
  observeEvent(input$submitB,{
    output$answer8 <- renderUI({
      if (!is.null(input$drp8)){
        if (input$drp8 == numbersB$questionB[numbersB$questionB[1]== "mean4", 4]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  observeEvent(input$clearB,{
    output$answer8 <- renderUI({
      img(src = NULL,width = 30)
    })
  })
  
  ####################################################################
  
  
  observeEvent(input$submitC,{  
    output$answer13 <- renderUI({
      if (!is.null(input$drp13)){
        if (input$drp13 ==numbersC$questionC[numbersC$questionC[1] == "left",4]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  observeEvent(input$clearC,{
    output$answer13 <- renderUI({
      img(src = NULL,width = 30)
    })
  })
  
  observeEvent(input$submitC,{  
    output$answer14 <- renderUI({
      if (!is.null(input$drp14)){
        if (input$drp14 == numbersC$questionC[numbersC$questionC[1] == "right",4]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  observeEvent(input$clearC,{
    output$answer14 <- renderUI({
      img(src = NULL,width = 30)
    })
  })
  
  observeEvent(input$submitC,{  
    output$answer15 <- renderUI({
      if (!is.null(input$drp15)){
        if (input$drp15 == numbersC$questionC[numbersC$questionC[1] == "normal",4]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  observeEvent(input$clearC,{
    output$answer15 <- renderUI({
      img(src = NULL,width = 30)
    })
  })
  
  observeEvent(input$submitC,{  
    output$answer16 <- renderUI({
      if (!is.null(input$drp16)){
        if (input$drp16 == numbersC$questionC[numbersC$questionC[1] == "uniform",4]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  observeEvent(input$clearC,{
    output$answer16 <- renderUI({
      img(src = NULL,width = 30)
    })
  })
  
  #######################################
  
  observeEvent(input$submitD,{  
    output$answer17 <- renderUI({
      if (!is.null(input$drp17)){
        if (input$drp17 ==numbersD$questionD[numbersD$questionD[3] == "neg",4]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  observeEvent(input$clearD,{
    output$answer17 <- renderUI({
      img(src = NULL,width = 30)
    })
  })
  
  observeEvent(input$submitD,{  
    output$answer18 <- renderUI({
      if (!is.null(input$drp18)){
        if (input$drp18 == numbersD$questionD[numbersD$questionD[3] == "pos",4]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  observeEvent(input$clearD,{
    output$answer18 <- renderUI({
      img(src = NULL,width = 30)
    })
  })
  
  observeEvent(input$submitD,{  
    output$answer19 <- renderUI({
      if (!is.null(input$drp19)){
        if (input$drp19 == numbersD$questionD[numbersD$questionD[3] == "out",4]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  observeEvent(input$clearD,{
    output$answer19 <- renderUI({
      img(src = NULL,width = 30)
    })
  })
  
  observeEvent(input$submitD,{  
    output$answer20 <- renderUI({
      if (!is.null(input$drp20)){
        if (input$drp20 == numbersD$questionD[numbersD$questionD[3] == "hhh",4]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  observeEvent(input$clearD,{
    output$answer20 <- renderUI({
      img(src = NULL,width = 30)
    })
  })
  
  #############
  observeEvent(input$submitE,{
    output$answer21 <- renderUI({
      if (!is.null(input$drp21)){
        if (input$drp21 ==numbersE$questionE[numbersE$questionE[1] == "normal",5]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  observeEvent(input$clearE,{
    output$answer21 <- renderUI({
      img(src = NULL,width = 30)
    })
  })
  
  observeEvent(input$submitE,{
    output$answer22 <- renderUI({
      if (!is.null(input$drp22)){
        if (input$drp22 ==numbersE$questionE[numbersE$questionE[1] == "right",5]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  observeEvent(input$clearE,{
    output$answer22 <- renderUI({
      img(src = NULL,width = 30)
    })
  })
  
  observeEvent(input$submitE,{
    output$answer23 <- renderUI({
      if (!is.null(input$drp23)){
        if (input$drp23 == numbersE$questionE[numbersE$questionE[1] == "left",5]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  observeEvent(input$clearE,{
    output$answer23 <- renderUI({
      img(src = NULL,width = 30)
    })
  })
  
  observeEvent(input$submitE,{
    output$answer24 <- renderUI({
      if (!is.null(input$drp24)){
        if (input$drp24 == numbersE$questionE[numbersE$questionE[1] == "binomial",5]){
          img(src = "check.png",width = 30)
        }else{
          img(src = "cross.png",width = 30)
        }
      }
    })
  })
  observeEvent(input$clearE,{
    output$answer24 <- renderUI({
      img(src = NULL,width = 30)
    })
  })
  
  #############
  if(choice==1){
    observeEvent(input$submitF,{
      output$answer25 <- renderUI({
        if (!is.null(input$drp25)){
          if (input$drp25 == numbersF1$questionF1[numbersF1$questionF1[2] == "1",3]){
            img(src = "check.png",width = 30)
          }else{
            img(src = "cross.png",width = 30)
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer25 <- renderUI({
        img(src = NULL,width = 30)
      })
    })
    
    observeEvent(input$submitF,{
      output$answer26 <- renderUI({
        if (!is.null(input$drp26)){
          if (input$drp26 ==numbersF1$questionF1[numbersF1$questionF1[2] == "2",3]){
            img(src = "check.png",width = 30)
          }else{
            img(src = "cross.png",width = 30)
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer26 <- renderUI({
        img(src = NULL,width = 30)
      })
    })
    
    observeEvent(input$submitF,{
      output$answer27 <- renderUI({
        if (!is.null(input$drp27)){
          if (input$drp27 == numbersF1$questionF1[numbersF1$questionF1[2] == "3",3]){
            img(src = "check.png",width = 30)
          }else{
            img(src = "cross.png",width = 30)
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer27 <- renderUI({
        img(src = NULL,width = 30)
      })
    })
    
    observeEvent(input$submitF,{
      output$answer28 <- renderUI({
        if (!is.null(input$drp28)){
          if (input$drp28 == numbersF1$questionF1[numbersF1$questionF1[2] == "4",3]){
            img(src = "check.png",width = 30)
          }else{
            img(src = "cross.png",width = 30)
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer28 <- renderUI({
        img(src = NULL,width = 30)
      })
    })}
  
  if(choice==2){
    observeEvent(input$submitF,{
      output$answer25 <- renderUI({
        if (!is.null(input$drp25)){
          if (input$drp25 ==numbersF2$questionF2[numbersF2$questionF2[2] == "1",3]){
            img(src = "check.png",width = 30)
          }else{
            img(src = "cross.png",width = 30)
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer25 <- renderUI({
        img(src = NULL,width = 30)
      })
    })
    
    observeEvent(input$submitF,{
      output$answer26 <- renderUI({
        if (!is.null(input$drp26)){
          if (input$drp26 ==numbersF2$questionF2[numbersF2$questionF2[2] == "2",3]){
            img(src = "check.png",width = 30)
          }else{
            img(src = "cross.png",width = 30)
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer26 <- renderUI({
        img(src = NULL,width = 30)
      })
    })
    
    observeEvent(input$submitF,{
      output$answer27 <- renderUI({
        if (!is.null(input$drp27)){
          if (input$drp27 == numbersF2$questionF2[numbersF2$questionF2[2] == "3",3]){
            img(src = "check.png",width = 30)
          }else{
            img(src = "cross.png",width = 30)
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer27 <- renderUI({
        img(src = NULL,width = 30)
      })
    })
    
    observeEvent(input$submitF,{
      output$answer28 <- renderUI({
        if (!is.null(input$drp28)){
          if (input$drp28 == numbersF2$questionF2[numbersF2$questionF2[2] == "4",3]){
            img(src = "check.png",width = 30)
          }else{
            img(src = "cross.png",width = 30)
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer28 <- renderUI({
        img(src = NULL,width = 30)
      })
    })}
  
  if(choice==3){
    observeEvent(input$submitF,{
      output$answer25 <- renderUI({
        if (!is.null(input$drp25)){
          if (input$drp25 ==numbersF3$questionF3[numbersF3$questionF3[2] == "1",3]){
            img(src = "check.png",width = 30)
          }else{
            img(src = "cross.png",width = 30)
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer25 <- renderUI({
        img(src = NULL,width = 30)
      })
    })
    
    observeEvent(input$submitF,{
      output$answer26 <- renderUI({
        if (!is.null(input$drp26)){
          if (input$drp26 ==numbersF3$questionF3[numbersF3$questionF3[2] == "2",3]){
            img(src = "check.png",width = 30)
          }else{
            img(src = "cross.png",width = 30)
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer26 <- renderUI({
        img(src = NULL,width = 30)
      })
    })
    
    observeEvent(input$submitF,{
      output$answer27 <- renderUI({
        if (!is.null(input$drp27)){
          if (input$drp27 == numbersF3$questionF3[numbersF3$questionF3[2] == "3",3]){
            img(src = "check.png",width = 30)
          }else{
            img(src = "cross.png",width = 30)
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer27 <- renderUI({
        img(src = NULL,width = 30)
      })
    })
    
    observeEvent(input$submitF,{
      output$answer28 <- renderUI({
        if (!is.null(input$drp28)){
          if (input$drp28 == numbersF3$questionF3[numbersF3$questionF3[2] == "4",3]){
            img(src = "check.png",width = 30)
          }else{
            img(src = "cross.png",width = 30)
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer28 <- renderUI({
        img(src = NULL,width = 30)
      })
    })}
  
  
  if(choice==4){
    observeEvent(input$submitF,{
      output$answer25 <- renderUI({
        if (!is.null(input$drp25)){
          if (input$drp25 ==numbersF4$questionF4[numbersF4$questionF4[2] == "1",3]){
            img(src = "check.png",width = 30)
          }else{
            img(src = "cross.png",width = 30)
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer25 <- renderUI({
        img(src = NULL,width = 30)
      })
    })
    
    observeEvent(input$submitF,{
      output$answer26 <- renderUI({
        if (!is.null(input$drp26)){
          if (input$drp26 ==numbersF4$questionF4[numbersF4$questionF4[2] == "2",3]){
            img(src = "check.png",width = 30)
          }else{
            img(src = "cross.png",width = 30)
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer26 <- renderUI({
        img(src = NULL,width = 30)
      })
    })
    
    observeEvent(input$submitF,{
      output$answer27 <- renderUI({
        if (!is.null(input$drp27)){
          if (input$drp27 == numbersF4$questionF4[numbersF4$questionF4[2] == "3",3]){
            img(src = "check.png",width = 30)
          }else{
            img(src = "cross.png",width = 30)
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer27 <- renderUI({
        img(src = NULL,width = 30)
      })
    })
    
    observeEvent(input$submitF,{
      output$answer28 <- renderUI({
        if (!is.null(input$drp28)){
          if (input$drp28 == numbersF4$questionF4[numbersF4$questionF4[2] == "4",3]){
            img(src = "check.png",width = 30)
          }else{
            img(src = "cross.png",width = 30)
          }
        }
      })
    })
    observeEvent(input$clearF,{
      output$answer28 <- renderUI({
        img(src = NULL,width = 30)
      })
    })}
  
  
  
  
  #####################################################
  ####################### Score #######################
  #####################################################
  
  
  summation <- reactiveValues(summationA = c(rep(0,8)), summationB = c(rep(0,8)),summationC = c(rep(0,16)), summationD = c(rep(0,20)),
                              summationE = c(rep(0,24)), summationF = c(rep(0,24)), summationScore = c(rep(0,100)))
  
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
    #cat("Current score of this level is",summation$summationA[input$submitA])
  })
  
  ############################################## 
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
    #cat("Current score of this level is",summation$summationB[input$submitB])
  })
  
  output$scoreC <- renderUI({
    str5 <- paste("Your current score on this level is:")
    str6 <- paste(summation$summationC[input$submitC]," out of 16.")
    HTML(paste(str5, str6, sep = '<br/>'))
    #cat("Current score of this level is",summation$summationC[input$submitC])
  })
  output$scoreD <- renderUI({
    str7 <- paste("Your current score on this level is:")
    str8 <- paste(summation$summationD[input$submitD]," out of 20.")
    HTML(paste(str7, str8, sep = '<br/>'))
    #cat("Current score of this level is",summation$summationD[input$submitD])
  })
  output$scoreE <- renderUI({
    str9 <- paste("Your current score on this level is:")
    str10 <- paste(summation$summationE[input$submitE]," out of 24.")
    HTML(paste(str9, str10, sep = '<br/>'))
    #cat("Current score of this level is",summation$summationE[input$submitE])
  })
  output$scoreF <- renderUI({
    str11 <- paste("Your current score on this level is:")
    str12 <- paste(summation$summationF[input$submitF]," out of 24.")
    HTML(paste(str11, str12, sep = '<br/>'))
    #cat("Current score of this level is",summation$summationF[input$submitF])
  })
  
  
  ############################################## 
  observeEvent(input$submitC,{
    score9 = c()
    score10 = c()
    score11 = c()
    score12 = c()
    
    for (i in input$drp13){
      if (i ==  numbersC$questionC[numbersC$questionC[1] == "left",4]){
        score9 = c(score9,4)
      }else{
        score9 = c(score9,-2)
      }
    }
    for (i in input$drp14){
      if (i ==  numbersC$questionC[numbersC$questionC[1] == "right",4]){
        score10 = c(score10,4)
      }else{
        score10 = c(score10,-2)
      }
    }
    for (i in input$drp15){
      if (i ==  numbersC$questionC[numbersC$questionC[1] == "normal",4]){
        score11 = c(score11,4)
      }else{
        score11 = c(score11,-2)
      }
    }
    for (i in input$drp16){
      if (i ==  numbersC$questionC[numbersC$questionC[1] == "uniform",4]){
        score12 = c(score12,4)
      }else{
        score12 = c(score12,-2)
      }
    }
    
    
    
    summation$summationC[input$submitC] <- sum(c(score9,score10, score11, score12))
  })
  ######################################################
  
  ############################################## 
  observeEvent(input$submitD,{
    score13 = c()
    score14 = c()
    score15 = c()
    score16 = c()
    
    for (i in input$drp17){
      if (i == numbersD$questionD[numbersD$questionD[3]== "neg", 4]){
        score13 = c(score13,5)
      }else{
        score13 = c(score13,-3)
      }
    }
    for (i in input$drp18){
      if (i ==  numbersD$questionD[numbersD$questionD[3]== "pos", 4]){
        score14 = c(score14,5)
      }else{
        score14 = c(score14,-3)
      }
    }
    for (i in input$drp19){
      if (i ==  numbersD$questionD[numbersD$questionD[3]== "out", 4]){
        score15 = c(score15,5)
      }else{
        score15 = c(score15,-3)
      }
    }
    for (i in input$drp20){
      if (i == numbersD$questionD[numbersD$questionD[3]== "hhh", 4]){
        score16 = c(score16,5)
      }else{
        score16 = c(score16,-3)
      }
    }
    summation$summationD[input$submitD] <- sum(c(score13,score14, score15, score16))
  })
  ###############################
  observeEvent(input$submitE,{
    score17 = c()
    score18 = c()
    score19 = c()
    score20 = c()
    
    for (i in input$drp21){
      if (i == numbersE$questionE[numbersE$questionE[1] == "normal",5]){
        score17 = c(score17,6)
      }else{
        score17 = c(score17,-3)
      }
    }
    for (i in input$drp22){
      if (i ==  numbersE$questionE[numbersE$questionE[1] == "right",5]){
        score18 = c(score18,6)
      }else{
        score18 = c(score18,-3)
      }
    }
    for (i in input$drp23){
      if (i ==  numbersE$questionE[numbersE$questionE[1] == "left",5]){
        score19 = c(score19,6)
      }else{
        score19 = c(score19,-3)
      }
    }
    for (i in input$drp24){
      if (i == numbersE$questionE[numbersE$questionE[1] == "binomial",5]){
        score20 = c(score20,6)
      }else{
        score20 = c(score20,-3)
      }
    }
    summation$summationE[input$submitE] <- sum(c(score17,score18, score19, score20))
  })
  
  ##############################
  ###############################
  observeEvent(input$submitF,{
    score21 = c()
    score22 = c()
    score23 = c()
    score24 = c()
    if(choice==1){  
      for (i in input$drp25){
        if (i == numbersF1$questionF1[numbersF1$questionF1[2] == "1",3]){
          score21 = c(score21,6)
        }else{
          score21 = c(score21,-3)
        }
      }
      for (i in input$drp26){
        if (i ==  numbersF1$questionF1[numbersF1$questionF1[2] == "2",3]){
          score22 = c(score22,6)
        }else{
          score22 = c(score22,-3)
        }
      }
      for (i in input$drp27){
        if (i ==  numbersF1$questionF1[numbersF1$questionF1[2] == "3",3]){
          score23 = c(score23,6)
        }else{
          score23 = c(score23,-3)
        }
      }
      for (i in input$drp28){
        if (i == numbersF1$questionF1[numbersF1$questionF1[2] == "4",3]){
          score24 = c(score24,6)
        }else{
          score24 = c(score24,-3)
        }
      } }
    else if(choice==2){  
      for (i in input$drp25){
        if (i == numbersF2$questionF2[numbersF2$questionF2[2] == "1",3]){
          score21 = c(score21,6)
        }else{
          score21 = c(score21,-3)
        }
      }
      for (i in input$drp26){
        if (i ==  numbersF2$questionF2[numbersF2$questionF2[2] == "2",3]){
          score22 = c(score22,6)
        }else{
          score22 = c(score22,-3)
        }
      }
      for (i in input$drp27){
        if (i ==  numbersF2$questionF2[numbersF2$questionF2[2] == "3",3]){
          score23 = c(score23,6)
        }else{
          score23 = c(score23,-3)
        }
      }
      for (i in input$drp28){
        if (i == numbersF2$questionF2[numbersF2$questionF2[2] == "4",3]){
          score24 = c(score24,6)
        }else{
          score24 = c(score24,-3)
        }
      } }
    else if(choice==3){  
      for (i in input$drp25){
        if (i == numbersF3$questionF3[numbersF3$questionF3[2] == "1",3]){
          score21 = c(score21,6)
        }else{
          score21 = c(score21,-3)
        }
      }
      for (i in input$drp26){
        if (i ==  numbersF3$questionF3[numbersF3$questionF3[2] == "2",3]){
          score22 = c(score22,6)
        }else{
          score22 = c(score22,-3)
        }
      }
      for (i in input$drp27){
        if (i ==  numbersF3$questionF3[numbersF3$questionF3[2] == "3",3]){
          score23 = c(score23,6)
        }else{
          score23 = c(score23,-3)
        }
      }
      for (i in input$drp28){
        if (i == numbersF3$questionF3[numbersF3$questionF3[2] == "4",3]){
          score24 = c(score24,6)
        }else{
          score24 = c(score24,-3)
        }
      } }
    else if(choice==4){  
      for (i in input$drp25){
        if (i == numbersF4$questionF4[numbersF4$questionF4[2] == "1",3]){
          score21 = c(score21,6)
        }else{
          score21 = c(score21,-3)
        }
      }
      for (i in input$drp26){
        if (i == numbersF4$questionF4[numbersF4$questionF4[2] == "2",3]){
          score22 = c(score22,6)
        }else{
          score22 = c(score22,-3)
        }
      }
      for (i in input$drp27){
        if (i ==  numbersF4$questionF4[numbersF4$questionF4[2] == "3",3]){
          score23 = c(score23,6)
        }else{
          score23 = c(score23,-3)
        }
      }
      for (i in input$drp28){
        if (i == numbersF4$questionF4[numbersF4$questionF4[2] == "4",3]){
          score24 = c(score24,6)
        }else{
          score24 = c(score24,-3)
        }
      } }
    summation$summationF[input$submitF] <- sum(c(score21,score22, score23, score24))
    
    
  })
  ###########################################################################################
  ### Penalty box text
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
      output$warning1 <- renderText({"Congratulations! You are ready to move on!"})
    }
    else if((summation$summationA[input$submitA] < 8)) {
      output$warning1 <- renderText({"Please drag wrong answers into this PENALTY box and drag back to try again."})
    }
  })
  
  # Level 2
  observeEvent(input$submitB,{
    if(summation$summationB[input$submitB] == 8){
      updateButton(session, "next2",disabled = FALSE)
      updateButton(session, "stop2",disabled = FALSE)
      #values$count = values$count + 80
    }})

  #####PENALTY BOX TEXT#####
  output$warning2 <- reactive({
    if(summation$summationB[input$submitB] == 8){
      output$warning2 <- renderText({"Congratulations! You are ready to move on!"})
    }
    else if((summation$summationB[input$submitB] < 8)) {
      output$warning2 <- renderText({"Please drag wrong answers into this PENALTY box and drag back to try again."})
    }
  })
  
  # Level 3
  observeEvent(input$submitC,{
    if(summation$summationC[input$submitC] == 16){
      updateButton(session, "next3",disabled = FALSE)
      updateButton(session, "stop3",disabled = FALSE)
      #values$count = values$count + 80
    }})

  #####PENALTY BOX TEXT#####
  output$warning3 <- reactive({
    if(summation$summationC[input$submitC] == 16){
      output$warning3 <- renderText({"Congratulations! You are ready to move on!"})
    }
    else if((summation$summationC[input$submitC] < 16)) {
      output$warning3 <- renderText({"Please drag wrong answers into this PENALTY box and drag back to try again."})
    }
  })
  
  # Level 4
  observeEvent(input$submitD,{
    if(summation$summationD[input$submitD] == 20){
      updateButton(session, "next4",disabled = FALSE)
      updateButton(session, "stop4",disabled = FALSE)
      #values$count = values$count + 80
    }})

  
  #####PENALTY BOX TEXT#####
  output$warning4 <- reactive({
    if(summation$summationD[input$submitD] == 20){
      output$warning4 <- renderText({"Congratulations! You are ready to move on!"})
    }
    else if((summation$summationD[input$submitD] < 20)) {
      output$warning4 <- renderText({"Please drag wrong answers into this PENALTY box and drag back to try again."})
    }
  })
  
  # Level 5
  observeEvent(input$submitE,{
    if(summation$summationE[input$submitE] == 24){
      updateButton(session, "next5",disabled = FALSE)
      updateButton(session, "stop5",disabled = FALSE)
      #values$count = values$count + 80
    }})

  
  #####PENALTY BOX TEXT#####
  output$warning5 <- reactive({
    if(summation$summationE[input$submitE] == 24){
      output$warning5 <- renderText({"Congratulations! You are ready to move on!"})
    }
    else if((summation$summationE[input$submitE] < 24)) {
      output$warning5 <- renderText({"Please drag wrong answers into this PENALTY box and drag back to try again."})
    }
  })
  
  # Level 6
  observeEvent(input$submitF,{
    if(summation$summationF[input$submitF] == 24){
      updateButton(session, "finish",disabled = FALSE)
      #values$count = values$count + 80
    }
    else{
      updateButton(session, "finish", disabled = TRUE)
    }
  })
  #####PENALTY BOX TEXT#####
  output$warning6 <- reactive({
    if(summation$summationF[input$submitF] == 24){
      output$warning6 <- renderText({"Congratulations! You are ready to move on!"})
    }
    else if((summation$summationF[input$submitF] < 24)) {
      output$warning6 <- renderText({"Please drag wrong answers into this PENALTY box and drag back to try again."})
    }
  })
  
  
  
  ################################ Score Section #####################################
  ### Initial score
  output$init <- renderPrint({
    
    if(any(summation$summationA[1] != 0) & any(summation$summationB[1] == 0) & any(summation$summationC[1] == 0) 
       & any(summation$summationD[1] == 0) & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {initialScore = summation$summationA[1]}
    
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0) & any(summation$summationC[1] == 0) 
            & any(summation$summationD[1] == 0) & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {initialScore = summation$summationA[1] + summation$summationB[1]}
    
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0) & any(summation$summationC[1] != 0) 
            & any(summation$summationD[1] == 0) & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {initialScore = summation$summationA[1] + summation$summationB[1] + summation$summationC[1]}
    
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0) & any(summation$summationC[1] != 0) 
            & any(summation$summationD[1] != 0) & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {initialScore = summation$summationA[1] + summation$summationB[1] + summation$summationC[1] + summation$summationD[1]}
    
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0) & any(summation$summationC[1] != 0) 
            & any(summation$summationD[1] != 0) & any(summation$summationE[1] != 0) & any(summation$summationF[1] == 0))
    {initialScore = summation$summationA[1] + summation$summationB[1] + summation$summationC[1] + summation$summationD[1]
    + summation$summationE[1]}
    
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0) & any(summation$summationC[1] != 0) 
            & any(summation$summationD[1] != 0) & any(summation$summationE[1] != 0) & any(summation$summationF[1] != 0))
    {initialScore = summation$summationA[1] + summation$summationB[1] + summation$summationC[1] + summation$summationD[1]
    + summation$summationE[1] + summation$summationF[1]}
    
    else{
      initialScore = 0
    }
    
    cat("First:",initialScore)
  })
  
  
  
  ### subsequent scores
  output$subsequent <- renderPrint({
    if(any(summation$summationA[1] != 0) & any(summation$summationB[1] == 0) & any(summation$summationC[1] == 0) 
       & any(summation$summationD[1] == 0) & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {subsequentScore = 8}
    
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0) & any(summation$summationC[1] == 0) 
            & any(summation$summationD[1] == 0) & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {subsequentScore = 16}
    
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0) & any(summation$summationC[1] != 0) 
            & any(summation$summationD[1] == 0) & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {subsequentScore = 32}
    
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0) & any(summation$summationC[1] != 0) 
            & any(summation$summationD[1] != 0) & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {subsequentScore = 52}
    
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0) & any(summation$summationC[1] != 0) 
            & any(summation$summationD[1] != 0) & any(summation$summationE[1] != 0) & any(summation$summationF[1] == 0))
    {subsequentScore = 76}
    
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0) & any(summation$summationC[1] != 0) 
            & any(summation$summationD[1] != 0) & any(summation$summationE[1] != 0) & any(summation$summationF[1] != 0))
    {subsequentScore = 100}
    
    else{
      subsequentScore = 0
    }
    
    cat("Subsequent:",subsequentScore)
  })
  
  
  
  ### Final Scores
  output$totalScore <- renderPrint({
    
    if(any(summation$summationA[1] != 0) & any(summation$summationB[1] == 0) & any(summation$summationC[1] == 0) 
       & any(summation$summationD[1] == 0) & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {summationScore = round(as.numeric(summation$summationA[1]) * (2/3) + 2.67, digits = 1)}
    
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0) & any(summation$summationC[1] == 0) 
            & any(summation$summationD[1] == 0) & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {summationScore = round(as.numeric(summation$summationA[1] + summation$summationB[1]) * (2/3) + 5.33, digit = 1)}
    
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0) & any(summation$summationC[1] != 0) 
            & any(summation$summationD[1] == 0) & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {summationScore = round(as.numeric(summation$summationA[1] + summation$summationB[1] + summation$summationC[1]) * (2/3) + 10.67, digits = 1)}
    
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0) & any(summation$summationC[1] != 0) 
            & any(summation$summationD[1] != 0) & any(summation$summationE[1] == 0) & any(summation$summationF[1] == 0))
    {summationScore = round(as.numeric(summation$summationA[1] + summation$summationB[1] + summation$summationC[1] + summation$summationD[1]) * (2/3)
                      + 17.33, digits = 1)}
    
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0) & any(summation$summationC[1] != 0) 
            & any(summation$summationD[1] != 0) & any(summation$summationE[1] != 0) & any(summation$summationF[1] == 0))
    {summationScore = round(as.numeric(summation$summationA[1] + summation$summationB[1] + summation$summationC[1] + summation$summationD[1]
    + summation$summationE[1]) * (2/3) + 25.33, digits = 1)}
    
    else if(any(summation$summationA[1] != 0) & any(summation$summationB[1] != 0) & any(summation$summationC[1] != 0) 
            & any(summation$summationD[1] != 0) & any(summation$summationE[1] != 0) & any(summation$summationF[1] != 0))
    {summationScore = round(as.numeric(summation$summationA[1] + summation$summationB[1] + summation$summationC[1] + summation$summationD[1]
    + summation$summationE[1] + summation$summationF[1]) * (2/3) + 33.33, digits = 1)}
    
    else{
      summationScore = 0
    }
    
    cat("Final: ", summationScore)
    #cat("Final: ",round(as.numeric(summation$summationScore[1]) * (2/3) + as.numeric(final$final) * (1/3), digits = 1))
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  # After this line, it will deal with the leaderboard thing.
  # ##############################################################################################################
  # output$checkName <- renderText({
  #   df = data.frame(data())
  #   df = df[,1]
  #   if (input$name %in% df){
  #     updateButton(session,"check",disabled = TRUE)
  #     print("The nickname has already been used. Please try another one.")
  #   }else{
  #     updateButton(session,"check",disabled = FALSE)
  #     print("The nickname is usable.")
  #   }
  # })
  
  
  outputDir = "scores"
  
  # options(warn = -1)
  values = reactiveValues()
  
  update = reactive({
    value = data.frame("Name" = as.character(input$name),
                       "Score1" = as.numeric(summation$summationScore[1]),
                       "Score2" = as.numeric(final$final),
                       "TotalScore" = as.numeric(summation$summationScore[1]) * (2/3) + as.numeric(final$final) * (1/3),
                       "TimeTaken" = as.numeric(time$inc))
    
    
  })
  values$df = data.frame()
  
  
  saveQuestions <- function(data) {
    # data <- t(data)
    # Create a unique file name
    fileName <- sprintf("%s_%s.csv", as.integer(Sys.Date()), digest::digest(data))
    # Write the file to the local system
    write.csv(
      x = data,
      file = file.path(outputDir, fileName), 
      row.names = FALSE, quote = TRUE
    )
  }
  
  loadData <- function() {
    # Read all the files into a list
    files <- list.files(outputDir, full.names = TRUE)
    data <- lapply(files, read.csv, stringsAsFactors = FALSE) 
    # Concatenate all data together into one data.frame
    data <- do.call(rbind, data)
    data
  }
  # First pattern try
  # paste0("^", Sys.Date(), sep = '')
  x = as.character(as.numeric(Sys.Date()))
  y = as.character(as.numeric(Sys.Date() - 7))
  if(substring(x, 5, 5) >= 7){
    pattern = paste0(substring(x, 1, 4), "[", substring(y, 5, 5), "-", substring(x, 5, 5), "]", sep = '')
  }
  else{
    pattern = paste0(substring(y, 1, 4), "[",substring(y, 5, 5), "-9]|", substring(x,1,4), "[0-", substring(x, 5, 5), "]")
  }
  
  
  loadDataWeek <- function() {
    files = list.files(outputDir, pattern = pattern, full.names = TRUE)
    data = lapply(files, read.csv, stringsAsFactors = FALSE)
    data = do.call(rbind, data)
    data
  }
  
  data = reactive({
    data = loadData()
    data = data[order(-data[,"TotalScore"], data[,"TimeTaken"]),]
    # data
  })
  
  data2 = reactive({
    data = loadDataWeek()
    data = data[order(-data[,"TotalScore"], data[,"TimeTaken"]),]
  })
  
  output$total = renderText({
    as.numeric(summation$summationScore[1]) * (2/3) + as.numeric(final$final) * (1/3)
  })
  
  observeEvent(input$check, {
    scores = update()
    values$df = rbind(values$df, scores)
    saveQuestions(values$df)
  })
  observeEvent(input$weekhigh, {
    output$highscore = renderDataTable({
      # head(data(), 5)
      if(is.null(loadDataWeek()) == TRUE){
        "No Highscores This week"
      }
      else{
        data2()  
      } 
      
    })
  })
  
  observeEvent(input$totalhigh, {
    output$highscore = renderDataTable({
      if(is.null(loadData()) == TRUE){
        "No Highscores"
      }
      else{
        data()
      }
    })
  })
  ########################################################################################
  
  
  # observeEvent(input$check,{
  #   updateButton(session,"check",disabled = TRUE)
  # })
  
  # output$badge = renderUI({
  #   score = round(summation$summationScore[1] * (2/3) + final$final * (1/3))
  #   if(is.null(input$name) == T){
  #     place = 0
  #   }
  #   else{
  #     # for(i in 1:3)
  #     #   {
  #     #   if(data2()[i, 1] == input$initials){
  #     #     place = i
  #     #   }
  #     # }
  #     if(score > data2()[3,4]){
  #       
  #       if(score > data2()[2,4]){
  #         if(score > data2()[1,4]){
  #           place = 1
  #         }
  #         else{
  #           place = 2
  #         }
  #       }
  #       else if(score == data2()[2,4]){
  #         if(time$inc > data2()[2,5]){
  #           place = 3
  #         }
  #         else{
  #           place = 2
  #         }
  #       }
  #       else{
  #         place = 3
  #       }
  #     }
  #     else if(score == data2()[3,4]){
  #       if(time$inc > data2()[3,5]){
  #         place = 0
  #       }
  #       else{
  #         place = 3
  #       }
  #     }
  #     else{
  #       place = 0
  #     }
  #   }
  #   
  #   
  #   
  #   
  #   if(place == 1){
  #     # 1st place image
  #     img(src = "trophy1st.png")
  #   }
  #   
  #   else if(place == 2){
  #     # 2nd place
  #     img(src = "trophy2nd.png")
  #   }
  #   
  #   else if(place == 3){
  #     # 3rd place
  #     img(src = "trophy3rd.png")
  #   }
  #   else{
  #     ""
  #   }
  #  
  # })
  
  
})
