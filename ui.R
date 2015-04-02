shinyUI(fluidPage(
  titlePanel("Playoff Simulator"),
  sidebarLayout(
    sidebarPanel(

      textInput(inputId = "series_format",
        value = "vector of As and Bs to define the format of the playoff series:"),

      textInput(inputId = "teamA",
        value = "team A's name"),

      textInput(inputId = "teamB",
        value = "team B's name"),

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

))