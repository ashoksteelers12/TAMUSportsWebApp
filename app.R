library(shiny)
library(ggplot2)

ui <- 
    fluidPage(
        h1(id="heading", "Texas A&M Sports"),
        tags$style(HTML("#heading{color: maroon;font-weight: bold;}")),
        sidebarLayout(
            sidebarPanel(
                actionButton("football", "Football", class = "btn-primary"),
                actionButton("basketball", "Basketball", class = "btn-primary") ,
                img(src = "logo.png", width = 180)
            ),
            mainPanel(
                tags$style(type="text/css",
                           ".shiny-output-error { visibility: hidden; }",
                           ".shiny-output-error:before { visibility: hidden; }"
                ),
                actionButton("roster", "Roster", class = "btn-danger"),
                actionButton("schedule", "Schedule", class = "btn-danger"),
                actionButton("stats", "Stats", class = "btn-danger"),
                tableOutput("Table"),
                tableOutput("rosterTable"),
                uiOutput("RosterMenu"),
                plotOutput("StatsBar", height = 500)
            )
        )
    )

server <- function(input, output) {
    # Football
    fbRoster <- read.csv("fbRoster.csv")
    fbRoster[is.na(fbRoster)] = 0
    fbSchedule <- read.csv("fbSchedule.csv")
    fbSchedule[is.na(fbSchedule)] = 0
    fbStats <- read.csv("fbStats.csv")
    fbStats[is.na(fbStats)] = 0
    
    fbGraphStats <- data.frame(
        difference <- abs(fbStats$Points - fbStats$Opp.Points),
        Points <- c(fbStats$Points, fbStats$Opp.Points, difference),
        Stats <- c("Team Points", "Opponent Points", "Point Differential")   
    )
    
    fbRosterData <- reactive({fbRoster})
    fbScheduleData <- reactive({fbSchedule})
    fbStatsData <- reactive({fbStats})

    #Basketball
    bbRoster <- read.csv("bbRoster.csv")
    bbRoster[is.na(bbRoster)] = 0
    bbSchedule <- read.csv("bbSchedule.csv")
    bbSchedule[is.na(bbSchedule)] = 0
    bbStats <- read.csv("bbStats.csv")
    bbStats[is.na(bbStats)] = 0
    
    bbGraphStats <- data.frame(
        Percentage <- c(bbStats$X3.Pointer, bbStats$Free.Throw, bbStats$Field.Goal),
        Categories <- c("3-Pointers", "Free Throws", "Field Goals")   
    )
    
    bbRosterData <- reactive({bbRoster})
    bbScheduleData <- reactive({bbSchedule})
    bbStatsData <- reactive({bbStats})

    observeEvent(input$football, {
        observeEvent(input$roster, {
            output$RosterMenu <- renderUI({
                values <- c("Ints", "QBR", "Touchdowns", "Rush.Yards", "Receiving.Yards", "Sacks", "Tackles")
                selectInput("fbMenu", "Select:", values)
            })
            output$rosterTable <- renderTable({
                fbRoster[, c("Name", input$fbMenu), drop=FALSE]
            }, rownames=TRUE)
            output$Table <- renderTable({})
            output$StatsBar <- renderPlot({})
        })
        observeEvent(input$schedule, {
            output$RosterMenu <- renderUI({})
            output$Table <- renderTable({
                fbScheduleData()
            }) 
            output$rosterTable <- renderTable({})
            output$StatsBar <- renderPlot({})
        })
        observeEvent(input$stats, {
            output$RosterMenu <- renderUI({})
            output$Table <- renderTable({
                fbStatsData()
            }) 
            output$rosterTable <- renderPlot({})
            output$StatsBar <- renderPlot({
                ggplot(fbGraphStats, aes(x=Stats,y=Points)) + geom_bar(stat="identity", fill = c("red", "blue", "green")) + coord_flip()
            })
        })
    }) 
    
    observeEvent(input$basketball, {
        observeEvent(input$roster, {
            output$RosterMenu <- renderUI({
                values <- c("Points", "Steals", "Blocks", "Assists", "Rebounds", "Turnovers", "X3.Pointer.Percentage", "Free.Throw.Percentage", "Field.Goal.Percentage", "Fouls", "Minutes")
                selectInput("bbMenu", "Select:", values)
            })
            output$rosterTable <- renderTable({
                bbRoster[, c("Name", input$bbMenu), drop=FALSE]
            }, rownames=TRUE)
            output$Table <- renderTable({}) 
            output$StatsBar <- renderPlot({})
        })
        observeEvent(input$schedule, {
            output$RosterMenu <- renderUI({})
            output$Table <- renderTable({
                bbScheduleData()
            }) 
            output$rosterTable <- renderTable({})
            output$StatsBar <- renderPlot({})
        })
        observeEvent(input$stats, {
            output$RosterMenu <- renderUI({})
            output$Table <- renderTable({
                bbStatsData()
            })
            output$rosterTable <- renderTable({})
            output$StatsBar <- renderPlot({
                ggplot(bbGraphStats, aes(x=Categories,y=Percentage)) + geom_bar(stat="identity", fill = c("red", "blue", "green"))
            })
        })
    })
}

shinyApp(ui = ui, server = server)
