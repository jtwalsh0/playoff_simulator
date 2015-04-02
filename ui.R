shinyUI (fluidPage (

  titlePanel("Playoff Simulator"),

  sidebarLayout(

    sidebarPanel(

      textInput(inputId = "series_format",
        label = "vector of As and Bs to define the format of the playoff series",
        value = c("A", "A", "B", "B", "A", "B", "A")),

      textInput(inputId = "teamA",
        label = "team A's name",
        value = "Tampa Bay"),

      textInput(inputId = "teamB",
        label = "team B's name",
        value = "Detroit"),

      numericInput(inputId = "p_teamA",
        label = "probability that team A wins on neutral ice:",
        value = .5),

      numericInput(inputId = "p_homeice",
        label = "home-ice advantage (percentage increase):",
        value = .04),

      numericInput(inputId = "teamA_wins",
        label = "how many wins team A has:",
        value = 0),

      numericInput(inputId = "teamB_wins",
        label = "how many wins team B has:",
        value = 0),
      
      numericInput(inputId = "n_simulations",
        label = "number of simulations:",
        value = 1000)

      ),
    
    mainPanel(

      plotOutput(outputId = "main_plot", height = "300px")
      
      )

    )

))