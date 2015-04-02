shinyUI (fluidPage (

  titlePanel("Playoff Simulator"),

  sidebarLayout(

    sidebarPanel(

      textInput(inputId = "teamA",
        label = "Team A's name",
        value = "Tampa Bay"),

      textInput(inputId = "teamB",
        label = "Team B's name",
        value = "Detroit"),

      textInput(inputId = "series_format",
        label = "Vector of As and Bs to define the format of the playoff series (default is 2-2-1-1-1)",
        value = "A, A, B, B, A, B, A"),

      numericInput(inputId = "p_teamA",
        label = "Probability that team A wins on neutral ice:",
        value = .6),

      numericInput(inputId = "p_homeice",
        label = <a href='http://www.sportingcharts.com/nhl/stats/team-home-and-away-winning-percentages/2013/'>"Home-ice advantage"</a>" (percentage swing for two equal teams):",
        value = .08),

      numericInput(inputId = "teamA_wins",
        label = "How many wins team A has:",
        value = 0),

      numericInput(inputId = "teamB_wins",
        label = "How many wins team B has:",
        value = 0),
      
      numericInput(inputId = "n_simulations",
        label = "Number of simulations:",
        value = 1000)

      ),
    
    mainPanel(

      plotOutput(outputId = "main_plot", width = "100%", height = "500px")
      
      )

    )

))